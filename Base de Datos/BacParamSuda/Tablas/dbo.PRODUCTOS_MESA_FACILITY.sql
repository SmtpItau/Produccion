USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTOS_MESA_FACILITY]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS_MESA_FACILITY](
	[Id_sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Codigo_ProductoOtro] [char](5) NOT NULL,
	[Codigo_Instrumento] [int] NOT NULL,
	[Codigo_Facility] [char](4) NOT NULL
) ON [PRIMARY]
GO
