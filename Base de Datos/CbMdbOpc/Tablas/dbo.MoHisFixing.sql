USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[MoHisFixing]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoHisFixing](
	[MoNumFolio] [numeric](8, 0) NOT NULL,
	[MoNumEstructura] [numeric](6, 0) NOT NULL,
	[MoFixFecha] [datetime] NULL,
	[MoFixNumero] [numeric](6, 0) NOT NULL,
	[MoPesoFij] [float] NULL,
	[MoVolFij] [float] NULL,
	[MoFijacion] [float] NULL,
	[MoFixBenchComp] [numeric](5, 0) NULL,
	[MoFixParBench] [varchar](7) NULL,
	[MoFixEstado] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[MoNumFolio] ASC,
	[MoNumEstructura] ASC,
	[MoFixNumero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
