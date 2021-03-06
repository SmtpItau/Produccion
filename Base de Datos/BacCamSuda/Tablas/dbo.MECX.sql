USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MECX]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MECX](
	[cxnumope] [numeric](6, 0) NOT NULL,
	[cxtipope] [char](1) NOT NULL,
	[cxproduc] [char](8) NOT NULL,
	[cxnomcli] [char](35) NOT NULL,
	[cxmtousd] [numeric](19, 4) NOT NULL,
	[cxticamb] [numeric](12, 4) NOT NULL,
	[cxticamc] [numeric](12, 4) NOT NULL,
	[cxfpmexb] [numeric](2, 0) NOT NULL,
	[cxfpmexc] [numeric](2, 0) NOT NULL,
	[cxfpmchb] [numeric](2, 0) NOT NULL,
	[cxfpmchc] [numeric](2, 0) NOT NULL,
	[cxfecvto] [datetime] NOT NULL,
	[cxuser] [char](10) NOT NULL,
	[cxhora] [char](8) NOT NULL,
	[cxfecha] [datetime] NOT NULL,
	[cxrutcli] [numeric](9, 0) NOT NULL,
	[cxcodoma] [numeric](3, 0) NOT NULL,
	[cxrentab] [numeric](2, 0) NOT NULL,
	[cxdifer] [numeric](7, 4) NOT NULL,
	[cxvalutb] [datetime] NOT NULL,
	[cxvalutc] [datetime] NOT NULL,
	[cxestatus] [char](1) NOT NULL,
	[cxpcierre] [char](1) NOT NULL,
	[cxenvia] [char](1) NOT NULL,
	[cxaprob] [char](1) NOT NULL,
	[cxalinea] [char](1) NOT NULL,
	[cxnumche] [numeric](6, 0) NOT NULL,
	[cxcorres] [numeric](7, 0) NOT NULL,
	[cxcodcli] [numeric](9, 0) NOT NULL,
	[cxterm] [char](12) NOT NULL,
	[cxentidad] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
