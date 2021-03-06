USE [MDPasivo]
GO
/****** Object:  Table [dbo].[INVERSION_EXTERIOR]    Script Date: 16-05-2022 11:41:39 ******/
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
	[Fecha_Fin_Contrato] [datetime] NOT NULL
) ON [PRIMARY]
GO
