USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[EXCEPCION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXCEPCION](
	[codigo_excepcion] [char](2) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[mensaje] [varchar](100) NOT NULL,
	[glosa_autorizacion] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
