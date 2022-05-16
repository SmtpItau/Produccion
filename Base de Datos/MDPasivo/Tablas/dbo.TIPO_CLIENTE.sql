USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_CLIENTE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_CLIENTE](
	[Codigo_Tipo_Cliente] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL,
	[Codigo_Cliente_SBIF] [numeric](2, 0) NOT NULL,
	[Descripcion_Cliente_SBIF] [char](40) NOT NULL
) ON [PRIMARY]
GO
