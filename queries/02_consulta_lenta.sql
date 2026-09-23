USE AdventureWorksLT;
GO

-- =========================================================================
-- Caso Práctico de Rendimiento: Consulta no indexada sobre el histórico
-- Curso: AI agent skills para bases de datos (Vídeos 04_01 y 05_02)
-- =========================================================================

-- Activamos estadísticas de E/S y tiempo para medir lecturas lógicas y CPU
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- Consulta analítica: Total gastado por cliente y producto en pedidos de 2026
-- Al no disponer de índices no agrupados sobre las claves de unión y filtro,
-- SQL Server debe realizar escaneos completos de índice agrupado (Clustered Index Scan).
SELECT 
    c.CustomerID,
    c.CompanyName,
    p.Name AS ProductName,
    SUM(d.OrderQty) AS TotalQuantity,
    SUM(d.LineTotal) AS TotalSpent
FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader h ON c.CustomerID = h.CustomerID
JOIN SalesLT.SalesOrderDetail d ON h.SalesOrderID = d.SalesOrderID
JOIN SalesLT.Product p ON d.ProductID = p.ProductID
WHERE h.OrderDate >= '2026-01-01'
GROUP BY c.CustomerID, c.CompanyName, p.Name
ORDER BY TotalSpent DESC;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

-- =========================================================================
-- Solución recomendada que propondrá el Agent Skill:
-- =========================================================================
-- CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_CustomerID_OrderDate
-- ON SalesLT.SalesOrderHeader (CustomerID, OrderDate)
-- INCLUDE (SubTotal, TotalDue);
-- GO
