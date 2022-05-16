USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Descripcion] [char](50) NULL,
	[Contabiliza] [char](1) NULL,
	[Gestion] [char](1) NULL,
	[plazos_matriz] [char](1) NOT NULL
) ON [PRIMARY]
GO
