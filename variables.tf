variable "vpc_cidr" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR para la subred pública 1"
  type        = string
  default     = "10.1.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR para la subred pública 2"
  type        = string
  default     = "10.1.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR para la subred privada 1"
  type        = string
  default     = "10.1.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR para la subred privada 2"
  type        = string
  default     = "10.1.4.0/24"
}

variable "my_ip" {
  description = "IP permitida para acceder por SSH"
  type        = string
  default     = "201.189.206.99/32"
}

variable "lab_role_arn" {
  description = "ARN del LabRole de AWS Academy para los Flow Logs"
  type        = string
}