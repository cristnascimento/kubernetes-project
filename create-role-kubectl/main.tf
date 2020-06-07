provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "test-k8s-role" {
  name = "test-k8s-role"

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

resource "aws_iam_role_policy_attachment" "k8s-rds-attach" {
  role       = aws_iam_role.test-k8s-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "k8s-ec2-attach" {
  role       = aws_iam_role.test-k8s-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "k8s-iam-attach" {
  role       = aws_iam_role.test-k8s-role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_role_policy_attachment" "k8s-s3-attach" {
  role       = aws_iam_role.test-k8s-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "k8s-route53-attach" {
  role       = aws_iam_role.test-k8s-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_instance_profile" "test-k8s-profile" {
  name  = "test-k8s-profile"
  role = "test-k8s-role"
}

