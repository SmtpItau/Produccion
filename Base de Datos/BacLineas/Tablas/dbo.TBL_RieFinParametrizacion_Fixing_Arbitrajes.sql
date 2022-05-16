USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RieFinParametrizacion_Fixing_Arbitrajes]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RieFinParametrizacion_Fixing_Arbitrajes](
	[Cliente] [char](70) NULL,
	[Rut] [numeric](9, 0) NULL,
	[Codigo] [numeric](9, 0) NULL,
	[Fixing] [int] NULL
) ON [PRIMARY]
GO
