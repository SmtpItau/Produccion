USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[USUARIO_ACTIVO_PASO]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO_ACTIVO_PASO](
	[usuario] [char](10) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[terminal] [varchar](2) NOT NULL,
	[fechaproceso] [datetime] NOT NULL,
	[fechasistema] [datetime] NOT NULL
) ON [PRIMARY]
GO
