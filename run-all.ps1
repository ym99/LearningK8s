# build all
cd .\LK8sApi
docker build -t sample-api .
cd ..

cd .\LK8sApp
docker build -t sample-app .
cd ..

# clean docker
if (docker ps -aq --filter "name=sample-api") {
    docker rm -f sample-api
}
if (docker ps -aq --filter "name=sample-app") {
    docker rm -f sample-app
}
if (docker network ls --filter "name=sample-network" --format "{{.Name}}" | Select-String "sample-network") {
    docker network rm sample-network
}

# create
docker network create sample-network
docker run -d --network sample-network --name sample-api -p 5001:5001 sample-api
docker run -d --network sample-network --name sample-app -p 5002:5002 sample-app
