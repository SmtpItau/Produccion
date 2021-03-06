USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RPTPOSICION]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPTPOSICION](
	[fecha] [char](10) NULL,
	[codigo_moneda] [numeric](3, 0) NULL,
	[nemotecnico_moneda] [char](3) NULL,
	[relacion_dolar] [char](1) NULL,
	[debe_haber_ayer] [char](1) NULL,
	[posicion_origen_ayer] [float] NULL,
	[posicion_dolares_ayer] [float] NULL,
	[paridad_finmes_ayer] [float] NULL,
	[debe_haber_hoy] [char](1) NULL,
	[posicion_origen_hoy] [float] NULL,
	[posicion_dolares_hoy] [float] NULL,
	[paridad_finmes_hoy] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__fecha__2DB429F3]  DEFAULT ('') FOR [fecha]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__codig__2EA84E2C]  DEFAULT (0) FOR [codigo_moneda]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__nemot__2F9C7265]  DEFAULT ('') FOR [nemotecnico_moneda]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__relac__3090969E]  DEFAULT ('') FOR [relacion_dolar]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__debe___3184BAD7]  DEFAULT ('') FOR [debe_haber_ayer]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__posic__3278DF10]  DEFAULT (0) FOR [posicion_origen_ayer]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__posic__336D0349]  DEFAULT (0) FOR [posicion_dolares_ayer]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__parid__34612782]  DEFAULT (0) FOR [paridad_finmes_ayer]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__debe___35554BBB]  DEFAULT ('') FOR [debe_haber_hoy]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__posic__36496FF4]  DEFAULT (0) FOR [posicion_origen_hoy]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__posic__373D942D]  DEFAULT (0) FOR [posicion_dolares_hoy]
GO
ALTER TABLE [dbo].[RPTPOSICION] ADD  CONSTRAINT [DF__rptPosici__parid__3831B866]  DEFAULT (0) FOR [paridad_finmes_hoy]
GO
