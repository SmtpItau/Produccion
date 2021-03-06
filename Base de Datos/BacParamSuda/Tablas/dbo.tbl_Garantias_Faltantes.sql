USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_Garantias_Faltantes]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Garantias_Faltantes](
	[RutCliente] [numeric](9, 0) NOT NULL,
	[CodCliente] [int] NOT NULL,
	[numGarantia] [numeric](10, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Avisado] [char](1) NULL,
	[MontoFaltante] [numeric](21, 4) NOT NULL,
	[MontoRequerido] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Garantias_Faltantes] ADD  DEFAULT ('N') FOR [Avisado]
GO
ALTER TABLE [dbo].[tbl_Garantias_Faltantes] ADD  DEFAULT (0.0000) FOR [MontoFaltante]
GO
ALTER TABLE [dbo].[tbl_Garantias_Faltantes] ADD  DEFAULT (0.0000) FOR [MontoRequerido]
GO
