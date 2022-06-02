create or alter procedure [dbo].[move_Categories]
as
begin
	truncate table [Staging].[CLEANSED].[Categories]
	truncate table [Staging].[ARCHIVED].[Categories]

INSERT INTO [Staging].[CLEANSED].[Categories]
           ([CategoryID]
           ,[CategoryName]
           ,[Discription])
	select *
	from [Staging].[RAW].[Categories]
	where ((TRY_CAST([CategoryID] as int)is not null)
		and (LEN([CategoryName]) <= 20)
		and (LEN([Description]) <= 50))

INSERT INTO [Staging].[ARCHIVED].[Categories]
           ([CategoryID]
           ,[CategoryName]
           ,[Discription])
	select *
	from [Staging].[RAW].[Categories]
	where ((TRY_CAST([CategoryID] as int)is null)
		or (LEN([CategoryName]) > 20)
		or (LEN([Description]) > 50))

END;
GO
exec move_Categories
