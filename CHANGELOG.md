# Changelog

Todas las modificaciones notables de este proyecto serán documentadas en este archivo de acuerdo con el estándar de Versionado Semántico (SemVer).

## [0.1.2] - 2026-05-28
### Fixed
- Corrección de sintaxis HCL en el bloque de ejemplo del `README.md` (eliminación de hipervínculo markdown para evitar errores de compilación).

## [0.1.1] - 2026-05-28
### Fixed
- Actualización de la documentación en el `README.md` para incluir el usuario de GitHub correcto en el bloque de código de ejemplo de uso.

## [0.1.0] - 2026-05-28
### Added
- Estructura base del módulo de redes de forma desacoplada (main.tf, variables.tf, outputs.tf, versions.tf).
- Recurso de VPC principal con soporte de nombres de dominio y resolución DNS habilitados.
- Configuración de cuatro subredes independientes (dos públicas y dos privadas) para alta disponibilidad.
- Componentes de conectividad pública: Internet Gateway y un NAT Gateway con IP elástica (EIP).
- Auditoría perimetral mediante VPC Flow Logs integrados con CloudWatch Logs.
- Directivas de seguridad y cifrado usando una llave criptográfica AWS KMS con su respectiva política de accesos.
- Grupo de seguridad perimetral configurado específicamente para accesos administrativos SSH restringidos.