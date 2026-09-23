USE AdventureWorksLT;
GO

-- =========================================================================
-- Verificación del laboratorio: comprobación rápida de conexión y datos
-- Curso: AI agent skills para bases de datos (Vídeo 01_02)
-- =========================================================================

-- 1. Comprobar que las tablas principales del esquema SalesLT están creadas
SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'SalesLT';
GO

-- 2. Consultar los primeros 5 clientes cargados en el contenedor
SELECT TOP (5) 
    CustomerID, 
    FirstName, 
    LastName, 
    CompanyName, 
    EmailAddress,
    Phone
FROM SalesLT.Customer;
GO
