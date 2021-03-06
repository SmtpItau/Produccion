USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_REPXMOD_FUSION]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_REPXMOD_FUSION](
	[id_modulo] [int] NOT NULL,
	[id_reporte] [int] NOT NULL,
	[starting] [varchar](8) NULL,
	[finish] [varchar](8) NULL,
	[priority] [int] NOT NULL,
	[process] [int] NOT NULL,
	[require] [varchar](15) NOT NULL,
	[active] [bit] NULL,
	[special_mode] [bit] NULL,
	[require_ny] [bit] NULL,
	[db_connection] [varchar](500) NULL
) ON [Reportes_Data_01]
GO
ALTER TABLE [dbo].[TBL_REPXMOD_FUSION] ADD  DEFAULT ('08:00:00') FOR [starting]
GO
ALTER TABLE [dbo].[TBL_REPXMOD_FUSION] ADD  DEFAULT ('08:00:00') FOR [finish]
GO
ALTER TABLE [dbo].[TBL_REPXMOD_FUSION] ADD  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[TBL_REPXMOD_FUSION] ADD  DEFAULT ((0)) FOR [special_mode]
GO
ALTER TABLE [dbo].[TBL_REPXMOD_FUSION] ADD  DEFAULT ((0)) FOR [require_ny]
GO
