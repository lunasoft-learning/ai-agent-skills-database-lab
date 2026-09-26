---
name: "sql-database-assistant"
description: "Use when the user asks to write SQL queries, explore database schemas, inspect table structures, or generate migration and documentation scripts for SQL Server, PostgreSQL, or MySQL."
argument-hint: "consulta SQL o nombre de tabla a inspeccionar"
---

# SQL Database Assistant

Habilidad comunitaria para la interacción operativa y exploración de esquemas en bases de datos relacionales, con soporte nativo para Microsoft SQL Server.

## Capacidades Principales

1. **Exploración de Esquemas en SQL Server**:
   - Inspección directa del catálogo del sistema mediante consultas optimizadas contra `INFORMATION_SCHEMA.TABLES` y las vistas `sys.tables`, `sys.columns`, `sys.foreign_keys` y `sys.indexes`.
   - Consulta de relaciones de clave foránea e índices existentes para evitar suposiciones sobre el modelo de datos.

2. **Formulación de Consultas en Lenguaje Natural**:
   - Conversión de requisitos de negocio a sentencias T-SQL correctas y tipadas.
   - Aplicación de uniones adecuadas (`INNER JOIN`, `LEFT JOIN`) basadas en las restricciones FK reales del esquema `SalesLT`.

3. **Herramientas Disponibles**:
   - `scripts/schema_explorer.py`: Generador de consultas de introspección e informes de esquema estructurados.

## Directivas de Conexión

Cuando interactúes con la base de datos de pruebas local, lee las variables de entorno definidas en el archivo `.env`:
- `MSSQL_HOST`: Host del servidor (por defecto: `localhost`).
- `MSSQL_PORT`: Puerto de conexión (por defecto: `1433`).
- `MSSQL_USER`: Usuario administrador (`sa`).
- `MSSQL_PASSWORD`: Contraseña configurada en el entorno.
- `MSSQL_DATABASE`: Base de datos de trabajo (`AdventureWorksLT`).
