USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[RELACION_BANCO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELACION_BANCO](
	[Codigo_Relacion_Banco] [numeric](2, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
