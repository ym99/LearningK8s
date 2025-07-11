function Set-Tag([string]$k8sYaml, [string]$tag)
{
   $tmpFileName = New-TemporaryFile

   Get-Content $k8sYaml | ForEach-Object { $_ -replace '[$]{TAG}', $tag } | Set-Content $tmpFileName

   $tmpFileName
}

$version = [System.DateTime]::Now.ToString('yyyy-MM-dd--HH-mm-ss')
.\Pipelines\Build\build-all.ps1 -version $version -redisUrl redis-service.lk8s-data.svc.cluster.local:6379 -appUrl 'http://lk8s-app-service.lk8s-app.svc.cluster.local:5002'

Push-Location .\Pipelines\RunOnK8s\
kubectl apply -f (Set-Tag namespaces.yaml $version)
kubectl apply -f (Set-Tag redis.yaml $version)
kubectl apply -f (Set-Tag lk8s-app.yaml $version)
kubectl apply -f (Set-Tag lk8s-api.yaml $version)
kubectl apply -f (Set-Tag ingress.yaml $version)
Pop-Location

curl http://lk8s