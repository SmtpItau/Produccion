USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Usuario_Reporte]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Usuario_Reporte](
	[ID_Usuario_Reporte] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[ID_Reporte] [int] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Perfileria_Usuario_Reporte] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario_Reporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
