USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MECC]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MECC](
	[CCRUT] [float] NULL,
	[CCMONEDA] [nvarchar](3) NULL,
	[CCBANCO] [nvarchar](45) NULL,
	[CCCUENTA] [nvarchar](30) NULL,
	[CCCSWIFT] [nvarchar](11) NULL,
	[CCCSUC] [nvarchar](3) NULL,
	[CCCODIGO] [nvarchar](4) NULL,
	[CCRUTCOD] [char](1) NULL
) ON [PRIMARY]
GO
