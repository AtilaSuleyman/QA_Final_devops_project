#!/bin/bash

#switch to root and download ansible through python pip

sudo apt-get install -y python-pip
sudo pip install --upgrade pip
sudo pip install  ansible
sudo apt-get update -y

#download wget
sudo apt-get install wget -y
sudo apt-get -y update


##ssh code goes here
umask 077; ~/UbuntuKeyTwo.pem -d ~/.ssh || mkdir ~/.ssh ; cat >> ~/.ssh/authorized_keys


cd /etc
sudo mkdir ansible
cd ansible

sudo rm /etc/ansible/hosts

##wget resources code
sudo wget  https://github.com/simonydbutt/QA_Final_Devops_Project/blob/master/hosts
sudo wget https://github.com/simonydbutt/QA_Final_Devops_Project/blob/master/playbook.yml

#execute playbook
sudo ansible-playbook playbook.yml

