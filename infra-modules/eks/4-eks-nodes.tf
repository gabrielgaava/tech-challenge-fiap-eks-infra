
  # Private Kubernetes node group
  resource "aws_eks_node_group" "private_nodes" {
    cluster_name    = aws_eks_cluster.this.name
    node_group_name = "private-nodes"
    node_role_arn   = "arn:aws:iam::387913590278:role/LabRole"
  
    subnet_ids = module.vpc.private_subnets

    capacity_type  = "ON_DEMAND"
    instance_types = ["t2.small"]
  
    scaling_config {
      desired_size = 1
      max_size     = 2
      min_size     = 0
    }
  
    update_config {
      max_unavailable = 1
    }
  
    labels = {
      role = "private-nodes"
    }
  }
  
  # Public Kubernetes node group (Most of the time you don't need this!)
  resource "aws_eks_node_group" "public_nodes" {
    cluster_name    = aws_eks_cluster.this.name
    node_group_name = "public-nodes"
    node_role_arn   = "arn:aws:iam::387913590278:role/LabRole"
    
    subnet_ids = module.vpc.public_subnets

    capacity_type  = "ON_DEMAND"
    instance_types = ["t2.small"]
  
    scaling_config {
      desired_size = 1
      max_size     = 2
      min_size     = 0
    }
  
    update_config {
      max_unavailable = 1
    }
  
    labels = {
      role = "public-nodes"
    }
  }