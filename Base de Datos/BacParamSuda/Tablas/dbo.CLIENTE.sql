USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[Clrut] [numeric](9, 0) NOT NULL,
	[Cldv] [char](1) NOT NULL,
	[Clcodigo] [numeric](9, 0) NOT NULL,
	[Clnombre] [char](70) NULL,
	[Clgeneric] [char](5) NULL,
	[Cldirecc] [char](40) NULL,
	[Clcomuna] [numeric](8, 0) NULL,
	[Clregion] [numeric](5, 0) NULL,
	[Cltipcli] [numeric](5, 0) NULL,
	[Clfecingr] [datetime] NULL,
	[Clctacte] [varchar](20) NOT NULL,
	[Clfono] [char](20) NULL,
	[Clfax] [char](20) NULL,
	[Clapelpa] [char](20) NULL,
	[Clapelma] [char](20) NULL,
	[Clnomb1] [char](15) NULL,
	[Clnomb2] [char](15) NULL,
	[Clapoderado] [char](40) NULL,
	[Clciudad] [numeric](8, 0) NULL,
	[Clmercado] [numeric](5, 0) NULL,
	[Clgrupo] [numeric](5, 0) NULL,
	[Clpais] [numeric](5, 0) NULL,
	[Clcalidadjuridica] [numeric](5, 0) NULL,
	[Cltipoml] [numeric](5, 0) NULL,
	[Cltipomx] [numeric](5, 0) NULL,
	[Clbanca] [numeric](5, 0) NULL,
	[Clrelac] [char](2) NULL,
	[Clnumero] [numeric](3, 0) NULL,
	[Clcomex] [char](1) NULL,
	[Clchips] [char](6) NULL,
	[Claba] [char](9) NULL,
	[Clswift] [char](11) NULL,
	[Clnfm] [numeric](3, 0) NULL,
	[Clfmutuo] [char](1) NULL,
	[Clfeculti] [datetime] NULL,
	[Clejecuti] [char](10) NULL,
	[Clentidad] [numeric](5, 0) NULL,
	[Clgraba] [char](2) NULL,
	[Clcompint] [numeric](3, 0) NULL,
	[Clcalle] [char](30) NULL,
	[Clctausd] [varchar](20) NOT NULL,
	[Clcaljur] [char](1) NULL,
	[Clnemo] [char](20) NULL,
	[Climplic] [char](1) NULL,
	[Clopcion] [char](1) NULL,
	[Clcalidad] [numeric](2, 0) NULL,
	[Cltipode] [numeric](2, 0) NULL,
	[Clrelacion] [numeric](2, 0) NULL,
	[Clcatego] [numeric](2, 0) NULL,
	[Clsector] [numeric](3, 0) NULL,
	[Clestado] [char](1) NULL,
	[Clclsbif] [varchar](6) NULL,
	[Clfesbif] [datetime] NULL,
	[Clclbco] [char](2) NULL,
	[Clfecbco] [datetime] NULL,
	[Clactivida] [numeric](3, 0) NULL,
	[Cltelef] [numeric](7, 0) NULL,
	[Usuario] [numeric](2, 0) NULL,
	[Cltipemp] [char](2) NULL,
	[Relbco] [numeric](2, 0) NULL,
	[Fecact] [datetime] NULL,
	[Cltipsis] [char](2) NULL,
	[Poder] [char](1) NULL,
	[Firma] [char](1) NULL,
	[Feca85] [datetime] NULL,
	[Relcia] [numeric](2, 0) NULL,
	[Relcor] [numeric](2, 0) NULL,
	[Infosoc] [char](1) NULL,
	[Art85] [char](1) NULL,
	[Dec85] [char](1) NULL,
	[Clconres] [char](2) NULL,
	[Clcodban] [numeric](8, 0) NULL,
	[Cod_Inst] [numeric](3, 0) NULL,
	[Rut_Grupo] [numeric](10, 0) NULL,
	[Clcodfox] [numeric](10, 0) NULL,
	[Clcrf] [char](10) NULL,
	[Clerf] [char](10) NULL,
	[Clvctolineas] [datetime] NULL,
	[Clvalidalinea] [char](1) NULL,
	[Oficinas] [char](1) NULL,
	[Clclaries] [char](10) NULL,
	[Codigo_Otc] [char](10) NULL,
	[Bloqueado] [char](1) NULL,
	[CLFECCONDGRL] [datetime] NULL,
	[clcosto] [numeric](5, 0) NULL,
	[mxcontab] [numeric](3, 0) NOT NULL,
	[clrutcliexterno] [numeric](18, 0) NULL,
	[cldvcliexterno] [char](1) NULL,
	[clBrokers] [varchar](1) NOT NULL,
	[RutBancoReceptor] [numeric](10, 0) NULL,
	[CodBancoReceptor] [numeric](10, 0) NULL,
	[clCondicionesGenerales] [char](1) NOT NULL,
	[clFechaFirma_cond] [datetime] NOT NULL,
	[fecha_escritura] [datetime] NOT NULL,
	[nombre_notaria] [varchar](50) NOT NULL,
	[ClCompBilateral] [varchar](1) NOT NULL,
	[NUEVO_CCG_FIRMADO] [char](1) NOT NULL,
	[VERSION_CONTRATOS_CCG] [numeric](2, 0) NOT NULL,
	[FECHA_FIRMA_NUEVO_CCG] [datetime] NOT NULL,
	[CLAUSULA_RETROACTIVA_FIRMADA] [char](1) NOT NULL,
	[seg_comercial] [char](6) NOT NULL,
	[ejecutivo_comercial] [varchar](40) NOT NULL,
	[garantiatotal] [numeric](14, 0) NOT NULL,
	[motivo_bloqueo] [varchar](2000) NOT NULL,
	[ClVigente] [char](1) NOT NULL,
	[garantiaefectiva] [numeric](18, 0) NOT NULL,
	[ClRecMtdCod] [numeric](5, 0) NOT NULL,
	[FechaFirmaCG_Pactos] [datetime] NULL,
	[EMAIL] [nvarchar](100) NOT NULL,
	[ComDer] [char](1) NOT NULL,
	[ClFechaFirmaContratoComDer] [datetime] NOT NULL,
	[ClClasificaDecimales] [char](1) NOT NULL,
	[ClCantidadDecimales] [numeric](1, 0) NOT NULL,
	[Secuencia] [numeric](9, 0) NOT NULL,
	[Codigo_AS400] [numeric](10, 0) NOT NULL,
	[Codigo_CGI] [numeric](15, 0) NULL,
	[clcodEmpRelacionada] [numeric](5, 0) NOT NULL,
	[clcod_contra] [numeric](5, 0) NOT NULL,
	[clcod_emp_cen] [numeric](5, 0) NOT NULL,
	[CNPJ] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Clrut] ASC,
	[Clcodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cldv__6292D1DD]  DEFAULT ('') FOR [Cldv]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clnombr__6386F616]  DEFAULT ('') FOR [Clnombre]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clgener__647B1A4F]  DEFAULT ('') FOR [Clgeneric]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cldirec__656F3E88]  DEFAULT ('') FOR [Cldirecc]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcomun__666362C1]  DEFAULT (0) FOR [Clcomuna]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clregio__675786FA]  DEFAULT (0) FOR [Clregion]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltipcl__684BAB33]  DEFAULT (0) FOR [Cltipcli]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfecin__693FCF6C]  DEFAULT ('') FOR [Clfecingr]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clctact__6A33F3A5]  DEFAULT ('') FOR [Clctacte]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfono__6B2817DE]  DEFAULT ('') FOR [Clfono]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfax__6C1C3C17]  DEFAULT ('') FOR [Clfax]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clapelp__6D106050]  DEFAULT ('') FOR [Clapelpa]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clapelm__6E048489]  DEFAULT ('') FOR [Clapelma]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clnomb1__6EF8A8C2]  DEFAULT ('') FOR [Clnomb1]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clnomb2__6FECCCFB]  DEFAULT ('') FOR [Clnomb2]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clapode__70E0F134]  DEFAULT ('') FOR [Clapoderado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clciuda__71D5156D]  DEFAULT (0) FOR [Clciudad]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clmerca__72C939A6]  DEFAULT (0) FOR [Clmercado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clgrupo__73BD5DDF]  DEFAULT (0) FOR [Clgrupo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clpais__74B18218]  DEFAULT (0) FOR [Clpais]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcalid__75A5A651]  DEFAULT (0) FOR [Clcalidadjuridica]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltipom__7699CA8A]  DEFAULT (0) FOR [Cltipoml]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltipom__778DEEC3]  DEFAULT (0) FOR [Cltipomx]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clbanca__788212FC]  DEFAULT (0) FOR [Clbanca]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clrelac__79763735]  DEFAULT ('') FOR [Clrelac]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clnumer__7A6A5B6E]  DEFAULT (0) FOR [Clnumero]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcomex__7B5E7FA7]  DEFAULT ('') FOR [Clcomex]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clchips__7C52A3E0]  DEFAULT ('') FOR [Clchips]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Claba__7D46C819]  DEFAULT ('') FOR [Claba]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clswift__7E3AEC52]  DEFAULT ('') FOR [Clswift]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clnfm__7F2F108B]  DEFAULT (0) FOR [Clnfm]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfmutu__002334C4]  DEFAULT ('') FOR [Clfmutuo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfecul__011758FD]  DEFAULT ('') FOR [Clfeculti]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clejecu__020B7D36]  DEFAULT ('') FOR [Clejecuti]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clentid__02FFA16F]  DEFAULT (0) FOR [Clentidad]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clgraba__03F3C5A8]  DEFAULT ('') FOR [Clgraba]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcompi__04E7E9E1]  DEFAULT (0) FOR [Clcompint]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcalle__05DC0E1A]  DEFAULT ('') FOR [Clcalle]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clctaus__06D03253]  DEFAULT ('') FOR [Clctausd]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcalju__07C4568C]  DEFAULT ('') FOR [Clcaljur]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clnemo__08B87AC5]  DEFAULT ('') FOR [Clnemo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Climpli__09AC9EFE]  DEFAULT ('') FOR [Climplic]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clopcio__0AA0C337]  DEFAULT ('') FOR [Clopcion]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcalid__0B94E770]  DEFAULT (0) FOR [Clcalidad]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltipod__0C890BA9]  DEFAULT (0) FOR [Cltipode]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clrelac__0D7D2FE2]  DEFAULT (0) FOR [Clrelacion]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcateg__0E71541B]  DEFAULT (0) FOR [Clcatego]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clsecto__0F657854]  DEFAULT (0) FOR [Clsector]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clestad__10599C8D]  DEFAULT ('') FOR [Clestado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfesbi__1241E4FF]  DEFAULT ('') FOR [Clfesbif]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clclbco__13360938]  DEFAULT ('') FOR [Clclbco]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clfecbc__142A2D71]  DEFAULT ('') FOR [Clfecbco]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clactiv__151E51AA]  DEFAULT (0) FOR [Clactivida]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltelef__161275E3]  DEFAULT (0) FOR [Cltelef]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Usuario__17069A1C]  DEFAULT (0) FOR [Usuario]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltipem__17FABE55]  DEFAULT ('') FOR [Cltipemp]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Relbco__18EEE28E]  DEFAULT (0) FOR [Relbco]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cltipsi__19E306C7]  DEFAULT ('') FOR [Cltipsis]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Poder__1AD72B00]  DEFAULT ('') FOR [Poder]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Firma__1BCB4F39]  DEFAULT ('') FOR [Firma]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Feca85__1CBF7372]  DEFAULT ('') FOR [Feca85]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Relcia__1DB397AB]  DEFAULT (0) FOR [Relcia]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Relcor__1EA7BBE4]  DEFAULT (0) FOR [Relcor]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Infosoc__1F9BE01D]  DEFAULT ('') FOR [Infosoc]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Art85__20900456]  DEFAULT ('') FOR [Art85]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Dec85__2184288F]  DEFAULT ('') FOR [Dec85]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clconre__22784CC8]  DEFAULT ('') FOR [Clconres]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcodba__236C7101]  DEFAULT (0) FOR [Clcodban]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Cod_Ins__2460953A]  DEFAULT (0) FOR [Cod_Inst]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Rut_Gru__2554B973]  DEFAULT (0) FOR [Rut_Grupo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcodfo__2648DDAC]  DEFAULT (0) FOR [Clcodfox]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clcrf__273D01E5]  DEFAULT ('') FOR [Clcrf]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clerf__2831261E]  DEFAULT ('') FOR [Clerf]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clvalid__29254A57]  DEFAULT ('') FOR [Clvalidalinea]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Oficina__2A196E90]  DEFAULT ('') FOR [Oficinas]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Clclari__2B0D92C9]  DEFAULT ('') FOR [Clclaries]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Codiogo__2C01B702]  DEFAULT ('') FOR [Codigo_Otc]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__Bloquea__2CF5DB3B]  DEFAULT ('N') FOR [Bloqueado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_clcosto]  DEFAULT (0) FOR [clcosto]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__cliente__mxconta__3AC5A2FC]  DEFAULT (0) FOR [mxcontab]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_clrutcliexterno]  DEFAULT (0) FOR [clrutcliexterno]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_cldvcliexterno]  DEFAULT ('') FOR [cldvcliexterno]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('') FOR [clBrokers]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_cliente_RutBcoReceptor]  DEFAULT (0) FOR [RutBancoReceptor]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_cliente_CodBcoReceptor]  DEFAULT (0) FOR [CodBancoReceptor]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('N') FOR [clCondicionesGenerales]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('19000101') FOR [clFechaFirma_cond]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('') FOR [fecha_escritura]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('') FOR [nombre_notaria]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('N') FOR [ClCompBilateral]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('') FOR [NUEVO_CCG_FIRMADO]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT (0) FOR [VERSION_CONTRATOS_CCG]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('') FOR [FECHA_FIRMA_NUEVO_CCG]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ('') FOR [CLAUSULA_RETROACTIVA_FIRMADA]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_cliente_seg_comercial]  DEFAULT ('') FOR [seg_comercial]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_cliente_ejecutivo_comercial]  DEFAULT ('') FOR [ejecutivo_comercial]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_cliente_garantiatotal]  DEFAULT (0) FOR [garantiatotal]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_cliente_motivo_bloqueo]  DEFAULT ('') FOR [motivo_bloqueo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [df_USUARIO_ClVigente]  DEFAULT ('S') FOR [ClVigente]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT (0) FOR [garantiaefectiva]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [CLIENTE_ClRecMtdCod]  DEFAULT ((0)) FOR [ClRecMtdCod]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_EMAIL]  DEFAULT ('') FOR [EMAIL]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_ComDer]  DEFAULT ('N') FOR [ComDer]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_ClFechaFirmaContratoComDer]  DEFAULT ('1900-01-01') FOR [ClFechaFirmaContratoComDer]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_ClClasificaDecimales]  DEFAULT ('N') FOR [ClClasificaDecimales]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_ClCantidadDecimales]  DEFAULT ((0)) FOR [ClCantidadDecimales]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [Secuencia]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [Codigo_AS400]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [Codigo_CGI]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [clcodEmpRelacionada]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((1)) FOR [clcod_contra]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [clcod_emp_cen]
GO
