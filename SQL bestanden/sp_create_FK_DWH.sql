CREATE OR ALTER PROCEDURE [dbo].[sp_create_FK_DWH]
as
begin
	-- FK productID in FACT.orders
	ALTER TABLE [SeaShippers_DWH].[FACT].[Orders] WITH NOCHECK
		ADD CONSTRAINT FK_Product_ID FOREIGN KEY ([product_id])
			REFERENCES [SeaShippers_DWH].[DIM].[Product]([Product_id])

	-- FK CustomerID in FACT.orders
	ALTER TABLE [SeaShippers_DWH].[FACT].[Orders] WITH NOCHECK
		ADD CONSTRAINT FK_Customer_ID FOREIGN KEY ([Customer_id])
			REFERENCES [SeaShippers_DWH].[DIM].[Customers]([Customer_id])

	-- FK productID in FACT.orders
	ALTER TABLE [SeaShippers_DWH].[FACT].[Orders] WITH NOCHECK
		ADD CONSTRAINT FK_ShipDate_ID FOREIGN KEY ([Order_date])
			REFERENCES [SeaShippers_DWH].[DIM].[ShipDate]([Order_date])

	-- FK productID in FACT.orders
	ALTER TABLE [SeaShippers_DWH].[FACT].[Orders] WITH NOCHECK
		ADD CONSTRAINT FK_shipVia_ID FOREIGN KEY ([Shipvia])
			REFERENCES [SeaShippers_DWH].[DIM].[Shippers]([Shipper_id])

	-- FK productID in FACT.orders
	ALTER TABLE [SeaShippers_DWH].[FACT].[Orders] WITH NOCHECK
		ADD CONSTRAINT FK_GeoID_ID FOREIGN KEY ([Geo_id])
			REFERENCES [SeaShippers_DWH].[DIM].[Location]([Geo_id])

	
END
GO
EXEC [dbo].[sp_create_FK_DWH]
