USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TABLA_DESARROLLO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_DESARROLLO](
	[tdmascara] [char](12) NOT NULL,
	[tdcupon] [numeric](3, 0) NOT NULL,
	[tdfecven] [datetime] NOT NULL,
	[tdinteres] [numeric](19, 10) NOT NULL,
	[tdamort] [numeric](19, 10) NOT NULL,
	[tdflujo] [numeric](19, 10) NOT NULL,
	[tdsaldo] [numeric](19, 10) NOT NULL,
	[spread_tasa_variable] [numeric](8, 4) NOT NULL
) ON [PRIMARY]
GO
