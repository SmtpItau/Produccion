USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_TipoCriterio]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_TipoCriterio](
	[IdTipoCriterio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Parametros_TipoCriterio] PRIMARY KEY CLUSTERED 
(
	[IdTipoCriterio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Reportes_Data_01]
) ON [Reportes_Data_01]
GO
