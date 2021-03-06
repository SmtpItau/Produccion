USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[TABLA_INTERFAZ]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_INTERFAZ](
	[CREG] [numeric](1, 0) NULL,
	[CRUT] [char](10) NULL,
	[CREF] [char](23) NULL,
	[NCOPE] [char](20) NULL,
	[NCSUP] [numeric](10, 0) NULL,
	[NCTAS] [char](3) NULL,
	[NSCTA] [char](2) NULL,
	[NCALI] [char](1) NULL,
	[NTIPC] [char](4) NULL,
	[NCPRO] [numeric](3, 0) NULL,
	[CTCAR] [char](3) NULL,
	[NTCRE] [char](2) NULL,
	[DFOTO] [datetime] NULL,
	[NVORI] [numeric](19, 4) NULL,
	[NCUPO] [numeric](15, 0) NULL,
	[NVATC] [numeric](19, 4) NULL,
	[CCMON] [char](2) NULL,
	[CCMOR] [char](3) NULL,
	[NMONE] [numeric](3, 0) NULL,
	[NBASE] [char](3) NULL,
	[NTASA1] [numeric](19, 4) NULL,
	[CTTAS] [char](3) NULL,
	[NTCOM] [numeric](19, 4) NULL,
	[NTCOF] [char](6) NULL,
	[DFEXT] [datetime] NULL,
	[DFVEN] [datetime] NULL,
	[NCAPOI] [numeric](15, 0) NULL,
	[NPCRB] [char](3) NULL,
	[NPZOP] [numeric](6, 0) NULL,
	[NNCUA] [char](3) NULL,
	[NMCUA] [char](16) NULL,
	[NMATR] [char](2) NULL,
	[NISIS] [char](3) NULL,
	[NOFIO] [char](5) NULL,
	[NOFCO] [char](5) NULL,
	[NCEJE] [char](3) NULL,
	[NCCOS] [char](5) NULL,
	[DFTAS] [datetime] NULL,
	[NNTO1] [numeric](3, 0) NULL,
	[NNCUP] [numeric](5, 0) NULL,
	[NCOPI] [char](20) NULL,
	[NINTEL] [numeric](19, 4) NULL,
	[NCOPR] [char](20) NULL,
	[NREAJ] [numeric](19, 4) NULL,
	[CCJUD] [char](1) NULL,
	[CINFO] [char](1) NULL,
	[CRELL] [numeric](5, 0) NULL,
	[DESCR] [numeric](1, 0) NULL,
	[NumeroOperacion] [numeric](19, 0) NOT NULL,
	[DigVerifCliente] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TABLA_INTERFAZ] ADD  CONSTRAINT [DF__TABLA_INT__Numer__353EA674]  DEFAULT (0) FOR [NumeroOperacion]
GO
ALTER TABLE [dbo].[TABLA_INTERFAZ] ADD  CONSTRAINT [DF_TABLA_INTERFAZ_DigVerifCli]  DEFAULT (' ') FOR [DigVerifCliente]
GO
