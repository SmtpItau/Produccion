USE [BacLineas]
GO
/****** Object:  Table [dbo].[RES_MAT]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RES_MAT](
	[Fila] [numeric](9, 0) NOT NULL,
	[Columna] [numeric](9, 0) NOT NULL,
	[Valor] [float] NOT NULL,
	[Nombre_Variable] [varchar](100) NOT NULL,
	[FechaGeneracion] [datetime] NULL,
	[TamannoMatriz] [numeric](9, 0) NULL
) ON [PRIMARY]
GO
