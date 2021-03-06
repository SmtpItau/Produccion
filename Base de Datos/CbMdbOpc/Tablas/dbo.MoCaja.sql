USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[MoCaja]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoCaja](
	[MoNumFolio] [numeric](8, 0) NOT NULL,
	[MoNumEstructura] [numeric](6, 0) NOT NULL,
	[MoCajFolio] [numeric](8, 0) NOT NULL,
	[MoCajFechaGen] [datetime] NULL,
	[MoCajFecPago] [datetime] NULL,
	[MoCajFDeMon1] [float] NULL,
	[MoCajMtoMon1] [float] NULL,
	[MoCajFDeMon2] [float] NULL,
	[MoCajMtoMon2] [float] NULL,
	[MoCajEstado] [char](2) NULL,
	[MoMTMImplicito] [float] NULL,
	[MoCajFormaPagoMon1] [numeric](5, 0) NULL,
	[MoCajFormaPagoMon2] [numeric](5, 0) NULL,
	[MoCajMdaM1] [numeric](5, 0) NULL,
	[MoCajMdaM2] [numeric](5, 0) NULL,
	[MoCajOrigen] [varchar](2) NULL,
	[MoCajMotorPago] [varchar](2) NULL,
	[MoCajModalidad] [char](1) NULL,
	[MoCajFechaPagMon1] [datetime] NULL,
	[MoCajFechaPagMon2] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MoNumFolio] ASC,
	[MoNumEstructura] ASC,
	[MoCajFolio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
