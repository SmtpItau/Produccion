USE [MDPasivo]
GO
/****** Object:  Table [dbo].[mdmn]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdmn](
	[MNCODMON] [numeric](5, 0) NOT NULL,
	[MNNEMO] [char](8) NOT NULL,
	[MNSIMBOL] [char](5) NOT NULL,
	[MNGLOSA] [char](35) NOT NULL,
	[MNCODSUPER] [numeric](3, 0) NOT NULL,
	[MNNEMSUPER] [char](8) NOT NULL,
	[MNCODBANCO] [numeric](5, 0) NOT NULL,
	[MNNEMBANCO] [char](3) NOT NULL,
	[MNBASE] [numeric](3, 0) NOT NULL,
	[MNREDONDEO] [numeric](2, 0) NOT NULL,
	[MNDECIMAL] [numeric](2, 0) NOT NULL,
	[MNCODPAIS] [numeric](3, 0) NOT NULL,
	[MNRRDA] [char](1) NOT NULL,
	[MNFACTOR] [numeric](9, 0) NOT NULL,
	[MNREFUSD] [char](1) NOT NULL,
	[MNLOCAL] [char](1) NOT NULL,
	[MNEXTRANJ] [char](1) NOT NULL,
	[MNVALOR] [char](1) NOT NULL,
	[MNREFMERC] [char](1) NOT NULL,
	[MNINGVAL] [numeric](3, 0) NOT NULL,
	[MNTIPMON] [char](1) NOT NULL,
	[MNPERIODO] [numeric](2, 0) NOT NULL,
	[MNMX] [char](1) NULL,
	[MNCODFOX] [char](6) NULL,
	[MNVALFOX] [numeric](5, 0) NULL,
	[MNCODCOR] [numeric](7, 0) NULL,
	[codigo_pais] [numeric](5, 0) NULL,
	[MNISO_CODDES] [char](5) NULL,
	[orden_planillon] [numeric](3, 0) NOT NULL,
	[codigo_sar_reajustable] [numeric](2, 0) NOT NULL,
	[codigo_sar_tasa] [numeric](4, 0) NOT NULL,
	[paridad_EURO] [numeric](19, 8) NOT NULL
) ON [PRIMARY]
GO
