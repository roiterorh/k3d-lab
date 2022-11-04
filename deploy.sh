set -e

./k3d cluster delete -c k3d-default.yaml 
./k3d cluster create -c k3d-default.yaml 
mkdir -p .tls
./mkcert-v1.4.4-linux-amd64 -key-file .tls/_wildcard.localtest.me-key.pem -cert-file .tls/_wildcard.localtest.me.pem  -install *.localtest.me localtest.me
# until kubectl apply -f recipes 2>/dev/null; do sleep 1;done
kubectl create secret tls ssl -n ingress --key=".tls/_wildcard.localtest.me-key.pem" --cert=".tls/_wildcard.localtest.me.pem"

# echo kubectl create configmap homepage-config --from-file=config/services.yaml --from-file=config/widgets.yaml
# kubectl delete -f dashy.yaml || true
# kubectl apply -f dashy.yaml

# helm upgrade --install prometheus  prometheus-community/prometheus -f prom-val.yaml  -n monitoring --create-namespace 

# curl -X POST -H "Content-Type: application/json" -d '{"name":"apikeycurl", "role": "Admin"}' https://admin:strongpassword@grafana.localtest.me/api/auth/keys
# helm template code-server-on-k8s/ --set user=admin --set password=password --set namespace=default --set loadBalancerSourceRanges={0.0.0.0/0} | kubectl apply -f -

