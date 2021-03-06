USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_DRV_MIDDLE_OFFICE]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_DRV_MIDDLE_OFFICE](
	[MddMod] [varchar](3) NOT NULL,
	[MddNumOpe] [numeric](10, 0) NOT NULL,
	[MddSujEarlyTerminationSN] [char](1) NULL,
	[MddSujEarlyTerminationFecha] [datetime] NULL,
	[MddSujEarlyTerminationPeriodo] [numeric](5, 0) NULL,
	[MddTipPer] [numeric](3, 0) NULL,
	[MddModRel] [varchar](3) NULL,
	[MddOpeRel] [numeric](10, 0) NULL,
	[MddFecVcto] [datetime] NULL,
 CONSTRAINT [PK_TBL_RIEFIN_DRV_MIDDLE_OFFICE] PRIMARY KEY NONCLUSTERED 
(
	[MddMod] ASC,
	[MddNumOpe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
