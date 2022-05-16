USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[pasocliente]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pasocliente](
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
	[Clctausd] [char](12) NULL,
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
	[Clclsbif] [char](2) NULL,
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
	[mxcontab] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
