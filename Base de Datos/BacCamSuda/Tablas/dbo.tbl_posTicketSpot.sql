USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbl_posTicketSpot]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_posTicketSpot](
	[Fecha_Posicion] [datetime] NOT NULL,
	[CodMoneda] [smallint] NOT NULL,
	[CodMesa] [smallint] NOT NULL,
	[Posicion_Anterior] [float] NOT NULL,
	[Compras_Dia] [float] NOT NULL,
	[Ventas_Dia] [float] NOT NULL,
	[Posicion_Actual] [float] NOT NULL,
	[pmpInc] [float] NULL,
	[pmpCmps] [float] NULL,
	[pmpVnts] [float] NULL,
	[pmpFin] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Fecha_Posicion] ASC,
	[CodMoneda] ASC,
	[CodMesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT ('') FOR [Fecha_Posicion]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [CodMoneda]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [CodMesa]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [Posicion_Anterior]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [Compras_Dia]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [Ventas_Dia]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [Posicion_Actual]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [pmpInc]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [pmpCmps]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [pmpVnts]
GO
ALTER TABLE [dbo].[tbl_posTicketSpot] ADD  DEFAULT (0) FOR [pmpFin]
GO
