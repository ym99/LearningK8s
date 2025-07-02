if (docker ps -aq --filter "name=sample-api") {
    docker rm -f sample-api
}
docker run -d -p 5001:5001 --name sample-api sample-api

if (docker ps -aq --filter "name=sample-app") {
    docker rm -f sample-app
}
docker run -d -p 5002:5002 --name sample-app sample-app