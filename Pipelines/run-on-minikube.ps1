.\Pipelines\Build\build-all.ps1

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

Push-Location .\Pipelines\RunOnK8s\
#terraform init
terraform plan
terraform apply -auto-approve
Pop-Location
