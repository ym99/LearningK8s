.\Pipelines\Build\build-all.ps1

docker network create lk8s-network
docker run -d --network lk8s-network --name lk8s-api -p 5001:5001 lk8s-api
docker run -d --network lk8s-network --name lk8s-app -p 5002:5002 lk8s-app
