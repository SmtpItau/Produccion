USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblCamposArchivo]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblCamposArchivo](
	[idCampo] [smallint] NOT NULL,
	[sDescripcion] [varchar](100) NOT NULL,
	[sCampoFisico] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idCampo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblCamposArchivo] ADD  DEFAULT ((0)) FOR [idCampo]
GO
ALTER TABLE [dbo].[MonitorFX_TblCamposArchivo] ADD  DEFAULT ('') FOR [sDescripcion]
GO
ALTER TABLE [dbo].[MonitorFX_TblCamposArchivo] ADD  DEFAULT ('') FOR [sCampoFisico]
GO
