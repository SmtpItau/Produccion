USE [MDPasivo]
GO
/****** Object:  Table [dbo].[COLOR]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLOR](
	[USUARIO] [char](15) NOT NULL,
	[ESTADO] [char](1) NOT NULL,
	[COLOR_FONDO] [float] NULL,
	[COLOR_TEXTO] [float] NULL,
	[COLOR_DEFAULT_FONDO] [float] NULL,
	[COLOR_DEFAULT_TEXTO] [float] NULL
) ON [PRIMARY]
GO
