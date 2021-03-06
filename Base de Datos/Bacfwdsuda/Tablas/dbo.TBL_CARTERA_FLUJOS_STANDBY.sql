USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_CARTERA_FLUJOS_STANDBY]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY](
	[Cfs_Numero_Credito] [numeric](10, 0) NOT NULL,
	[Cfs_Numero_Dividendo] [numeric](10, 0) NOT NULL,
	[Cfs_Fecha_Vencimiento] [datetime] NOT NULL,
	[Cfs_Monto_UF] [numeric](21, 4) NOT NULL,
	[Cfs_Precio_Contrato] [numeric](21, 4) NOT NULL,
	[Cfs_Usuario_Lock] [char](15) NOT NULL,
 CONSTRAINT [PK_TBL_CARTERA_FLUJO_STANDBY] PRIMARY KEY CLUSTERED 
(
	[Cfs_Numero_Credito] ASC,
	[Cfs_Numero_Dividendo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY] ADD  CONSTRAINT [CT_cfs_numero_credito]  DEFAULT (0) FOR [Cfs_Numero_Credito]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY] ADD  CONSTRAINT [CT_cfs_numero_dividendo]  DEFAULT (0) FOR [Cfs_Numero_Dividendo]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY] ADD  CONSTRAINT [CT_cfs_fecha_vencimiento]  DEFAULT ('') FOR [Cfs_Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY] ADD  CONSTRAINT [CT_cfs_monto_principal]  DEFAULT (0) FOR [Cfs_Monto_UF]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY] ADD  CONSTRAINT [CT_cfs_precio_contrato]  DEFAULT (0) FOR [Cfs_Precio_Contrato]
GO
ALTER TABLE [dbo].[TBL_CARTERA_FLUJOS_STANDBY] ADD  CONSTRAINT [CT_cfs_usuario_lock]  DEFAULT ('') FOR [Cfs_Usuario_Lock]
GO
