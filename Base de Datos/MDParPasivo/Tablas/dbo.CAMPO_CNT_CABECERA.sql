USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CAMPO_CNT_CABECERA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAMPO_CNT_CABECERA](
	[CODIGO] [numeric](3, 0) NOT NULL,
	[DESCRIPCION] [varchar](50) NOT NULL,
	[NOMBRE_CAMPO_TABLA] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
