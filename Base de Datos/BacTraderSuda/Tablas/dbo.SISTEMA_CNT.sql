USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[SISTEMA_CNT]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SISTEMA_CNT](
	[id_sistema] [char](3) NOT NULL,
	[nombre_sistema] [char](30) NOT NULL,
	[operativo] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
