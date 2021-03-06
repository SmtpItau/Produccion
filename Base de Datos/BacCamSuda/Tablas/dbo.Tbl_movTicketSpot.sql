USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[Tbl_movTicketSpot]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_movTicketSpot](
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Numero_Relacion_Operacion] [numeric](10, 0) NOT NULL,
	[Fecha_Operacion] [datetime] NOT NULL,
	[Tipo_Operacion] [varchar](1) NOT NULL,
	[Codigo_Producto] [char](4) NULL,
	[CodCarteraOrigen] [smallint] NOT NULL,
	[CodMesaOrigen] [smallint] NOT NULL,
	[CodCarteraDestino] [smallint] NOT NULL,
	[CodMesaDestino] [smallint] NOT NULL,
	[CodMoneda1] [smallint] NOT NULL,
	[MontoMoneda1] [float] NOT NULL,
	[CodMoneda2] [smallint] NOT NULL,
	[MontoMoneda2] [float] NOT NULL,
	[TipoCambio] [float] NOT NULL,
	[Paridad] [float] NOT NULL,
	[Precio] [float] NOT NULL,
	[Hora] [varchar](8) NOT NULL,
	[Usuario] [varchar](10) NOT NULL,
	[Estado_Operacion] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Numero_Operacion] ASC,
	[Fecha_Operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [Numero_Relacion_Operacion]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT ('') FOR [Fecha_Operacion]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [CodCarteraOrigen]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [CodMesaOrigen]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [CodCarteraDestino]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [CodMesaDestino]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [CodMoneda1]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [MontoMoneda1]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [CodMoneda2]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [MontoMoneda2]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [TipoCambio]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT (0) FOR [Paridad]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[Tbl_movTicketSpot] ADD  DEFAULT ('') FOR [Estado_Operacion]
GO
