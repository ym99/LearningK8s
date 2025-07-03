# clean docker
if (docker ps -aq --filter "name=lk8s-api") {
    docker rm -f lk8s-api
}
if (docker ps -aq --filter "name=lk8s-app") {
    docker rm -f lk8s-app
}
if (docker network ls --filter "name=lk8s-network" --format "{{.Name}}" | Select-String "lk8s-network") {
    docker network rm lk8s-network
}

Push-Location .\LK8sApi
docker build -t lk8s-api .
docker tag lk8s-api lk8s-api:latest
Pop-Location

Push-Location .\LK8sApp
docker build -t lk8s-app .
docker tag lk8s-app lk8s-app:latest
Pop-Location