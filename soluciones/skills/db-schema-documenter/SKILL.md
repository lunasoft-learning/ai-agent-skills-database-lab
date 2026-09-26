---
name: db-schema-documenter
description: Inspecciona el esquema de una base de datos en Microsoft SQL Server (tablas, columnas, restricciones, claves foráneas) y genera automáticamente un diccionario de datos en Markdown con diagramas entidad-relación visuales en Mermaid.
argument-hint: [nombre de la tabla o esquema opcional]
---

# Documentador de Esquemas (SQL Server)

Utiliza este procedimiento para generar o actualizar la documentación técnica del modelo de datos de SQL Server:

## Flujo de Trabajo

1. **Extracción de Metadatos**:
   - Consulta el catálogo de SQL Server (`sys.tables`, `sys.columns`, `sys.types`, `sys.foreign_keys`) para listar tablas, columnas, tipos de datos y nulabilidad del esquema `SalesLT`.
   - Identifica las claves primarias (PK) y claves foráneas (FK) que relacionan las entidades.

2. **Estructura del Diccionario de Datos**:
   - Genera una tabla en Markdown por cada entidad con las siguientes columnas:
     `| Columna | Tipo de Dato | Admite Nulos | Clave | Descripción Funcional |`
   - Añade una breve descripción funcional del propósito de la entidad en el negocio.

3. **Generación de Diagrama Mermaid**:
   - Añade un bloque de código `mermaid` con sintaxis `erDiagram`:
     ```mermaid
     erDiagram
         CUSTOMER ||--o{ SALES_ORDER_HEADER : "realiza"
         SALES_ORDER_HEADER ||--|{ SALES_ORDER_DETAIL : "contiene"
         PRODUCT ||--o{ SALES_ORDER_DETAIL : "incluido_en"
         PRODUCT_CATEGORY ||--o{ PRODUCT : "clasifica"
     ```

4. **Guardado**:
   - Escribe o actualiza el resultado en el archivo `data-dictionary.md` en la raíz del proyecto.
