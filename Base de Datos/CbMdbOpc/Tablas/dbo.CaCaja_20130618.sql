USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[CaCaja_20130618]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaCaja_20130618](
	[CaNumContrato] [numeric](8, 0) NOT NULL,
	[CaNumEstructura] [numeric](6, 0) NOT NULL,
	[CaCajFolio] [numeric](8, 0) NOT NULL,
	[CaCajFechaGen] [datetime] NOT NULL,
	[CaCajFecPago] [datetime] NOT NULL,
	[CaCajFDeMon1] [float] NOT NULL,
	[CaCajMtoMon1] [float] NOT NULL,
	[CaCajFDeMon2] [float] NOT NULL,
	[CaCajMtoMon2] [float] NOT NULL,
	[CaCajEstado] [char](2) NOT NULL,
	[CaMTMImplicito] [float] NOT NULL,
	[CaCajFormaPagoMon1] [numeric](5, 0) NOT NULL,
	[CaCajFormaPagoMon2] [numeric](5, 0) NOT NULL,
	[CaCajMdaM1] [numeric](5, 0) NOT NULL,
	[CaCajMdaM2] [numeric](5, 0) NOT NULL,
	[CaCajOrigen] [varchar](2) NOT NULL,
	[CaCajMotorPago] [varchar](2) NOT NULL,
	[CaCajModalidad] [char](1) NOT NULL,
	[CaCajFechaPagMon1] [datetime] NOT NULL,
	[CaCajFechaPagMon2] [datetime] NOT NULL
) ON [PRIMARY]
GO
