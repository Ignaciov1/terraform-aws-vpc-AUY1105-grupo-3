# Módulo de Terraform para Redes AWS (VPC)

Repositorio destinado al desarrollo del Módulo de Redes para la Evaluación Parcial N° 2 de la asignatura **AUY1105 - Infraestructura como Código II**.

## Objetivos del Repositorio
El propósito principal de este repositorio es proporcionar un módulo desacoplado, altamente reutilizable y parametrizado para desplegar una infraestructura de red segura y estandarizada en Amazon Web Services (AWS), facilitando su implementación transparente en múltiples entornos de desarrollo.

## Propósito General del Código
Este módulo automatiza la creación de una arquitectura de red base en AWS que incluye aislamiento de componentes, auditoría perimetral y mecanismos robustos de cifrado. Despliega:
- Una VPC con soporte DNS activo.
- 4 Subredes (2 públicas y 2 privadas) distribuidas estratégicamente.
- Un Internet Gateway y un NAT Gateway para canalizar la salida controlada a Internet.
- VPC Flow Logs vinculados a CloudWatch y cifrados mediante AWS KMS.
- Un Grupo de Seguridad perimetral configurado para accesos administrativos SSH restringidos.

## Parámetros Configurables (Variables)

| Nombre | Descripción | Tipo | Por Defecto | Obligatorio |
|--------|-------------|------|-------------|-------------|
| `vpc_cidr` | Bloque CIDR principal para la VPC | `string` | `"10.1.0.0/16"` | No |
| `public_subnet_1_cidr` | CIDR para la subred pública 1 | `string` | `"10.1.1.0/24"` | No |
| `public_subnet_2_cidr` | CIDR para la subred pública 2 | `string` | `"10.1.2.0/24"` | No |
| `private_subnet_1_cidr` | CIDR para la subred privada 1 | `string` | `"10.1.3.0/24"` | No |
| `private_subnet_2_cidr` | CIDR para la subred privada 2 | `string` | `"10.1.4.0/24"` | No |
| `my_ip` | IP segura permitida para accesos vía SSH | `string` | `"201.189.206.99/32"` | No |
| `lab_role_arn` | ARN del LabRole de AWS Academy para Flow Logs | `string` | N/A | **Sí** |

## Valores de Salida (Outputs)

| Nombre | Descripción |
|--------|-------------|
| `vpc_id` | Identificador único de la VPC generada. |
| `public_subnet_1_id` | Identificador de la subred pública principal (requerida por el módulo de cómputo). |
| `security_group_ssh_id` | Identificador del Security Group configurado para acceso SSH restringido. |

## Instrucciones Básicas de Uso
Para implementar este módulo en un entorno, puede ser invocado declarando la ruta del repositorio en GitHub:

```hcl
module "redes" {
  source       = "[github.com/TU_USUARIO/terraform-aws-vpc-AUY1105-grupo-3](https://github.com/TU_USUARIO/terraform-aws-vpc-AUY1105-grupo-3)"
  lab_role_arn = "arn:aws:iam::123456789012:role/LabRole"
}