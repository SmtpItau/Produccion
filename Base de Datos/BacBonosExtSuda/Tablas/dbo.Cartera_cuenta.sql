USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[Cartera_cuenta]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cartera_cuenta](
	[Sistema] [char](3) NULL,
	[t_movimiento] [char](3) NULL,
	[t_operacion] [char](4) NULL,
	[RutCartera] [numeric](9, 0) NULL,
	[NumDocu] [numeric](10, 0) NULL,
	[Correla] [numeric](3, 0) NULL,
	[NumOper] [numeric](10, 0) NULL,
	[CodigoInst] [numeric](5, 0) NULL,
	[Instrumento] [varchar](25) NULL,
	[Mascara] [varchar](25) NULL,
	[InstSer] [varchar](25) NULL,
	[Moneda] [numeric](3, 0) NULL,
	[CMoneda] [char](3) NULL,
	[Nominal] [numeric](19, 4) NULL,
	[Monto] [numeric](19, 4) NULL,
	[Variable] [varchar](30) NULL,
	[Seriado] [char](1) NULL,
	[CtaContable] [char](20) NULL,
	[FolPerfil] [numeric](5, 0) NULL,
	[CorPerfil] [numeric](5, 0) NULL,
	[CodigoVariable] [varchar](30) NULL,
	[Fijo] [char](1) NULL,
	[CampoVariable] [numeric](5, 0) NULL,
	[RutCliente] [numeric](9, 0) NULL,
	[CodigoCliente] [numeric](9, 0) NULL,
	[RutEmisor] [numeric](9, 0) NULL,
	[tipobono] [char](1) NULL,
	[ForPagI] [numeric](5, 0) NULL,
	[ForPagV] [numeric](5, 0) NULL,
	[TipoLinea] [char](1) NULL,
	[TipoLetra] [char](1) NULL,
	[FechaInip] [datetime] NULL,
	[FechaVtop] [datetime] NULL
) ON [PRIMARY]
GO
