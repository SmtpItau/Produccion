USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblTipoArchivos]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblTipoArchivos](
	[idTipoArchivo] [smallint] NOT NULL,
	[sDescripcion] [varchar](15) NOT NULL,
	[sExtension] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblTipoArchivos] ADD  DEFAULT ((0)) FOR [idTipoArchivo]
GO
ALTER TABLE [dbo].[MonitorFX_TblTipoArchivos] ADD  DEFAULT ('') FOR [sDescripcion]
GO
