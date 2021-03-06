USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TASA_REFERENCIA_SOMA_HIS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA_REFERENCIA_SOMA_HIS](
	[Rca_Fecha_Proceso] [datetime] NOT NULL,
	[Rca_trincodigo] [numeric](3, 0) NOT NULL,
	[Rca_trClasificacionRiesgo] [char](3) NOT NULL,
	[Rca_trserie] [char](12) NOT NULL,
	[Rca_trDesde] [numeric](10, 0) NOT NULL,
	[Rca_trHasta] [numeric](10, 0) NOT NULL,
	[Rca_trtipoper] [char](3) NOT NULL,
	[Rca_trtasareferencial] [float] NOT NULL,
	[Rca_trrutemisor] [numeric](9, 0) NOT NULL,
	[Rca_tricodemisor] [numeric](3, 0) NOT NULL,
	[Rca_trgenericemisor] [char](5) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA_HIS] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_HIS_Rca_trClasificacionriesgo]  DEFAULT ('') FOR [Rca_trClasificacionRiesgo]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA_HIS] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_HIS_Rca_trrutemisor]  DEFAULT (0) FOR [Rca_trrutemisor]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA_HIS] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_HIS_Rca_tricodemisor]  DEFAULT (0) FOR [Rca_tricodemisor]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA_HIS] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_HIS_Rca_trgenericemisor]  DEFAULT ('') FOR [Rca_trgenericemisor]
GO
