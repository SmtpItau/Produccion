USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LIMITES_TASAS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITES_TASAS](
	[Operacion] [char](5) NULL,
	[Glosa] [varchar](20) NULL,
	[Moneda] [numeric](3, 0) NULL,
	[Tasa_inf] [numeric](19, 4) NULL,
	[Tasa_sup] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
