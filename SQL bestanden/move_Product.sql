
create or alter procedure [dbo].[move_Product]
as
begin
	truncate table [STAGING].[CLEANSED].[Product]
	truncate table [STAGING].[ARCHIVED].[Product]

INSERT INTO [STAGING].[CLEANSED].[Product]
           ([ProductID]
           ,[ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
		   	select *
	from [RAW].[Product]

	where ((TRY_CAST([ProductID] as tinyint)is not null)
        and (LEN([ProductName]) <=40)
        and (TRY_CAST([SupplierID] as tinyint) is not null)
        and (TRY_CAST([CategoryID] as tinyint) is not null)
        and (LEN([QuantityPerUnit]) <= 35)
        and (TRY_CAST([UnitPrice] as decimal) is not null)
        and (TRY_CAST([UnitsInStock]as int)is not null)
        and (TRY_CAST([UnitsOnOrder]as int)is not null)
        and (TRY_CAST([ReorderLevel]as int)is not null)
        and (TRY_CAST([Discontinued] as bit) is not null))


INSERT INTO [STAGING].[ARCHIVED].[Product]
           ([ProductID]
           ,[ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
		   	select *
	from [RAW].[Product]

	where ((TRY_CAST([ProductID] as tinyint)is null)
        or (LEN([ProductName]) >40)
        or (TRY_CAST([SupplierID] as tinyint) is null)
        or (TRY_CAST([CategoryID] as tinyint) is null)
        or (LEN([QuantityPerUnit]) <> 35)
        or (TRY_CAST([UnitPrice] as decimal) is null)
        or (TRY_CAST([UnitsInStock]as int)is null)
        or (TRY_CAST([UnitsOnOrder]as int)is null)
        or (TRY_CAST([ReorderLevel]as int)is null)
        or (TRY_CAST([Discontinued] as bit) is null))

END;
GO
exec move_Product