USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MERS]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MERS](
	[rsfecha] [datetime] NULL,
	[rsnemome] [char](3) NULL,
	[rscodigome] [numeric](3, 0) NULL,
	[rsposicion] [numeric](19, 4) NULL,
	[rscuentacambio] [numeric](19, 0) NULL,
	[rscuentaajustada] [numeric](19, 0) NULL,
	[rsvalorajuste] [numeric](19, 0) NULL,
	[rsutilidad] [numeric](19, 0) NULL,
	[rsperdida] [numeric](19, 0) NULL
) ON [PRIMARY]
GO
