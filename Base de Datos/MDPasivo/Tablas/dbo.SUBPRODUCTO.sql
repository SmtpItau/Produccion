USE [MDPasivo]
GO
/****** Object:  Table [dbo].[SUBPRODUCTO]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUBPRODUCTO](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Codigo_Subproducto] [char](15) NOT NULL,
	[Descripcion] [char](50) NULL,
	[Contabiliza] [char](1) NOT NULL,
	[Gestion] [char](1) NOT NULL
) ON [PRIMARY]
GO
