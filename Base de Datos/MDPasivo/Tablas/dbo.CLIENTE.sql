USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 16-05-2022 11:41:39 ******/
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
	[Clctacte] [char](15) NULL,
	[Clfono] [char](20) NULL,
	[Clfax] [char](20) NULL,
	[Clapelpa] [char](20) NULL,
	[Clapelma] [char](20) NULL,
	[Clnomb1] [char](15) NULL,
	[Clnomb2] [char](15) NULL,
	[Clciudad] [numeric](8, 0) NULL,
	[Clmercado] [numeric](5, 0) NULL,
	[Clpais] [numeric](5, 0) NULL,
	[Clcalidadjuridica] [numeric](5, 0) NULL,
	[Clchips] [char](20) NULL,
	[Claba] [char](20) NULL,
	[Clswift] [char](11) NULL,
	[Clctausd] [char](12) NULL,
	[Climplic] [char](1) NULL,
	[Clopcion] [char](1) NULL,
	[Clrelacion] [numeric](5, 0) NULL,
	[Clcatego] [numeric](2, 0) NULL,
	[Clsector] [numeric](5, 0) NULL,
	[Clestado] [char](1) NULL,
	[Clclsbif] [char](2) NULL,
	[Clactivida] [numeric](5, 0) NULL,
	[Cltipemp] [char](2) NULL,
	[Relbco] [numeric](2, 0) NULL,
	[Poder] [char](1) NULL,
	[Firma] [char](1) NULL,
	[Infosoc] [char](1) NULL,
	[Art85] [char](1) NULL,
	[Dec85] [char](1) NULL,
	[Clcodban] [numeric](8, 0) NULL,
	[Cod_Inst] [numeric](3, 0) NULL,
	[Rut_Grupo] [numeric](10, 0) NULL,
	[Clcodfox] [numeric](10, 0) NULL,
	[Clvalidalinea] [char](1) NULL,
	[Oficinas] [char](1) NULL,
	[Clclaries] [char](10) NULL,
	[Codigo_Otc] [char](10) NULL,
	[Bloqueado] [char](1) NULL,
	[NumPro_PU] [numeric](20, 0) NOT NULL,
	[Nif_España] [char](10) NOT NULL,
	[NumeroMargenPU] [char](20) NOT NULL,
	[NumeroItemPU] [char](2) NOT NULL,
	[CodNif] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clrut]  DEFAULT ((0)) FOR [Clrut]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Cldv]  DEFAULT ('') FOR [Cldv]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clcodigo]  DEFAULT ((0)) FOR [Clcodigo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clnombre]  DEFAULT ('') FOR [Clnombre]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clgeneric]  DEFAULT ('') FOR [Clgeneric]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Cldirecc]  DEFAULT ('') FOR [Cldirecc]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clcomuna]  DEFAULT ((0)) FOR [Clcomuna]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clregion]  DEFAULT ((0)) FOR [Clregion]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Cltipcli]  DEFAULT ((0)) FOR [Cltipcli]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clfecingr]  DEFAULT ('') FOR [Clfecingr]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clctacte]  DEFAULT ('') FOR [Clctacte]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clfono]  DEFAULT ('') FOR [Clfono]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clfax]  DEFAULT ('') FOR [Clfax]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clapelpa]  DEFAULT ('') FOR [Clapelpa]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clapelma]  DEFAULT ('') FOR [Clapelma]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clnomb1]  DEFAULT ('') FOR [Clnomb1]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clnomb2]  DEFAULT ('') FOR [Clnomb2]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clciudad]  DEFAULT ((0)) FOR [Clciudad]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clmercado]  DEFAULT ((0)) FOR [Clmercado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clpais]  DEFAULT ((0)) FOR [Clpais]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clcalidadjuridica]  DEFAULT ((0)) FOR [Clcalidadjuridica]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clchips]  DEFAULT ('') FOR [Clchips]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Claba]  DEFAULT ('') FOR [Claba]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clswift]  DEFAULT ('') FOR [Clswift]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clctausd]  DEFAULT ('') FOR [Clctausd]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Climplic]  DEFAULT ('') FOR [Climplic]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clopcion]  DEFAULT ('') FOR [Clopcion]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clrelacion]  DEFAULT ((0)) FOR [Clrelacion]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clcatego]  DEFAULT ((0)) FOR [Clcatego]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clsector]  DEFAULT ((0)) FOR [Clsector]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clestado]  DEFAULT ('') FOR [Clestado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clclsbif]  DEFAULT ('') FOR [Clclsbif]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clactivida]  DEFAULT ((0)) FOR [Clactivida]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Cltipemp]  DEFAULT ('') FOR [Cltipemp]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Relbco]  DEFAULT ((0)) FOR [Relbco]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Poder]  DEFAULT ('') FOR [Poder]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Firma]  DEFAULT ('') FOR [Firma]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Infosoc]  DEFAULT ('') FOR [Infosoc]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Art85]  DEFAULT ('') FOR [Art85]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Dec85]  DEFAULT ('') FOR [Dec85]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clcodban]  DEFAULT ((0)) FOR [Clcodban]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Cod_Inst]  DEFAULT ((0)) FOR [Cod_Inst]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Rut_Grupo]  DEFAULT ((0)) FOR [Rut_Grupo]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clcodfox]  DEFAULT ((0)) FOR [Clcodfox]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clvalidalinea]  DEFAULT ('') FOR [Clvalidalinea]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Oficinas]  DEFAULT ('') FOR [Oficinas]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Clclaries]  DEFAULT ('') FOR [Clclaries]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Codigo_Otc]  DEFAULT ('') FOR [Codigo_Otc]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Bloqueado]  DEFAULT ('') FOR [Bloqueado]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_NumPro_PU]  DEFAULT ((0)) FOR [NumPro_PU]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_Nif_España]  DEFAULT ('') FOR [Nif_España]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_NumeroMargenPU]  DEFAULT ('') FOR [NumeroMargenPU]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_NumeroItemPU]  DEFAULT ('') FOR [NumeroItemPU]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_CodNif]  DEFAULT ('') FOR [CodNif]
GO
