---
name: sql-query-optimizer
description: Analiza el rendimiento de consultas T-SQL lentas en Microsoft SQL Server mediante planes de ejecución y estadísticas de E/S y tiempo, diagnostica escaneos de tabla o índice innecesarios y propone optimizaciones de sintaxis e índices no agrupados recomendados.
argument-hint: [consulta T-SQL a optimizar]
---

# Optimizador de Consultas T-SQL (SQL Server)

Utiliza este procedimiento cuando el usuario pida evaluar, acelerar o diagnosticar el rendimiento de una consulta sobre SQL Server:

## Flujo de Trabajo

1. **Medición del Rendimiento con Estadísticas**:
   - Antes de ejecutar la consulta en el banco de pruebas, activa las estadísticas de tiempo y lecturas lógicas:
     ```sql
     SET STATISTICS IO ON;
     SET STATISTICS TIME ON;
     ```
   - Inspecciona el número de lecturas lógicas (*logical reads*) y el tiempo de CPU y tiempo transcurrido (*elapsed time*).

2. **Diagnóstico del Plan de Ejecución**:
   - Identifica si existen escaneos completos de tabla (*Table Scan*) o escaneos de índice agrupado no selectivos (*Clustered Index Scan*).
   - Detecta operadores de ordenación costosos (*Sort*), conversiones implícitas de tipos (*Type Conversion*) y advertencias de falta de índices (*Missing Index Warning*).

3. **Propuesta de Solución Estructurada**:
   - Devuelve la consulta reescrita aplicando buenas prácticas (selección explícita de campos en lugar de `SELECT *`, uniones correctas y filtros sargables).
   - Genera la sentencia DDL exacta con el índice no agrupado recomendado:
     ```sql
     CREATE NONCLUSTERED INDEX IX_NombreTabla_Columna
     ON SalesLT.NombreTabla (ColumnaFiltro)
     INCLUDE (ColumnasSeleccionadas);
     ```
   - Explica brevemente la reducción de lecturas lógicas y coste porcentual esperada tras aplicar el cambio.
