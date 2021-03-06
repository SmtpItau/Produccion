USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[InterfazContableGL58]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterfazContableGL58](
	[FechaProceso] [datetime] NOT NULL,
	[NI05TR] [varchar](1) NOT NULL,
	[NI05OF] [varchar](5) NOT NULL,
	[NI05AR] [varchar](1) NOT NULL,
	[NI05SEC] [varchar](5) NOT NULL,
	[NI05DIA] [char](2) NULL,
	[NI05MES] [char](2) NULL,
	[NI05AÑO] [char](2) NULL,
	[NI05NDO] [char](6) NULL,
	[NI05DCOP] [char](16) NULL,
	[NI05DDIV] [char](2) NULL,
	[NI05DDBE] [varchar](1) NOT NULL,
	[NI05DMTO] [char](17) NULL,
	[NI05DCLA] [varchar](4) NULL,
	[NI05DNOM] [varchar](8) NULL,
	[NI05DREF] [char](10) NULL,
	[NI05HCOP] [char](16) NULL,
	[NI05HDIV] [char](2) NULL,
	[NI05HDBE] [varchar](1) NOT NULL,
	[NI05HMTO] [char](17) NULL,
	[NI05HCLA] [varchar](4) NULL,
	[NI05HNOM] [varchar](8) NULL,
	[NI05HREF] [char](10) NULL,
	[NI05OEMI] [varchar](5) NULL,
	[NI05OREC] [varchar](5) NULL,
	[NI05OFILL] [varchar](126) NULL,
	[NI05TICP] [varchar](11) NOT NULL,
	[CANTREG] [numeric](9, 0) NULL
) ON [PRIMARY]
GO
