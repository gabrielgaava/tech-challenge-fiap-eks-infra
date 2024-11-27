# To use node groups :
# Private Kubernetes node group with EC2 Instances
resource "aws_eks_node_group" "private_nodes" {
    cluster_name    = aws_eks_cluster.this.name
    node_group_name = "private-nodes"
    node_role_arn   = "arn:aws:iam::775370709632:role/LabRole"

    subnet_ids = module.vpc.private_subnets
    
    capacity_type  = "ON_DEMAND"
    instance_types = ["t2.small"]

    scaling_config {
      desired_size = 2
      max_size     = 6
      min_size     = 2
    }

    update_config {
      max_unavailable = 1
    }

    labels = {
      role = "private-nodes"
    }
}

