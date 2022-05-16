USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_gar_AsociacionOper]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_gar_AsociacionOper](
	[FolioAsocia] [numeric](18, 0) NOT NULL,
	[RutCliente] [numeric](9, 0) NULL,
	[CodCliente] [numeric](5, 0) NULL,
	[Sistema] [varchar](3) NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
