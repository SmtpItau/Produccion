USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfmo]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfmo](
	[monumoper] [numeric](10, 0) NOT NULL,
	[mocodpos1] [numeric](2, 0) NOT NULL,
	[mocodmon1] [numeric](3, 0) NOT NULL,
	[mocodsuc1] [numeric](3, 0) NOT NULL,
	[mocodpos2] [numeric](2, 0) NOT NULL,
	[mocodmon2] [numeric](3, 0) NOT NULL,
	[mocodcart] [numeric](9, 0) NOT NULL,
	[mocodigo] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[motipoper] [char](1) NOT NULL,
	[motipmoda] [char](1) NOT NULL,
	[mofecha] [datetime] NOT NULL,
	[motipcam] [float] NOT NULL,
	[momdausd] [numeric](3, 0) NOT NULL,
	[momtomon1] [numeric](21, 4) NOT NULL,
	[moequusd1] [numeric](21, 4) NOT NULL,
	[moequmon1] [numeric](21, 4) NOT NULL,
	[momtomon2] [numeric](21, 4) NOT NULL,
	[moequusd2] [numeric](21, 4) NOT NULL,
	[moequmon2] [numeric](21, 4) NOT NULL,
	[moparmon1] [float] NOT NULL,
	[mopremon1] [float] NOT NULL,
	[moparmon2] [float] NOT NULL,
	[mopremon2] [float] NOT NULL,
	[moestado] [char](1) NOT NULL,
	[moretiro] [char](1) NOT NULL,
	[mocontraparte] [numeric](9, 0) NOT NULL,
	[moobserv] [varchar](255) NOT NULL,
	[mospread] [float] NOT NULL,
	[motasadolar] [float] NOT NULL,
	[motasaufclp] [float] NOT NULL,
	[moprecal] [float] NOT NULL,
	[moplazo] [numeric](6, 0) NOT NULL,
	[mofecvcto] [datetime] NOT NULL,
	[molock] [char](15) NOT NULL,
	[mooperador] [char](15) NOT NULL,
	[motasfwdcmp] [float] NOT NULL,
	[motasfwdvta] [float] NOT NULL,
	[mocalcmpdol] [float] NOT NULL,
	[mocalcmpspr] [float] NOT NULL,
	[mocalvtadol] [float] NOT NULL,
	[mocalvtaspr] [float] NOT NULL,
	[motasausd] [float] NOT NULL,
	[motasacon] [float] NOT NULL,
	[momtomon1ini] [numeric](21, 4) NOT NULL,
	[momtomon1fin] [numeric](21, 4) NOT NULL,
	[momtomon2ini] [numeric](21, 4) NOT NULL,
	[momtomon2fin] [numeric](21, 4) NOT NULL,
	[modiferen] [float] NOT NULL,
	[mofpagomn] [numeric](3, 0) NOT NULL,
	[mofpagomx] [numeric](3, 0) NOT NULL,
	[mobroker] [numeric](9, 0) NOT NULL,
	[mopremio] [numeric](21, 4) NOT NULL,
	[motipopc] [char](1) NOT NULL,
	[mohora] [char](8) NOT NULL,
	[mopreciopunta] [float] NOT NULL,
	[moremunera_linea] [numeric](10, 4) NOT NULL,
	[motasa_efectiva_moneda1] [float] NOT NULL,
	[motasa_efectiva_moneda2] [float] NOT NULL,
	[mooperrelaspot] [char](2) NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[motasaEfectMon1] [float] NOT NULL,
	[motasaEfectMon2] [float] NOT NULL,
	[motipcamSpot] [float] NOT NULL,
	[motipcamFwd] [float] NOT NULL,
	[mofecEfectiva] [datetime] NOT NULL,
	[moserie] [varchar](12) NULL,
	[moseriado] [char](1) NULL,
	[motipcamPtosFwd] [float] NOT NULL,
	[mocartera_normativa] [char](6) NULL,
	[mosubcartera_normativa] [char](6) NULL,
	[molibro] [char](6) NULL,
	[moArea_Responsable] [char](6) NULL,
	[estado_sinacofi] [char](25) NOT NULL,
	[fecha_estado_sina] [datetime] NOT NULL,
	[mocosto_usdclp] [float] NOT NULL,
	[mocosto_mxusd] [float] NOT NULL,
	[mocosto_mxclp] [float] NOT NULL,
	[mofijaTCRef] [datetime] NOT NULL,
	[mofijaPRRef] [datetime] NOT NULL,
	[moSpotTipCam] [float] NOT NULL,
	[moSpotParidad] [float] NOT NULL,
	[numerospot] [numeric](9, 0) NOT NULL,
	[Resultado_Mesa] [float] NOT NULL,
	[moDigitador] [char](15) NOT NULL,
	[Threshold] [char](1) NOT NULL,
	[MoFechaStarting] [datetime] NOT NULL,
	[MoFechaFijacionStarting] [datetime] NOT NULL,
	[MoPuntosFwdCierre] [float] NOT NULL,
	[MoPuntosTransfObs] [float] NOT NULL,
	[MoPuntosTransfFwd] [float] NOT NULL,
	[MoTasaPriPzoFijObs] [float] NOT NULL,
	[MoTasaSecPzoFijObs] [float] NOT NULL,
	[MoDelta] [float] NOT NULL,
	[moNroOpeMxClp] [numeric](9, 0) NOT NULL,
	[bEarlyTermination] [bit] NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[Periodicidad] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__monumoper__084444D0]  DEFAULT (0) FOR [monumoper]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodpos1__09386909]  DEFAULT (0) FOR [mocodpos1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodmon1__0A2C8D42]  DEFAULT (0) FOR [mocodmon1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodsuc1__0B20B17B]  DEFAULT (0) FOR [mocodsuc1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodpos2__0C14D5B4]  DEFAULT (0) FOR [mocodpos2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodmon2__0D08F9ED]  DEFAULT (0) FOR [mocodmon2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodcart__0DFD1E26]  DEFAULT (0) FOR [mocodcart]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodigo__0EF1425F]  DEFAULT (0) FOR [mocodigo]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocodcli__0FE56698]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motipoper__10D98AD1]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motipmoda__11CDAF0A]  DEFAULT (' ') FOR [motipmoda]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mofecha__12C1D343]  DEFAULT (' ') FOR [mofecha]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motipcam__13B5F77C]  DEFAULT (0) FOR [motipcam]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momdausd__14AA1BB5]  DEFAULT (0) FOR [momdausd]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momtomon1__159E3FEE]  DEFAULT (0) FOR [momtomon1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moequusd1__16926427]  DEFAULT (0) FOR [moequusd1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moequmon1__17868860]  DEFAULT (0) FOR [moequmon1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momtomon2__187AAC99]  DEFAULT (0) FOR [momtomon2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moequusd2__196ED0D2]  DEFAULT (0) FOR [moequusd2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moequmon2__1A62F50B]  DEFAULT (0) FOR [moequmon2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moparmon1__1B571944]  DEFAULT (0) FOR [moparmon1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mopremon1__1C4B3D7D]  DEFAULT (0) FOR [mopremon1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moparmon2__1D3F61B6]  DEFAULT (0) FOR [moparmon2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mopremon2__1E3385EF]  DEFAULT (0) FOR [mopremon2]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moestado__1F27AA28]  DEFAULT (' ') FOR [moestado]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moretiro__201BCE61]  DEFAULT (' ') FOR [moretiro]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocontrapa__210FF29A]  DEFAULT (0) FOR [mocontraparte]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moobserv__220416D3]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mospread__22F83B0C]  DEFAULT (0) FOR [mospread]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motasadola__23EC5F45]  DEFAULT (0) FOR [motasadolar]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motasaufcl__24E0837E]  DEFAULT (0) FOR [motasaufclp]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moprecal__25D4A7B7]  DEFAULT (0) FOR [moprecal]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__moplazo__26C8CBF0]  DEFAULT (0) FOR [moplazo]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mofecvcto__27BCF029]  DEFAULT (' ') FOR [mofecvcto]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__molock__28B11462]  DEFAULT (' ') FOR [molock]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mooperador__29A5389B]  DEFAULT (' ') FOR [mooperador]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motasfwdcm__2A995CD4]  DEFAULT (0) FOR [motasfwdcmp]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motasfwdvt__2B8D810D]  DEFAULT (0) FOR [motasfwdvta]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocalcmpdo__2C81A546]  DEFAULT (0) FOR [mocalcmpdol]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocalcmpsp__2D75C97F]  DEFAULT (0) FOR [mocalcmpspr]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocalvtado__2E69EDB8]  DEFAULT (0) FOR [mocalvtadol]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mocalvtasp__2F5E11F1]  DEFAULT (0) FOR [mocalvtaspr]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motasausd__3052362A]  DEFAULT (0) FOR [motasausd]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motasacon__31465A63]  DEFAULT (0) FOR [motasacon]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momtomon1i__323A7E9C]  DEFAULT (0) FOR [momtomon1ini]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momtomon1f__332EA2D5]  DEFAULT (0) FOR [momtomon1fin]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momtomon2i__3422C70E]  DEFAULT (0) FOR [momtomon2ini]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__momtomon2f__3516EB47]  DEFAULT (0) FOR [momtomon2fin]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__modiferen__360B0F80]  DEFAULT (' ') FOR [modiferen]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mofpagomn__36FF33B9]  DEFAULT (0) FOR [mofpagomn]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mofpagomx__37F357F2]  DEFAULT (0) FOR [mofpagomx]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mobroker__38E77C2B]  DEFAULT (0) FOR [mobroker]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mopremio__39DBA064]  DEFAULT (0) FOR [mopremio]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__motipopc__3ACFC49D]  DEFAULT (' ') FOR [motipopc]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF__mfmo__mohora__3BC3E8D6]  DEFAULT (' ') FOR [mohora]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_mfmo_mopreciopunta]  DEFAULT (0) FOR [mopreciopunta]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_mfmo_moremunera_linea]  DEFAULT (0) FOR [moremunera_linea]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_mfmo_motasa_efectiva_moneda1]  DEFAULT (0) FOR [motasa_efectiva_moneda1]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_mfmo_motasa_efectiva_moneda2]  DEFAULT (0) FOR [motasa_efectiva_moneda2]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [motasaEfectMon1]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [motasaEfectMon2]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [motipcamSpot]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [motipcamFwd]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [mofecEfectiva]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [df_mfmo_moserie]  DEFAULT ('') FOR [moserie]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [df_mfmo_moseriado]  DEFAULT ('N') FOR [moseriado]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0.0) FOR [motipcamPtosFwd]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [mocartera_normativa]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [mosubcartera_normativa]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [molibro]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [moArea_Responsable]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [fecha_estado_sina]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_cacosto_usdclp]  DEFAULT (0.0) FOR [mocosto_usdclp]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_cacosto_mxusd]  DEFAULT (0.0) FOR [mocosto_mxusd]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_cacosto_mxclp]  DEFAULT (0.0) FOR [mocosto_mxclp]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_mofijaTCRef]  DEFAULT ('') FOR [mofijaTCRef]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_mofijaPRRef]  DEFAULT ('') FOR [mofijaPRRef]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_moSpotTipCam]  DEFAULT (0.0) FOR [moSpotTipCam]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [dfmfmo_moSpotParidad]  DEFAULT (0.0) FOR [moSpotParidad]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [numerospot]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [df_MFMO_Resultado_Mesa]  DEFAULT (0.0) FOR [Resultado_Mesa]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [df_MFMO_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoFechaStarting]  DEFAULT ('19000101') FOR [MoFechaStarting]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoFechaFijacionStarting]  DEFAULT ('19000101') FOR [MoFechaFijacionStarting]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoPuntosFwdCierre]  DEFAULT (0.0) FOR [MoPuntosFwdCierre]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoPuntosTransfObs]  DEFAULT (0.0) FOR [MoPuntosTransfObs]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoPuntosTransfFwd]  DEFAULT (0.0) FOR [MoPuntosTransfFwd]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoTasaPriPzoFijObs]  DEFAULT (0.0) FOR [MoTasaPriPzoFijObs]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoTasaSecPzoFijObs]  DEFAULT (0.0) FOR [MoTasaSecPzoFijObs]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_MFMO_MoDelta]  DEFAULT (0.0) FOR [MoDelta]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT (0) FOR [moNroOpeMxClp]
GO
ALTER TABLE [dbo].[mfmo] ADD  CONSTRAINT [DF_mfmo_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[mfmo] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
