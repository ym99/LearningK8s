param(
      [string]$version = $(throw "Please provide the -version parameter")
    , [string]$redisUrl = $(throw "Please provide the -redisUrl parameter")
    , [string]$appUrl = $(throw "Please provide the -appUrl parameter")

)

# Check if logged in to Docker Hub
Write-Host "Checking Docker Hub authentication..."
try {
    docker info | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Please run 'docker login' first"
        exit 1
    }
} catch {
    Write-Host "Please run 'docker login' first"
    exit 1
}

Push-Location .\LK8sApi
docker build -t lk8s-api --build-arg APP_URL_ARG=$appUrl .
docker tag lk8s-api ym1999/lk8s-api:$version
docker push ym1999/lk8s-api:$version
Pop-Location

Push-Location .\LK8sApp
docker build -t lk8s-app --build-arg REDIS_URL_ARG=$redisUrl .
docker tag lk8s-app ym1999/lk8s-app:$version 
docker push ym1999/lk8s-app:$version
Pop-Location