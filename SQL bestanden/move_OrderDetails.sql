CREATE OR ALTER PROCEDURE [dbo].[move_OrderDetails]
AS
BEGIN
	TRUNCATE TABLE [staging].[CLEANSED].[Orders Details]
	TRUNCATE TABLE [staging].[ARCHIVED].[Orders Details]

	INSERT INTO [staging].[CLEANSED].[Orders Details] ([OrderID],[Quantity],[Discount])
	SELECT
		[OrderID],
		[Quantity],
		CONVERT(decimal, [Discount])
	FROM 
	[staging].[RAW].[Orders Details]
	WHERE
		(TRY_CAST (OrderID as int) IS NOT NULL) AND
		(TRY_CAST (Quantity as TINYINT) IS NOT NULL) AND
		(TRY_CAST (Discount as decimal) IS NULL)

	INSERT INTO [staging].[ARCHIVED].[Orders Details] ([OrderID],[Quantity],[Discount])
	SELECT
		[OrderID],
		[Quantity],
		[Discount]
	FROM 
	[staging].[RAW].[Orders Details]
	WHERE
		(TRY_CAST (OrderID as int) IS NULL) or
		(TRY_CAST (Quantity as TINYINT) IS NULL) or
		(TRY_CAST (Discount as decimal) IS NOT NULL)
	
END; 
GO

EXEC [dbo].[move_OrderDetails]
GO
