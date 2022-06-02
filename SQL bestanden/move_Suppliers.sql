
create or alter procedure [dbo].[move_Suppliers]
as
begin
	truncate table [STAGING].[CLEANSED].[Suppliers]
	truncate table [STAGING].[ARCHIVED].[Suppliers]

INSERT INTO [STAGING].[CLEANSED].[Suppliers]
           ([SupplierID]
           ,[Company]
           ,[Contact]
           ,[Contact title]
           ,[Phone]
           ,[Location])
		   select *
	from [STAGING].[RAW].[Suppliers]

	where ((TRY_CAST([SupplierID] as tinyint) is not null)
          and (LEN([Company]) <= 50)
          and (LEN([Contact]) <= 35)
          and (LEN([Contact title]) <= 35)
          and (LEN([Phone]) <= 20)
          and (LEN([Location]) <= 100))


INSERT INTO [STAGING].[ARCHIVED].[Suppliers]
           ([SupplierID]
           ,[Company]
           ,[Contact]
           ,[Contact title]
           ,[Phone]
           ,[Location])
		   select *
	from [STAGING].[RAW].[Suppliers]

	where ((TRY_CAST([SupplierID] as tinyint) is null)
          or (LEN([Company]) <> 50)
          or (LEN([Contact]) <> 35)
          or (LEN([Contact title]) <> 35)
          or (LEN([Phone]) <> 20)
          or (LEN([Location]) <> 100))

END;
GO
exec move_Suppliers

