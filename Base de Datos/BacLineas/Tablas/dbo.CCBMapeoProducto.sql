USE [BacLineas]
GO
/****** Object:  Table [dbo].[CCBMapeoProducto]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCBMapeoProducto](
	[CCBCodProducto] [int] NOT NULL,
	[CCBCodSubProducto] [int] NOT NULL,
	[CCBCodMonPrinc] [int] NOT NULL,
	[CCBCodMonPrincNoAplica] [int] NOT NULL,
	[CCBCodMonSecu] [int] NOT NULL,
	[BACID_Sistema] [char](3) NOT NULL,
	[BACCaCodPos1] [numeric](5, 0) NOT NULL,
	[BACCaCodMon1] [numeric](5, 0) NOT NULL,
	[BACCaCodMon2] [numeric](5, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CCBCodProducto] ASC,
	[CCBCodSubProducto] ASC,
	[CCBCodMonPrinc] ASC,
	[CCBCodMonSecu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
