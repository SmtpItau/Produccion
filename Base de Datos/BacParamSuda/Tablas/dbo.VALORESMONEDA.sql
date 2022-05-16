USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[VALORESMONEDA]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALORESMONEDA](
	[codigo] [numeric](3, 0) NULL,
	[fecha] [datetime] NULL,
	[valor] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
