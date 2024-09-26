# Verificar se o repositório ECR já existe
data "aws_ecr_repository" "existing_repo" {
  name = "tech-challenge-fiap"
}

# Criar o repositório ECR apenas se ele não existir
resource "aws_ecr_repository" "my_repo" {
  count = try(data.aws_ecr_repository.existing_repo.id, "") == "" ? 1 : 0

  name                 = "tech-challenge-fiap"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}