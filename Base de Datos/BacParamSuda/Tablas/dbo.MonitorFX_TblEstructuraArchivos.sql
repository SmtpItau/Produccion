USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblEstructuraArchivos]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblEstructuraArchivos](
	[idArchivo] [smallint] NOT NULL,
	[idPosicion] [smallint] NOT NULL,
	[Estru_sCampo] [varchar](30) NOT NULL,
	[Estru_sDescripcion] [varchar](100) NOT NULL,
	[Estru_iLargo] [smallint] NOT NULL,
	[idTipoDato] [smallint] NOT NULL,
	[Estru_PosInicio] [smallint] NOT NULL,
	[Estru_PosFinal] [smallint] NOT NULL,
	[idCampo] [smallint] NOT NULL,
	[Estru_sClases] [varchar](200) NOT NULL,
	[Estru_sRutaTAG] [varchar](500) NULL,
	[Estru_sTipoTAG] [varchar](1) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [idArchivo]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [idPosicion]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ('') FOR [Estru_sCampo]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ('') FOR [Estru_sDescripcion]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [Estru_iLargo]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [idTipoDato]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [Estru_PosInicio]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [Estru_PosFinal]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ((0)) FOR [idCampo]
GO
ALTER TABLE [dbo].[MonitorFX_TblEstructuraArchivos] ADD  DEFAULT ('') FOR [Estru_sClases]
GO
