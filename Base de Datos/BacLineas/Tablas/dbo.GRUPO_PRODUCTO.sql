USE [BacLineas]
GO
/****** Object:  Table [dbo].[GRUPO_PRODUCTO]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_PRODUCTO](
	[Codigo_Grupo] [char](5) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Glosa_Grupo] [char](35) NOT NULL
) ON [PRIMARY]
GO
