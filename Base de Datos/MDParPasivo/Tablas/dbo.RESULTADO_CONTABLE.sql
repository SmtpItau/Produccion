USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[RESULTADO_CONTABLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESULTADO_CONTABLE](
	[fecha_proceso] [datetime] NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[numero_documento] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](10, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_operacion] [char](3) NOT NULL,
	[concepto_programa] [char](5) NOT NULL,
	[numero_secuencia] [int] NOT NULL,
	[fecha_contable] [datetime] NOT NULL,
	[divisa] [int] NOT NULL,
	[cuenta_contable] [char](15) NOT NULL,
	[tipo_monto] [char](1) NOT NULL,
	[centro_origen] [char](4) NOT NULL,
	[centro_destino] [char](4) NOT NULL,
	[concepto_contable] [char](5) NOT NULL,
	[monto] [numeric](19, 4) NOT NULL,
	[ristra_contable] [char](69) NOT NULL,
	[ristra_sin_procesar] [char](69) NOT NULL,
	[tipo_resultado] [char](3) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_moneda1] [numeric](3, 0) NOT NULL,
	[codigo_moneda2] [numeric](3, 0) NOT NULL,
	[concepto_programa_antiguo] [char](5) NOT NULL,
	[fecha_contabiliza] [datetime] NOT NULL,
	[fecha_referencia] [char](10) NOT NULL,
	[sucursal_contabiliza] [numeric](18, 0) NOT NULL,
	[sistema_original] [char](3) NOT NULL,
	[producto_original] [char](5) NOT NULL
) ON [PRIMARY]
GO
