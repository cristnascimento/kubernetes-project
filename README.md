# Running order

1. Create VPC and Subnet
1. Create Security Groups
1. Create Private Hosted Zone
1. Create IAM Roles: kubectl, master and nodes
1. Create S3 bucket
1. Create EC2 kubectl
1. Ansible - Install kubectl and kops
1. Ansible - Deploy kubernetes cluster
1. Ansible - Deploy application

# References

Deploying Kubernetes Cluster on AWS using Terraform

https://www.nclouds.com/blog/kubernetes-aws-terraform-kops/

Installing Kubernetes:

https://kubernetes.io/docs/setup/production-environment/tools/kops/

https://zero-to-jupyterhub.readthedocs.io/en/latest/amazon/step-zero-aws.html

Kubernetes Template + Terraform

https://medium.com/bench-engineering/deploying-kubernetes-clusters-with-kops-and-terraform-832b89250e8e

https://github.com/BenchLabs/blog-k8s-kops-terraform/blob/master/kubernetes-cluster/cluster-template.yaml


Another Kubernetes Template + Terraform

https://github.com/nclouds/generalized/tree/rogue_one/terraform/terraform-kops/modules/kubernetes/templates/kops

https://www.nclouds.com/blog/kubernetes-aws-terraform-kops/
