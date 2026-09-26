---
name: schema-exploration
description: Lists tables, describes columns and data types, identifies foreign key relationships, and maps entity relationships in a database. Use when the user asks about database schema, table structure, column types, what tables exist, ERD, foreign keys, or how entities relate.
---

# Schema Exploration Skill

Habilidad comunitaria para la introspección y exploración de esquemas relacionales, originaria de `langchain-ai/deepagents`.

## Capacidades

1. **Listar tablas**: Inspecciona las tablas base disponibles en el catálogo de la base de datos (`INFORMATION_SCHEMA.TABLES` o `sys.tables`).
2. **Describir estructura**: Extrae columnas, tipos de datos, nulabilidad y restricciones de clave primaria (`sys.columns`, `sys.types`).
3. **Mapear relaciones**: Identifica claves foráneas (`foreign keys`) y relaciones entre entidades para generar consultas SQL precisas y diagramas ERD.

## Directivas para el Agente

- **Estrategia Explore-First**: Antes de redactar o ejecutar cualquier consulta SQL, comprueba siempre la existencia real de las tablas y sus relaciones en el esquema.
- **Evitar alucinaciones**: No asumas nombres de columnas o claves de unión sin haber consultado previamente el catálogo de metadatos.
- **Soporte de dialectos**: Compatible con Microsoft SQL Server (T-SQL), PostgreSQL y MySQL.

## Conexión y Parámetros

Cuando interactúes con la base de datos local en Docker, utiliza los parámetros definidos en el entorno:
- **Host**: `localhost`
- **Puerto**: `1433`
- **Usuario**: `sa`
- **Base de datos**: `AdventureWorksLT`
