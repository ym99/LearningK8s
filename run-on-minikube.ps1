$version = [System.DateTime]::Now.ToString('yyyy-MM-dd--HH-mm-ss')
.\Pipelines\Build\build-all.ps1 -version $version -appUrl 'http://lk8s-app-service:5002'

if (minikube image ls)
{
   Write-Host "Minikube is running..."
}
else
{
   minikube start
   #minikube addons enable ingress
}

minikube image load lk8s-api:$version
minikube image load lk8s-app:$version

Push-Location .\Pipelines\RunOnK8s\
#terraform init
terraform plan -var="image_version=$version"
terraform apply -var="image_version=$version" -auto-approve
Pop-Location

# Force deployment refresh
kubectl rollout restart deployment lk8s-api
kubectl rollout restart deployment lk8s-app

minikube service lk8s-api-service
