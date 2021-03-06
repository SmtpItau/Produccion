USE [Reportes]
GO
/****** Object:  Table [dbo].[CNT_AUX_RENTABILIDAD_RF]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Glosa] [char](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Tipo_Operacion_Original] [char](5) NOT NULL,
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
	[id_automatico] [numeric](10, 0) NULL
) ON [Reportes_Data_01]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ((0)) FOR [Correlativo]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('') FOR [instser]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ((0)) FOR [Documento]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('') FOR [codigo_producto]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('BTR') FOR [id_sistema]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('0') FOR [fpagoentre]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('0') FOR [fpago]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ((0)) FOR [plazo]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('0') FOR [condicion_pacto]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ('0') FOR [clasificacion_cliente]
GO
ALTER TABLE [dbo].[CNT_AUX_RENTABILIDAD_RF] ADD  DEFAULT ((0)) FOR [id_automatico]
GO
