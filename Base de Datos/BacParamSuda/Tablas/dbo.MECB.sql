USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MECB]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MECB](
	[CBRUT] [float] NULL,
	[CBCODIGO] [nvarchar](4) NULL,
	[CBBANCO] [nvarchar](40) NULL,
	[CBMONEDA] [nvarchar](3) NULL,
	[CBCUENTA] [nvarchar](20) NULL,
	[CBPLAZA] [float] NULL,
	[CBCSWIFT] [nvarchar](15) NULL
) ON [PRIMARY]
GO
