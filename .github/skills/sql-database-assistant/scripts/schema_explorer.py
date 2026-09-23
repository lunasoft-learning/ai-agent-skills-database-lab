#!/usr/bin/env python3
"""
Schema Explorer — Soporte para SQL Server y bases de datos relacionales.
Genera consultas de introspección para extraer tablas, columnas, relaciones e índices.
"""

import argparse
import sys

QUERIES = {
    "sqlserver": {
        "tables": """
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;
""",
        "columns": """
SELECT 
    s.name AS schema_name,
    t.name AS table_name,
    c.name AS column_name,
    ty.name AS data_type,
    c.max_length,
    c.is_nullable
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY s.name, t.name, c.column_id;
""",
        "foreign_keys": """
SELECT 
    fk.name AS fk_constraint,
    sp.name AS parent_schema,
    tp.name AS parent_table,
    cp.name AS parent_column,
    sr.name AS ref_schema,
    tr.name AS ref_table,
    cr.name AS ref_column
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id
JOIN sys.schemas sp ON tp.schema_id = sp.schema_id
JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id
JOIN sys.schemas sr ON tr.schema_id = sr.schema_id
JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
ORDER BY sp.name, tp.name;
""",
        "indexes": """
SELECT 
    s.name AS schema_name,
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc AS index_type,
    i.is_unique,
    c.name AS column_name
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE i.name IS NOT NULL
ORDER BY s.name, t.name, i.name;
"""
    }
}

def main():
    parser = argparse.ArgumentParser(description="Extractor de consultas de introspección de esquemas.")
    parser.add_argument("--dialect", default="sqlserver", choices=["sqlserver"], help="Motor de base de datos")
    parser.add_argument("--type", default="tables", choices=["tables", "columns", "foreign_keys", "indexes", "all"], help="Tipo de metadatos a consultar")
    args = parser.parse_args()

    dialect_queries = QUERIES[args.dialect]
    if args.type == "all":
        for k, v in dialect_queries.items():
            print(f"-- === Introspección: {k.upper()} ===")
            print(v.strip())
            print("\n")
    else:
        print(dialect_queries[args.type].strip())

if __name__ == "__main__":
    main()
