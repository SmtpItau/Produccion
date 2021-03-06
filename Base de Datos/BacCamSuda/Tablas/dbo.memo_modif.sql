USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[memo_modif]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memo_modif](
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
	[MOVALUTA1] [datetime] NULL,
	[MOVALUTA2] [datetime] NULL,
	[MOVAMOS] [numeric](1, 0) NOT NULL,
	[MOTLXP1] [numeric](2, 0) NOT NULL,
	[MOTLXP2] [numeric](2, 0) NOT NULL,
	[MOOPER] [char](15) NOT NULL,
	[MOFECH] [datetime] NULL,
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
	[MOCORRES] [numeric](7, 0) NOT NULL,
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
	[MOFECINI] [datetime] NULL,
	[Swift_Corresponsal] [varchar](10) NOT NULL,
	[Swift_Recibimos] [varchar](10) NOT NULL,
	[Swift_Entregamos] [varchar](10) NOT NULL,
	[Plaza_Corresponsal] [numeric](5, 0) NOT NULL,
	[Plaza_Recibimos] [numeric](5, 0) NOT NULL,
	[Plaza_Entregamos] [numeric](5, 0) NOT NULL,
	[Precio_Cliente] [numeric](10, 4) NOT NULL,
	[Forma_Pago_Cli_Nac] [numeric](3, 0) NOT NULL,
	[Forma_Pago_Cli_Ext] [numeric](3, 0) NOT NULL,
	[Valuta_Cli_Nac] [datetime] NULL,
	[Valuta_Cli_Ext] [datetime] NULL,
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
	[anula_fecha] [datetime] NULL,
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
	[moResultado_Comercial_Clp] [numeric](19, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOENTIDAD]  DEFAULT (0) FOR [MOENTIDAD]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTIPMER]  DEFAULT ('') FOR [MOTIPMER]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MONUMOPE]  DEFAULT (0) FOR [MONUMOPE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTIPOPE]  DEFAULT ('') FOR [MOTIPOPE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MORUTCLI]  DEFAULT (0) FOR [MORUTCLI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCODCLI]  DEFAULT (0) FOR [MOCODCLI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MONOMCLI]  DEFAULT ('') FOR [MONOMCLI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCODMON]  DEFAULT ('') FOR [MOCODMON]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCODCNV]  DEFAULT ('') FOR [MOCODCNV]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOMONMO]  DEFAULT (0) FOR [MOMONMO]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTICAM]  DEFAULT (0) FOR [MOTICAM]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTCTRA]  DEFAULT (0) FOR [MOTCTRA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTCFIN]  DEFAULT (0) FOR [MOTCFIN]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPARME]  DEFAULT (0) FOR [MOPARME]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPARCIE]  DEFAULT (0) FOR [MOPARCIE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPARTR]  DEFAULT (0) FOR [MOPARTR]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPAR30]  DEFAULT (0) FOR [MOPAR30]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPARFI]  DEFAULT (0) FOR [MOPARFI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPRECIO]  DEFAULT (0) FOR [MOPRECIO]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPRETRA]  DEFAULT (0) FOR [MOPRETRA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPREFI]  DEFAULT (0) FOR [MOPREFI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOUSSME]  DEFAULT (0) FOR [MOUSSME]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOUSS30]  DEFAULT (0) FOR [MOUSS30]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOUSSTR]  DEFAULT (0) FOR [MOUSSTR]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOUSSFI]  DEFAULT (0) FOR [MOUSSFI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOMONPE]  DEFAULT (0) FOR [MOMONPE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOENTRE]  DEFAULT (0) FOR [MOENTRE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MORECIB]  DEFAULT (0) FOR [MORECIB]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOVAMOS]  DEFAULT (0) FOR [MOVAMOS]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTLXP1]  DEFAULT (0) FOR [MOTLXP1]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTLXP2]  DEFAULT (0) FOR [MOTLXP2]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOOPER]  DEFAULT ('') FOR [MOOPER]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOHORA]  DEFAULT ('') FOR [MOHORA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTERM]  DEFAULT ('') FOR [MOTERM]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCODOMA]  DEFAULT (0) FOR [MOCODOMA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOESTATUS]  DEFAULT ('') FOR [MOESTATUS]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOIMPRESO]  DEFAULT ('') FOR [MOIMPRESO]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPCIERRE]  DEFAULT ('') FOR [MOPCIERRE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MORENTAB]  DEFAULT (0) FOR [MORENTAB]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCENCOS]  DEFAULT ('') FOR [MOCENCOS]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOUNIDAD]  DEFAULT ('') FOR [MOUNIDAD]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCODEJEC]  DEFAULT (0) FOR [MOCODEJEC]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOGRPGEN]  DEFAULT (0) FOR [MOGRPGEN]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOGRPPRO]  DEFAULT (0) FOR [MOGRPPRO]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCORRES]  DEFAULT (0) FOR [MOCORRES]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOEJECUTI]  DEFAULT ('') FOR [MOEJECUTI]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPMECO]  DEFAULT (0) FOR [MOPMECO]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOPMEVE]  DEFAULT (0) FOR [MOPMEVE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTOTCO]  DEFAULT (0) FOR [MOTOTCO]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTOTVE]  DEFAULT (0) FOR [MOTOTVE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTOTCOM]  DEFAULT (0) FOR [MOTOTCOM]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTOTVEM]  DEFAULT (0) FOR [MOTOTVEM]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOENVIA]  DEFAULT ('') FOR [MOENVIA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOALINEA]  DEFAULT ('') FOR [MOALINEA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOAPROB]  DEFAULT ('') FOR [MOAPROB]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MONUMCHE]  DEFAULT (0) FOR [MONUMCHE]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOCARTA]  DEFAULT ('') FOR [MOCARTA]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MOTIPCAR]  DEFAULT (0) FOR [MOTIPCAR]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_MONUMFUT]  DEFAULT (0) FOR [MONUMFUT]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Swift_Corresponsal]  DEFAULT ('') FOR [Swift_Corresponsal]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Swift_Recibimos]  DEFAULT ('') FOR [Swift_Recibimos]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Swift_Entregamos]  DEFAULT ('') FOR [Swift_Entregamos]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Plaza_Corresponsal]  DEFAULT (0) FOR [Plaza_Corresponsal]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Plaza_Recibimos]  DEFAULT (0) FOR [Plaza_Recibimos]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Plaza_Entregamos]  DEFAULT (0) FOR [Plaza_Entregamos]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Precio_Cliente]  DEFAULT (0) FOR [Precio_Cliente]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Forma_Pago_Cli_Nac]  DEFAULT (0) FOR [Forma_Pago_Cli_Nac]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Forma_Pago_Cli_Ext]  DEFAULT (0) FOR [Forma_Pago_Cli_Ext]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Apoderado_Izquierda]  DEFAULT (0) FOR [Apoderado_Izquierda]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Apoderado_Derecha]  DEFAULT (0) FOR [Apoderado_Derecha]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Id_Sistema]  DEFAULT ('') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Contabiliza]  DEFAULT ('') FOR [Contabiliza]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Sintetico]  DEFAULT ('') FOR [Sintetico]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Mercado]  DEFAULT ('') FOR [Mercado]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Codigo_Pais]  DEFAULT (0) FOR [Codigo_Pais]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Casa_Matriz]  DEFAULT (0) FOR [Casa_Matriz]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Marca]  DEFAULT ('') FOR [Marca]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_NumeroInterfaz]  DEFAULT ('') FOR [NumeroInterfaz]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_Observacion]  DEFAULT ('') FOR [Observacion]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_anula_usuario]  DEFAULT ('') FOR [anula_usuario]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_anula_hora]  DEFAULT ('') FOR [anula_hora]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_anula_motivo]  DEFAULT ('') FOR [anula_motivo]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_codigo_area]  DEFAULT ('') FOR [codigo_area]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_codigo_comercio]  DEFAULT ('') FOR [codigo_comercio]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_codigo_concepto]  DEFAULT ('') FOR [codigo_concepto]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_moutilpe]  DEFAULT (0) FOR [moutilpe]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_mocostofo]  DEFAULT (0) FOR [mocostofo]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_morutgir]  DEFAULT (0) FOR [morutgir]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_modias]  DEFAULT (0) FOR [modias]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_mocodigogirador]  DEFAULT (0) FOR [mocodigogirador]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_moobservlin]  DEFAULT (' ') FOR [moobservlin]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_moobservlim]  DEFAULT (' ') FOR [moobservlim]
GO
ALTER TABLE [dbo].[memo_modif] ADD  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [df_memo_modif_DcrpConfirma]  DEFAULT ('N') FOR [Dcrp_Confirmador]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [df_memo_modif_DcrpCodigo]  DEFAULT (0) FOR [Dcrp_Codigo]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [df_memo_modif_DcrpGlosa]  DEFAULT ('-') FOR [Dcrp_Glosa]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [df_memo_modif_DcrpHora]  DEFAULT ('00:00:00') FOR [Dcrp_HoraConfirm]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [df_memo_modif_OperHora]  DEFAULT ('-') FOR [Dcrp_OperConfirm]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [df_memo_modif_OpeCnvHora]  DEFAULT ('-') FOR [Dcrp_OpeCnvConfirm]
GO
ALTER TABLE [dbo].[memo_modif] ADD  DEFAULT (0) FOR [moDifTran_Mo]
GO
ALTER TABLE [dbo].[memo_modif] ADD  DEFAULT (0) FOR [moDifTran_Clp]
GO
ALTER TABLE [dbo].[memo_modif] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[memo_modif] ADD  CONSTRAINT [DF_memo_modif_moResultado_Comercial_Clp]  DEFAULT ((0)) FOR [moResultado_Comercial_Clp]
GO
