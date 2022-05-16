USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[EXCEPCION_USUARIO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXCEPCION_USUARIO](
	[usuario] [char](15) NOT NULL,
	[usuario_subroga] [char](15) NOT NULL,
	[estado] [char](1) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL
) ON [PRIMARY]
GO
