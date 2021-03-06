USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_Interfaz_OMA_cNormativo]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_Interfaz_OMA_cNormativo](
	[Cabeza] [char](2) NOT NULL,
	[Registro10] [char](193) NOT NULL,
	[Registro20] [char](86) NOT NULL,
	[Registro30] [char](66) NOT NULL,
	[Registro40] [char](59) NOT NULL,
	[Registro50] [char](16) NOT NULL,
	[Registro60] [char](198) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Cabeza]  DEFAULT ('') FOR [Cabeza]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Registro10]  DEFAULT ('') FOR [Registro10]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Registro20]  DEFAULT ('') FOR [Registro20]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Registro30]  DEFAULT ('') FOR [Registro30]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Registro40]  DEFAULT ('') FOR [Registro40]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Registro50]  DEFAULT ('') FOR [Registro50]
GO
ALTER TABLE [dbo].[TBL_Interfaz_OMA_cNormativo] ADD  CONSTRAINT [df_TBL_Interfaz_OMA_cNormativo_Registro60]  DEFAULT ('') FOR [Registro60]
GO
