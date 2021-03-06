USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_ser_expo]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_ser_expo](
	[Cod_familia] [numeric](4, 0) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[fecha_vcto] [datetime] NOT NULL,
	[nom_nemo] [char](50) NOT NULL,
	[rut_emis] [numeric](9, 0) NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[indice_basilea] [numeric](1, 0) NOT NULL,
	[per_cupones] [numeric](2, 0) NOT NULL,
	[num_cupones] [numeric](3, 0) NOT NULL,
	[fecha_emis] [datetime] NOT NULL,
	[afecto_encaje] [char](1) NOT NULL,
	[tasa_emis] [float] NOT NULL,
	[base_tasa_emi] [numeric](3, 0) NOT NULL,
	[tasa_vigente] [float] NOT NULL,
	[fecha_primer_pago] [datetime] NOT NULL,
	[dias_reales] [char](1) NOT NULL,
	[base_flujo] [numeric](3, 0) NOT NULL,
	[tasa_fija] [char](1) NOT NULL,
	[monto_emision] [numeric](19, 4) NOT NULL,
	[monemi] [numeric](5, 0) NOT NULL,
	[monpag] [numeric](5, 0) NOT NULL,
	[tasas_bases] [char](15) NOT NULL,
	[per_capital] [numeric](2, 0) NOT NULL,
	[cod_emis] [numeric](1, 0) NULL,
	[dias_habiles_valor] [numeric](3, 0) NOT NULL,
	[valor_spread] [float] NOT NULL,
	[periodo_tasa] [numeric](5, 0) NOT NULL,
	[Tipo_Cartera] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
