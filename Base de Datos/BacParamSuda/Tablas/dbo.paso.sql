USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[paso]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paso](
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[codigo_plaza] [numeric](5, 0) NOT NULL,
	[codigo_swift] [varchar](10) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[cuenta_corriente] [varchar](30) NOT NULL,
	[swift_santiago] [varchar](10) NOT NULL,
	[banco_central] [char](1) NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[codigo_corres] [numeric](6, 0) NULL,
	[codigo_contable] [char](4) NULL,
	[cod_corresponsal] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
