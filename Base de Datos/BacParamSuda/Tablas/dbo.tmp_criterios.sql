USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tmp_criterios]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_criterios](
	[oId] [numeric](9, 0) IDENTITY(1,1) NOT NULL,
	[oOrigen] [varchar](5) NOT NULL,
	[oProducto] [varchar](10) NOT NULL,
	[oTipOperacion] [varchar](10) NOT NULL,
	[oMoneda] [varchar](10) NOT NULL,
	[oCtaAvrPos] [varchar](20) NOT NULL,
	[oCtaAvrNeg] [varchar](20) NOT NULL,
	[oCtaResPos] [varchar](20) NOT NULL,
	[oCtaResNeg] [varchar](20) NOT NULL,
	[oCtaPatPos] [varchar](20) NOT NULL,
	[oCtaPatNeg] [varchar](20) NOT NULL,
	[oCtaCajPos] [varchar](20) NOT NULL,
	[oCtaCajNeg] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
