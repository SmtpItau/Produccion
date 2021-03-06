USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[MF_TASAS_MTM]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF_TASAS_MTM](
	[Moneda] [numeric](4, 0) NULL,
	[Plazo_Ini] [numeric](18, 0) NULL,
	[Plazo_Fin] [numeric](18, 0) NULL,
	[Tasa] [float] NULL,
	[Spread] [float] NULL,
	[fSpotCom] [float] NULL,
	[fSpotVen] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MF_TASAS_MTM] ADD  DEFAULT (1) FOR [fSpotCom]
GO
ALTER TABLE [dbo].[MF_TASAS_MTM] ADD  DEFAULT (1) FOR [fSpotVen]
GO
