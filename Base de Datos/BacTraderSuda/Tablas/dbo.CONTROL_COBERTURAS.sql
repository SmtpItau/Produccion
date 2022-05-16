USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CONTROL_COBERTURAS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROL_COBERTURAS](
	[Cobertura] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CONTROL_COBERTURAS] ADD  CONSTRAINT [df_numcobertura_cobertura]  DEFAULT (0) FOR [Cobertura]
GO
