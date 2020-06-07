provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../create-vpc-subnet/terraform.tfstate"
  }
}

resource "aws_route53_zone" "private" {
  name = "k8s.cristnascimento.br"

  vpc {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  }
}

