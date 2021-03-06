USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[InterfazContableGL53]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterfazContableGL53](
	[FechaProceso] [datetime] NULL,
	[TIPOREG] [varchar](1) NOT NULL,
	[CODOFIC] [varchar](5) NOT NULL,
	[AREA] [varchar](1) NOT NULL,
	[SECCION] [varchar](5) NOT NULL,
	[DIA] [varchar](13) NULL,
	[mes] [varchar](13) NULL,
	[año] [varchar](2) NULL,
	[num_voucher] [numeric](10, 0) NOT NULL,
	[CUENTADEBE] [varchar](20) NULL,
	[codmoneda] [varchar](6) NOT NULL,
	[DDBE] [varchar](1) NOT NULL,
	[MTODEBE] [float] NULL,
	[CLASEDBE] [varchar](4) NOT NULL,
	[NOMINATIVODBE] [varchar](8) NULL,
	[REFERENCIADBE] [numeric](10, 0) NULL,
	[CODHABER] [varchar](20) NULL,
	[CODMDHABER] [varchar](6) NOT NULL,
	[HDBE] [varchar](1) NOT NULL,
	[MTOHABER] [float] NULL,
	[CLASEHBE] [varchar](4) NOT NULL,
	[NOMINATIVOHBE] [varchar](8) NOT NULL,
	[REFERENCIAHBE] [numeric](10, 0) NULL,
	[EMISORA] [varchar](5) NULL,
	[RECPTORA] [varchar](5) NULL,
	[CERO] [varchar](126) NULL,
	[TCCAMBIO] [numeric](38, 11) NULL
) ON [PRIMARY]
GO
