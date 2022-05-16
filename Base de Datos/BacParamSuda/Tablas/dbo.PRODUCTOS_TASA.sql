USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTOS_TASA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS_TASA](
	[Codigo] [numeric](18, 0) NULL,
	[moneda] [numeric](3, 0) NULL,
	[Campo_Tasa] [char](20) NULL
) ON [PRIMARY]
GO
