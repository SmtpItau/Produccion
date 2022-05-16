USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_MENU]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_MENU](
	[Modulo] [char](4) NOT NULL,
	[Indice] [int] NOT NULL,
	[Posicion] [int] NOT NULL,
	[Opcion] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
