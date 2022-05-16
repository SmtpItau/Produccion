USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_ident]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_ident](
	[cod_id] [int] NOT NULL,
	[cod_Nemo] [char](20) NULL,
	[sIsin] [char](15) NULL,
	[sCusip] [char](15) NULL,
	[sBBNumber] [char](15) NULL,
	[sSerie] [char](15) NULL,
	[sMercado] [char](15) NULL
) ON [PRIMARY]
GO
