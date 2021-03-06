USE [BacLineas]
GO
/****** Object:  Table [dbo].[RIEFIN_Matriz_Covarianza]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RIEFIN_Matriz_Covarianza](
	[Fila] [numeric](9, 0) NOT NULL,
	[Columna] [numeric](9, 0) NOT NULL,
	[Valor] [float] NOT NULL,
	[Nombre_Variable] [varchar](100) NOT NULL,
	[FechaGeneracion] [datetime] NULL,
	[TamannoMatriz] [numeric](9, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Fila] ASC,
	[Columna] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
