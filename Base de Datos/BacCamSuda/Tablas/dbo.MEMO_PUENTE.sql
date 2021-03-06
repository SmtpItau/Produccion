USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEMO_PUENTE]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMO_PUENTE](
	[moentidad] [numeric](10, 0) NOT NULL,
	[motipmer] [char](4) NOT NULL,
	[monumope] [numeric](7, 0) NOT NULL,
	[motipope] [char](1) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[monomcli] [char](35) NOT NULL,
	[mocodmon] [char](3) NOT NULL,
	[mocodcnv] [char](3) NOT NULL,
	[momonmo] [numeric](19, 4) NOT NULL,
	[moticam] [numeric](19, 4) NOT NULL,
	[motctra] [numeric](19, 4) NOT NULL,
	[motcfin] [numeric](19, 4) NOT NULL,
	[moparme] [numeric](19, 8) NOT NULL,
	[moparcie] [numeric](19, 8) NOT NULL,
	[mopartr] [numeric](19, 8) NOT NULL,
	[mopar30] [numeric](19, 8) NOT NULL,
	[moparfi] [numeric](19, 8) NOT NULL,
	[moprecio] [numeric](19, 4) NOT NULL,
	[mopretra] [numeric](19, 4) NOT NULL,
	[moprefi] [numeric](19, 4) NOT NULL,
	[moussme] [numeric](19, 4) NOT NULL,
	[mouss30] [numeric](19, 4) NOT NULL,
	[mousstr] [numeric](19, 4) NOT NULL,
	[moussfi] [numeric](19, 4) NOT NULL,
	[momonpe] [numeric](19, 4) NOT NULL,
	[moentre] [numeric](3, 0) NOT NULL,
	[morecib] [numeric](3, 0) NOT NULL,
	[movaluta1] [datetime] NOT NULL,
	[movaluta2] [datetime] NOT NULL,
	[movamos] [numeric](1, 0) NOT NULL,
	[motlxp1] [numeric](2, 0) NOT NULL,
	[motlxp2] [numeric](2, 0) NOT NULL,
	[mooper] [char](15) NOT NULL,
	[mofech] [datetime] NOT NULL,
	[mohora] [char](8) NOT NULL,
	[moterm] [char](15) NOT NULL,
	[mocodoma] [numeric](3, 0) NOT NULL,
	[moestatus] [char](1) NOT NULL,
	[moimpreso] [char](1) NOT NULL,
	[mopcierre] [char](1) NOT NULL,
	[morentab] [numeric](3, 0) NOT NULL,
	[mocencos] [char](35) NOT NULL,
	[mounidad] [char](35) NOT NULL,
	[mocodejec] [numeric](6, 0) NOT NULL,
	[mogrpgen] [numeric](3, 0) NOT NULL,
	[mogrppro] [numeric](3, 0) NOT NULL,
	[mocorres] [numeric](8, 0) NOT NULL,
	[moejecuti] [char](7) NOT NULL,
	[mopmeco] [numeric](9, 4) NOT NULL,
	[mopmeve] [numeric](9, 4) NOT NULL,
	[mototco] [numeric](19, 4) NOT NULL,
	[mototve] [numeric](19, 4) NOT NULL,
	[mototcom] [numeric](19, 4) NOT NULL,
	[mototvem] [numeric](19, 4) NOT NULL,
	[moenvia] [char](1) NOT NULL,
	[moalinea] [char](1) NOT NULL,
	[moaprob] [char](1) NOT NULL,
	[monumche] [numeric](6, 0) NOT NULL,
	[mocarta] [char](1) NOT NULL,
	[motipcar] [numeric](3, 0) NOT NULL,
	[monumfut] [numeric](8, 0) NOT NULL,
	[mofecini] [datetime] NOT NULL,
	[swift_corresponsal] [varchar](10) NOT NULL,
	[swift_recibimos] [varchar](10) NOT NULL,
	[swift_entregamos] [varchar](10) NOT NULL,
	[plaza_corresponsal] [numeric](5, 0) NOT NULL,
	[plaza_recibimos] [numeric](5, 0) NOT NULL,
	[plaza_entregamos] [numeric](5, 0) NOT NULL,
	[precio_cliente] [numeric](10, 4) NOT NULL,
	[forma_pago_cli_nac] [numeric](3, 0) NOT NULL,
	[forma_pago_cli_ext] [numeric](3, 0) NOT NULL,
	[valuta_cli_nac] [datetime] NOT NULL,
	[valuta_cli_ext] [datetime] NOT NULL,
	[apoderado_izquierda] [numeric](9, 0) NOT NULL,
	[apoderado_derecha] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[contabiliza] [char](1) NOT NULL,
	[sintetico] [char](1) NOT NULL,
	[mercado] [char](1) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[casa_matriz] [numeric](5, 0) NOT NULL,
	[marca] [varchar](30) NOT NULL,
	[numerointerfaz] [varchar](16) NOT NULL,
	[observacion] [varchar](250) NOT NULL,
	[anula_usuario] [varchar](15) NOT NULL,
	[anula_fecha] [datetime] NOT NULL,
	[anula_hora] [char](8) NOT NULL,
	[anula_motivo] [char](60) NOT NULL,
	[codigo_area] [varchar](5) NOT NULL,
	[codigo_comercio] [char](6) NOT NULL,
	[codigo_concepto] [char](3) NOT NULL,
	[moutilpe] [numeric](19, 0) NOT NULL,
	[mocostofo] [numeric](10, 4) NOT NULL,
	[autorizador_limite] [char](15) NOT NULL,
	[morutgir] [numeric](9, 0) NOT NULL,
	[mofecvcto] [datetime] NOT NULL,
	[modias] [numeric](4, 0) NOT NULL,
	[mocodigogirador] [numeric](9, 0) NOT NULL,
	[moobservlin] [char](255) NOT NULL,
	[moobservlim] [char](255) NOT NULL,
	[swimpresion] [numeric](1, 0) NOT NULL,
	[dcrp_confirmador] [char](1) NOT NULL,
	[dcrp_codigo] [numeric](9, 0) NOT NULL,
	[dcrp_glosa] [varchar](100) NOT NULL,
	[dcrp_horaconfirm] [char](8) NOT NULL,
	[dcrp_operconfirm] [char](15) NOT NULL,
	[dcrp_opecnvconfirm] [char](30) NOT NULL,
 CONSTRAINT [PRIMARY_KEY_MEMO_PUENTE] PRIMARY KEY CLUSTERED 
(
	[monumope] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moent__6ECC298B]  DEFAULT (0.0) FOR [moentidad]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motip__6FC04DC4]  DEFAULT ('') FOR [motipmer]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__monum__70B471FD]  DEFAULT (0.0) FOR [monumope]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motip__71A89636]  DEFAULT (0.0) FOR [motipope]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__morut__729CBA6F]  DEFAULT (0.0) FOR [morutcli]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocod__7390DEA8]  DEFAULT (0.0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__monom__748502E1]  DEFAULT ('') FOR [monomcli]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocod__7579271A]  DEFAULT ('') FOR [mocodmon]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocod__766D4B53]  DEFAULT ('') FOR [mocodcnv]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__momon__77616F8C]  DEFAULT (0.0) FOR [momonmo]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motic__785593C5]  DEFAULT (0.0) FOR [moticam]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motct__7949B7FE]  DEFAULT (0.0) FOR [motctra]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motcf__7A3DDC37]  DEFAULT (0.0) FOR [motcfin]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopar__7B320070]  DEFAULT (0.0) FOR [moparme]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopar__7C2624A9]  DEFAULT (0.0) FOR [moparcie]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopar__7D1A48E2]  DEFAULT (0.0) FOR [mopartr]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopar__7E0E6D1B]  DEFAULT (0.0) FOR [mopar30]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopar__7F029154]  DEFAULT (0.0) FOR [moparfi]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopre__7FF6B58D]  DEFAULT (0.0) FOR [moprecio]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopre__00EAD9C6]  DEFAULT (0.0) FOR [mopretra]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopre__01DEFDFF]  DEFAULT (0.0) FOR [moprefi]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mouss__02D32238]  DEFAULT (0.0) FOR [moussme]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mouss__03C74671]  DEFAULT (0.0) FOR [mouss30]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mouss__04BB6AAA]  DEFAULT (0.0) FOR [mousstr]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mouss__05AF8EE3]  DEFAULT (0.0) FOR [moussfi]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__momon__06A3B31C]  DEFAULT (0.0) FOR [momonpe]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moent__0797D755]  DEFAULT (0.0) FOR [moentre]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__morec__088BFB8E]  DEFAULT (0.0) FOR [morecib]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moval__09801FC7]  DEFAULT ('') FOR [movaluta1]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moval__0A744400]  DEFAULT ('') FOR [movaluta2]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__movam__0B686839]  DEFAULT (0.0) FOR [movamos]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motlx__0C5C8C72]  DEFAULT (0.0) FOR [motlxp1]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motlx__0D50B0AB]  DEFAULT (0.0) FOR [motlxp2]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moope__0E44D4E4]  DEFAULT ('') FOR [mooper]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mofec__0F38F91D]  DEFAULT ('') FOR [mofech]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mohor__102D1D56]  DEFAULT ('') FOR [mohora]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moter__1121418F]  DEFAULT ('') FOR [moterm]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocod__121565C8]  DEFAULT (0.0) FOR [mocodoma]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moest__13098A01]  DEFAULT ('') FOR [moestatus]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moimp__13FDAE3A]  DEFAULT ('') FOR [moimpreso]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopci__14F1D273]  DEFAULT ('') FOR [mopcierre]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moren__15E5F6AC]  DEFAULT (0.0) FOR [morentab]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocen__16DA1AE5]  DEFAULT ('') FOR [mocencos]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mouni__17CE3F1E]  DEFAULT ('') FOR [mounidad]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocod__18C26357]  DEFAULT (0.0) FOR [mocodejec]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mogrp__19B68790]  DEFAULT (0.0) FOR [mogrpgen]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mogrp__1AAAABC9]  DEFAULT (0.0) FOR [mogrppro]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocor__1B9ED002]  DEFAULT (0.0) FOR [mocorres]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moeje__1C92F43B]  DEFAULT ('') FOR [moejecuti]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopme__1D871874]  DEFAULT (0.0) FOR [mopmeco]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mopme__1E7B3CAD]  DEFAULT (0.0) FOR [mopmeve]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motot__1F6F60E6]  DEFAULT (0.0) FOR [mototco]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motot__2063851F]  DEFAULT (0.0) FOR [mototve]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motot__2157A958]  DEFAULT (0.0) FOR [mototcom]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motot__224BCD91]  DEFAULT (0.0) FOR [mototvem]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moenv__233FF1CA]  DEFAULT ('') FOR [moenvia]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moali__24341603]  DEFAULT ('') FOR [moalinea]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moapr__25283A3C]  DEFAULT ('') FOR [moaprob]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__monum__261C5E75]  DEFAULT (0.0) FOR [monumche]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocar__271082AE]  DEFAULT ('') FOR [mocarta]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__motip__2804A6E7]  DEFAULT (0.0) FOR [motipcar]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__monum__28F8CB20]  DEFAULT (0.0) FOR [monumfut]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mofec__29ECEF59]  DEFAULT ('') FOR [mofecini]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__swift__2AE11392]  DEFAULT ('') FOR [swift_corresponsal]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__swift__2BD537CB]  DEFAULT ('') FOR [swift_recibimos]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__swift__2CC95C04]  DEFAULT ('') FOR [swift_entregamos]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__plaza__2DBD803D]  DEFAULT (0.0) FOR [plaza_corresponsal]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__plaza__2EB1A476]  DEFAULT (0.0) FOR [plaza_recibimos]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__plaza__2FA5C8AF]  DEFAULT (0.0) FOR [plaza_entregamos]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__preci__3099ECE8]  DEFAULT (0.0) FOR [precio_cliente]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__forma__318E1121]  DEFAULT (0.0) FOR [forma_pago_cli_nac]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__forma__3282355A]  DEFAULT (0.0) FOR [forma_pago_cli_ext]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__valut__33765993]  DEFAULT ('') FOR [valuta_cli_nac]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__valut__346A7DCC]  DEFAULT ('') FOR [valuta_cli_ext]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__apode__355EA205]  DEFAULT (0.0) FOR [apoderado_izquierda]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__apode__3652C63E]  DEFAULT (0.0) FOR [apoderado_derecha]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__id_si__3746EA77]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__conta__383B0EB0]  DEFAULT ('') FOR [contabiliza]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__sinte__392F32E9]  DEFAULT ('') FOR [sintetico]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__merca__3A235722]  DEFAULT ('') FOR [mercado]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__codig__3B177B5B]  DEFAULT (0.0) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__casa___3C0B9F94]  DEFAULT (0.0) FOR [casa_matriz]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__marca__3CFFC3CD]  DEFAULT ('') FOR [marca]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__numer__3DF3E806]  DEFAULT ('') FOR [numerointerfaz]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__obser__3EE80C3F]  DEFAULT ('') FOR [observacion]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__anula__3FDC3078]  DEFAULT ('') FOR [anula_usuario]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__anula__40D054B1]  DEFAULT ('') FOR [anula_fecha]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__anula__41C478EA]  DEFAULT ('') FOR [anula_hora]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__anula__42B89D23]  DEFAULT ('') FOR [anula_motivo]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__codig__43ACC15C]  DEFAULT ('') FOR [codigo_area]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__codig__44A0E595]  DEFAULT ('') FOR [codigo_comercio]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__codig__459509CE]  DEFAULT ('') FOR [codigo_concepto]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mouti__46892E07]  DEFAULT (0.0) FOR [moutilpe]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocos__477D5240]  DEFAULT (0.0) FOR [mocostofo]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__autor__48717679]  DEFAULT ('') FOR [autorizador_limite]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__morut__49659AB2]  DEFAULT (0.0) FOR [morutgir]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mofec__4A59BEEB]  DEFAULT ('') FOR [mofecvcto]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__modia__4B4DE324]  DEFAULT (0.0) FOR [modias]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__mocod__4C42075D]  DEFAULT (0.0) FOR [mocodigogirador]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moobs__4D362B96]  DEFAULT ('') FOR [moobservlin]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__moobs__4E2A4FCF]  DEFAULT ('') FOR [moobservlim]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__swimp__4F1E7408]  DEFAULT (0.0) FOR [swimpresion]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__dcrp___50129841]  DEFAULT ('') FOR [dcrp_confirmador]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__dcrp___5106BC7A]  DEFAULT (0.0) FOR [dcrp_codigo]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__dcrp___51FAE0B3]  DEFAULT ('') FOR [dcrp_glosa]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__dcrp___52EF04EC]  DEFAULT ('') FOR [dcrp_horaconfirm]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__dcrp___53E32925]  DEFAULT ('') FOR [dcrp_operconfirm]
GO
ALTER TABLE [dbo].[MEMO_PUENTE] ADD  CONSTRAINT [DF__MEMO_PUEN__dcrp___54D74D5E]  DEFAULT ('') FOR [dcrp_opecnvconfirm]
GO
