############
## Deploy ##
############

# Apply ConfigMap
Write-Host "📌 Applying ConfigMaps..."
kubectl apply -f .\kubernetes\backend-configmap.yml

# Apply Deployment
Write-Host "🚀 Deploying Services..."
kubectl apply -f .\kubernetes\frontend-ingress.yml
kubectl apply -f .\kubernetes\backend-deployment.yml
kubectl apply -f .\kubernetes\frontend-deployment.yml

# Make sure the deployments are pulling the latest changes
kubectl rollout restart deployment backend
kubectl rollout restart deployment frontend

Write-Host "✅ Services successfully deployed to GKE!"