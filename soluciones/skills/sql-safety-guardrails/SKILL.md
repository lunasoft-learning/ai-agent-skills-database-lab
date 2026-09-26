---
name: "sql-safety-guardrails"
description: "Filtro de seguridad e inspección preventiva que valida sentencias T-SQL antes de su ejecución en Microsoft SQL Server, bloqueando operaciones UPDATE y DELETE sin cláusula WHERE, controlando comandos DDL destructivos y forzando límites de lectura TOP en consultas masivas."
argument-hint: "sentencia T-SQL a validar"
---

# Guardarraíles de Seguridad T-SQL (SQL Server)

Aplica estas reglas de forma innegociable antes de ejecutar cualquier sentencia sobre la base de datos:

## Reglas de Validación Preventiva

1. **Bloqueo de Modificaciones Masivas Accidentales**:
   - Si la sentencia es un `UPDATE` o `DELETE` y **no incluye una cláusula WHERE explícita**, **BLOQUEA** inmediatamente la ejecución.
   - Muestra una advertencia:
     ```text
     [SEGURIDAD SQL SERVER]: Operación cancelada. No se permiten sentencias UPDATE o DELETE sin cláusula WHERE explícita.
     ```

2. **Control de Comandos DDL Destructivos**:
   - Si la sentencia incluye `DROP TABLE`, `DROP DATABASE`, `TRUNCATE TABLE` o `ALTER TABLE ... DROP COLUMN`:
     - Solicita confirmación explícita al usuario (*Human-in-the-Loop*).
     - Informa con claridad del riesgo de pérdida irreversible de datos antes de proceder.

3. **Límites de Lectura Segura**:
   - En cualquier consulta de lectura `SELECT` que no incluya paginación o agregaciones, exige o añade la cláusula `TOP (100)` para evitar saturación de memoria en el servidor y volcados masivos innecesarios.

4. **Prevención de Inyección SQL**:
   - Asegúrate de que las consultas generadas utilicen parámetros con tipos correctos o el procedimiento de sistema `sp_executesql` en lugar de concatenación dinámica de cadenas.
