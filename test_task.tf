provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}
resource "aws_instance" "my_webserver" {
ami                    = "ami-0747bdcabd34c712a"
instance_type          = "t3.micro"
vpc_security_group_ids = [aws_security_group.my_webserver_two.id]
user_data              = <<EOF
#!/bin/bash
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo docker run -p 8080:8080 -d vchaws/node-test-task
EOF

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Volodymyr Chumachenko"
  }
}


resource "aws_security_group" "my_webserver_two" {
  name        = "WebServer Security Group 2"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup 2"
    Owner = "Volodymyr Chumachenko"
  }
}
