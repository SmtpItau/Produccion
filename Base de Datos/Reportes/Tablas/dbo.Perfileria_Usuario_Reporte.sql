USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Usuario_Reporte]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Usuario_Reporte](
	[ID_Usuario_Reporte] [int] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [int] NULL,
	[ID_Reporte] [int] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Perfileria_Usuario_Reporte] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario_Reporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
