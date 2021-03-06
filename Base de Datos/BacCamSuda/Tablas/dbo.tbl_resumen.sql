USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbl_resumen]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_resumen](
	[Fecha] [datetime] NULL,
	[Moneda] [varchar](3) NULL,
	[CodigoOrigen] [smallint] NULL,
	[Saldo_Inicial] [float] NULL,
	[OperadoDia] [float] NULL,
	[Saldo] [float] NULL,
	[MontoCompra] [float] NOT NULL,
	[TCPondCompra] [float] NOT NULL,
	[MontoVenta] [float] NOT NULL,
	[TCPondventa] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_resumen] ADD  DEFAULT (0.0) FOR [MontoCompra]
GO
ALTER TABLE [dbo].[tbl_resumen] ADD  DEFAULT (0.0) FOR [TCPondCompra]
GO
ALTER TABLE [dbo].[tbl_resumen] ADD  DEFAULT (0.0) FOR [MontoVenta]
GO
ALTER TABLE [dbo].[tbl_resumen] ADD  DEFAULT (0.0) FOR [TCPondventa]
GO
