---
name: schema-exploration
description: Lists tables, describes columns and data types, identifies foreign key relationships, and maps entity relationships in a database. Use when the user asks about database schema, table structure, column types, what tables exist, ERD, foreign keys, or how entities relate.
---

# Schema Exploration Skill (Versión adaptada al laboratorio)

Habilidad comunitaria para la introspección y exploración de esquemas relacionales, basada en el estándar de `langchain-ai/deepagents` y adaptada para nuestro entorno de trabajo con Microsoft SQL Server.

## Flujo de Trabajo (Workflow)

### 1. Listar todas las tablas
Inspecciona las tablas base disponibles en el catálogo de la base de datos consultando `INFORMATION_SCHEMA.TABLES` o `sys.tables`.

Esto devuelve el listado completo de tablas del esquema `SalesLT` que podemos consultar.

### 2. Obtener el esquema de tablas específicas
Inspecciona los metadatos de las tablas objetivo para examinar:
- **Nombres de columna**: qué campos están disponibles.
- **Tipos de datos**: `INT`, `NVARCHAR`, `DATETIME`, etc.
- **Claves primarias**: identificadores únicos de fila (`PRIMARY KEY`).
- **Claves foráneas**: relaciones hacia otras tablas (`sys.foreign_keys`).

### 3. Mapear relaciones
Identifica cómo se conectan las tablas en el esquema:
- Columnas terminadas en `ID` (ej. `CustomerID`, `ProductID`).
- Claves foráneas que enlazan con claves primarias de otras tablas.
- Estructura padre-hijo para resolver uniones `JOIN` con precisión.

### 4. Responder a la consulta
Proporciona información estructurada sobre:
- Tablas disponibles y su propósito de negocio.
- Estructura de campos y restricciones.
- Rutas de unión recomendadas (`INNER JOIN`, `LEFT JOIN`).

---

## Directivas para el Agente

- **Estrategia Explore-First**: Antes de redactar o ejecutar cualquier consulta SQL, comprueba siempre la existencia real de las tablas y sus relaciones en el esquema.
- **Evitar alucinaciones**: No asumas nombres de columnas o claves de unión sin haber consultado previamente el catálogo de metadatos.
- **Soporte de dialectos**: Compatible con Microsoft SQL Server (T-SQL) y esquema `SalesLT`.

---

## Conexión y Parámetros del Entorno

Cuando interactúes con la base de datos de pruebas local, lee las variables de entorno definidas en el archivo `.env`:
- `MSSQL_HOST`: Host del servidor (`localhost`).
- `MSSQL_PORT`: Puerto de conexión (`1433`).
- `MSSQL_USER`: Usuario administrador (`sa`).
- `MSSQL_PASSWORD`: Contraseña configurada en el entorno (`SecretPassword123!`).
- `MSSQL_DATABASE`: Base de datos de trabajo (`AdventureWorksLT`).
