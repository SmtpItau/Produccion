USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[costo]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[costo](
	[rut] [numeric](9, 0) NOT NULL,
	[costo] [numeric](5, 0) NULL,
	[ctacte] [char](15) NULL
) ON [PRIMARY]
GO
