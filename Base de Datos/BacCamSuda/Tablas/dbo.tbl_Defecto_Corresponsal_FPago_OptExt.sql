USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbl_Defecto_Corresponsal_FPago_OptExt]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Defecto_Corresponsal_FPago_OptExt](
	[Origen] [varchar](10) NOT NULL,
	[CodMon] [numeric](5, 0) NOT NULL,
	[TipoCV] [varchar](1) NOT NULL,
	[CodMon2] [numeric](5, 0) NOT NULL,
	[Cod_Corresponsal] [numeric](10, 0) NOT NULL,
	[Corres_Desde] [numeric](5, 0) NOT NULL,
	[Corres_Donde] [numeric](5, 0) NOT NULL,
	[Corres_Quien] [numeric](5, 0) NOT NULL,
	[PL_Corres_Desde] [numeric](5, 0) NOT NULL,
	[PL_Corres_Donde] [numeric](5, 0) NOT NULL,
	[PL_Corres_Quien] [numeric](5, 0) NOT NULL,
	[Forma_pagomn] [numeric](5, 0) NOT NULL,
	[Forma_pagomx] [numeric](5, 0) NOT NULL,
	[Codigo_Oma] [numeric](5, 0) NOT NULL,
	[Codigo_Comercio] [varchar](6) NOT NULL,
	[Codigo_Concepto] [varchar](3) NOT NULL,
	[Operador] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Origen] ASC,
	[CodMon] ASC,
	[TipoCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Defecto_Corresponsal_FPago_OptExt] ADD  DEFAULT ('') FOR [Origen]
GO
