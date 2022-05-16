USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbXMLOperacionDetalle]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbXMLOperacionDetalle](
	[dcSistema] [char](3) NULL,
	[dfOperacion] [datetime] NULL,
	[dnOperacion] [numeric](7, 0) NULL,
	[dnFila] [int] NULL,
	[dcDetalle] [varchar](255) NULL
) ON [PRIMARY]
GO
