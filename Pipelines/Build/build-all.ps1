param(
      [string]$version = $(throw "Please provide the -version parameter")
    , [string]$redisUrl = $(throw "Please provide the -redisUrl parameter")
    , [string]$appUrl = $(throw "Please provide the -appUrl parameter")

)

Push-Location .\LK8sApi
docker build -t lk8s-api --build-arg APP_URL_ARG=$appUrl .
docker tag lk8s-api lk8s-api:$version
Pop-Location

Push-Location .\LK8sApp
docker build -t lk8s-app --build-arg REDIS_URL_ARG=$redisUrl .
docker tag lk8s-app lk8s-app:$version 
Pop-Location