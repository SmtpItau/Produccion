USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MATRIZ_RIESGO_NORMATIVO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MATRIZ_RIESGO_NORMATIVO](
	[Codigo_Riesgo] [int] NOT NULL,
	[Plazo_Desde] [int] NOT NULL,
	[Plazo_Hasta] [int] NOT NULL,
	[Factor1] [numeric](21, 4) NOT NULL,
	[Factor2] [numeric](21, 4) NOT NULL,
 CONSTRAINT [PK_Matriz_Riesgo_Normativo] PRIMARY KEY NONCLUSTERED 
(
	[Codigo_Riesgo] ASC,
	[Plazo_Desde] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MATRIZ_RIESGO_NORMATIVO]  WITH CHECK ADD  CONSTRAINT [FK_Matriz_Riesgo_Normativo_Riesgo_Normativo] FOREIGN KEY([Codigo_Riesgo])
REFERENCES [dbo].[RIESGO_NORMATIVO] ([Codigo_Riesgo])
GO
ALTER TABLE [dbo].[MATRIZ_RIESGO_NORMATIVO] CHECK CONSTRAINT [FK_Matriz_Riesgo_Normativo_Riesgo_Normativo]
GO
