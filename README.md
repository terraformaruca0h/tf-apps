## Terraform Cloud VCS Integration with GitHub 
This repo is intended to serve as an "umbrella" repository for multiple applications (app1, app2, etc.)
Each application will have multiple environments (dev, prod)

Intended to explore the Terraform simple and OAuth-based VCS integration with Github

Explore if a Workspace can point to a specific "folder" (e.g. app2/dev,  app3/prod)
This would be an alternative to having dedicated repos for each combination (e.g. repos app1-dev, app1-prod, etc.)
- This can be done with the parameter "Terraform Working Directory" when creating a Workspace.
- We will attempt to create 2 workspaces with a slightly different set of parameters.
    -  gh-app2-android-dev
    -  gh-app2-ios-dev
 

In app2
- All variables except app_name are defined in variables.auto.tfvars
    - Explore if TF Cloud does not prompt for these variables to be created in the workspace
In app3
- All variables except app_name AND environment are defined in variables.auto.tfvars
    - Explore if TF Cloud does not prompt for these variables to be created in the workspace

## Authentication of TF Cloud to Azure
### Service Principal and Client Secret 

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal
- The values obtained from this procedure have to included in Terraform Environment Variables 


Alternatively we can use this mini script to populate the Environment variables 

```bash
az login
az account set -s SUBSCRIPTION_NAME

# Get your sub id
sub_id=$(az account show --query id -o tsv)

# Create an SP with contributor access to your sub
sp_info=$(az ad sp create-for-rbac \
  --name sp-tf-cloud-2 --role contributor \
  --scopes /subscriptions/$sub_id)

# Variables and their values for Terraform Cloud 
# ARM_CLIENT_ID
echo $sp_info | jq .appId -r

# ARM_CLIENT_SECRET
echo $sp_info | jq .password -r

# ARM_SUBSCRIPTION_ID
echo $sub_id

# ARM_TENANT_ID
echo $sp_info | jq .tenant -r
```