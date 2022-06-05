USE Staging;

DROP TABLE [CLEANSED].[Categories]
DROP TABLE [CLEANSED].[Customers]
DROP TABLE [CLEANSED].[Shippers]
DROP TABLE [CLEANSED].[Product]
DROP TABLE [CLEANSED].[Orders]
DROP TABLE [CLEANSED].[Orders Details]
DROP TABLE [CLEANSED].[Suppliers]


CREATE TABLE [CLEANSED].[Categories]
(
	[CategoryID] TINYINT NOT NULL PRIMARY KEY,
    [CategoryName] NVARCHAR(20),
	[Discription] NVARCHAR(50)

);
CREATE TABLE [CLEANSED].[Customers]
(
	[CustomerID] CHAR(5) NOT NULL PRIMARY KEY,
	[Customer] VARCHAR(50),
	[ContactName Customer] VARCHAR(75),
	[Title] VARCHAR(25),
	[Adres] VARCHAR(30),
	[City] VARCHAR(20),
	[PostalCode] VARCHAR(10),
	[Country] VARCHAR(15),
	[Phone] VARCHAR(20)
);

CREATE TABLE [CLEANSED].[Shippers] (
	[ShippersID] TINYINT NOT NULL PRIMARY KEY,
	[Name] VARCHAR(20),
	[Phone] VARCHAR(20)
);

CREATE TABLE [CLEANSED].[Product] (
	[ProductID] TINYINT NOT NULL PRIMARY KEY,
	[ProductName] NVARCHAR(40),
	[SupplierID] TINYINT NOT NULL, 
	[CategoryID] TINYINT NOT NULL,
	[QuantityPerUnit] NVARCHAR(35),
	[UnitPrice] DECIMAL(5,2),
	[UnitsInStock] INT,
	[UnitsOnOrder] INT,
	[ReorderLevel] INT,
	[Discontinued] BIT
)

CREATE TABLE [CLEANSED].[Orders]
(
	[OrderID] INT NOT NULL PRIMARY KEY,
	[CustomerID] CHAR(5) ,
	[EmployeeID] TINYINT,
	[OrderDate] DATETIME NOT NULL,
	[RequiredDate] DATETIME NOT NULL,
	[ShippedDate] DATETIME,
	[ShipVia] TINYINT NOT NULL ,
	[Freight] DECIMAL(18,0) NOT NULL,
	[ShipName] NVARCHAR(50),
	[ShipAddress] NVARCHAR(50),
	[ShipCity] NVARCHAR(20),
	[ShipPostalCode] NVARCHAR(10),
	[ShipCountry] NVARCHAR(15),
	[ProductID] TINYINT NOT NULL 
);
CREATE TABLE [CLEANSED].[Orders Details]
(
	[OrderID] INT NOT NULL PRIMARY KEY,
	[Quantity] TINYINT NOT NULL,
	[Discount] DECIMAL(3,2)
   
);
CREATE TABLE [CLEANSED].[Suppliers] (
	[SupplierID] TINYINT NOT NULL PRIMARY KEY,
	[Company] NVARCHAR(50),
	[Contact] NVARCHAR(35),
	[Contact title] NVARCHAR(35),
	[Phone] NVARCHAR(20),
	[Location] NVARCHAR(100))
