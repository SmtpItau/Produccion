USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblTipoMensajesLOG]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblTipoMensajesLOG](
	[idTipoMensaje] [smallint] NOT NULL,
	[sDescripcion] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoMensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblTipoMensajesLOG] ADD  DEFAULT ((0)) FOR [idTipoMensaje]
GO
ALTER TABLE [dbo].[MonitorFX_TblTipoMensajesLOG] ADD  DEFAULT ('') FOR [sDescripcion]
GO
