provider "aws" {
    region = "var.aws_region"
    access_key = "var.aws_access_key"
    secret_key = "var.aws_secret_key"
    token = "var.aws_session_token"
}

terraform {
    backend "local" {
      path = "./terraform.tfstate"
    }
}

module "eks" {
    source = "./infra-modules/eks"
    cluster_name = "eks-tech-challenge"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
variable "aws_region" {}