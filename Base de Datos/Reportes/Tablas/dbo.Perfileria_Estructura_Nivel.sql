USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Estructura_Nivel]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Estructura_Nivel](
	[ID_Estructura_Nivel] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Estructura_Nivel] PRIMARY KEY CLUSTERED 
(
	[ID_Estructura_Nivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
