USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CLIENTE_aux]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_aux](
	[Clrut] [decimal](9, 0) NOT NULL,
	[Cldv] [char](1) NOT NULL,
	[Clcodigo] [decimal](9, 0) NOT NULL,
	[Clnombre] [char](70) NULL,
	[Clgeneric] [char](5) NULL,
	[Cldirecc] [char](40) NULL,
	[Clcomuna] [decimal](8, 0) NULL,
	[Clregion] [decimal](5, 0) NULL,
	[Cltipcli] [decimal](5, 0) NULL,
	[Clfecingr] [datetime] NULL,
	[Clctacte] [char](15) NULL,
	[Clfono] [char](20) NULL,
	[Clfax] [char](20) NULL,
	[Clapelpa] [char](20) NULL,
	[Clapelma] [char](20) NULL,
	[Clnomb1] [char](15) NULL,
	[Clnomb2] [char](15) NULL,
	[Clciudad] [decimal](8, 0) NULL,
	[Clmercado] [decimal](5, 0) NULL,
	[Clpais] [decimal](5, 0) NULL,
	[Clcalidadjuridica] [decimal](5, 0) NULL,
	[Clchips] [char](6) NULL,
	[Claba] [char](9) NULL,
	[Clswift] [char](11) NULL,
	[Clctausd] [char](12) NULL,
	[Climplic] [char](1) NULL,
	[Clopcion] [char](1) NULL,
	[Clrelacion] [decimal](5, 0) NULL,
	[Clcatego] [decimal](2, 0) NULL,
	[Clsector] [decimal](5, 0) NULL,
	[Clestado] [char](1) NULL,
	[Clclsbif] [char](2) NULL,
	[Clactivida] [decimal](5, 0) NULL,
	[Cltipemp] [char](2) NULL,
	[Relbco] [decimal](2, 0) NULL,
	[Poder] [char](1) NULL,
	[Firma] [char](1) NULL,
	[Infosoc] [char](1) NULL,
	[Art85] [char](1) NULL,
	[Dec85] [char](1) NULL,
	[Clcodban] [decimal](8, 0) NULL,
	[Cod_Inst] [decimal](3, 0) NULL,
	[Rut_Grupo] [decimal](10, 0) NULL,
	[Clcodfox] [decimal](10, 0) NULL,
	[Clvalidalinea] [char](1) NULL,
	[Oficinas] [char](1) NULL,
	[Clclaries] [char](10) NULL,
	[Codigo_Otc] [char](10) NULL,
	[Bloqueado] [char](1) NULL,
	[NumPro_PU] [decimal](20, 0) NOT NULL,
	[codnif] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
