USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[INSTRUMENTOS_SOMA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INSTRUMENTOS_SOMA](
	[InCodigo] [numeric](5, 0) NOT NULL,
	[InTipSOMA] [char](3) NOT NULL
) ON [PRIMARY]
GO
