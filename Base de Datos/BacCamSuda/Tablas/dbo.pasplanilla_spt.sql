USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[pasplanilla_spt]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pasplanilla_spt](
	[fecha] [datetime] NOT NULL,
	[entidad] [numeric](3, 0) NOT NULL,
	[planilla_fecha] [datetime] NULL,
	[planilla_numero] [numeric](6, 0) NOT NULL,
	[interesado_rut] [numeric](9, 0) NULL,
	[interesado_codigo] [numeric](9, 0) NULL,
	[interesado_nombre] [varchar](30) NULL,
	[interesado_direccion] [varchar](30) NULL,
	[interesado_ciudad] [varchar](20) NULL,
	[operacion_numero] [numeric](7, 0) NULL,
	[operacion_fecha] [datetime] NULL,
	[tipo_documento] [numeric](1, 0) NULL,
	[tipo_operacion_cambio] [numeric](3, 0) NULL,
	[codigo_comercio] [varchar](6) NULL,
	[concepto] [varchar](3) NULL,
	[pais_operacion] [numeric](3, 0) NULL,
	[operacion_moneda] [char](3) NULL,
	[monto_origen] [numeric](19, 4) NULL,
	[paridad] [numeric](19, 8) NULL,
	[monto_dolares] [numeric](19, 4) NULL,
	[tipo_cambio] [numeric](19, 4) NULL,
	[monto_pesos] [numeric](19, 4) NULL,
	[afecto_derivados] [numeric](1, 0) NULL,
	[cantidad_acuerdos] [numeric](1, 0) NULL,
	[autbcch_tipo] [varchar](2) NULL,
	[autbcch_numero] [numeric](6, 0) NULL,
	[autbcch_fecha] [datetime] NULL,
	[rel_institucion] [numeric](3, 0) NULL,
	[rel_fecha] [datetime] NULL,
	[rel_numero] [numeric](6, 0) NULL,
	[rel_arbitraje] [char](1) NULL,
	[ofi_numero_inscripcion] [numeric](8, 0) NULL,
	[ofi_fecha_inscripcion] [datetime] NULL,
	[ofi_fecha_vencimiento] [datetime] NULL,
	[ofi_nombre_financista] [varchar](30) NULL,
	[ofi_fecha_desembolso] [datetime] NULL,
	[ofi_moneda_desembolso] [numeric](3, 0) NULL,
	[ofi_monto_desembolso] [numeric](15, 2) NULL,
	[ofi_impuesto_adicional] [numeric](13, 2) NULL,
	[exp_codigo_aduana] [numeric](3, 0) NULL,
	[exp_declaracion_fecha] [datetime] NULL,
	[exp_declaracion_numero] [varchar](7) NULL,
	[exp_informe_fecha] [datetime] NULL,
	[exp_informe_numero] [varchar](7) NULL,
	[exp_fecha_vence_retorno] [datetime] NULL,
	[exp_valor_bruto] [numeric](15, 2) NULL,
	[exp_comisiones] [numeric](13, 2) NULL,
	[exp_otros_gastos] [numeric](13, 2) NULL,
	[exp_valor_total] [numeric](16, 2) NULL,
	[exp_plazo_financia] [numeric](4, 0) NULL,
	[exp_nombre_comprador] [varchar](30) NULL,
	[imp_informe_fecha] [datetime] NULL,
	[imp_informe_numero] [numeric](6, 0) NULL,
	[imp_declaracion_numero] [varchar](18) NULL,
	[imp_forma_pago] [numeric](2, 0) NULL,
	[imp_embarque_numero] [numeric](8, 0) NULL,
	[imp_embarque_fecha] [datetime] NULL,
	[imp_fecha_vence] [datetime] NULL,
	[imp_valor_mercaderia] [numeric](14, 2) NULL,
	[imp_gastos_fob] [numeric](13, 2) NULL,
	[imp_valor_fob] [numeric](14, 2) NULL,
	[imp_flete] [numeric](13, 2) NULL,
	[imp_seguro] [numeric](13, 2) NULL,
	[imp_valor_cif] [numeric](14, 2) NULL,
	[imp_intereses] [numeric](14, 2) NULL,
	[imp_gastos_bancarios] [numeric](13, 2) NULL,
	[der_numero_contrato] [numeric](8, 0) NULL,
	[der_fecha_inicio] [datetime] NULL,
	[der_fecha_vence] [datetime] NULL,
	[der_instrumento] [numeric](2, 0) NULL,
	[der_precio_contrato] [numeric](11, 4) NULL,
	[der_area_contable] [numeric](2, 0) NULL,
	[acuerdo_codigo_1] [varchar](7) NULL,
	[acuerdo_numero_1] [varchar](17) NULL,
	[acuerdo_codigo_2] [varchar](7) NULL,
	[acuerdo_numero_2] [varchar](17) NULL,
	[acuerdo_codigo_3] [varchar](7) NULL,
	[acuerdo_numero_3] [varchar](17) NULL,
	[acuerdo_codigo_4] [varchar](7) NULL,
	[acuerdo_numero_4] [varchar](17) NULL,
	[acuerdo_codigo_5] [varchar](7) NULL,
	[acuerdo_numero_5] [varchar](17) NULL,
	[obs_1] [varchar](240) NULL,
	[obs_2] [varchar](240) NULL,
	[obs_3] [varchar](240) NULL,
	[HORA_PROC] [varchar](8) NULL
) ON [PRIMARY]
GO
