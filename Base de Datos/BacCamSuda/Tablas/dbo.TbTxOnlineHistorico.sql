USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TbTxOnlineHistorico]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TbTxOnlineHistorico](
	[Fecha] [char](8) NULL,
	[Hora] [char](8) NULL,
	[Origen] [varchar](20) NULL,
	[Codigo] [varchar](20) NULL,
	[Numero] [numeric](10, 0) NULL,
	[Mercado] [char](4) NULL,
	[Tipo] [char](1) NULL,
	[Moneda] [char](3) NULL,
	[MonedaCnv] [char](3) NULL,
	[Monto] [numeric](19, 2) NULL,
	[Precio] [numeric](10, 4) NULL,
	[Equivalente] [numeric](19, 2) NULL,
	[Rut] [numeric](9, 0) NULL,
	[CodigoCliente] [numeric](9, 0) NULL,
	[Contraparte] [varchar](40) NULL,
	[Contrausuario] [varchar](40) NULL,
	[Usuario] [char](40) NULL,
	[Estado] [char](1) NULL,
	[Operacion] [numeric](10, 0) NULL,
	[indicador] [char](1) NULL
) ON [PRIMARY]
GO
