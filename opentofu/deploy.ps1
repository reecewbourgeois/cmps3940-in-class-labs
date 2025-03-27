# Enable strict mode
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Build and push images
.\deploy-containers.ps1

# Update kubernetes manifests
.\update-kubernetes.ps1