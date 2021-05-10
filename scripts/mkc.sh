#!/bin/bash

export MINIKUBE_VER=v1.0.0
export KUBECTL_VER=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`

show_help() {
  echo "mk-kc.sh - update minikube and kubectl"
  echo " "
  echo "mk-kc.sh [options]"
  echo " "
  echo "options:"
  echo "-h, --help          show brief help"
  echo "    --minikube      minikube version that will be used for minikube (default is v1.0.0)"
  echo "    --kubectl       kubectl version that will be used for kubectl (default is from https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
}

while test $# -gt 0; do
  case "$1" in
    -h | --help)
      show_help
      exit 0
      ;;
    --minikube*)
      export MINIKUBE_VER=$(echo $1 | sed -e 's/^[^=]*=//g')
      shift
      ;;
    --kubectl*)
      export KUBECTL_VER=$(echo $1 | sed -e 's/^[^=]*=//g')
      shift
      ;;
    *)
      shift
      ;;
  esac
done

echo ""
echo "MINIKUBE VERSION = ${MINIKUBE_VER}"
echo "KUBECTL VERSION = ${KUBECTL_VER}"

echo ""
echo "downloading minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/${MINIKUBE_VER}/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm ./minikube

echo ""
echo "downloding kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl