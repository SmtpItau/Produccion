USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLI_COLATERAL]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLI_COLATERAL](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Cliente] [numeric](3, 0) NOT NULL,
	[Cod_Colateral] [varchar](5) NOT NULL
) ON [PRIMARY]
GO
