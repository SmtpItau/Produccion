USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Estructura_Nivel]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Estructura_Nivel](
	[ID_Estructura_Nivel] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Estructura_Nivel] PRIMARY KEY CLUSTERED 
(
	[ID_Estructura_Nivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
