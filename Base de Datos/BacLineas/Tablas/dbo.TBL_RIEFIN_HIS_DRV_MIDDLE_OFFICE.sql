USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_HIS_DRV_MIDDLE_OFFICE]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_HIS_DRV_MIDDLE_OFFICE](
	[MddMod] [varchar](3) NOT NULL,
	[MddNumOpe] [numeric](10, 0) NOT NULL,
	[MddSujEarlyTerminationSN] [char](1) NULL,
	[MddSujEarlyTerminationFecha] [datetime] NULL,
	[MddSujEarlyTerminationPeriodo] [numeric](5, 0) NULL,
	[MddTipPer] [numeric](3, 0) NULL,
	[MddModRel] [varchar](3) NULL,
	[MddOpeRel] [numeric](10, 0) NULL,
	[MddFecVcto] [datetime] NULL
) ON [PRIMARY]
GO
