# Insecure secret

resource "aws_secretsmanager_secret" "secret-a33" {
  name = "rotation-example"
}