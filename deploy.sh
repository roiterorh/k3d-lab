set -e
# docker build -t test .

./k3d cluster delete -c k3d-default.yaml 
./k3d cluster create -c k3d-default.yaml 
mkdir -p .tls
./mkcert-v1.4.4-linux-amd64 -key-file .tls/_wildcard.localtest.me-key.pem -cert-file .tls/_wildcard.localtest.me.pem  -install *.localtest.me
until kubectl apply -f recipes 2>/dev/null; do sleep 1;done
kubectl create secret tls ssl --key=".tls/_wildcard.localtest.me-key.pem" --cert=".tls/_wildcard.localtest.me.pem"

