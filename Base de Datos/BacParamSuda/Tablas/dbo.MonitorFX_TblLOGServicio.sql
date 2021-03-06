USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblLOGServicio]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblLOGServicio](
	[idLOG] [bigint] IDENTITY(1,1) NOT NULL,
	[LOG_dFecha] [datetime] NOT NULL,
	[idTipoMensaje] [smallint] NOT NULL,
	[LOG_sEquipo] [varchar](50) NOT NULL,
	[LOG_sIP] [varchar](50) NOT NULL,
	[LOG_sServicio] [varchar](50) NOT NULL,
	[LOG_sProceso] [varchar](50) NOT NULL,
	[LOG_sDetalle] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idLOG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblLOGServicio] ADD  DEFAULT ('') FOR [LOG_sEquipo]
GO
ALTER TABLE [dbo].[MonitorFX_TblLOGServicio] ADD  DEFAULT ('') FOR [LOG_sIP]
GO
ALTER TABLE [dbo].[MonitorFX_TblLOGServicio] ADD  DEFAULT ('') FOR [LOG_sServicio]
GO
ALTER TABLE [dbo].[MonitorFX_TblLOGServicio] ADD  DEFAULT ('') FOR [LOG_sProceso]
GO
ALTER TABLE [dbo].[MonitorFX_TblLOGServicio] ADD  DEFAULT ('') FOR [LOG_sDetalle]
GO
