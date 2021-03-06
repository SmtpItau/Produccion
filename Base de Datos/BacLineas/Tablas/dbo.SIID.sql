USE [BacLineas]
GO
/****** Object:  Table [dbo].[SIID]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIID](
	[Sistema] [char](3) NOT NULL,
	[Operacion] [numeric](10, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Adquisicion_PorCesion] [char](1) NULL,
	[Tipo_Modificacion] [char](1) NULL,
	[Termino_Cesion] [char](1) NULL,
	[Rut_Cedente] [char](10) NULL,
	[Termino_Anticipado] [char](3) NULL,
	[Comprension_Cartera] [char](1) NULL,
	[Plataforma] [char](3) NULL,
	[Rut_Intermediario] [char](10) NULL,
	[Usuario] [char](15) NULL,
	[FechaActualizacion] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('N') FOR [Adquisicion_PorCesion]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('N') FOR [Termino_Cesion]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('') FOR [Rut_Cedente]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('NOT') FOR [Termino_Anticipado]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('N') FOR [Comprension_Cartera]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('OTC') FOR [Plataforma]
GO
ALTER TABLE [dbo].[SIID] ADD  DEFAULT ('') FOR [Rut_Intermediario]
GO
