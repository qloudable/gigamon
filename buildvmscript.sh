#!/bin/sh
user=$1
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update 
sudo apt-get install -y docker-ce
sudo usermod -aG docker $user
wget https://raw.githubusercontent.com/qloudable/gigamon/main/deploy.sh
wget https://raw.githubusercontent.com/qloudable/gigamon/main/destroy.sh
wget https://raw.githubusercontent.com/qloudable/gigamon/main/Dockerfile
wget https://raw.githubusercontent.com/qloudable/gigamon/main/backend.tf
docker build -t gigaimage/terraform:latesst .
