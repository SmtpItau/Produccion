USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaVALOR_MONEDA_CONTABLE]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaVALOR_MONEDA_CONTABLE](
	[Fecha] [datetime] NULL,
	[Codigo_Moneda] [numeric](5, 0) NULL,
	[Nemo_Moneda] [char](5) NULL,
	[Codigo_Contable] [char](6) NULL,
	[Tipo_Cambio] [float] NULL,
	[Porcentaje_Variacion] [numeric](3, 0) NULL,
	[SpotCompra] [float] NULL,
	[SpotVenta] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BacParamSudaVALOR_MONEDA_CONTABLE] ADD  CONSTRAINT [dfvalmoncnt_Punta_Com]  DEFAULT ((0.0)) FOR [SpotCompra]
GO
ALTER TABLE [dbo].[BacParamSudaVALOR_MONEDA_CONTABLE] ADD  CONSTRAINT [dfvalmoncnt_Punta_Vta]  DEFAULT ((0.0)) FOR [SpotVenta]
GO
