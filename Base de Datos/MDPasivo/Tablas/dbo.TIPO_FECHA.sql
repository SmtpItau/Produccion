USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_FECHA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_FECHA](
	[Codigo_Tipo_Fecha] [numeric](1, 0) NOT NULL,
	[Descripcion] [char](30) NULL
) ON [PRIMARY]
GO
