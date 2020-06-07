provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../create-vpc-subnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "sg" {
  backend = "local"
  config = {
    path = "../create-security-group/terraform.tfstate"
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  role = "test-k8s-role"
}

resource "aws_instance" "k8s_controller" {

  ami           = "ami-085925f297f89fce1"
  instance_type = "t1.micro"
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
  key_name = "cristnascimento-maio-2020"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  tags = {
    Name = "K8s Controller"
  }
}
