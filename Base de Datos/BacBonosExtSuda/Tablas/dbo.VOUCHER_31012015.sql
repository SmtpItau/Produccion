USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[VOUCHER_31012015]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOUCHER_31012015](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Glosa] [char](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Operacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[instser] [char](12) NOT NULL,
	[Documento] [numeric](10, 0) NOT NULL,
	[codigo_producto] [char](7) NULL,
	[id_sistema] [char](3) NULL,
	[fpagoentre] [char](6) NULL,
	[fpago] [char](6) NULL,
	[plazo] [numeric](9, 0) NULL,
	[condicion_pacto] [char](3) NULL,
	[clasificacion_cliente] [char](6) NULL,
	[MonedaOperacion] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
