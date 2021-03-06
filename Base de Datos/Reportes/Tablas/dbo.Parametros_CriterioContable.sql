USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_CriterioContable]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_CriterioContable](
	[IdParametros] [int] IDENTITY(1,1) NOT NULL,
	[Parametros] [varchar](200) NULL,
	[Sistema] [varchar](50) NULL,
	[TipoConsulta] [char](1) NULL,
 CONSTRAINT [PK_Parametros_CriterioContable] PRIMARY KEY CLUSTERED 
(
	[IdParametros] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Reportes_Data_01]
) ON [Reportes_Data_01]
GO
