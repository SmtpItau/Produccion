USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CONCEPTO_CARTERA_CONTABLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONCEPTO_CARTERA_CONTABLE](
	[Id_Sistema] [char](10) NOT NULL,
	[Subproducto] [char](15) NOT NULL,
	[Concepto_Contable] [char](5) NOT NULL,
	[Nombre_campo] [char](30) NULL,
	[Nombre_Tabla] [char](30) NULL,
	[Condicion_Tabla] [varchar](255) NULL
) ON [PRIMARY]
GO
