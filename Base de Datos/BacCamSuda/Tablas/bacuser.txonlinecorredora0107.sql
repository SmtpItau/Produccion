USE [BacCamSuda]
GO
/****** Object:  Table [bacuser].[txonlinecorredora0107]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[txonlinecorredora0107](
	[FechaProceso] [datetime] NULL,
	[EstadoEnvio] [char](1) NULL,
	[Reserva] [char](1) NULL,
	[Id] [numeric](7, 0) NULL,
	[Tipo] [char](1) NULL,
	[Monto] [numeric](19, 4) NULL,
	[MONEDA] [int] NULL,
	[CotraMoneda] [int] NULL,
	[TipoCambio] [numeric](19, 4) NULL,
	[Paridad] [numeric](19, 4) NULL,
	[Precio] [numeric](19, 4) NULL,
	[PrecioTransferencia] [numeric](19, 8) NULL,
	[RutClienteFinal] [numeric](9, 0) NULL,
	[DvClienteFinal] [char](1) NULL,
	[origen] [char](12) NULL,
	[Fecha] [char](8) NULL,
	[Entregamos] [numeric](5, 0) NULL,
	[ValutaEntregamos] [datetime] NULL,
	[Recibimos] [numeric](5, 0) NULL,
	[ValutaRecibimos] [datetime] NULL,
	[ESTADO] [char](1) NULL,
	[TipoMercado] [char](1) NULL,
	[Filler] [char](20) NULL
) ON [PRIMARY]
GO
