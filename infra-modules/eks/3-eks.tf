/*
  resource "aws_iam_role_policy_attachment" "eks_amazon_eks_cluster_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       =  aws_iam_role.eks.name
  }
*/
  
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = "1.30"
  role_arn = "arn:aws:iam::793862496606:role/LabRole"

  vpc_config {
    subnet_ids = concat(
      module.vpc.private_subnets,
      module.vpc.public_subnets
    )
  }
}