USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Clientes_CGI]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_CGI](
	[RUTCLI_CGI] [numeric](9, 0) NOT NULL,
	[DVCLI_CGI] [char](1) NOT NULL,
	[CGI] [numeric](15, 0) NOT NULL
) ON [PRIMARY]
GO
