USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_MENU]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_MENU](
	[entidad] [char](3) NOT NULL,
	[indice] [numeric](3, 0) NOT NULL,
	[nombre_opcion] [char](50) NOT NULL,
	[nombre_objeto] [char](30) NOT NULL,
	[posicion] [numeric](3, 0) NOT NULL,
	[entidadfox] [char](3) NOT NULL
) ON [PRIMARY]
GO
