USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_EXCESO_LIMITES_HIST]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_EXCESO_LIMITES_HIST](
	[fecha_sistema] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[tipo_limites] [char](6) NOT NULL,
	[correlativo] [numeric](6, 0) NOT NULL,
	[codigo_exceso] [numeric](5, 0) NOT NULL,
	[monto_exceso] [float] NOT NULL,
	[plazo] [numeric](5, 0) NOT NULL,
	[rut_cliente] [numeric](10, 0) NOT NULL,
	[codigo_rut] [numeric](5, 0) NOT NULL,
	[estado] [char](1) NOT NULL,
	[monto_ocupado] [float] NOT NULL
) ON [PRIMARY]
GO
