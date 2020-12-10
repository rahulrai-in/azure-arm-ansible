location='australiaeast'

# Install AZ CLI
echo 'Installing AZ CLI'
if ! command -v az >/dev/null; then
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

# Authenticate using service principal on CI: https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal
echo 'Login to Azure'
az login
az account set --subscription $1

# Create resource group
echo 'Creating resource group'
az group create --name $2 --location $location >/dev/null

# Run playbook
echo 'Executing playbook'
ansible-playbook deploy.yaml -e resourceGroup=$2 -e env=$3
