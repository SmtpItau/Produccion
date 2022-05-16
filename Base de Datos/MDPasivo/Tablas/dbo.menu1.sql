USE [MDPasivo]
GO
/****** Object:  Table [dbo].[menu1]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[menu1](
	[entidad] [char](3) NULL,
	[indice] [numeric](3, 0) NULL,
	[nombre_opcion] [char](50) NULL,
	[nombre_objeto] [char](30) NULL,
	[posicion] [numeric](3, 0) NULL,
	[entidadfox] [char](3) NULL
) ON [PRIMARY]
GO
