USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[IMPRESION]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMPRESION](
	[ImpID] [int] IDENTITY(1,1) NOT NULL,
	[ImpGrupo] [int] NULL,
	[ImpNumContrato] [numeric](8, 0) NOT NULL,
	[ImpFolio] [numeric](8, 0) NOT NULL,
	[ImpUsuario] [varchar](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IMPRESION] ADD  DEFAULT ((0)) FOR [ImpNumContrato]
GO
ALTER TABLE [dbo].[IMPRESION] ADD  DEFAULT ((0)) FOR [ImpFolio]
GO
ALTER TABLE [dbo].[IMPRESION] ADD  DEFAULT ('') FOR [ImpUsuario]
GO
