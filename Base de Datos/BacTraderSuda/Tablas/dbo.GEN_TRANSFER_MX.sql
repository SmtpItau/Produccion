USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_TRANSFER_MX]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_TRANSFER_MX](
	[id_sistema] [char](3) NOT NULL,
	[tipo_tran] [char](4) NOT NULL,
	[fecha_tran] [datetime] NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[moneda] [numeric](4, 0) NOT NULL,
	[monto] [float] NOT NULL
) ON [PRIMARY]
GO
