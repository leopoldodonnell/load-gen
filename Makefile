.DEFAULT_GOAL := all
CHART := load-gen
RELEASE := chart-${CHART}-release
NAMESPACE := chart-tests
ACR := hmctssandbox
ACR_SUBSCRIPTION := DCD-CFT-Sandbox
AKS_RESOURCE_GROUP := cnp-aks-sandbox-rg
AKS_CLUSTER := cnp-aks-sandbox-cluster

setup:
	az account set --subscription ${ACR_SUBSCRIPTION}
	az configure --defaults acr=${ACR}
	az acr helm repo add
	az aks get-credentials --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER}

clean:
	-helm delete --purge ${RELEASE}
	
lint:
	helm lint ${CHART} -f ci-values.yaml

deploy:
	helm install ${CHART} --name ${RELEASE} --namespace ${NAMESPACE} -f ci-values.yaml --wait --timeout 60

all: setup clean lint deploy

.PHONY: setup clean lint deploy all
