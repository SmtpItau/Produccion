USE [MDPasivo]
GO
/****** Object:  Table [dbo].[VARIABLE_FORMULA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VARIABLE_FORMULA](
	[Tipo] [decimal](1, 0) NOT NULL,
	[Variable] [char](10) NOT NULL,
	[Texto] [char](100) NOT NULL,
	[Glosa] [char](100) NULL,
	[Orden] [int] NOT NULL,
	[Tipo_Variable] [char](1) NULL,
	[Parametro1] [char](1) NULL,
	[Parametro2] [char](1) NULL,
	[Parametro3] [char](1) NULL,
	[Parametro4] [char](1) NULL
) ON [PRIMARY]
GO
