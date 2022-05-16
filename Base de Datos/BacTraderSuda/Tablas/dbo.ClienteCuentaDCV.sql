USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[ClienteCuentaDCV]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteCuentaDCV](
	[Rut] [numeric](12, 0) NOT NULL,
	[Dv] [char](1) NOT NULL,
	[Codigo_Secuencia] [numeric](12, 0) NOT NULL,
	[Cuenta_DVC] [char](12) NOT NULL
) ON [PRIMARY]
GO
