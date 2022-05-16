USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[INVERSION_EXTERIOR]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVERSION_EXTERIOR](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Nombre] [varchar](70) NOT NULL,
	[Plazo] [numeric](5, 0) NOT NULL,
	[ArbSpo_Total] [numeric](19, 0) NOT NULL,
	[ArbSpo_Ocupado] [numeric](19, 0) NOT NULL,
	[ArbSpo_Disponible] [numeric](19, 0) NOT NULL,
	[ArbSpo_Exceso] [numeric](19, 0) NOT NULL,
	[ArbFwd_Total] [numeric](19, 0) NOT NULL,
	[ArbFwd_Ocupado] [numeric](19, 0) NOT NULL,
	[ArbFwd_Disponible] [numeric](19, 0) NOT NULL,
	[ArbFwd_Exceso] [numeric](19, 0) NOT NULL,
	[InvExt_Total] [numeric](19, 0) NOT NULL,
	[InvExt_Ocupado] [numeric](19, 0) NOT NULL,
	[InvExt_Disponible] [numeric](19, 0) NOT NULL,
	[ArbExt_Exceso] [numeric](19, 0) NOT NULL,
	[Fecha_Vencimiento] [datetime] NOT NULL,
	[Fecha_Fin_Contrato] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__Nombr__5C3ADA09]  DEFAULT ('') FOR [Nombre]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__Plazo__5D2EFE42]  DEFAULT (0) FOR [Plazo]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbSp__5E23227B]  DEFAULT (0) FOR [ArbSpo_Total]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbSp__5F1746B4]  DEFAULT (0) FOR [ArbSpo_Ocupado]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbSp__600B6AED]  DEFAULT (0) FOR [ArbSpo_Disponible]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbSp__60FF8F26]  DEFAULT (0) FOR [ArbSpo_Exceso]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbFw__61F3B35F]  DEFAULT (0) FOR [ArbFwd_Total]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbFw__62E7D798]  DEFAULT (0) FOR [ArbFwd_Ocupado]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbFw__63DBFBD1]  DEFAULT (0) FOR [ArbFwd_Disponible]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbFw__64D0200A]  DEFAULT (0) FOR [ArbFwd_Exceso]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__InvEx__65C44443]  DEFAULT (0) FOR [InvExt_Total]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__InvEx__66B8687C]  DEFAULT (0) FOR [InvExt_Ocupado]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__InvEx__67AC8CB5]  DEFAULT (0) FOR [InvExt_Disponible]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__ArbEx__68A0B0EE]  DEFAULT (0) FOR [ArbExt_Exceso]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__Fecha__6994D527]  DEFAULT (' ') FOR [Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[INVERSION_EXTERIOR] ADD  CONSTRAINT [DF__INVERSION__Fecha__6A88F960]  DEFAULT (' ') FOR [Fecha_Fin_Contrato]
GO
