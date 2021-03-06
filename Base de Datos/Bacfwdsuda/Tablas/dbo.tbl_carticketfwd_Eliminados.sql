USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[tbl_carticketfwd_Eliminados]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_carticketfwd_Eliminados](
	[Fecha_Operacion] [datetime] NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Numero_Operacion_Relacion] [numeric](10, 0) NOT NULL,
	[Tipo_Operacion] [varchar](1) NOT NULL,
	[Codigo_Producto] [smallint] NOT NULL,
	[CodCarteraOrigen] [smallint] NOT NULL,
	[CodMesaOrigen] [smallint] NOT NULL,
	[CodCarteraDestino] [smallint] NOT NULL,
	[CodMesaDestino] [smallint] NOT NULL,
	[CodMoneda1] [smallint] NOT NULL,
	[MontoMoneda1] [float] NOT NULL,
	[CodMoneda2] [smallint] NOT NULL,
	[MontoMoneda2] [float] NOT NULL,
	[TipoCambio] [float] NOT NULL,
	[Precio1] [float] NOT NULL,
	[Precio2] [float] NOT NULL,
	[Paridad] [float] NOT NULL,
	[Hora] [varchar](8) NOT NULL,
	[Usuario] [varchar](10) NOT NULL,
	[Plazo] [smallint] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[ReferenciaMercado] [smallint] NOT NULL,
	[FechaFijRefMerc] [datetime] NOT NULL,
	[ReferenciaParidad] [smallint] NOT NULL,
	[Fecha_Fijacion_Par] [datetime] NOT NULL,
	[Fecha_Vecto_Paridad] [datetime] NOT NULL,
	[Modalidad] [varchar](1) NOT NULL,
	[Equivalente_CLP] [float] NOT NULL,
	[Equivalente_USD] [float] NOT NULL,
	[Mto_Inicial_Mon1] [float] NOT NULL,
	[Mto_Final_Mon1] [float] NOT NULL,
	[Mto_Inicial_Mon2] [float] NOT NULL,
	[Mto_Final_Mon2] [float] NOT NULL,
	[Serie] [varchar](12) NOT NULL,
	[Anticipo] [char](1) NOT NULL
) ON [PRIMARY]
GO
