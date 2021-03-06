USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TASA_REFERENCIA_SOMA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA_REFERENCIA_SOMA](
	[trincodigo] [numeric](3, 0) NOT NULL,
	[trClasificacionRiesgo] [char](3) NOT NULL,
	[trserie] [char](12) NOT NULL,
	[trDesde] [numeric](10, 0) NOT NULL,
	[trHasta] [numeric](10, 0) NOT NULL,
	[trtipoper] [char](3) NOT NULL,
	[trtasareferencial] [float] NOT NULL,
	[trrutemisor] [numeric](9, 0) NOT NULL,
	[tricodemisor] [numeric](3, 0) NOT NULL,
	[trgenericemisor] [char](5) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_trClasificacionRiesgo]  DEFAULT ('') FOR [trClasificacionRiesgo]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_trrutemisor]  DEFAULT (0) FOR [trrutemisor]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_tricodemisor]  DEFAULT (0) FOR [tricodemisor]
GO
ALTER TABLE [dbo].[TASA_REFERENCIA_SOMA] ADD  CONSTRAINT [df_TASA_REFERENCIA_SOMA_trgenericemisor]  DEFAULT ('') FOR [trgenericemisor]
GO
