USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[cliente_tipo]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente_tipo](
	[rut] [numeric](9, 0) NOT NULL,
	[codigo] [numeric](9, 0) NOT NULL,
	[tipcli] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
