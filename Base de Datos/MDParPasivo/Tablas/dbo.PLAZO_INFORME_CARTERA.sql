USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PLAZO_INFORME_CARTERA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAZO_INFORME_CARTERA](
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[Tipo_Plazo] [char](1) NULL
) ON [PRIMARY]
GO
