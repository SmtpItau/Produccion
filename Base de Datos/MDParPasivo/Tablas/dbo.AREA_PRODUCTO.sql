USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[AREA_PRODUCTO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AREA_PRODUCTO](
	[codigo_area] [varchar](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[posicion_cambio] [char](1) NULL,
	[posicion_futuro] [char](1) NULL,
	[contabilidad_btr] [char](1) NULL,
	[contabilidad_inv] [char](1) NULL,
	[valorizacion] [char](1) NOT NULL,
	[valorizacionauto] [char](1) NOT NULL,
	[contabilizaval] [char](1) NOT NULL
) ON [PRIMARY]
GO
