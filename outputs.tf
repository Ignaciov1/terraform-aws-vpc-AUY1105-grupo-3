output "vpc_id" {
  description = "El ID de la VPC creada"
  value       = aws_vpc.mi_vpc.id
}

output "public_subnet_1_id" {
  description = "El ID de la Subred Pública 1"
  value       = aws_subnet.subnet_publica_1.id
}

output "id_sg_ssh" {
  value = aws_security_group.ssh_access.id
}