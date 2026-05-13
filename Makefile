.PHONY: setup attack heal status

setup:
powershell ./scripts/setup-lab.ps1

attack:
kubectl apply -f chaos/experiments/inventory-latency.yaml

heal:
kubectl delete -f chaos/experiments/inventory-latency.yaml

status:
kubectl get networkchaos
