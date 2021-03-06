USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaTBL_CLASIFICACION_CARTERA]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaTBL_CLASIFICACION_CARTERA](
	[id_Sistema] [char](3) NOT NULL,
	[Tipo_movimiento] [varchar](5) NOT NULL,
	[Tipo_operacion] [varchar](5) NOT NULL,
	[TipoInstrumento] [int] NOT NULL,
	[Moneda] [int] NOT NULL,
	[TipoEmisor] [int] NOT NULL,
	[OrigenEmision] [int] NOT NULL,
	[ObjetoCubierto] [int] NOT NULL,
	[Contraparte] [numeric](9, 0) NOT NULL,
	[Desde] [int] NOT NULL,
	[Hasta] [int] NOT NULL,
	[CarteraNormativa] [char](10) NOT NULL,
	[SubcarteraNormativa] [char](10) NOT NULL,
	[Glosa] [varchar](155) NOT NULL,
	[CodigoCartera] [int] NOT NULL
) ON [PRIMARY]
GO
