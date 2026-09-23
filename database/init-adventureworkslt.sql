-- =========================================================================
-- Script de Inicialización: AdventureWorksLT (SalesLT) para SQL Server 2022
-- Curso LinkedIn Learning: AI agent skills para bases de datos
-- =========================================================================

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'AdventureWorksLT')
BEGIN
    CREATE DATABASE AdventureWorksLT;
END
GO

USE AdventureWorksLT;
GO

-- Crear esquema SalesLT
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'SalesLT')
BEGIN
    EXEC('CREATE SCHEMA SalesLT');
END
GO

-- 1. Tabla Clientes (SalesLT.Customer)
IF OBJECT_ID('SalesLT.Customer', 'U') IS NULL
BEGIN
    CREATE TABLE SalesLT.Customer (
        CustomerID INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(8) NULL,
        FirstName NVARCHAR(50) NOT NULL,
        MiddleName NVARCHAR(50) NULL,
        LastName NVARCHAR(50) NOT NULL,
        CompanyName NVARCHAR(128) NULL,
        EmailAddress NVARCHAR(50) NULL,
        Phone NVARCHAR(25) NULL,
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- 2. Tabla Categorías de Productos (SalesLT.ProductCategory)
IF OBJECT_ID('SalesLT.ProductCategory', 'U') IS NULL
BEGIN
    CREATE TABLE SalesLT.ProductCategory (
        ProductCategoryID INT IDENTITY(1,1) PRIMARY KEY,
        ParentProductCategoryID INT NULL,
        Name NVARCHAR(50) NOT NULL,
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- 3. Tabla Productos (SalesLT.Product)
IF OBJECT_ID('SalesLT.Product', 'U') IS NULL
BEGIN
    CREATE TABLE SalesLT.Product (
        ProductID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(50) NOT NULL,
        ProductNumber NVARCHAR(25) NOT NULL UNIQUE,
        Color NVARCHAR(15) NULL,
        StandardCost MONEY NOT NULL,
        ListPrice MONEY NOT NULL,
        Size NVARCHAR(5) NULL,
        Weight DECIMAL(8, 2) NULL,
        ProductCategoryID INT NULL FOREIGN KEY REFERENCES SalesLT.ProductCategory(ProductCategoryID),
        SellStartDate DATETIME NOT NULL,
        SellEndDate DATETIME NULL,
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- 4. Tabla Cabecera de Pedidos (SalesLT.SalesOrderHeader)
IF OBJECT_ID('SalesLT.SalesOrderHeader', 'U') IS NULL
BEGIN
    CREATE TABLE SalesLT.SalesOrderHeader (
        SalesOrderID INT IDENTITY(1,1) PRIMARY KEY,
        OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
        DueDate DATETIME NULL,
        ShipDate DATETIME NULL,
        Status TINYINT NOT NULL DEFAULT 1,
        SalesOrderNumber NVARCHAR(25) NOT NULL,
        CustomerID INT NOT NULL FOREIGN KEY REFERENCES SalesLT.Customer(CustomerID),
        SubTotal MONEY NOT NULL DEFAULT 0.00,
        TaxAmt MONEY NOT NULL DEFAULT 0.00,
        Freight MONEY NOT NULL DEFAULT 0.00,
        TotalDue MONEY NOT NULL DEFAULT 0.00,
        Comment NVARCHAR(MAX) NULL,
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- 5. Tabla Detalle de Pedidos (SalesLT.SalesOrderDetail)
IF OBJECT_ID('SalesLT.SalesOrderDetail', 'U') IS NULL
BEGIN
    CREATE TABLE SalesLT.SalesOrderDetail (
        SalesOrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
        SalesOrderID INT NOT NULL FOREIGN KEY REFERENCES SalesLT.SalesOrderHeader(SalesOrderID) ON DELETE CASCADE,
        OrderQty SMALLINT NOT NULL,
        ProductID INT NOT NULL FOREIGN KEY REFERENCES SalesLT.Product(ProductID),
        UnitPrice MONEY NOT NULL,
        UnitPriceDiscount MONEY NOT NULL DEFAULT 0.00,
        LineTotal MONEY NOT NULL DEFAULT 0.00,
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END
GO

-- =========================================================================
-- Inserción de Datos Iniciales Realistas
-- =========================================================================

-- Categorías
IF NOT EXISTS (SELECT 1 FROM SalesLT.ProductCategory)
BEGIN
    INSERT INTO SalesLT.ProductCategory (Name) VALUES 
    ('Bikes'), ('Components'), ('Clothing'), ('Accessories');

    INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name) VALUES 
    (1, 'Mountain Bikes'), (1, 'Road Bikes'), (1, 'Touring Bikes'),
    (2, 'Handlebars'), (2, 'Brakes'), (2, 'Pedals'),
    (3, 'Jerseys'), (3, 'Gloves'), (3, 'Shorts'),
    (4, 'Helmets'), (4, 'Locks'), (4, 'Pumps');
END
GO

-- Clientes
IF NOT EXISTS (SELECT 1 FROM SalesLT.Customer)
BEGIN
    INSERT INTO SalesLT.Customer (Title, FirstName, LastName, CompanyName, EmailAddress, Phone) VALUES
    ('Mr.', 'Orlando', 'Gee', 'A Bike Store', 'orlando0@adventure-works.com', '245-555-0173'),
    ('Mr.', 'Keith', 'Harris', 'Progressive Sports', 'keith0@adventure-works.com', '170-555-0127'),
    ('Ms.', 'Donna', 'Carreras', 'Advanced Bike Components', 'donna0@adventure-works.com', '279-555-0130'),
    ('Ms.', 'Janet', 'Gates', 'Modular Cycle Systems', 'janet1@adventure-works.com', '710-555-0173'),
    ('Mr.', 'Lucy', 'Harrington', 'Metropolitan Sports', 'lucy0@adventure-works.com', '828-555-0186'),
    ('Mr.', 'Rosmarie', 'Carroll', 'Aerobic Exercise Company', 'rosmarie0@adventure-works.com', '244-555-0112'),
    ('Mr.', 'Dominic', 'Gash', 'Associated Bike Technologies', 'dominic0@adventure-works.com', '192-555-0173'),
    ('Ms.', 'Kathleen', 'Garza', 'Rural Cycle Emporium', 'kathleen0@adventure-works.com', '150-555-0127'),
    ('Ms.', 'Katherine', 'Harding', 'Sharp Bikes', 'katherine0@adventure-works.com', '926-555-0159'),
    ('Mr.', 'Johnny', 'Caprio', 'Bikes and More', 'johnny0@adventure-works.com', '112-555-0191');
END
GO

-- Productos
IF NOT EXISTS (SELECT 1 FROM SalesLT.Product)
BEGIN
    INSERT INTO SalesLT.Product (Name, ProductNumber, Color, StandardCost, ListPrice, Size, Weight, ProductCategoryID, SellStartDate) VALUES
    ('HL Mountain Frame - Black, 38', 'FR-M94B-38', 'Black', 739.04, 1349.60, '38', 1210.0, 5, '2023-01-01'),
    ('HL Mountain Frame - Silver, 42', 'FR-M94S-42', 'Silver', 747.20, 1364.50, '42', 1250.0, 5, '2023-01-01'),
    ('Road-150 Red, 48', 'BK-R93R-48', 'Red', 2171.29, 3578.27, '48', 6800.0, 6, '2023-01-01'),
    ('Road-150 Red, 52', 'BK-R93R-52', 'Red', 2171.29, 3578.27, '52', 6900.0, 6, '2023-01-01'),
    ('Sport-100 Helmet, Red', 'HL-U509-R', 'Red', 13.08, 34.99, NULL, 340.0, 14, '2023-01-01'),
    ('Sport-100 Helmet, Black', 'HL-U509-B', 'Black', 13.08, 34.99, NULL, 340.0, 14, '2023-01-01'),
    ('Mountain Bike Gloves, M', 'GL-M201-M', 'Black', 9.00, 24.49, 'M', 110.0, 12, '2023-01-01'),
    ('Mountain Bike Gloves, L', 'GL-M201-L', 'Black', 9.00, 24.49, 'L', 120.0, 12, '2023-01-01'),
    ('ML Road Pedal', 'PD-R747', 'Silver', 27.90, 62.09, NULL, 280.0, 10, '2023-01-01'),
    ('Touring-1000 Blue, 50', 'BK-T79U-50', 'Blue', 1481.93, 2384.07, '50', 11200.0, 7, '2023-01-01');
END
GO

-- Pedidos y Líneas de Venta
IF NOT EXISTS (SELECT 1 FROM SalesLT.SalesOrderHeader)
BEGIN
    -- Pedido 1
    INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, Status, SalesOrderNumber, CustomerID, SubTotal, TaxAmt, Freight, TotalDue)
    VALUES ('2026-08-01', '2026-08-13', '2026-08-08', 5, 'SO71774', 1, 1424.59, 113.97, 35.61, 1574.17);

    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, LineTotal)
    VALUES (1, 1, 1, 1349.60, 0.00, 1349.60),
           (1, 2, 5, 34.99, 0.00, 69.98);

    -- Pedido 2
    INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, Status, SalesOrderNumber, CustomerID, SubTotal, TaxAmt, Freight, TotalDue)
    VALUES ('2026-08-10', '2026-08-22', '2026-08-17', 5, 'SO71776', 2, 3640.36, 291.23, 91.01, 4022.60);

    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, LineTotal)
    VALUES (2, 1, 3, 3578.27, 0.00, 3578.27),
           (2, 1, 9, 62.09, 0.00, 62.09);

    -- Pedido 3
    INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, Status, SalesOrderNumber, CustomerID, SubTotal, TaxAmt, Freight, TotalDue)
    VALUES ('2026-08-15', '2026-08-27', '2026-08-22', 5, 'SO71780', 3, 2419.06, 193.52, 60.48, 2673.06);

    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, LineTotal)
    VALUES (3, 1, 10, 2384.07, 0.00, 2384.07),
           (3, 1, 6, 34.99, 0.00, 34.99);

    -- Pedido 4
    INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, Status, SalesOrderNumber, CustomerID, SubTotal, TaxAmt, Freight, TotalDue)
    VALUES ('2026-08-20', '2026-09-01', '2026-08-27', 5, 'SO71782', 4, 1434.48, 114.76, 35.86, 1585.10);

    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, LineTotal)
    VALUES (4, 1, 2, 1364.50, 0.00, 1364.50),
           (4, 2, 7, 24.49, 0.00, 48.98),
           (4, 1, 5, 34.99, 0.10, 31.49);

    -- Pedido 5
    INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, Status, SalesOrderNumber, CustomerID, SubTotal, TaxAmt, Freight, TotalDue)
    VALUES ('2026-09-01', '2026-09-13', NULL, 1, 'SO71784', 1, 3578.27, 286.26, 89.46, 3953.99);

    INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, LineTotal)
    VALUES (5, 1, 3, 3578.27, 0.00, 3578.27);
END
GO
