USE [MDPasivo]
GO
/****** Object:  Table [dbo].[GRUPOS_COMPATIBLES_DETALLE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPOS_COMPATIBLES_DETALLE](
	[id_grupo] [int] NOT NULL,
	[id_sistema] [varchar](50) NOT NULL,
	[id_producto] [varchar](50) NOT NULL,
	[id_subproducto] [varchar](50) NOT NULL,
	[moneda] [int] NOT NULL,
	[curva] [int] NOT NULL,
	[id_row] [int] NOT NULL
) ON [PRIMARY]
GO
