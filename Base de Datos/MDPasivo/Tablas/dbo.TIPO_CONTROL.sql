USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_CONTROL]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_CONTROL](
	[codigo_control] [char](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[tipo_control] [char](1) NOT NULL
) ON [PRIMARY]
GO
