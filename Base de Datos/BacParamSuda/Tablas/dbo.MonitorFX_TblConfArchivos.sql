USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblConfArchivos]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblConfArchivos](
	[idArchivo] [smallint] NOT NULL,
	[Arch_sCodigo] [varchar](15) NOT NULL,
	[Arch_sDescripcion] [varchar](150) NOT NULL,
	[idTipoArchivo] [smallint] NOT NULL,
	[Arch_sRutaFisica] [varchar](200) NOT NULL,
	[Arch_sNombreFisico] [varchar](50) NOT NULL,
	[idSeparador] [smallint] NOT NULL,
	[Arch_bHabilitado] [bit] NOT NULL,
	[Arch_bGrabaLog] [bit] NOT NULL,
	[Arch_dHoraInicio] [datetime] NOT NULL,
	[Arch_dHoraFinal] [datetime] NOT NULL,
	[Arch_sCodColor] [varchar](255) NOT NULL,
	[idAmbiente] [smallint] NOT NULL,
	[Arch_bDirectorio] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ((0)) FOR [idArchivo]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('') FOR [Arch_sCodigo]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('') FOR [Arch_sDescripcion]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ((0)) FOR [idTipoArchivo]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('') FOR [Arch_sRutaFisica]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('') FOR [Arch_sNombreFisico]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('') FOR [idSeparador]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ((0)) FOR [Arch_bHabilitado]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ((0)) FOR [Arch_bGrabaLog]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('1901-01-01 00:00:00') FOR [Arch_dHoraInicio]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('1901-01-01 00:00:00') FOR [Arch_dHoraFinal]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ('') FOR [Arch_sCodColor]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ((0)) FOR [idAmbiente]
GO
ALTER TABLE [dbo].[MonitorFX_TblConfArchivos] ADD  DEFAULT ((0)) FOR [Arch_bDirectorio]
GO
