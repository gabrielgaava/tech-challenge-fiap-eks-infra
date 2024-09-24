resource "aws_eks_fargate_profile" "fargate_profile_kube_system" {
    cluster_name           = var.cluster_name
    fargate_profile_name   = "fargate-kube-system-${var.cluster_name}"

    pod_execution_role_arn = "arn:aws:iam::793862496606:role/LabRole"

    subnet_ids = module.vpc.private_subnets

    selector {
        namespace = "kube-system"
    }

    depends_on = [ aws_eks_cluster.this ]
}

resource "aws_eks_fargate_profile" "fargate_profile_default" {
    cluster_name           = var.cluster_name
    fargate_profile_name   = "fargate-default-${var.cluster_name}"

    pod_execution_role_arn = "arn:aws:iam::793862496606:role/LabRole"

    subnet_ids = module.vpc.private_subnets  # Use apenas subnets privadas para workloads

    selector {
        namespace = "default"
    }

    depends_on = [ aws_eks_cluster.this ]
}

/*
    # To use node groups :  
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
  */
