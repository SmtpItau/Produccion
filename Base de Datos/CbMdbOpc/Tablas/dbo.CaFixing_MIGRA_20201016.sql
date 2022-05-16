USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[CaFixing_MIGRA_20201016]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaFixing_MIGRA_20201016](
	[CaNumContrato] [numeric](8, 0) NOT NULL,
	[CaNumEstructura] [numeric](6, 0) NOT NULL,
	[CaFixFecha] [datetime] NULL,
	[CaFixNumero] [numeric](6, 0) NOT NULL,
	[CaPesoFij] [float] NULL,
	[CaVolFij] [float] NULL,
	[CaFijacion] [float] NULL,
	[CaFixBenchComp] [numeric](5, 0) NULL,
	[CaFixParBench] [varchar](7) NULL,
	[CaFixEstado] [char](1) NULL
) ON [PRIMARY]
GO
