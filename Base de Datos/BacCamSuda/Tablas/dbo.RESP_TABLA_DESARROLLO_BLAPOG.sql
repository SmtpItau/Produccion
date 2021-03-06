USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RESP_TABLA_DESARROLLO_BLAPOG]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESP_TABLA_DESARROLLO_BLAPOG](
	[tdmascara] [char](12) NOT NULL,
	[tdcupon] [numeric](3, 0) NOT NULL,
	[tdfecven] [datetime] NULL,
	[tdinteres] [numeric](19, 10) NULL,
	[tdamort] [numeric](19, 10) NULL,
	[tdflujo] [numeric](19, 10) NULL,
	[tdsaldo] [numeric](19, 10) NULL
) ON [PRIMARY]
GO
