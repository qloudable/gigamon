#!/bin/sh
user=$1
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update 
sudo apt-get install -y docker-ce
sudo usermod -aG docker $user
wget https://raw.githubusercontent.com/sudheermareddy/test/master/giga/deploy.sh
wget https://raw.githubusercontent.com/sudheermareddy/test/master/giga/destroy.sh
wget https://raw.githubusercontent.com/sudheermareddy/test/master/giga/Dockerfile
wget https://raw.githubusercontent.com/sudheermareddy/test/master/giga/backend.tf
docker build -t gigaimage/terraform:latesst .
