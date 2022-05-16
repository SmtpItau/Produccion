USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_PERFIL_COMEX]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_PERFIL_COMEX](
	[nNumOper] [numeric](10, 0) NOT NULL,
	[cEstado] [char](1) NOT NULL,
	[cPerfil] [char](6) NOT NULL,
	[cUsuario] [char](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_PERFIL_COMEX] ADD  DEFAULT (0) FOR [nNumOper]
GO
ALTER TABLE [dbo].[TBL_PERFIL_COMEX] ADD  DEFAULT ('') FOR [cEstado]
GO
ALTER TABLE [dbo].[TBL_PERFIL_COMEX] ADD  DEFAULT ('') FOR [cPerfil]
GO
ALTER TABLE [dbo].[TBL_PERFIL_COMEX] ADD  DEFAULT (0) FOR [cUsuario]
GO
