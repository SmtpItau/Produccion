USE [BacLineas]
GO
/****** Object:  Table [dbo].[DETALLE_ENDEUDAMIENTO]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_ENDEUDAMIENTO](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Numero_Documento] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](10, 0) NOT NULL,
	[Monto_Afecto] [numeric](19, 0) NOT NULL,
	[Fecha_Origen] [datetime] NOT NULL,
	[Fecha_Vencimiento] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__Rut_C__2E94D641]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__Codig__2F88FA7A]  DEFAULT (0) FOR [Codigo_Cliente]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__id_si__307D1EB3]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__Numer__317142EC]  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__Numer__32656725]  DEFAULT (0) FOR [Numero_Documento]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__Corre__33598B5E]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[DETALLE_ENDEUDAMIENTO] ADD  CONSTRAINT [DF__detalle_A__Monto__344DAF97]  DEFAULT (0) FOR [Monto_Afecto]
GO
