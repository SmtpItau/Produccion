USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDPV]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDPV](
	[pvcodigo] [numeric](3, 0) NULL,
	[pvserie] [char](12) NULL,
	[pvporcentaje] [numeric](19, 2) NOT NULL
) ON [PRIMARY]
GO
