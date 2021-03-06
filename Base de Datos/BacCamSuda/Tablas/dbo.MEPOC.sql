USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEPOC]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEPOC](
	[poccodtx] [numeric](3, 0) NOT NULL,
	[pocnumer] [numeric](7, 0) NOT NULL,
	[poccodig] [numeric](4, 0) NOT NULL,
	[pocfecha] [datetime] NOT NULL,
	[pocplaza] [char](20) NOT NULL,
	[poccodplz] [numeric](3, 0) NOT NULL,
	[poctippoc] [numeric](1, 0) NOT NULL,
	[pocrutint] [numeric](9, 0) NOT NULL,
	[pocnemmon] [char](3) NOT NULL,
	[pocmonto] [numeric](17, 4) NOT NULL,
	[pocmonus] [numeric](17, 4) NOT NULL,
	[pocticam] [numeric](9, 4) NOT NULL,
	[pocmarca] [char](1) NOT NULL,
	[pocpesos] [numeric](19, 0) NOT NULL,
	[pocnumfi] [char](12) NOT NULL
) ON [PRIMARY]
GO
