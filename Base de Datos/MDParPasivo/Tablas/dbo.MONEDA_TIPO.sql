USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MONEDA_TIPO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA_TIPO](
	[Codigo_Tipo_Moneda] [char](1) NOT NULL,
	[Descripcion] [char](30) NULL
) ON [PRIMARY]
GO
