USE [MDPasivo]
GO
/****** Object:  Table [dbo].[EXCEPCION_USUARIO_DETALLE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXCEPCION_USUARIO_DETALLE](
	[usuario] [char](15) NOT NULL,
	[codigo_excepcion] [char](2) NOT NULL,
	[estado] [char](1) NOT NULL,
	[monto_excepcion] [float] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL
) ON [PRIMARY]
GO
