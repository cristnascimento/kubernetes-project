provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "test-k8s-role-nodes" {
  name = "test-k8s-role-nodes"

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

resource "aws_iam_policy" "nodes-k8s-policy" {
  name        = "nodes-k8s-policy"
  description = "A policy for k8s nodes"
  policy      = file("policy_nodes.json")
}


resource "aws_iam_role_policy_attachment" "k8s-s3-attach-nodes" {
  role       = aws_iam_role.test-k8s-role-nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_role_policy_attachment" "k8s-route53-attach-nodes" {
  role       = aws_iam_role.test-k8s-role-nodes.name
  policy_arn = aws_iam_policy.nodes-k8s-policy.arn

}

resource "aws_iam_instance_profile" "test-k8s-profile-nodes" {
  name  = "test-k8s-profile-nodes"
  role = "test-k8s-role-nodes"
}
