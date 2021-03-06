USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLRE]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLRE](
	[lreemisor] [numeric](9, 0) NOT NULL,
	[lrepatrim] [float] NOT NULL,
	[lrefacsol] [float] NOT NULL,
	[lreporpatr] [float] NOT NULL,
	[lrelbpatr] [float] NOT NULL,
	[lreporcart] [float] NOT NULL,
	[lrelinpatr] [float] NOT NULL,
	[lrelincart] [float] NOT NULL,
	[lrelinbase] [float] NOT NULL,
	[lrelinocup] [float] NOT NULL,
	[lresaldo] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lreemisor__2A563856]  DEFAULT (0) FOR [lreemisor]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrepatrim__2B4A5C8F]  DEFAULT (0.0) FOR [lrepatrim]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrefacsol__2C3E80C8]  DEFAULT (0.0) FOR [lrefacsol]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lreporpat__2D32A501]  DEFAULT (0.0) FOR [lreporpatr]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrelbpatr__2E26C93A]  DEFAULT (0.0) FOR [lrelbpatr]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lreporcar__2F1AED73]  DEFAULT (0.0) FOR [lreporcart]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrelinpat__300F11AC]  DEFAULT (0.0) FOR [lrelinpatr]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrelincar__310335E5]  DEFAULT (0.0) FOR [lrelincart]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrelinbas__31F75A1E]  DEFAULT (0.0) FOR [lrelinbase]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lrelinocu__32EB7E57]  DEFAULT (0.0) FOR [lrelinocup]
GO
ALTER TABLE [dbo].[MDLRE] ADD  CONSTRAINT [DF__mdlre__lresaldo__33DFA290]  DEFAULT (0.0) FOR [lresaldo]
GO
