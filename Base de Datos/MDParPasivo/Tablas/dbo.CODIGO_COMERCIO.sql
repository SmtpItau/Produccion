USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CODIGO_COMERCIO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_COMERCIO](
	[comercio] [char](6) NOT NULL,
	[glosa] [varchar](60) NOT NULL,
	[tipo_documento] [numeric](3, 0) NOT NULL,
	[codigo_oma] [numeric](3, 0) NOT NULL,
	[tipo_registro] [char](3) NOT NULL,
	[codigo_validacion] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
