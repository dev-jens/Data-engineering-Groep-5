CREATE OR ALTER PROCEDURE [dbo].[move_Order]
AS
BEGIN
	TRUNCATE TABLE [staging].[CLEANSED].[Orders]
	TRUNCATE TABLE [staging].[ARCHIVED].[Orders]

INSERT INTO [staging].[CLEANSED].[Orders]
           ([OrderID],[CustomerID],[EmployeeID],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress] ,[ShipCity],[ShipPostalCode],[ShipCountry],[ProductID])
SELECT 
	   TRY_CAST([OrderID] AS int)
      ,[CustomerID]
      ,TRY_CAST([EmployeeID] AS tinyint)
      ,TRY_CAST([OrderDate] AS datetime)
      ,TRY_CAST([RequiredDate] AS datetime)
      ,TRY_CAST([ShippedDate] AS datetime)
      ,TRY_CAST([ShipVia] AS tinyint)
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,TRY_CAST([ShipPostalCode] AS int)
      ,[ShipCountry]
      ,TRY_CAST([ProductID] AS tinyint)
  FROM [staging].[RAW].[Orders] 
  WHERE
		(OrderID  IS NOT NULL)  AND
		(LEN(CustomerID) = 5  AND (CustomerID IS NOT NULL)) AND
		(EmployeeID IS NOT NULL) AND
		(OrderDate IS NOT NULL) AND 
		(RequiredDate IS NOT NULL) AND
		(ShippedDate IS NOT NULL) AND 
		(ShipVia IS NOT NULL) AND 
		(Freight IS NOT NULL) AND
		(LEN(ShipName) <= 50 AND (ShipName IS NOT NULL)) AND
		(LEN(ShipAddress) <= 50 AND (ShipAddress IS NOT NULL)) AND
		(LEN(ShipCity) <= 20 AND (ShipCity IS NOT NULL)) AND
		(LEN(ShipPostalCode) <= 10 AND (ShipPostalCode IS NOT NULL)) AND
		(LEN(ShipCountry) <= 15 AND (ShipCountry IS NOT NULL)) AND
		(ProductID IS NOT NULL)
	UNION ALL
SELECT 
	   TRY_CAST([OrderID] AS int)
      ,[CustomerID] AS int
      ,TRY_CAST([EmployeeID] AS tinyint)
      ,TRY_CAST([OrderDate] AS datetime)
      ,TRY_CAST([RequiredDate] AS datetime)
      ,TRY_CAST([ShippedDate] AS datetime)
      ,TRY_CAST([ShipVia] AS tinyint)
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,TRY_CAST([ShipPostalCode] AS int)
      ,[ShipCountry]
      ,TRY_CAST([ProductID] AS tinyint)
  FROM [staging].[RAW].[Orders2] 
  WHERE
		(OrderID  IS NOT NULL)  AND
		(LEN(CustomerID) = 5  AND (CustomerID IS NOT NULL)) AND
		(EmployeeID IS NOT NULL) AND
		(OrderDate IS NOT NULL) AND 
		(RequiredDate IS NOT NULL) AND
		(ShippedDate IS NOT NULL) AND 
		(ShipVia IS NOT NULL) AND 
		(Freight IS NOT NULL) AND
		(LEN(ShipName) <= 50 AND (ShipName IS NOT NULL)) AND
		(LEN(ShipAddress) <= 50 AND (ShipAddress IS NOT NULL)) AND
		(LEN(ShipCity) <= 20 AND (ShipCity IS NOT NULL)) AND
		(LEN(ShipPostalCode) <= 10 AND (ShipPostalCode IS NOT NULL)) AND
		(LEN(ShipCountry) <= 15 AND (ShipCountry IS NOT NULL)) AND
		(ProductID IS NOT NULL)

INSERT INTO [staging].[ARCHIVED].[Orders]
           ([OrderID],[CustomerID],[EmployeeID],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipPostalCode],[ShipCountry],[ProductID])
SELECT 
	   TRY_CAST([OrderID] AS int)
      ,[CustomerID]
      ,TRY_CAST([EmployeeID] AS tinyint)
      ,TRY_CAST([OrderDate] AS datetime)
      ,TRY_CAST([RequiredDate] AS datetime)
      ,TRY_CAST([ShippedDate] AS datetime)
      ,TRY_CAST([ShipVia] AS tinyint)
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,TRY_CAST([ShipPostalCode] AS int)
      ,[ShipCountry]
      ,TRY_CAST([ProductID] AS tinyint)
  FROM [staging].[RAW].[Orders]
  WHERE
		(OrderID IS NULL)  or
		(LEN(CustomerID) <> 5  OR (CustomerID IS NULL)) or
		(EmployeeID IS NULL) or
		(OrderDate IS NULL) or 
		(RequiredDate IS NULL) or
		(ShippedDate IS NULL) or 
		(ShipVia IS NULL) or 
		(Freight IS NULL) or
		(LEN(ShipName) > 50 OR (ShipName IS NULL)) or
		(LEN(ShipAddress) > 50 OR (ShipAddress IS  NULL)) or
		(LEN(ShipCity) > 20 OR (ShipCity IS NULL)) or
		(LEN(ShipPostalCode) > 10 OR (ShipPostalCode IS NULL)) or
		(LEN(ShipCountry) > 15 OR (ShipCountry IS NULL)) or
		(ProductID IS NULL)
	UNION ALL
SELECT 
	   TRY_CAST([OrderID] AS int)
      ,[CustomerID]
      ,TRY_CAST([EmployeeID] AS tinyint)
      ,TRY_CAST([OrderDate] AS datetime)
      ,TRY_CAST([RequiredDate] AS datetime)
      ,TRY_CAST([ShippedDate] AS datetime)
      ,TRY_CAST([ShipVia] AS tinyint)
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,TRY_CAST([ShipPostalCode] AS int)
      ,[ShipCountry]
      ,TRY_CAST([ProductID] AS tinyint)
  FROM [staging].[RAW].[Orders2]
  WHERE
		(OrderID IS NULL)  or
		(LEN(CustomerID) <> 5  OR (CustomerID IS NULL)) or
		(EmployeeID IS NULL) or
		(OrderDate IS NULL) or 
		(RequiredDate IS NULL) or
		(ShippedDate IS NULL) or 
		(ShipVia IS NULL) or 
		(Freight IS NULL) or
		(LEN(ShipName) > 50 OR (ShipName IS NULL)) or
		(LEN(ShipAddress) > 50 OR (ShipAddress IS  NULL)) or
		(LEN(ShipCity) > 20 OR (ShipCity IS NULL)) or
		(LEN(ShipPostalCode) > 10 OR (ShipPostalCode IS NULL)) or
		(LEN(ShipCountry) > 15 OR (ShipCountry IS NULL)) or
		(ProductID IS NULL)

END;
GO

EXEC [dbo].[move_Order]