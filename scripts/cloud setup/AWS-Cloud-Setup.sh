#!/bin/bash

# AWS Setup Script

# Install AWS CLI
pip install awscli

# Configure AWS CLI
aws configure

# Create an EC2 instance
aws ec2 run-instances --image-id ami-0abcdef1234567890 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-0abc1234567890def --subnet-id subnet-0abc1234567890def

# Install Docker on EC2 instance
ssh -i "MyKeyPair.pem" ec2-user@ec2-198-51-100-1.compute-1.amazonaws.com << 'EOF'
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
EOF

# Deploy Docker container
ssh -i "MyKeyPair.pem" ec2-user@ec2-198-51-100-1.compute-1.amazonaws.com << 'EOF'
git clone https://github.com/projectzerodays/vengence.git
cd vengence
docker-compose up -d
EOF
