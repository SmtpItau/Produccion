USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CONCEPTO_CONTABLE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONCEPTO_CONTABLE](
	[concepto_contable] [char](5) NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[inventario] [char](1) NOT NULL,
	[resultado] [char](1) NOT NULL,
	[switch_producto] [int] NOT NULL,
	[switch_garantia] [int] NOT NULL,
	[switch_tipo_plazo] [int] NOT NULL,
	[switch_financia] [int] NOT NULL,
	[switch_sector] [int] NOT NULL,
	[switch_corresponsal] [int] NOT NULL,
	[switch_propiedad] [int] NOT NULL,
	[switch_cuota] [int] NOT NULL,
	[switch_colocacion] [int] NOT NULL,
	[switch_recup] [int] NOT NULL,
	[switch_divisa] [int] NOT NULL,
	[switch_tipo_moneda] [int] NOT NULL,
	[referencia] [int] NOT NULL,
	[switch_codigo_operacion] [int] NOT NULL
) ON [PRIMARY]
GO
