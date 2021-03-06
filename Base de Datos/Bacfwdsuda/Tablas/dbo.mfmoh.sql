USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfmoh]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfmoh](
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
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__monumoper__3EA05581]  DEFAULT (0) FOR [monumoper]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodpos1__3F9479BA]  DEFAULT (0) FOR [mocodpos1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodmon1__40889DF3]  DEFAULT (0) FOR [mocodmon1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodsuc1__417CC22C]  DEFAULT (0) FOR [mocodsuc1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodpos2__4270E665]  DEFAULT (0) FOR [mocodpos2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodmon2__43650A9E]  DEFAULT (0) FOR [mocodmon2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodcart__44592ED7]  DEFAULT (0) FOR [mocodcart]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodigo__454D5310]  DEFAULT (0) FOR [mocodigo]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocodcli__46417749]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motipoper__47359B82]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motipmoda__4829BFBB]  DEFAULT (' ') FOR [motipmoda]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mofecha__491DE3F4]  DEFAULT (' ') FOR [mofecha]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motipcam__4A12082D]  DEFAULT (0) FOR [motipcam]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momdausd__4B062C66]  DEFAULT (0) FOR [momdausd]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momtomon1__4BFA509F]  DEFAULT (0) FOR [momtomon1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moequusd1__4CEE74D8]  DEFAULT (0) FOR [moequusd1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moequmon1__4DE29911]  DEFAULT (0) FOR [moequmon1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momtomon2__4ED6BD4A]  DEFAULT (0) FOR [momtomon2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moequusd2__4FCAE183]  DEFAULT (0) FOR [moequusd2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moequmon2__50BF05BC]  DEFAULT (0) FOR [moequmon2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moparmon1__51B329F5]  DEFAULT (0) FOR [moparmon1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mopremon1__52A74E2E]  DEFAULT (0) FOR [mopremon1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moparmon2__539B7267]  DEFAULT (0) FOR [moparmon2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mopremon2__548F96A0]  DEFAULT (0) FOR [mopremon2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moestado__5583BAD9]  DEFAULT (' ') FOR [moestado]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moretiro__5677DF12]  DEFAULT (' ') FOR [moretiro]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocontrap__576C034B]  DEFAULT (0) FOR [mocontraparte]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moobserv__58602784]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mospread__59544BBD]  DEFAULT (0) FOR [mospread]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motasadol__5A486FF6]  DEFAULT (0) FOR [motasadolar]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motasaufc__5B3C942F]  DEFAULT (0) FOR [motasaufclp]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moprecal__5C30B868]  DEFAULT (0) FOR [moprecal]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__moplazo__5D24DCA1]  DEFAULT (0) FOR [moplazo]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mofecvcto__5E1900DA]  DEFAULT (' ') FOR [mofecvcto]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__molock__5F0D2513]  DEFAULT (' ') FOR [molock]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mooperado__6001494C]  DEFAULT (' ') FOR [mooperador]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motasfwdc__60F56D85]  DEFAULT (0) FOR [motasfwdcmp]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motasfwdv__61E991BE]  DEFAULT (0) FOR [motasfwdvta]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocalcmpd__62DDB5F7]  DEFAULT (0) FOR [mocalcmpdol]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocalcmps__63D1DA30]  DEFAULT (0) FOR [mocalcmpspr]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocalvtad__64C5FE69]  DEFAULT (0) FOR [mocalvtadol]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mocalvtas__65BA22A2]  DEFAULT (0) FOR [mocalvtaspr]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motasausd__66AE46DB]  DEFAULT (0) FOR [motasausd]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motasacon__67A26B14]  DEFAULT (0) FOR [motasacon]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momtomon1__68968F4D]  DEFAULT (0) FOR [momtomon1ini]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momtomon1__698AB386]  DEFAULT (0) FOR [momtomon1fin]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momtomon2__6A7ED7BF]  DEFAULT (0) FOR [momtomon2ini]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__momtomon2__6B72FBF8]  DEFAULT (0) FOR [momtomon2fin]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__modiferen__6C672031]  DEFAULT (' ') FOR [modiferen]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mofpagomn__6D5B446A]  DEFAULT (0) FOR [mofpagomn]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mofpagomx__6E4F68A3]  DEFAULT (0) FOR [mofpagomx]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mobroker__6F438CDC]  DEFAULT (0) FOR [mobroker]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mopremio__7037B115]  DEFAULT (0) FOR [mopremio]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__motipopc__712BD54E]  DEFAULT (' ') FOR [motipopc]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF__mfmoh__mohora__721FF987]  DEFAULT (' ') FOR [mohora]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_mfmoh_mopreciopunta]  DEFAULT (0) FOR [mopreciopunta]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_mfmoh_moremunera_linea]  DEFAULT (0) FOR [moremunera_linea]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_mfmoh_motasa_efectiva_moneda1]  DEFAULT (0) FOR [motasa_efectiva_moneda1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_mfmoh_motasa_efectiva_moneda2]  DEFAULT (0) FOR [motasa_efectiva_moneda2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0) FOR [motasaEfectMon1]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0) FOR [motasaEfectMon2]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0) FOR [motipcamSpot]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0) FOR [motipcamFwd]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [mofecEfectiva]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [df_mfmoh_moserie]  DEFAULT ('') FOR [moserie]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [df_mfmoh_moseriado]  DEFAULT ('N') FOR [moseriado]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0.0) FOR [motipcamPtosFwd]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [mocartera_normativa]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [mosubcartera_normativa]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [molibro]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [moArea_Responsable]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [fecha_estado_sina]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_cacosto_usdclp]  DEFAULT (0.0) FOR [mocosto_usdclp]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_cacosto_mxusd]  DEFAULT (0.0) FOR [mocosto_mxusd]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_cacosto_mxclp]  DEFAULT (0.0) FOR [mocosto_mxclp]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_mofijaTCRef]  DEFAULT ('') FOR [mofijaTCRef]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_mofijaPRRef]  DEFAULT ('') FOR [mofijaPRRef]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_moSpotTipCam]  DEFAULT (0.0) FOR [moSpotTipCam]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [dfmfmoh_moSpotParidad]  DEFAULT (0.0) FOR [moSpotParidad]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0) FOR [numerospot]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [df_MFMOH_Resultado_Mesa]  DEFAULT (0.0) FOR [Resultado_Mesa]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [df_MFMOH_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoFechaStarting]  DEFAULT ('19000101') FOR [MoFechaStarting]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoFechaFijacionStarting]  DEFAULT ('19000101') FOR [MoFechaFijacionStarting]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoPuntosFwdCierre]  DEFAULT (0.0) FOR [MoPuntosFwdCierre]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoPuntosTransfObs]  DEFAULT (0.0) FOR [MoPuntosTransfObs]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoPuntosTransfFwd]  DEFAULT (0.0) FOR [MoPuntosTransfFwd]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoTasaPriPzoFijObs]  DEFAULT (0.0) FOR [MoTasaPriPzoFijObs]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoTasaSecPzoFijObs]  DEFAULT (0.0) FOR [MoTasaSecPzoFijObs]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_MFMOH_MoDelta]  DEFAULT (0.0) FOR [MoDelta]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT (0) FOR [moNroOpeMxClp]
GO
ALTER TABLE [dbo].[mfmoh] ADD  CONSTRAINT [DF_mfmoh_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[mfmoh] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
