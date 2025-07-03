Pipelines\build-all.ps1

if (minikube image ls)
{
   Write-Host "Minikube is running..."
}
else
{
   minikube start
}

minikube image load lk8s-api:latest
minikube image load lk8s-app:latest


Push-Location .\Pipelines
#terraform init
terraform plan
terraform apply -auto-approve
Pop-Location

# create
# docker network create sample-network
# docker run -d --network sample-network --name sample-api -p 5001:5001 sample-api
# docker run -d --network sample-network --name sample-app -p 5002:5002 sample-app
