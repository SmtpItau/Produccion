USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[OmaHoja2]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OmaHoja2](
	[TIPOPE10] [char](1) NULL,
	[CODIGO10] [numeric](3, 0) NULL,
	[MONTO10] [numeric](20, 4) NULL,
	[TIPCAMP10] [numeric](20, 4) NULL,
	[NOMBREEMI10] [char](60) NULL,
	[COMERCIO10] [char](6) NULL,
	[CONCEPTO10] [char](3) NULL,
	[TIPOPE40] [char](1) NULL,
	[CODIGO40] [numeric](3, 0) NULL,
	[MONTO40] [numeric](20, 4) NULL,
	[TIPCAMP40] [numeric](20, 4) NULL,
	[NOMBREEMI40] [char](40) NULL,
	[COMERCIO40] [char](6) NULL,
	[CONCEPTO40] [char](3) NULL,
	[FECHA_PROCESO] [char](10) NULL,
	[HORA] [char](8) NULL,
	[SERIE] [int] NULL
) ON [PRIMARY]
GO
