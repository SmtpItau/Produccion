USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_EMISOR]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_EMISOR](
	[codigo_tipo] [char](3) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[glosa] [varchar](15) NOT NULL
) ON [PRIMARY]
GO
