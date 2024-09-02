locals {
  name = "tech-challenge-cluster"
  region = "us-east-1"
  vpc-cdir = ""
  azs = ["us-east-1a", "us-east-1b"]
}

module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"
    
    cluster_name    = "my-cluster"
    cluster_version = "1.30"
    
    cluster_endpoint_public_access  = true
    
    cluster_addons = {
        coredns                = {}
        eks-pod-identity-agent = {}
        kube-proxy             = {}
        vpc-cni                = {}
    }
    
    vpc_id                   = "vpc-0e04c2b72c3fc6365"
    subnet_ids               = ["subnet-0d0b46276b1319220", "subnet-bcde012a", "subnet-fghi345a"]
    control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]
}