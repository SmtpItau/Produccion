USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RPTDETALLEINTERESES]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPTDETALLEINTERESES](
	[planilla_fecha] [varchar](10) NULL,
	[planilla_numero] [numeric](6, 0) NULL,
	[correlativo] [numeric](3, 0) NULL,
	[concepto_capital] [varchar](50) NULL,
	[capital] [numeric](15, 2) NULL,
	[tipo_interes] [varchar](50) NULL,
	[codigo_base_tasa] [varchar](50) NULL,
	[tasa_interes_anual] [numeric](9, 6) NULL,
	[fecha_inicial] [varchar](10) NULL,
	[fecha_final] [varchar](10) NULL,
	[dias] [numeric](6, 0) NULL,
	[monto_interes] [numeric](13, 2) NULL,
	[indica_pago_exterior] [varchar](10) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__plani__36F37B6A]  DEFAULT ('') FOR [planilla_fecha]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__plani__37E79FA3]  DEFAULT (0) FOR [planilla_numero]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__corre__38DBC3DC]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__conce__39CFE815]  DEFAULT ('') FOR [concepto_capital]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__capit__3AC40C4E]  DEFAULT (0) FOR [capital]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__tipo___3BB83087]  DEFAULT ('') FOR [tipo_interes]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__codig__3CAC54C0]  DEFAULT ('') FOR [codigo_base_tasa]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__tasa___3DA078F9]  DEFAULT (0) FOR [tasa_interes_anual]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__fecha__3E949D32]  DEFAULT ('') FOR [fecha_inicial]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__fecha__3F88C16B]  DEFAULT ('') FOR [fecha_final]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetalle__dias__407CE5A4]  DEFAULT (0) FOR [dias]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__monto__417109DD]  DEFAULT (0) FOR [monto_interes]
GO
ALTER TABLE [dbo].[RPTDETALLEINTERESES] ADD  CONSTRAINT [DF__rptDetall__indic__42652E16]  DEFAULT ('') FOR [indica_pago_exterior]
GO
