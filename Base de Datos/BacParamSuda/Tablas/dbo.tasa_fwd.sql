USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tasa_fwd]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tasa_fwd](
	[codigo] [numeric](5, 0) NULL,
	[plazo] [numeric](5, 0) NULL,
	[tasa_compra] [float] NULL,
	[tasa_venta] [float] NULL,
	[lleva_plazo] [numeric](1, 0) NULL,
	[tasa_nominal] [float] NULL,
	[tasa_uf] [float] NULL,
	[precio_nominal] [float] NULL,
	[punto_fwd] [float] NULL,
	[desviacion_estandar] [float] NULL,
	[tasa_var] [float] NULL,
	[desviacion1] [float] NULL,
	[desviacion2] [float] NULL,
	[desviacion3] [float] NULL,
	[desviacion_total] [float] NULL,
	[media1] [float] NULL,
	[media2] [float] NULL,
	[media3] [float] NULL,
	[media_total] [float] NULL,
	[fecha] [datetime] NULL,
	[tasa_efectiva] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__codigo__1C6B390E]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__plazo__1D5F5D47]  DEFAULT (0) FOR [plazo]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__tasa_c__1E538180]  DEFAULT (0) FOR [tasa_compra]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__tasa_v__1F47A5B9]  DEFAULT (0) FOR [tasa_venta]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__lleva___203BC9F2]  DEFAULT (0) FOR [lleva_plazo]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__tasa_n__212FEE2B]  DEFAULT (0) FOR [tasa_nominal]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__tasa_u__22241264]  DEFAULT (0) FOR [tasa_uf]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__precio__2318369D]  DEFAULT (0) FOR [precio_nominal]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__punto___240C5AD6]  DEFAULT (0) FOR [punto_fwd]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__desvia__25007F0F]  DEFAULT (0) FOR [desviacion_estandar]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__tasa_v__25F4A348]  DEFAULT (0) FOR [tasa_var]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__desvia__26E8C781]  DEFAULT (0) FOR [desviacion1]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__desvia__27DCEBBA]  DEFAULT (0) FOR [desviacion2]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__desvia__28D10FF3]  DEFAULT (0) FOR [desviacion3]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__desvia__29C5342C]  DEFAULT (0) FOR [desviacion_total]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__media1__2AB95865]  DEFAULT (0) FOR [media1]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__media2__2BAD7C9E]  DEFAULT (0) FOR [media2]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__media3__2CA1A0D7]  DEFAULT (0) FOR [media3]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__media___2D95C510]  DEFAULT (0) FOR [media_total]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__fecha__2E89E949]  DEFAULT (' ') FOR [fecha]
GO
ALTER TABLE [dbo].[tasa_fwd] ADD  CONSTRAINT [DF__tasa_fwd__tasa_e__2F7E0D82]  DEFAULT (0) FOR [tasa_efectiva]
GO
