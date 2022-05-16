USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[BASE]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BASE](
	[codigo] [numeric](2, 0) NOT NULL,
	[glosa] [char](25) NOT NULL,
	[dias] [char](4) NOT NULL,
	[base] [char](4) NOT NULL,
	[cod_neosoft] [char](2) NOT NULL
) ON [PRIMARY]
GO
