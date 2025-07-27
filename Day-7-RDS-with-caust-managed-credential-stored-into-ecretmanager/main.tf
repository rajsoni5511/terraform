
# Create the Secrets Manager secret
resource "aws_secretsmanager_secret" "rds" {
  name = "rds/db-credentials"
}

# Store the credentials as a secret value
resource "aws_secretsmanager_secret_version" "rds" {
  secret_id     = aws_secretsmanager_secret.rds.id
  secret_string = jsonencode({
    username = "admin"
    password = "YourSecurePassword123!"
  })
}

# Read the secret version
data "aws_secretsmanager_secret_version" "rds" {
  depends_on = [aws_secretsmanager_secret_version.rds]
  secret_id  = aws_secretsmanager_secret.rds.id
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
}
