USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TIPO_BASILEA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_BASILEA](
	[Codigo_Basilea] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
