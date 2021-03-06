USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TABLA_DESARROLLO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_DESARROLLO](
	[tdmascara] [char](12) NOT NULL,
	[tdcupon] [numeric](3, 0) NOT NULL,
	[tdfecven] [datetime] NULL,
	[tdinteres] [numeric](19, 10) NULL,
	[tdamort] [numeric](19, 10) NULL,
	[tdflujo] [numeric](19, 10) NULL,
	[tdsaldo] [numeric](19, 10) NULL,
PRIMARY KEY CLUSTERED 
(
	[tdmascara] ASC,
	[tdcupon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TABLA_DESARROLLO] ADD  CONSTRAINT [DF__TABLA_DES__Tdint__310FB98B]  DEFAULT (0) FOR [tdinteres]
GO
ALTER TABLE [dbo].[TABLA_DESARROLLO] ADD  CONSTRAINT [DF__TABLA_DES__Tdamo__3203DDC4]  DEFAULT (0) FOR [tdamort]
GO
ALTER TABLE [dbo].[TABLA_DESARROLLO] ADD  CONSTRAINT [DF__TABLA_DES__Tdflu__32F801FD]  DEFAULT (0) FOR [tdflujo]
GO
ALTER TABLE [dbo].[TABLA_DESARROLLO] ADD  CONSTRAINT [DF__TABLA_DES__Tdsal__33EC2636]  DEFAULT (0) FOR [tdsaldo]
GO
