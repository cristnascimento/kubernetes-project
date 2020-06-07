provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "test.k8s.cristinascimento.br"
  acl    = "private"

  tags = {
    Name        = "k8s bucket"
    Environment = "Dev"
  }
}

