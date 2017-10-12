#!/bin/bash

#switch to root and download ansible through python pip

sudo apt-get -y install python-pip
#sudo pip install --upgrade pip
#sudo pip install  ansible
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt install -y ansible
sudo apt-get -y update

#download wget
sudo apt-get -y install wget 
sudo apt-get -y update


##ssh code goes here
cat /home/ubuntu/UbuntuKeyTwo.pem >> ~/.ssh/authorized_key
cat /home/ubuntu/UbuntuKeyTwo.pem >> ~/.ssh/known_hosts

cd /etc
sudo mkdir ansible
cd ansible

sudo rm /etc/ansible/hosts

##wget resources code
sudo wget https://raw.githubusercontent.com/simonydbutt/QA_Final_Devops_Project/master/hosts
sudo wget https://raw.githubusercontent.com/simonydbutt/QA_Final_Devops_Project/master/playbook.yml

#execute playbook
sudo ansible-playbook playbook.yml

