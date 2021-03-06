USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEVB2]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEVB2](
	[vb2numope] [numeric](7, 0) NOT NULL,
	[vb2tipope] [char](1) NOT NULL,
	[vb2produc] [char](8) NOT NULL,
	[vb2mtousd] [numeric](19, 4) NOT NULL,
	[vb2tipcam] [numeric](9, 4) NOT NULL,
	[vb2rutcli] [numeric](9, 0) NOT NULL,
	[vb2nomcli] [char](35) NOT NULL,
	[vb2user] [char](8) NOT NULL,
	[vb2hora] [char](8) NOT NULL,
	[vb2fecha] [datetime] NOT NULL,
	[vb2saldo] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
