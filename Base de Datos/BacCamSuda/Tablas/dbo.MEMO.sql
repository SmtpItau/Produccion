USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEMO]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMO](
	[MOENTIDAD] [numeric](10, 0) NOT NULL,
	[MOTIPMER] [char](4) NOT NULL,
	[MONUMOPE] [numeric](7, 0) NOT NULL,
	[MOTIPOPE] [char](1) NOT NULL,
	[MORUTCLI] [numeric](9, 0) NOT NULL,
	[MOCODCLI] [numeric](9, 0) NOT NULL,
	[MONOMCLI] [char](35) NOT NULL,
	[MOCODMON] [char](3) NOT NULL,
	[MOCODCNV] [char](3) NOT NULL,
	[MOMONMO] [numeric](19, 4) NOT NULL,
	[MOTICAM] [numeric](19, 4) NOT NULL,
	[MOTCTRA] [numeric](19, 4) NOT NULL,
	[MOTCFIN] [numeric](19, 4) NOT NULL,
	[MOPARME] [numeric](19, 8) NOT NULL,
	[MOPARCIE] [numeric](19, 8) NOT NULL,
	[MOPARTR] [numeric](19, 8) NOT NULL,
	[MOPAR30] [numeric](19, 8) NOT NULL,
	[MOPARFI] [numeric](19, 8) NOT NULL,
	[MOPRECIO] [numeric](19, 4) NOT NULL,
	[MOPRETRA] [numeric](19, 4) NOT NULL,
	[MOPREFI] [numeric](19, 4) NOT NULL,
	[MOUSSME] [numeric](19, 4) NOT NULL,
	[MOUSS30] [numeric](19, 4) NOT NULL,
	[MOUSSTR] [numeric](19, 4) NOT NULL,
	[MOUSSFI] [numeric](19, 4) NOT NULL,
	[MOMONPE] [numeric](19, 4) NOT NULL,
	[MOENTRE] [numeric](3, 0) NOT NULL,
	[MORECIB] [numeric](3, 0) NOT NULL,
	[MOVALUTA1] [datetime] NOT NULL,
	[MOVALUTA2] [datetime] NOT NULL,
	[MOVAMOS] [numeric](1, 0) NOT NULL,
	[MOTLXP1] [numeric](2, 0) NOT NULL,
	[MOTLXP2] [numeric](2, 0) NOT NULL,
	[MOOPER] [char](15) NOT NULL,
	[MOFECH] [datetime] NOT NULL,
	[MOHORA] [char](8) NOT NULL,
	[MOTERM] [char](15) NOT NULL,
	[MOCODOMA] [numeric](3, 0) NOT NULL,
	[MOESTATUS] [char](1) NOT NULL,
	[MOIMPRESO] [char](1) NOT NULL,
	[MOPCIERRE] [char](1) NOT NULL,
	[MORENTAB] [numeric](3, 0) NOT NULL,
	[MOCENCOS] [char](35) NOT NULL,
	[MOUNIDAD] [char](35) NOT NULL,
	[MOCODEJEC] [numeric](6, 0) NOT NULL,
	[MOGRPGEN] [numeric](3, 0) NOT NULL,
	[MOGRPPRO] [numeric](3, 0) NOT NULL,
	[MOCORRES] [numeric](8, 0) NOT NULL,
	[MOEJECUTI] [char](7) NOT NULL,
	[MOPMECO] [numeric](9, 4) NOT NULL,
	[MOPMEVE] [numeric](9, 4) NOT NULL,
	[MOTOTCO] [numeric](19, 4) NOT NULL,
	[MOTOTVE] [numeric](19, 4) NOT NULL,
	[MOTOTCOM] [numeric](19, 4) NOT NULL,
	[MOTOTVEM] [numeric](19, 4) NOT NULL,
	[MOENVIA] [char](1) NOT NULL,
	[MOALINEA] [char](1) NOT NULL,
	[MOAPROB] [char](1) NOT NULL,
	[MONUMCHE] [numeric](6, 0) NOT NULL,
	[MOCARTA] [char](1) NOT NULL,
	[MOTIPCAR] [numeric](3, 0) NOT NULL,
	[MONUMFUT] [numeric](8, 0) NOT NULL,
	[MOFECINI] [datetime] NOT NULL,
	[Swift_Corresponsal] [varchar](10) NOT NULL,
	[Swift_Recibimos] [varchar](10) NOT NULL,
	[Swift_Entregamos] [varchar](10) NOT NULL,
	[Plaza_Corresponsal] [numeric](5, 0) NOT NULL,
	[Plaza_Recibimos] [numeric](5, 0) NOT NULL,
	[Plaza_Entregamos] [numeric](5, 0) NOT NULL,
	[Precio_Cliente] [numeric](10, 4) NOT NULL,
	[Forma_Pago_Cli_Nac] [numeric](3, 0) NOT NULL,
	[Forma_Pago_Cli_Ext] [numeric](3, 0) NOT NULL,
	[Valuta_Cli_Nac] [datetime] NOT NULL,
	[Valuta_Cli_Ext] [datetime] NOT NULL,
	[Apoderado_Izquierda] [numeric](9, 0) NOT NULL,
	[Apoderado_Derecha] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Contabiliza] [char](1) NOT NULL,
	[Sintetico] [char](1) NOT NULL,
	[Mercado] [char](1) NOT NULL,
	[Codigo_Pais] [numeric](5, 0) NOT NULL,
	[Casa_Matriz] [numeric](5, 0) NOT NULL,
	[Marca] [varchar](30) NOT NULL,
	[NumeroInterfaz] [varchar](16) NOT NULL,
	[Observacion] [varchar](250) NOT NULL,
	[anula_usuario] [varchar](15) NOT NULL,
	[anula_fecha] [datetime] NOT NULL,
	[anula_hora] [char](8) NOT NULL,
	[anula_motivo] [char](60) NOT NULL,
	[codigo_area] [varchar](5) NOT NULL,
	[codigo_comercio] [char](6) NOT NULL,
	[codigo_concepto] [char](3) NOT NULL,
	[moutilpe] [numeric](19, 0) NOT NULL,
	[mocostofo] [numeric](10, 4) NOT NULL,
	[autorizador_limite] [char](15) NULL,
	[morutgir] [numeric](9, 0) NOT NULL,
	[mofecvcto] [datetime] NULL,
	[modias] [numeric](4, 0) NOT NULL,
	[mocodigogirador] [numeric](9, 0) NOT NULL,
	[moobservlin] [char](255) NOT NULL,
	[moobservlim] [char](255) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[Dcrp_Confirmador] [char](1) NOT NULL,
	[Dcrp_Codigo] [numeric](9, 0) NOT NULL,
	[Dcrp_Glosa] [varchar](100) NOT NULL,
	[Dcrp_HoraConfirm] [char](8) NOT NULL,
	[Dcrp_OperConfirm] [char](15) NOT NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NOT NULL,
	[CMX_Punta_Pizarra] [numeric](18, 4) NULL,
	[CMX_TC_Costo_Trad] [numeric](18, 4) NULL,
	[moDifTran_Mo] [numeric](19, 4) NOT NULL,
	[moDifTran_Clp] [numeric](19, 0) NOT NULL,
	[moDigitador] [char](15) NOT NULL,
	[moResultado_Comercial_Clp] [numeric](21, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOENTIDAD__3CF99ADF]  DEFAULT (0) FOR [MOENTIDAD]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTIPMER__3DEDBF18]  DEFAULT ('') FOR [MOTIPMER]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MONUMOPE__3EE1E351]  DEFAULT (0) FOR [MONUMOPE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTIPOPE__3FD6078A]  DEFAULT ('') FOR [MOTIPOPE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MORUTCLI__40CA2BC3]  DEFAULT (0) FOR [MORUTCLI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCODCLI__41BE4FFC]  DEFAULT (0) FOR [MOCODCLI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MONOMCLI__42B27435]  DEFAULT ('') FOR [MONOMCLI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCODMON__43A6986E]  DEFAULT ('') FOR [MOCODMON]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCODCNV__449ABCA7]  DEFAULT ('') FOR [MOCODCNV]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOMONMO__458EE0E0]  DEFAULT (0) FOR [MOMONMO]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTICAM__46830519]  DEFAULT (0) FOR [MOTICAM]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTCTRA__47772952]  DEFAULT (0) FOR [MOTCTRA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTCFIN__486B4D8B]  DEFAULT (0) FOR [MOTCFIN]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPARME__495F71C4]  DEFAULT (0) FOR [MOPARME]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPARCIE__4A5395FD]  DEFAULT (0) FOR [MOPARCIE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPARTR__4B47BA36]  DEFAULT (0) FOR [MOPARTR]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPAR30__4C3BDE6F]  DEFAULT (0) FOR [MOPAR30]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPARFI__4D3002A8]  DEFAULT (0) FOR [MOPARFI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPRECIO__4E2426E1]  DEFAULT (0) FOR [MOPRECIO]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPRETRA__4F184B1A]  DEFAULT (0) FOR [MOPRETRA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPREFI__500C6F53]  DEFAULT (0) FOR [MOPREFI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOUSSME__5100938C]  DEFAULT (0) FOR [MOUSSME]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOUSS30__51F4B7C5]  DEFAULT (0) FOR [MOUSS30]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOUSSTR__52E8DBFE]  DEFAULT (0) FOR [MOUSSTR]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOUSSFI__53DD0037]  DEFAULT (0) FOR [MOUSSFI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOMONPE__54D12470]  DEFAULT (0) FOR [MOMONPE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOENTRE__55C548A9]  DEFAULT (0) FOR [MOENTRE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MORECIB__56B96CE2]  DEFAULT (0) FOR [MORECIB]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOVALUTA1__57AD911B]  DEFAULT ('') FOR [MOVALUTA1]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOVALUTA2__58A1B554]  DEFAULT ('') FOR [MOVALUTA2]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOVAMOS__5995D98D]  DEFAULT (0) FOR [MOVAMOS]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTLXP1__5A89FDC6]  DEFAULT (0) FOR [MOTLXP1]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTLXP2__5B7E21FF]  DEFAULT (0) FOR [MOTLXP2]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOOPER__5C724638]  DEFAULT ('') FOR [MOOPER]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOFECH__5D666A71]  DEFAULT ('') FOR [MOFECH]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOHORA__5E5A8EAA]  DEFAULT ('') FOR [MOHORA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTERM__5F4EB2E3]  DEFAULT ('') FOR [MOTERM]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCODOMA__6042D71C]  DEFAULT (0) FOR [MOCODOMA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOESTATUS__6136FB55]  DEFAULT ('') FOR [MOESTATUS]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOIMPRESO__622B1F8E]  DEFAULT ('') FOR [MOIMPRESO]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPCIERRE__631F43C7]  DEFAULT ('') FOR [MOPCIERRE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MORENTAB__64136800]  DEFAULT (0) FOR [MORENTAB]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCENCOS__65078C39]  DEFAULT ('') FOR [MOCENCOS]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOUNIDAD__65FBB072]  DEFAULT ('') FOR [MOUNIDAD]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCODEJEC__66EFD4AB]  DEFAULT (0) FOR [MOCODEJEC]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOGRPGEN__67E3F8E4]  DEFAULT (0) FOR [MOGRPGEN]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOGRPPRO__68D81D1D]  DEFAULT (0) FOR [MOGRPPRO]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCORRES__69CC4156]  DEFAULT (0) FOR [MOCORRES]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOEJECUTI__6AC0658F]  DEFAULT ('') FOR [MOEJECUTI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPMECO__6BB489C8]  DEFAULT (0) FOR [MOPMECO]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOPMEVE__6CA8AE01]  DEFAULT (0) FOR [MOPMEVE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTOTCO__6D9CD23A]  DEFAULT (0) FOR [MOTOTCO]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTOTVE__6E90F673]  DEFAULT (0) FOR [MOTOTVE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTOTCOM__6F851AAC]  DEFAULT (0) FOR [MOTOTCOM]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTOTVEM__70793EE5]  DEFAULT (0) FOR [MOTOTVEM]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOENVIA__716D631E]  DEFAULT ('') FOR [MOENVIA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOALINEA__72618757]  DEFAULT ('') FOR [MOALINEA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOAPROB__7355AB90]  DEFAULT ('') FOR [MOAPROB]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MONUMCHE__7449CFC9]  DEFAULT (0) FOR [MONUMCHE]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOCARTA__753DF402]  DEFAULT ('') FOR [MOCARTA]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOTIPCAR__7632183B]  DEFAULT (0) FOR [MOTIPCAR]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MONUMFUT__77263C74]  DEFAULT (0) FOR [MONUMFUT]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__MOFECINI__781A60AD]  DEFAULT ('') FOR [MOFECINI]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Swift_Corr__790E84E6]  DEFAULT ('') FOR [Swift_Corresponsal]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Swift_Reci__7A02A91F]  DEFAULT ('') FOR [Swift_Recibimos]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Swift_Entr__7AF6CD58]  DEFAULT ('') FOR [Swift_Entregamos]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Plaza_Corr__7BEAF191]  DEFAULT (0) FOR [Plaza_Corresponsal]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Plaza_Reci__7CDF15CA]  DEFAULT (0) FOR [Plaza_Recibimos]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Plaza_Entr__7DD33A03]  DEFAULT (0) FOR [Plaza_Entregamos]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Precio_Cli__7EC75E3C]  DEFAULT (0) FOR [Precio_Cliente]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Forma_Pago__7FBB8275]  DEFAULT (0) FOR [Forma_Pago_Cli_Nac]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Forma_Pago__00AFA6AE]  DEFAULT (0) FOR [Forma_Pago_Cli_Ext]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Valuta_Cli__01A3CAE7]  DEFAULT ('') FOR [Valuta_Cli_Nac]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Valuta_Cli__0297EF20]  DEFAULT ('') FOR [Valuta_Cli_Ext]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Apoderado___038C1359]  DEFAULT (0) FOR [Apoderado_Izquierda]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Apoderado___04803792]  DEFAULT (0) FOR [Apoderado_Derecha]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Id_Sistema__05745BCB]  DEFAULT ('') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Contabiliz__06688004]  DEFAULT ('') FOR [Contabiliza]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Sintetico__075CA43D]  DEFAULT ('') FOR [Sintetico]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Mercado__0850C876]  DEFAULT ('') FOR [Mercado]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Codigo_Pai__0944ECAF]  DEFAULT (0) FOR [Codigo_Pais]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Casa_Matri__0A3910E8]  DEFAULT (0) FOR [Casa_Matriz]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Marca__0B2D3521]  DEFAULT ('') FOR [Marca]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__NumeroInte__0C21595A]  DEFAULT ('') FOR [NumeroInterfaz]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__Observacio__0D157D93]  DEFAULT ('') FOR [Observacion]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__anula_usua__0E09A1CC]  DEFAULT ('') FOR [anula_usuario]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__anula_fech__0EFDC605]  DEFAULT ('') FOR [anula_fecha]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__anula_hora__0FF1EA3E]  DEFAULT ('') FOR [anula_hora]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__anula_moti__10E60E77]  DEFAULT ('') FOR [anula_motivo]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__codigo_are__11DA32B0]  DEFAULT ('') FOR [codigo_area]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__codigo_com__12CE56E9]  DEFAULT ('') FOR [codigo_comercio]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__codigo_con__13C27B22]  DEFAULT ('') FOR [codigo_concepto]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__moutilpe__14B69F5B]  DEFAULT (0) FOR [moutilpe]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__mocostofo__15AAC394]  DEFAULT (0) FOR [mocostofo]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__autorizado__169EE7CD]  DEFAULT ('') FOR [autorizador_limite]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__morutgir__17930C06]  DEFAULT (0) FOR [morutgir]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__mofecvcto__1887303F]  DEFAULT ('') FOR [mofecvcto]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF__MEMO__modias__197B5478]  DEFAULT (0) FOR [modias]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF_MEMO_mocodigogirador]  DEFAULT (0) FOR [mocodigogirador]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF_MEMO_moobservlin]  DEFAULT (' ') FOR [moobservlin]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF_MEMO_moobservlim]  DEFAULT (' ') FOR [moobservlim]
GO
ALTER TABLE [dbo].[MEMO] ADD  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [df_memo_DcrpConfirma]  DEFAULT ('N') FOR [Dcrp_Confirmador]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [df_memo_DcrpCodigo]  DEFAULT (0) FOR [Dcrp_Codigo]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [df_memo_DcrpGlosa]  DEFAULT ('-') FOR [Dcrp_Glosa]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [df_memo_DcrpHora]  DEFAULT ('00:00:00') FOR [Dcrp_HoraConfirm]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [df_memo_OperHora]  DEFAULT ('-') FOR [Dcrp_OperConfirm]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [df_memo_OpeCnvHora]  DEFAULT ('-') FOR [Dcrp_OpeCnvConfirm]
GO
ALTER TABLE [dbo].[MEMO] ADD  DEFAULT (0) FOR [moDifTran_Mo]
GO
ALTER TABLE [dbo].[MEMO] ADD  DEFAULT (0) FOR [moDifTran_Clp]
GO
ALTER TABLE [dbo].[MEMO] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[MEMO] ADD  CONSTRAINT [DF_MEMO_moResultado_Comercial_Clp]  DEFAULT ((0)) FOR [moResultado_Comercial_Clp]
GO
