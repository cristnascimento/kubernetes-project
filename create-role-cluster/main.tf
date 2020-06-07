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

resource "aws_iam_role_policy_attachment" "k8s-s3-attach-nodes" {
  role       = aws_iam_role.test-k8s-role-nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_role_policy_attachment" "k8s-route53-attach-nodes" {
  role       = aws_iam_role.test-k8s-role-nodes.name
  policy_arn = "arn:aws:iam::660013417910:policy/nodes-k8s-policy"

}

resource "aws_iam_instance_profile" "test-k8s-profile-nodes" {
  name  = "test-k8s-profile-nodes"
  role = "test-k8s-role-nodes"
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

resource "aws_iam_role_policy_attachment" "k8s-route53-attach-master" {
  role       = aws_iam_role.test-k8s-role-master.name
  policy_arn = "arn:aws:iam::660013417910:policy/master-k8s-policy"
}

resource "aws_iam_instance_profile" "test-k8s-profile-master" {
  name  = "test-k8s-profile-master"
  role = "test-k8s-role-master"
}
