#aws.tf

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws"{
 region = "eu-west-1"
 access_key = "${var.AWS_ACCESS_KEY}"
 secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_key_pair" "armani-key"{
 key_name = "armani-key"
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNXkWteOt8qUXacGZzw2tWEBRmYE5WtEmNEA4mH4fTuw0Rd4qI6WPdvpNBXKTFy1BRHzURh2KaEfLyvmQO1LyMzpEFWYS7MMSGoNV3SM1XZAyHE2x4yor5G5dDeQhBfRSuhNV4puem5w18jfL38KTxuliJLbQBgxyVbzHhXQoJs1jgwUxFkbQ8VTtIucf/TVxeoJVNmU+zC3FtK4GaHk5HenH7VD52XYxBSHTq+5Ffhsc1L0eYH+28904WiVYOTZY7ZUIjAXiD5ySt/pNWZKQgFTmGNGDTC4OX49So8X/4CJnyg+WZuyQGU6sYoAu3Pv5fNoAu3xY/kX309fBHCjZ/ atila@atila-VirtualBox"
}

resource "aws_instance" "web1"{
 ami = "ami-17d11e6e"
 subnet_id = "subnet-bbfba0e2"
 private_ip = "172.31.33.33"
 instance_type = "t2.large"
 key_name = "${aws_key_pair.armani-key.key_name}"
 tags{
  Name = "Test_Instance_Slave"
 }
 provisioner "remote-exec"{
   inline = [
    "sudo apt update",
    "sudo apt -y install python"
   ]
   connection {
   type = "ssh"
   user = "ubuntu"
   private_key = "${file("/home/atila/awsconfig/UbuntuKeyTwo.pem")}"
  }

  }
}


resource "aws_instance" "web"{
 ami = "ami-17d11e6e"
 private_ip = "172.31.44.52"
 subnet_id = "subnet-bbfba0e2"
 instance_type = "t2.micro"
 key_name = "${aws_key_pair.armani-key.key_name}"
 tags{
  Name = "Test_Instance_1"
 }
 provisioner "file"{
  source = "/home/atila/awsconfig/UbuntuKeyTwo.pem"
  destination = "/home/ubuntu/UbuntuKeyTwo.pem"
  connection {
   type = "ssh"
   user = "ubuntu"
   private_key = "${file("/home/atila/awsconfig/UbuntuKeyTwo.pem")}"
  }
 }
 provisioner "file"{
  source = "/home/atila/awsconfig/armani-key.pub"
  destination = "/home/ubuntu/armani-key.pub"
  connection {
   type = "ssh"
   user = "ubuntu"
   private_key = "${file("/home/atila/awsconfig/UbuntuKeyTwo.pem")}"
  }
 }
 provisioner "remote-exec"{
   inline = [
    "sudo wget https://raw.githubusercontent.com/simonydbutt/QA_Final_Devops_Project/master/masterScript.sh -P /home/ubuntu/",
    "sudo chmod +x /home/ubuntu/masterScript.sh",
    "sudo sh /home/ubuntu/masterScript.sh"
   ]
   connection {
   type = "ssh"
   user = "ubuntu"
   private_key = "${file("/home/atila/awsconfig/UbuntuKeyTwo.pem")}"
  }

  }
}
