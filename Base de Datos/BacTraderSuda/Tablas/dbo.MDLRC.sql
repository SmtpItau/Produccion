USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLRC]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLRC](
	[lrccliente] [numeric](9, 0) NOT NULL,
	[lrcpatrim] [float] NOT NULL,
	[lrcfacsol] [float] NOT NULL,
	[lrcporpatr] [float] NOT NULL,
	[lrclbpatr] [float] NOT NULL,
	[lrcporcart] [float] NOT NULL,
	[lrclincart] [float] NOT NULL,
	[lrclinpatr] [float] NOT NULL,
	[lrclinbase] [float] NOT NULL,
	[lrclinocup] [float] NOT NULL,
	[lrcsaldo] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrcclient__118A8A8C]  DEFAULT (0) FOR [lrccliente]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrcpatrim__127EAEC5]  DEFAULT (0.0) FOR [lrcpatrim]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrcfacsol__1372D2FE]  DEFAULT (0.0) FOR [lrcfacsol]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrcporpat__1466F737]  DEFAULT (0.0) FOR [lrcporpatr]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrclbpatr__155B1B70]  DEFAULT (0.0) FOR [lrclbpatr]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrcporcar__164F3FA9]  DEFAULT (0.0) FOR [lrcporcart]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrclincar__174363E2]  DEFAULT (0.0) FOR [lrclincart]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrclinpat__1837881B]  DEFAULT (0.0) FOR [lrclinpatr]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrclinbas__192BAC54]  DEFAULT (0.0) FOR [lrclinbase]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrclinocu__1A1FD08D]  DEFAULT (0.0) FOR [lrclinocup]
GO
ALTER TABLE [dbo].[MDLRC] ADD  CONSTRAINT [DF__mdlrc__lrcsaldo__1B13F4C6]  DEFAULT (0.0) FOR [lrcsaldo]
GO
