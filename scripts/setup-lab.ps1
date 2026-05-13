Write-Host "Starting Resilience Lab Setup for Windows..." -ForegroundColor Cyan

# 1. Check for Kind
if (!(Get-Command kind -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Kind not found. Please install it: https://kind.sigs.k8s.io/" -ForegroundColor Red
    return
}

# 2. Create Cluster
$clusterName = "resilience-lab"
$clusters = kind get clusters
if ($clusters -notcontains $clusterName) {
    Write-Host "Creating Kubernetes cluster: $clusterName..." -ForegroundColor Yellow
    kind create cluster --name $clusterName
} else {
    Write-Host "Cluster '$clusterName' already exists." -ForegroundColor Green
}

# 3. Install Chaos Mesh via Helm
Write-Host "Installing Chaos Mesh via Helm..." -ForegroundColor Yellow
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm repo update

# Create namespace and install
kubectl create ns chaos-mesh
helm install chaos-mesh chaos-mesh/chaos-mesh `
  --namespace=chaos-mesh `
  --set dashboard.securityMode=false

Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "Verify with: kubectl get pods -n chaos-mesh"
