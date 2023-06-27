provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "jump_server" {
  ami             = "ami-024e6efaf93d85776"
  instance_type   = "t2.medium"
  security_groups = [module.security_group.sg_id]

  tags = {
    Name = "JumpServer"
  }
}

resource "aws_instance" "web_server2" {
  ami             = "ami-024e6efaf93d85776"
  instance_type   = "t2.micro"
  security_groups = [module.security_group.sg_id]

  tags = {
    Name = "WebServer1"
  }
}

resource "aws_instance" "web_server1" {
  ami             = "ami-024e6efaf93d85776"
  instance_type   = "t2.micro"
  security_groups = [module.security_group.sg_id]

  tags = {
    Name = "WebServer2"
  }
}
module "security_group" {
  source = "./modules/security-groups"
}