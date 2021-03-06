USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CargaOperaciones_Plataformas]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CargaOperaciones_Plataformas](
	[idPlataforma] [smallint] NOT NULL,
	[sDescripcion] [varchar](40) NOT NULL,
	[sTipoPlataforma] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idPlataforma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CargaOperaciones_Plataformas] ADD  DEFAULT ((0)) FOR [idPlataforma]
GO
ALTER TABLE [dbo].[CargaOperaciones_Plataformas] ADD  DEFAULT ('') FOR [sDescripcion]
GO
ALTER TABLE [dbo].[CargaOperaciones_Plataformas] ADD  DEFAULT ((0)) FOR [sTipoPlataforma]
GO
