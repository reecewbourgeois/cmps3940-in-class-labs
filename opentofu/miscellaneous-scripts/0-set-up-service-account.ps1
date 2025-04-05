$PROJECT_ID=""
$OWNER="CMPS3940"
$REPO=""
$POOL=""
$PROVIDER=""
$SERVICE_ACCOUNT=""

# Create Pool
gcloud iam workload-identity-pools create $POOL `
    --location="global" `
    --project="$PROJECT_ID" `
    --display-name="GitHub Actions Pool"

# Create Provider
gcloud iam workload-identity-pools providers create-oidc $PROVIDER `
    --location="global" `
    --project="$PROJECT_ID" `
    --workload-identity-pool="$POOL" `
    --display-name="GitHub Actions Provider" `
    --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" `
    --attribute-condition="assertion.repository_owner == '$OWNER' && assertion.repository == '$OWNER/$REPO'" `
    --issuer-uri="https://token.actions.githubusercontent.com"

# Create service account
gcloud iam service-accounts create $SERVICE_ACCOUNT `
    --project="$PROJECT_ID" `
    --display-name="GitHub Actions Service Account"

# Allow Impersonation
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com `
   --project="$PROJECT_ID" `
   --role="roles/iam.workloadIdentityUser" `
   --member="serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com"

# Allow pushing
gcloud artifacts repositories add-iam-policy-binding cmps3940-docker-repo `
    --project="$PROJECT_ID" `
    --location="us-central1" `
    --member="serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com" `
    --role="roles/artifactregistry.writer"

# Create key.json (DO NOT FORGET TO DELETE WHEN DONE. I added a gitignore just in case)
gcloud iam service-accounts keys create key.json --iam-account=$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com

# IMPORTANT: Create GitHub Action secret to store the json