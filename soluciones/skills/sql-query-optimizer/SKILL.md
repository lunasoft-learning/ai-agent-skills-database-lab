---
name: "sql-query-optimizer"
description: "Analiza el rendimiento de consultas T-SQL lentas en Microsoft SQL Server mediante planes de ejecución y estadísticas de E/S y tiempo, diagnostica escaneos de tabla o índice innecesarios y propone optimizaciones de sintaxis e índices no agrupados recomendados."
argument-hint: "consulta T-SQL a optimizar"
---

# Optimizador de Consultas T-SQL (SQL Server)

Utiliza este procedimiento cuando el usuario pida evaluar, acelerar o diagnosticar el rendimiento de una consulta sobre SQL Server:

## Flujo de Trabajo

1. **Verificación del contexto**:
   - Confirma la base de datos, el esquema, las tablas y los tipos de las columnas implicadas.
   - Revisa los índices existentes y sus claves antes de proponer otro. Las claves foráneas no crean índices automáticamente en SQL Server.
   - Comprueba el volumen y la distribución de los datos que afectan al filtro. Un conjunto pequeño o un filtro poco selectivo puede hacer que un escaneo sea la opción correcta.
   - No ejecutes DDL ni modifiques datos salvo que el usuario lo pida explícitamente.

2. **Medición del rendimiento**:
   - Ejecuta la consulta original con parámetros y datos representativos. Comprueba primero que devuelve el resultado esperado.
   - Para SQL Server, habilita las estadísticas de E/S y tiempo:
     ```sql
     SET STATISTICS IO ON;
     SET STATISTICS TIME ON;
     ```
   - Lee los mensajes informativos del cliente, donde aparecen las lecturas lógicas, el tiempo de CPU y el tiempo transcurrido (*elapsed time*). Estos datos no forman parte del conjunto de filas devuelto.
   - Si está disponible la extensión SQL Server (`ms-mssql.mssql`) de VS Code, el flujo de ejecución y medición es interactivo: entrega el bloque T-SQL preparado para que el usuario lo ejecute desde el editor SQL (`Ctrl + Shift + E`) y revise la pestaña **Messages** además de **Results**. No intentes ejecutar comandos de terminal como `sqlcmd` en el host local si la base de datos corre en Docker o no hay conexión de terminal configurada.
   - Si el conector usado solo entrega filas y metadatos, no concluyas que `STATISTICS` falló ni inventes métricas: indica al usuario que use la extensión SQL Server en VS Code o SSMS/Azure Data Studio, que pueden exponer esos mensajes.
   - Cuando el usuario mida Before/After en el editor, recomienda al menos 10 ejecuciones por perfil, manteniendo los mismos parámetros, datos y condiciones de caché. Resume lecturas lógicas y tiempos con una estadística representativa, como la mediana. Si no se cuenta con métricas medidas en vivo, describe el beneficio esperado cualitativamente (reducción de escaneos a búsquedas directas) sin inventar números observados.

3. **Diagnóstico del plan**:
   - Inspecciona el plan de ejecución real cuando esté disponible. Distingue sus operadores observados de estimaciones del plan estimado; no afirmes que hubo un escaneo, una conversión o una advertencia sin evidencia del plan.
   - Evalúa los escaneos según cardinalidad y selectividad: un escaneo no es necesariamente un problema, especialmente en tablas pequeñas o cuando el filtro devuelve gran parte de las filas.
   - Busca ordenaciones o agregaciones costosas, conversiones implícitas, discrepancias entre filas estimadas y reales, búsquedas (*Key Lookup*) repetidas y advertencias de índices ausentes.
   - En la extensión SQL Server de VS Code, usa **MS SQL: Toggle Actual Plan** y vuelve a ejecutar la consulta para capturar el plan real; usa **MS SQL: Estimated Plan** para obtener solo el plan estimado sin ejecutar. Desactiva el plan real después de la medición si ya no hace falta.
   - Si el cliente no permite obtener el plan, decláralo y separa explícitamente las hipótesis del diagnóstico confirmado. En SQL Server, `SET SHOWPLAN_XML` debe enviarse en un lote separado de la consulta que se quiere explicar.

4. **Propuesta y validación del índice**:
   - Ordena las claves según los predicados reales: normalmente, columnas con igualdad antes que columnas de rango; justifica el orden para la consulta concreta y considera también las uniones y el ordenamiento.
   - Usa `INCLUDE` solo para columnas necesarias para cubrir la consulta y que no convenga usar como claves. No incluyas columnas que la consulta no lee. Recuerda que un índice no agrupado sobre una tabla con índice agrupado contiene la clave agrupada como localizador, pero verifica cuál es esa clave.
   - Evita duplicar índices existentes y explica el coste de almacenamiento y mantenimiento de escrituras. Si otro acceso, como una unión sobre una tabla de detalle, sigue siendo un posible cuello de botella, sepáralo como seguimiento y no lo atribuyas al índice recomendado.
   - Devuelve la consulta reescrita solo si mejora algo concreto: proyección explícita, uniones correctas y predicados sargables. Conserva el significado y los resultados.
   - Proporciona el DDL exacto del índice no agrupado recomendado:
     ```sql
     CREATE NONCLUSTERED INDEX IX_NombreTabla_Columna
     ON SalesLT.NombreTabla (ColumnaFiltro)
     INCLUDE (ColumnasSeleccionadas);
     ```
   - Explica qué parte del plan debería mejorar y por qué. Cuantifica la mejora solo si se midió Before/After en condiciones comparables; si no, describe el beneficio esperado cualitativamente y advierte qué podría limitarlo.
