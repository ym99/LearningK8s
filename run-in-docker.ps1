$version = [System.DateTime]::Now.ToString('yyyy-MM-dd--HH-mm-ss')
.\Pipelines\Build\build-all.ps1 -version $version -redisUrl redis:6379 -appUrl 'http://lk8s-app:5002'

$env:VERSION = $version
Push-Location .\Pipelines\RunInDocker\
docker-compose up -d
Pop-Location

Start-Process -FilePath "http://localhost:5001"