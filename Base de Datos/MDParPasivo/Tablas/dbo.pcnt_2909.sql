USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[pcnt_2909]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pcnt_2909](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[codigo_instrumento] [char](10) NULL,
	[moneda_instrumento] [char](4) NULL,
	[tipo_voucher] [char](1) NULL,
	[glosa_perfil] [char](70) NULL
) ON [PRIMARY]
GO
