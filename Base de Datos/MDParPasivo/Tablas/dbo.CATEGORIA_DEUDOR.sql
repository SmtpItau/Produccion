USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CATEGORIA_DEUDOR]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA_DEUDOR](
	[Codigo_Deudor] [numeric](2, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
