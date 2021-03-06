USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEUS]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEUS](
	[marca] [char](1) NOT NULL,
	[nombre] [char](40) NOT NULL,
	[oficina] [numeric](7, 0) NOT NULL,
	[totspcom] [numeric](19, 2) NOT NULL,
	[totspven] [numeric](19, 2) NOT NULL,
	[totspres] [numeric](19, 2) NOT NULL,
	[totarcom] [numeric](19, 2) NOT NULL,
	[totarven] [numeric](19, 2) NOT NULL,
	[totarres] [numeric](19, 2) NOT NULL,
	[canspcom] [numeric](5, 0) NOT NULL,
	[canspven] [numeric](5, 0) NOT NULL,
	[canarcom] [numeric](5, 0) NOT NULL,
	[canarven] [numeric](5, 0) NOT NULL,
	[totsprfi] [numeric](19, 2) NOT NULL,
	[totarrfi] [numeric](19, 2) NOT NULL,
	[cominv] [char](1) NOT NULL,
	[pestfcom] [numeric](19, 2) NOT NULL,
	[pestfven] [numeric](19, 2) NOT NULL,
	[pestccom] [numeric](19, 2) NOT NULL,
	[pestcven] [numeric](19, 2) NOT NULL,
	[user1] [char](10) NOT NULL,
	[password] [char](16) NOT NULL,
	[nombre2] [char](15) NOT NULL,
	[coduser] [numeric](4, 0) NOT NULL,
	[depto] [numeric](3, 0) NOT NULL,
	[usrfijo] [char](1) NOT NULL
) ON [PRIMARY]
GO
