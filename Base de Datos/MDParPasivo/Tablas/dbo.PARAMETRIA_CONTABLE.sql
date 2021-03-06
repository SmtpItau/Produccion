USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PARAMETRIA_CONTABLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARAMETRIA_CONTABLE](
	[codigo_operacion] [char](3) NOT NULL,
	[concepto_programa] [char](5) NOT NULL,
	[numero_secuencia] [int] NOT NULL,
	[tipo_monto] [char](1) NOT NULL,
	[moneda] [int] NOT NULL,
	[centro_origen] [char](4) NOT NULL,
	[centro_destino] [char](4) NOT NULL,
	[concepto_contable] [char](5) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PARAMETRIA_CONTABLE] ADD  CONSTRAINT [DF_PARAMETRIA_CONTABLE_id_sistema]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[PARAMETRIA_CONTABLE] ADD  CONSTRAINT [DF_PARAMETRIA_CONTABLE_codigo_producto]  DEFAULT ('') FOR [codigo_producto]
GO
