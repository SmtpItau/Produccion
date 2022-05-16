USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[GEN_MENU]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_MENU](
	[entidad] [char](3) NOT NULL,
	[indice] [numeric](3, 0) NOT NULL,
	[nombre_opcion] [varchar](150) NULL,
	[nombre_objeto] [char](50) NULL,
	[posicion] [numeric](3, 0) NOT NULL,
	[entidadfox] [char](3) NOT NULL
) ON [PRIMARY]
GO
