CREATE OR ALTER PROCEDURE [dbo].[move_Customers]
AS
BEGIN
	TRUNCATE TABLE [Staging].[CLEANSED].[Customers]
	TRUNCATE TABLE [Staging].[ARCHIVED].[Customers]

	INSERT INTO [Staging].[CLEANSED].[Customers]
           ([CustomerID]
           ,[Customer]
           ,[ContactName Customer]
           ,[Title]
           ,[Adres]
           ,[City]
           ,[PostalCode]
           ,[Country]
           ,[Phone])
	SELECT 
	*
	FROM 
	[Staging].[RAW].[Customers]
	WHERE 
		((LEN(CustomerID) = 5) AND (CustomerID IS NOT NULL)
			AND (LEN(Customer) <= 50) 
			AND (LEN([ContactName Customer]) <= 75) 
			AND (LEN(Title) <= 25) 
			AND (LEN([Address]) <= 30) AND ([Address] IS NOT NULL)
			AND (LEN(City) <= 20) AND (City IS NOT NULL)
			AND (LEN(PostalCode) <= 10) AND (PostalCode IS NOT NULL)
			AND (LEN(Country) <= 15) AND (Country IS NOT NULL)
			AND (LEN(Phone) <= 20) AND (Phone IS NOT NULL))

	INSERT INTO [Staging].[ARCHIVED].[Customers]
           ([CustomerID]
           ,[Customer]
           ,[ContactName Customer]
           ,[Title]
           ,[Adres]
           ,[City]
           ,[PostalCode]
           ,[Country]
           ,[Phone])
	SELECT 
	*
	FROM 
	[Staging].[RAW].[Customers]
	WHERE 
			((LEN(CustomerID) <> 5) OR (CustomerID IS NULL)
			or (LEN(Customer) > 50) OR (Customer IS NULL)
			or (LEN([ContactName Customer]) > 75) 
			or (LEN(Title) > 25) 
			or (LEN([Address]) > 30) OR ([Address] IS NULL)
			or (LEN(City) > 20) OR (City IS NULL)
			or (LEN(PostalCode) > 10) OR (PostalCode IS NULL)
			or (LEN(Country) > 15) OR (Country IS NULL)
			or (LEN(Phone) > 20) OR (Phone IS NULL))
END;		
GO

EXEC move_Customers;