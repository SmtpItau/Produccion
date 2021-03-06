USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[cl]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cl](
	[CLRUT] [float] NULL,
	[CLDV] [nvarchar](1) NULL,
	[CLCODCLIE] [float] NULL,
	[CLCODDV] [nvarchar](1) NULL,
	[CLNOMBRE] [nvarchar](40) NULL,
	[CLGENERIC] [nvarchar](5) NULL,
	[CLDIRECC] [nvarchar](40) NULL,
	[CLCOMUNA] [float] NULL,
	[CLREGION] [float] NULL,
	[CLTELEFON] [nvarchar](15) NULL,
	[CLFAX] [nvarchar](15) NULL,
	[CLTELEX] [nvarchar](15) NULL,
	[CLCONTACT] [nvarchar](40) NULL,
	[CLCALJURI] [float] NULL,
	[CLCOMPINT] [float] NULL,
	[CLFECINGR] [smalldatetime] NULL,
	[CLFECULAC] [smalldatetime] NULL,
	[CLESTADO] [float] NULL,
	[CLENDMAXI] [float] NULL,
	[CLCOBMAXI] [float] NULL,
	[CLREPLE] [nvarchar](40) NULL,
	[CLESTCIVL] [nvarchar](1) NULL,
	[CLFICHCLI] [nvarchar](1) NULL,
	[CLPROFESN] [nvarchar](17) NULL,
	[CLAPPATRN] [nvarchar](15) NULL,
	[CLAPMATRN] [nvarchar](15) NULL,
	[CLNOMBRES] [nvarchar](20) NULL,
	[CLTIPO] [float] NULL,
	[CLDEUDA] [float] NULL,
	[CLLAPROB] [float] NULL,
	[CLNUMCOR] [float] NULL,
	[CLCUENTA] [float] NULL,
	[CLCTACTE] [float] NULL,
	[CLCODCAP] [float] NULL,
	[CLBANCA] [nvarchar](3) NULL,
	[CLRELAC] [nvarchar](2) NULL,
	[CLFECHA] [smalldatetime] NULL,
	[CLSECTOR] [float] NULL,
	[CLOPERADR] [nvarchar](10) NULL,
	[CLHORA] [nvarchar](8) NULL,
	[CLTERMINL] [nvarchar](12) NULL,
	[CLCODLOC] [float] NULL,
	[CLCODSUC] [float] NULL,
	[CLCREDITO] [float] NULL,
	[CLOCUCRED] [float] NULL,
	[CLCLASI] [float] NULL,
	[CLRUTRELAC] [float] NULL,
	[CLCENCOS] [float] NULL,
	[CLTIPVENC] [float] NULL,
	[CLFECVENC] [smalldatetime] NULL
) ON [PRIMARY]
GO
