USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_EMISOR_INST_PLAZO]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_EMISOR_INST_PLAZO](
	[rut] [numeric](10, 0) NULL,
	[instrumento] [char](6) NULL,
	[plazo_ini] [int] NULL,
	[plazo_fin] [int] NULL,
	[monto_asignado] [float] NULL,
	[monto_ocupado] [float] NULL
) ON [PRIMARY]
GO
