USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[REPORTES_FIRMA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPORTES_FIRMA](
	[Id_firma] [int] NULL,
	[Nombre_Usuario] [nvarchar](50) NULL,
	[Firma] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
