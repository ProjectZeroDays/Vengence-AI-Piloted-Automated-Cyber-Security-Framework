#!/bin/bash

# Azure Setup Script

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to Azure
az login

# Create a resource group
az group create --name myResourceGroup --location eastus

# Create a virtual machine
az vm create --resource-group myResourceGroup --name myVM --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

# Install Docker on the VM
az vm run-command invoke --command-id RunShellScript --name myVM --resource-group myResourceGroup --scripts "sudo apt-get update && sudo apt-get install -y docker.io && sudo systemctl start docker && sudo usermod -aG docker azureuser"

# Deploy Docker container
az vm run-command invoke --command-id RunShellScript --name myVM --resource-group myResourceGroup --scripts "git clone https://github.com/projectzerodays/vengence.git && cd vengence && docker-compose up -d"
