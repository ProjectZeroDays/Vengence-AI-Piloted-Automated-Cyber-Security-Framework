#!/bin/bash

# Google Cloud Setup Script

# Install Google Cloud SDK
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
gcloud init

# Create a VM instance
gcloud compute instances create my-instance --zone=us-central1-a --machine-type=e2-medium --image-family=debian-10 --image-project=debian-cloud --boot-disk-size=10GB --metadata=startup-script='#! /bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo usermod -aG docker $USER
git clone https://github.com/projectzerodays/vengence.git
cd vengence
docker-compose up -d
'

# Connect to the VM instance
gcloud compute ssh my-instance --zone=us-central1-a
