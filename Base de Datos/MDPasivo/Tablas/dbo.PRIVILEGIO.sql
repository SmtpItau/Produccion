USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PRIVILEGIO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRIVILEGIO](
	[tipo_privilegio] [char](1) NOT NULL,
	[usuario] [char](15) NOT NULL,
	[entidad] [char](3) NOT NULL,
	[opcion] [char](30) NOT NULL,
	[habilitado] [char](1) NULL
) ON [PRIMARY]
GO
