USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[MoHisDetContrato]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoHisDetContrato](
	[MoNumFolio] [numeric](8, 0) NOT NULL,
	[MoNumEstructura] [numeric](6, 0) NOT NULL,
	[MoVinculacion] [varchar](15) NULL,
	[MoTipoOpc] [varchar](1) NULL,
	[MoSubyacente] [varchar](5) NULL,
	[MoTipoPayOff] [varchar](2) NULL,
	[MoCallPut] [varchar](5) NULL,
	[MoCVOpc] [varchar](3) NULL,
	[MoTipoEmisionPT] [varchar](3) NULL,
	[MoFechaInicioOpc] [datetime] NULL,
	[MoFechaFijacion] [datetime] NULL,
	[MoFechaVcto] [datetime] NULL,
	[MoFormaPagoMon1] [numeric](3, 0) NULL,
	[MoFechaPagMon1] [datetime] NULL,
	[MoFormaPagoMon2] [numeric](3, 0) NULL,
	[MoFechaPagMon2] [datetime] NULL,
	[MoFechaPagoEjer] [datetime] NULL,
	[MoCodMon1] [numeric](5, 0) NULL,
	[MoMontoMon1] [numeric](21, 6) NULL,
	[MoCodMon2] [numeric](5, 0) NULL,
	[MoMontoMon2] [numeric](21, 6) NULL,
	[MoModalidad] [varchar](1) NULL,
	[MoMdaCompensacion] [numeric](5, 0) NULL,
	[MoBenchComp] [numeric](5, 0) NULL,
	[MoParStrike] [varchar](7) NULL,
	[MoStrike] [float] NULL,
	[MoPorcStrike] [numeric](15, 7) NULL,
	[MoTipoEjercicio] [varchar](2) NULL,
	[MoCurveMon1] [varchar](20) NULL,
	[MoCurveMon2] [varchar](20) NULL,
	[MoCurveSmile] [varchar](20) NULL,
	[MoWf_mon1] [float] NULL,
	[MoWf_mon2] [float] NULL,
	[MoVol] [float] NULL,
	[MoFwd_teo] [float] NULL,
	[MoDelta_spot] [float] NULL,
	[MoDelta_spot_num] [float] NULL,
	[MoDelta_fwd] [float] NULL,
	[MoDelta_fwd_num] [float] NULL,
	[MoGamma_spot] [float] NULL,
	[MoGamma_spot_num] [float] NULL,
	[MoGamma_fwd] [float] NULL,
	[MoGamma_fwd_num] [float] NULL,
	[MoVega] [float] NULL,
	[MoVega_num] [float] NULL,
	[MoVanna_spot] [float] NULL,
	[MoVanna_spot_num] [float] NULL,
	[MoVanna_fwd] [float] NULL,
	[MoVanna_fwd_num] [float] NULL,
	[MoVolga] [float] NULL,
	[MoVolga_num] [float] NULL,
	[MoTheta] [float] NULL,
	[MoTheta_num] [float] NULL,
	[MoRho] [float] NULL,
	[MoRho_num] [float] NULL,
	[MoRhof] [float] NULL,
	[MoRhof_num] [float] NULL,
	[MoCharm_spot] [float] NULL,
	[MoCharm_spot_num] [float] NULL,
	[MoCharm_fwd] [float] NULL,
	[MoCharm_fwd_num] [float] NULL,
	[MoZomma_spot] [float] NULL,
	[MoZomma_spot_num] [float] NULL,
	[MoZomma_fwd] [float] NULL,
	[MoZomma_fwd_num] [float] NULL,
	[MoSpeed_spot] [float] NULL,
	[MoSpeed_spot_num] [float] NULL,
	[MoSpeed_fwd] [float] NULL,
	[MoSpeed_fwd_num] [float] NULL,
	[MoVrDet] [float] NULL,
	[MoSpotDet] [float] NULL,
	[MoSpotDetCosto] [float] NULL,
	[MoWf_Mon1_Costo] [float] NULL,
	[MoWf_Mon2_Costo] [float] NULL,
	[MoVol_Costo] [float] NULL,
	[MoFwd_Teo_Costo] [float] NULL,
	[MoVr_CostoDet] [float] NULL,
	[MoPrimaBSSpotDet] [float] NULL,
	[MoIteAsoSis] [varchar](3) NULL,
	[MoIteAsoCon] [numeric](8, 0) NULL,
	[MoFormaPagoComp] [numeric](3, 0) NULL,
	[MoVrDetML] [numeric](21, 4) NULL,
	[MoPrimaInicialDet] [float] NULL,
	[MoWf_ML] [float] NULL,
	[MoPrimaInicialDetML] [numeric](21, 4) NULL,
PRIMARY KEY CLUSTERED 
(
	[MoNumFolio] ASC,
	[MoNumEstructura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
