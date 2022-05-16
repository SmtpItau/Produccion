USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[paso_cliente]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paso_cliente](
	[Clrut] [numeric](9, 0) NOT NULL,
	[Cldv] [char](1) NOT NULL,
	[Clcodigo] [numeric](9, 0) NOT NULL,
	[Clcomuna] [numeric](8, 0) NULL,
	[Clregion] [numeric](5, 0) NULL,
	[clciudad] [numeric](8, 0) NULL
) ON [PRIMARY]
GO
