USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RENTABILIDAD]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RENTABILIDAD](
	[Fecha] [datetime] NULL,
	[Result_Trading] [numeric](19, 4) NULL,
	[Posicion] [numeric](19, 4) NULL,
	[TC_Posicion] [numeric](10, 4) NULL,
	[TC_Cierre] [numeric](10, 4) NULL,
	[Result_TC_Cierre] [numeric](19, 4) NULL,
	[Result_Hedge] [numeric](19, 4) NOT NULL,
	[AcacumDia] [numeric](19, 4) NOT NULL,
	[AcacumMes] [numeric](19, 4) NOT NULL,
	[Result_Trading_Empresa] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RENTABILIDAD] ADD  DEFAULT (0.0) FOR [Result_Hedge]
GO
ALTER TABLE [dbo].[RENTABILIDAD] ADD  DEFAULT (0.0) FOR [AcacumDia]
GO
ALTER TABLE [dbo].[RENTABILIDAD] ADD  DEFAULT (0.0) FOR [AcacumMes]
GO
ALTER TABLE [dbo].[RENTABILIDAD] ADD  DEFAULT (0.0) FOR [Result_Trading_Empresa]
GO
