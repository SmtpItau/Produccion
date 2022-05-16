USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLASIFICACION_CARTERA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASIFICACION_CARTERA](
	[codigo_ClasificacionCartera] [decimal](1, 0) NOT NULL,
	[codigo_carterasuper] [nvarchar](1) NOT NULL,
	[codigo_carteraFinanciera] [nvarchar](2) NOT NULL,
	[Glosa_Cartera] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
