USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_VOUCHER_0807]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_VOUCHER_0807](
	[Numero_Voucher] [decimal](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Fecha_Contable] [datetime] NOT NULL,
	[Glosa] [varchar](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Operacion] [decimal](10, 0) NOT NULL,
	[Correlativo] [decimal](5, 0) NOT NULL,
	[Documento] [decimal](10, 0) NOT NULL,
	[codigo_producto] [char](7) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[rut_cliente] [decimal](10, 0) NOT NULL,
	[codigo_cliente] [decimal](18, 0) NOT NULL,
	[Mercado] [char](4) NOT NULL,
	[Moneda_Operacion] [char](3) NOT NULL,
	[Tipo_Cambio] [decimal](19, 4) NOT NULL
) ON [PRIMARY]
GO
