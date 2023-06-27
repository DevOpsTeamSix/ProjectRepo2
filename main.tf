provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "jump_server" {
  ami             = "ami-024e6efaf93d85776"
  instance_type   = "t2.medium"
  security_groups = [module.security_group.sg_id]
  key_name        = aws_key_pair.keypair.key_name

  tags = {
    Name = "JumpServer"
  }
}

resource "aws_instance" "web_server2" {
  ami             = "ami-024e6efaf93d85776"
  instance_type   = "t2.micro"
  security_groups = [module.security_group.sg_id]
  key_name        = aws_key_pair.keypair.key_name

  tags = {
    Name = "WebServer1"
  }
}

resource "aws_instance" "web_server1" {
  ami             = "ami-024e6efaf93d85776"
  instance_type   = "t2.micro"
  security_groups = [module.security_group.sg_id]
  key_name        = aws_key_pair.keypair.key_name

  tags = {
    Name = "WebServer2"
  }
}
module "security_group" {
  source = "./modules/security-groups"
}

resource "tls_private_key" "pemkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name   = "practicekey"
  public_key = tls_private_key.pemkey.public_key_openssh
}

resource "local_file" "key_local_file" {
  content  = tls_private_key.pemkey.private_key_pem
  filename = "practicekey.pem"
}