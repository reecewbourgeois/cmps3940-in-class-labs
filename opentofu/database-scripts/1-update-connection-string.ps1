####################
## Deploy secrets ##
####################

Write-Host "🔑 Deploying secrets..."
# Get PostgreSQL IP from OpenTofu
# Note: This is assuming you are running the script from within the database-scripts folder
cd ..
$POSTGRES_IP = & tofu output -raw postgres_ip_address
cd database-scripts

# Get user input
$Password = Read-Host -Prompt "Enter cmps3940-api user password"

# Generate the connection string
$POSTGRES_CONNECTION_STRING = ""

# Create Kubernetes Secret
# Note: If you get an error, make sure you have authenticated with the Kubernetes cluster in google cloud
Write-Host "🔑 Creating Kubernetes Secret..."
kubectl create secret generic ## COMMAND_HERE ##

Write-Host "✅ Kubernetes Secret created for PostgreSQL Connection String"