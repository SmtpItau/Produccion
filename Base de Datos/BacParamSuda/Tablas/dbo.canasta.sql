USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[canasta]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[canasta](
	[canasta] [char](2) NULL,
	[plazo_inicial] [numeric](4, 0) NULL,
	[plazo_final] [numeric](4, 0) NULL,
	[porcentaje] [numeric](10, 4) NULL,
	[tramo] [numeric](4, 0) NULL
) ON [PRIMARY]
GO
