USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[tbl_carticketfwd]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_carticketfwd](
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
	[Anticipo] [char](1) NOT NULL,
 CONSTRAINT [PK_tbl_carticketfwd] PRIMARY KEY NONCLUSTERED 
(
	[Fecha_Operacion] ASC,
	[Numero_Operacion] ASC,
	[Numero_Operacion_Relacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Fecha_Operacion]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Numero_Operacion_Relacion]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Codigo_Producto]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [CodCarteraOrigen]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [CodMesaOrigen]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [CodCarteraDestino]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [CodMesaDestino]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [CodMoneda1]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [MontoMoneda1]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [CodMoneda2]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [MontoMoneda2]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [TipoCambio]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Precio1]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Precio2]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Paridad]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Plazo]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [ReferenciaMercado]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [FechaFijRefMerc]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [ReferenciaParidad]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Fecha_Fijacion_Par]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Fecha_Vecto_Paridad]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Modalidad]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Equivalente_CLP]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Equivalente_USD]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Mto_Inicial_Mon1]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Mto_Final_Mon1]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Mto_Inicial_Mon2]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT (0) FOR [Mto_Final_Mon2]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[tbl_carticketfwd] ADD  DEFAULT ('') FOR [Anticipo]
GO
