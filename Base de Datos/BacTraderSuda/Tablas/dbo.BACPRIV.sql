USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BACPRIV]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BACPRIV](
	[usuario] [char](15) NOT NULL,
	[nivel] [char](11) NOT NULL,
	[tipo] [char](1) NOT NULL
) ON [PRIMARY]
GO
