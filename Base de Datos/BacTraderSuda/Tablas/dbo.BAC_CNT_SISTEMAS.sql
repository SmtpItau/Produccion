USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_SISTEMAS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_SISTEMAS](
	[id_sistema] [char](3) NOT NULL,
	[nombre_sistema] [char](30) NOT NULL,
	[operativo] [char](1) NOT NULL
) ON [PRIMARY]
GO
