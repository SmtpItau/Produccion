USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TABLA_GENERAL_DETALLE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_GENERAL_DETALLE](
	[tbcateg] [int] NOT NULL,
	[tbcodigo1] [char](10) NOT NULL,
	[tbtasa] [decimal](3, 0) NOT NULL,
	[tbfecha] [datetime] NULL,
	[tbvalor] [decimal](18, 6) NULL,
	[tbglosa] [char](60) NOT NULL,
	[nemo] [char](10) NULL
) ON [PRIMARY]
GO
