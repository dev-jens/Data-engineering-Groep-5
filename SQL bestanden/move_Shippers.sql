CREATE OR ALTER PROCEDURE [dbo].[move_Shippers]
AS
BEGIN
	TRUNCATE TABLE [Staging].[CLEANSED].[Shippers]
	TRUNCATE TABLE [Staging].[ARCHIVED].[Shippers]

	INSERT INTO [staging].[CLEANSED].[Shippers]
           ([ShippersID]
           ,[Name]
           ,[Phone])
  SELECT 
	LEFT([Name], 1) AS [ShippersID],
	SUBSTRING([Name], 4, 20) AS [Name],
	[Phone]
	FROM 
	[Staging].[RAW].[Shippers]
	WHERE 
		(TRY_CAST ( LEFT([Name], 1) as int) IS NOT NULL) AND
		(LEN(SUBSTRING([Name], 4, 20)) <= 20 AND (SUBSTRING([Name], 4, 20) IS NOT NULL))AND 
		(LEN([Phone]) <= 20 AND ([Phone] IS NOT NULL))


	INSERT INTO [Staging].[ARCHIVED].[Shippers]
           ([Name]
           ,[Phone])
	SELECT 
	*
	FROM 
	[Staging].[RAW].[Shippers]
	WHERE 
		(TRY_CAST ( LEFT([Name], 1) as int) IS NULL) OR
		(LEN(SUBSTRING([Name], 4, 20)) > 20 AND (SUBSTRING([Name], 4, 20) IS NULL))or 
		(LEN([Phone]) > 20 AND ([Phone] IS  NULL))


END;
GO

EXEC move_Shippers;