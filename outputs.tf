output "vpc_id" {
  description = "El ID de la VPC creada"
  value       = aws_vpc.mi_vpc.id
}

output "public_subnet_1_id" {
  description = "El ID de la Subred Pública 1"
  value       = aws_subnet.subnet_publica_1.id
}

output "security_group_ssh_id" {
  description = "El ID del Security Group para SSH"
  value       = aws_security_group.ssh_access.id
}