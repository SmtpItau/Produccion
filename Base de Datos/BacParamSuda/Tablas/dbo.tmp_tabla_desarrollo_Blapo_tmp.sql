USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tmp_tabla_desarrollo_Blapo_tmp]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_tabla_desarrollo_Blapo_tmp](
	[tdmascara] [char](12) NOT NULL,
	[tdcupon] [numeric](3, 0) NOT NULL,
	[tdfecven] [datetime] NULL,
	[tdinteres] [numeric](19, 10) NULL,
	[tdamort] [numeric](19, 10) NULL,
	[tdflujo] [numeric](19, 10) NULL,
	[tdsaldo] [numeric](19, 10) NULL
) ON [PRIMARY]
GO
