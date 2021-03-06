USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CONCEPTO_PROGRAMA_CONTABLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONCEPTO_PROGRAMA_CONTABLE](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[concepto_programa] [char](5) NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[negativo] [char](1) NOT NULL,
	[nombre_campo] [char](50) NOT NULL
) ON [PRIMARY]
GO
