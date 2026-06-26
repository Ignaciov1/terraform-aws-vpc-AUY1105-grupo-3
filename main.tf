# Generador de sufijo aleatorio
resource "random_string" "sufijo" {
  length  = 5
  special = false
  upper   = false
}

# 1. Configuración de KMS
resource "aws_kms_key" "log_key" {
  description             = "Llave para cifrar logs de CloudWatch"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "log_key_alias" {
  name          = "alias/cloudwatch-logs-key-${random_string.sufijo.result}"
  target_key_id = aws_kms_key.log_key.key_id
}

resource "aws_kms_key_policy" "log_key_policy" {
  key_id = aws_kms_key.log_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Enable IAM User Permissions"
        Effect    = "Allow"
        Principal = { AWS = "*" }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        Sid       = "Allow CloudWatch Logs"
        Effect    = "Allow"
        Principal = { Service = "logs.amazonaws.com" }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

# 2. Infraestructura de Red (VPC, Subnets)
resource "aws_vpc" "mi_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Securizamos el Security Group por defecto
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.mi_vpc.id
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mi_vpc.id
  tags = { Name = "igw-principal" }
}

# Subnets
resource "aws_subnet" "subnet_publica_1" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = false
}

resource "aws_subnet" "subnet_publica_2" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = false
}

resource "aws_subnet" "subnet_privada_1" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.private_subnet_1_cidr
  map_public_ip_on_launch = false
}

resource "aws_subnet" "subnet_privada_2" {
  vpc_id                  = aws_vpc.mi_vpc.id
  cidr_block              = var.private_subnet_2_cidr
  map_public_ip_on_launch = false
}

# 3. Flow Logs
resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name              = "/aws/vpc/flow-logs-${random_string.sufijo.result}"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.log_key.arn
}

resource "aws_flow_log" "mi_flow_log" {
  iam_role_arn    = var.lab_role_arn
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.mi_vpc.id
}

# 4. NAT Gateway y EIP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_publica_1.id
  depends_on    = [aws_internet_gateway.igw]
}

# 5. Grupos de Seguridad (Traído de sg-group.tf)
#resource "aws_security_group" "ssh_access" {
#  name        = "ssh-access"
#  description = "Permitir acceso SSH restringido"
#  vpc_id      = aws_vpc.mi_vpc.id
#
#  ingress {
#    description = "SSH desde mi IP segura"
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = [var.my_ip]
#  }
#
#  egress {
#    description = "Salida restringida HTTPS"
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = { Name = "ssh-access" }
#}