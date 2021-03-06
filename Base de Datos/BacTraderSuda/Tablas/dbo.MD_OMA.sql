USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_OMA]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_OMA](
	[omacodigo] [char](3) NOT NULL,
	[omagrupo] [char](10) NOT NULL,
	[omaglogrupo] [char](15) NULL,
	[omatipcli] [char](1) NOT NULL,
	[omaglocli] [char](15) NULL,
	[omaventmon] [numeric](19, 2) NULL,
	[omaventtas] [numeric](8, 4) NULL,
	[omaventpla] [numeric](6, 0) NULL,
	[omacompmon] [numeric](19, 2) NULL,
	[omacomptas] [numeric](8, 4) NULL,
	[omacomppla] [numeric](6, 0) NULL,
	[omacodigo1] [char](3) NOT NULL,
	[omacodigo2] [char](3) NOT NULL,
	[omacodigo3] [char](3) NOT NULL,
	[omamoneda] [char](15) NULL,
	[omatiptasa] [char](10) NULL,
	[omaorden] [int] NULL
) ON [PRIMARY]
GO
