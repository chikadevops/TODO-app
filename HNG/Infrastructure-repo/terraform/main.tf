provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}


#Create security group with firewall rules
resource "aws_security_group" "jenkins-sg-2023" {
  name        = var.security_group
  description = "Security group for HNG"
                                        
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from Jenkins server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins-sg-2023.id]
  tags= {
    Name = var.tag_name
  }
}

# Null resource to trigger Ansible playbook execution after provisioning
resource "null_resource" "run_ansible" {
  depends_on = [aws_instance.my_server]
  
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.my_server.public_ip}, ansible/playbook.yml"
  }
}