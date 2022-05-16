USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tmp_Tabla_general_Detalle]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Tabla_general_Detalle](
	[tbcateg] [numeric](4, 0) NOT NULL,
	[tbcodigo1] [char](6) NOT NULL,
	[tbtasa] [numeric](3, 0) NOT NULL,
	[tbfecha] [datetime] NULL,
	[tbvalor] [numeric](18, 6) NULL,
	[tbglosa] [char](50) NOT NULL,
	[nemo] [char](10) NULL
) ON [PRIMARY]
GO
