USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[nofinan]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nofinan](
	[TIPOPE10] [char](1) NULL,
	[CODIGO10] [numeric](3, 0) NULL,
	[MONTO10] [numeric](20, 4) NULL,
	[TIPCAMP10] [numeric](20, 4) NULL,
	[NOMBREEMI10] [char](60) NULL,
	[COMERCIO10] [char](6) NULL,
	[CONCEPTO10] [char](3) NULL
) ON [PRIMARY]
GO
