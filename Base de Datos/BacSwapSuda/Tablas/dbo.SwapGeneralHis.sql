USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[SwapGeneralHis]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwapGeneralHis](
	[entidad] [char](2) NOT NULL,
	[codigo] [char](3) NOT NULL,
	[nombre] [char](45) NOT NULL,
	[rut] [numeric](9, 0) NOT NULL,
	[direccion] [char](40) NOT NULL,
	[comuna] [char](20) NOT NULL,
	[ciudad] [char](20) NOT NULL,
	[telefono] [char](10) NOT NULL,
	[fax] [char](15) NOT NULL,
	[fechaant] [datetime] NOT NULL,
	[fechaproc] [datetime] NOT NULL,
	[fechaprox] [datetime] NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[rutbcch] [numeric](9, 0) NOT NULL,
	[iniciodia] [numeric](1, 0) NOT NULL,
	[libor] [numeric](1, 0) NOT NULL,
	[paridad] [numeric](1, 0) NOT NULL,
	[tasamtm] [numeric](1, 0) NOT NULL,
	[tasas] [numeric](1, 0) NOT NULL,
	[findia] [numeric](1, 0) NOT NULL,
	[cierreMesa] [char](1) NOT NULL,
	[codigobanco] [numeric](3, 0) NOT NULL,
	[devengo] [numeric](1, 0) NOT NULL,
	[contabilidad] [numeric](1, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SwapGeneralHis] ADD  CONSTRAINT [DF__swapgener__deven__632F8E56]  DEFAULT (0) FOR [devengo]
GO
ALTER TABLE [dbo].[SwapGeneralHis] ADD  CONSTRAINT [DF__swapgener__conta__6423B28F]  DEFAULT (0) FOR [contabilidad]
GO
