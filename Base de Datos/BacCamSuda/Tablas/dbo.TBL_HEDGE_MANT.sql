USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_MANT]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_MANT](
	[Cod_Origen] [varchar](10) NOT NULL,
	[Cod_Producto] [varchar](10) NOT NULL,
	[Tipo_Ope] [char](1) NOT NULL,
	[Moneda] [char](3) NOT NULL,
	[Cuenta_Contable] [varchar](15) NOT NULL,
	[Tipo_Valor] [varchar](1) NOT NULL,
	[Imputacion] [varchar](1) NOT NULL,
	[Variable] [varchar](30) NOT NULL,
	[Cod_Orden] [int] NOT NULL
) ON [PRIMARY]
GO
