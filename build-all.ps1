cd .\LK8sApi
docker build -t sample-api .
cd ..

cd .\LK8sApp
docker build -t sample-app .
cd ..
 