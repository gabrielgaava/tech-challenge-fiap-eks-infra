resource "aws_eks_fargate_profile" "fargate_profile_default" {
    cluster_name           = var.cluster_name
    fargate_profile_name   = "fargate-application-${var.cluster_name}"

    pod_execution_role_arn = "arn:aws:iam::793862496606:role/LabRole"

    subnet_ids = module.vpc.private_subnets  # Use apenas subnets privadas para workloads

    selector {
        namespace = "fargate-application"
    }

    depends_on = [ aws_eks_cluster.this ]
}

# To use node groups :
# Private Kubernetes node group with EC2 Instances
resource "aws_eks_node_group" "private_nodes" {
    cluster_name    = aws_eks_cluster.this.name
    node_group_name = "private-nodes"
    node_role_arn   = "arn:aws:iam::793862496606:role/LabRole"

    subnet_ids = module.vpc.private_subnets
    
    capacity_type  = "ON_DEMAND"
    instance_types = ["t2.small"]

    scaling_config {
      desired_size = 1
      max_size     = 6
      min_size     = 1
    }

    update_config {
      max_unavailable = 1
    }

    labels = {
      role = "private-nodes"
    }
}

