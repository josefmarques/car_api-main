# car_api
k3d cluster create cluster-k3d --port 80:80@loadbalancer --port 443:443@loadbalancer
k3d image import car-api:1.0.0 car-api-mkdocs:1.0.0 -c cluster-k3d
helm upgrade --install --namespace pycodebr --create-namespace car-api . -f values-local.yaml
helm upgrade --install --namespace pycodebr --create-namespace car-api . -f values-local.yaml
k3d cluster delete cluster-k3d