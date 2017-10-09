#!/bin/bash

#switch to root and download ansible through python pip
sudo -i
apt-get install -y python-pip
pip install -y ansible
pip upgrade -y ansible
apt-get update -y

#download wget
apt-get install wget -y
apt-get -y update


##ssh code goes here
umask 077; ~/UbuntuKeyTwo.pem -d ~/.ssh || mkdir ~/.ssh ; cat >> ~/.ssh/authorized_keys


cd /etc/ansible

##wget resources code
wget  https://github.com/simonydbutt/QA_Final_Devops_Project/blob/master/hosts
wget https://github.com/simonydbutt/QA_Final_Devops_Project/blob/master/playbook.yml

#execute playbook
ansible-playbook playbook.yml

