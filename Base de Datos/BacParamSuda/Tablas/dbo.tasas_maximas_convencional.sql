USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tasas_maximas_convencional]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tasas_maximas_convencional](
	[Codigo_Moneda] [numeric](3, 0) NOT NULL,
	[DiasDesde] [int] NOT NULL,
	[DiasHasta] [int] NOT NULL,
	[MontoMinimo] [float] NOT NULL,
	[MontoMaximo] [float] NOT NULL,
	[Tasa] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tasas_maximas_convencional] ADD  CONSTRAINT [DF_tasas_maximas_convencional_Codigo_Moneda]  DEFAULT ((0)) FOR [Codigo_Moneda]
GO
ALTER TABLE [dbo].[tasas_maximas_convencional] ADD  CONSTRAINT [DF_tasas_maximas_convencional_DiasDesde]  DEFAULT ((0)) FOR [DiasDesde]
GO
ALTER TABLE [dbo].[tasas_maximas_convencional] ADD  CONSTRAINT [DF_tasas_maximas_convencional_DiasHasta]  DEFAULT ((0)) FOR [DiasHasta]
GO
ALTER TABLE [dbo].[tasas_maximas_convencional] ADD  CONSTRAINT [DF_tasas_maximas_convencional_MontoMinimo]  DEFAULT ((0)) FOR [MontoMinimo]
GO
ALTER TABLE [dbo].[tasas_maximas_convencional] ADD  CONSTRAINT [DF_tasas_maximas_convencional_MontoMaximo]  DEFAULT ((0)) FOR [MontoMaximo]
GO
ALTER TABLE [dbo].[tasas_maximas_convencional] ADD  CONSTRAINT [DF_tasas_maximas_convencional_Tasa]  DEFAULT ((0)) FOR [Tasa]
GO
