USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ResFusion_TABLA_DESARROLLO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResFusion_TABLA_DESARROLLO](
	[tdmascara] [char](12) NOT NULL,
	[tdcupon] [numeric](3, 0) NOT NULL,
	[tdfecven] [datetime] NULL,
	[tdinteres] [numeric](19, 10) NULL,
	[tdamort] [numeric](19, 10) NULL,
	[tdflujo] [numeric](19, 10) NULL,
	[tdsaldo] [numeric](19, 10) NULL
) ON [PRIMARY]
GO
