# Verificar se o repositório ECR já existe
data "aws_ecr_repository" "existing_repo" {
  name = "tech-challenge-fiap"

  # Ignora erros se o repositório não for encontrado
  count = 1
  lifecycle {
    ignore_errors = true
  }
}

# Criar o repositório ECR apenas se ele não existir
resource "aws_ecr_repository" "tech-challenge-fiap-repo" {
  count = length(data.aws_ecr_repository.existing_repo.id) == 0 ? 1 : 0

  name                 = "tech-challenge-fiap"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}