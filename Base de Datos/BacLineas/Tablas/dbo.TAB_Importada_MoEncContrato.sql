USE [BacLineas]
GO
/****** Object:  Table [dbo].[TAB_Importada_MoEncContrato]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAB_Importada_MoEncContrato](
	[NumFolio] [numeric](8, 0) NULL,
	[TipoTransaccion] [char](10) NULL,
	[NumContrato] [numeric](8, 0) NULL,
	[FechaContrato] [datetime] NULL,
	[Estado] [char](1) NULL,
	[RutCliente] [numeric](9, 0) NULL,
	[Codigo] [numeric](9, 0) NULL,
	[Usuario] [char](15) NULL,
	[CodEstructura] [char](10) NULL,
	[CVEstructura] [char](1) NULL,
	[Estado_Oper] [char](1) NULL
) ON [PRIMARY]
GO
