USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEPP02]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEPP02](
	[codrenta] [numeric](3, 0) NOT NULL,
	[codpos] [numeric](3, 0) NOT NULL,
	[posicion] [char](1) NOT NULL,
	[pmedio] [char](1) NOT NULL,
	[oinversa] [char](1) NOT NULL,
	[resultado] [char](1) NOT NULL
) ON [PRIMARY]
GO
