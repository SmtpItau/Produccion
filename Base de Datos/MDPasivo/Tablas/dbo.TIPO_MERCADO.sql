USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_MERCADO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_MERCADO](
	[Codigo_Mercado] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
