USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TABLA_INTERFAZ_VCTO]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_INTERFAZ_VCTO](
	[TREG] [numeric](1, 0) NULL,
	[RUT] [char](10) NULL,
	[REF] [nvarchar](20) NULL,
	[COPE] [char](20) NULL,
	[CORR] [numeric](2, 0) NULL,
	[NCUA] [numeric](5, 0) NULL,
	[NTOC] [numeric](19, 0) NULL,
	[SEPA] [char](1) NULL,
	[NSEP] [numeric](19, 0) NULL,
	[FVEN] [datetime] NULL,
	[VAMO] [numeric](19, 0) NULL,
	[INTE] [numeric](19, 0) NULL,
	[COMI] [numeric](1, 0) NULL,
	[VCUO] [numeric](19, 4) NULL,
	[SVCA] [numeric](19, 0) NULL,
	[TASA] [numeric](19, 4) NULL,
	[CRELL] [char](15) NULL,
	[DESCR] [numeric](1, 0) NULL
) ON [PRIMARY]
GO
