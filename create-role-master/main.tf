provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "test-k8s-role-master" {
  name = "test-k8s-role-master"

  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
}
EOF
}

resource "aws_iam_policy" "master-k8s-policy" {
  name        = "master-k8s-policy"
  description = "A policy for k8s master"
  policy      = file("policy_master.json")
}


resource "aws_iam_role_policy_attachment" "k8s-route53-attach-master" {
  role       = aws_iam_role.test-k8s-role-master.name
  policy_arn = aws_iam_policy.master-k8s-policy.arn
}

resource "aws_iam_instance_profile" "test-k8s-profile-master" {
  name  = "test-k8s-profile-master"
  role = "test-k8s-role-master"
}
