USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DJ1829_DetalleRectif]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DJ1829_DetalleRectif](
	[Fecha_Analisis] [datetime] NULL,
	[Contrato] [numeric](10, 0) NULL,
	[Evento] [varchar](30) NULL,
	[SubEvento] [varchar](30) NULL,
	[FechaEvento] [datetime] NULL,
	[Rut_Contraparte] [numeric](9, 0) NULL,
	[DV_Rut_COntraparte] [varchar](1) NOT NULL,
	[Tax_ID_Contraparte] [varchar](15) NULL,
	[Codigo_Pais_Contraparte] [varchar](2) NOT NULL,
	[Tipo_Relacion_con_Contraparte] [int] NOT NULL,
	[Modalidad_Contratacion] [numeric](2, 0) NULL,
	[Tipo_Acuerdo_Marco] [numeric](1, 0) NULL,
	[Numero_Acuerdo_Marco] [varchar](200) NULL,
	[Fecha_Suscripcion_Acuerdo_Marco] [datetime] NULL,
	[Numero_Contrato] [varchar](10) NULL,
	[Fecha_Suscripcion_Contrato] [datetime] NULL,
	[Contrato_Vencido_En_El_Ejercicio] [int] NOT NULL,
	[Estado_Contrato] [int] NOT NULL,
	[Evento_Informado] [numeric](1, 0) NULL,
	[Tipo_Contrato] [numeric](2, 0) NULL,
	[Nombre_Instrumento] [varchar](20) NULL,
	[Modalidad_Cumplimiento] [numeric](1, 0) NULL,
	[Posicion_Declarante] [numeric](1, 0) NULL,
	[Tipo_Activo_Subyacente] [numeric](1, 0) NULL,
	[Codigo_Activo_Subyacente] [varchar](3) NULL,
	[Otro_Activo_Subyacente_Especificacion] [varchar](15) NULL,
	[Tasa_Fija_o_Spread_Activo_Subyacente] [numeric](7, 4) NULL,
	[Tipo_Segundo_Activo_Subyacente] [numeric](1, 0) NULL,
	[Codigo_Segundo_Activo_Subyacente] [varchar](3) NULL,
	[Otro_Segundo_Activo_Subyacente_Especificacion] [varchar](15) NULL,
	[Tasa_Fija_o_Spread_Segundo_Activo_Subyacente] [numeric](7, 4) NULL,
	[Codigo_Precio_Futuro_Contratado] [numeric](1, 0) NULL,
	[Precio_Futuro_Contratado] [numeric](15, 2) NULL,
	[Moneda_Precio_Futuro_Contratado] [varchar](3) NULL,
	[Unidad] [numeric](2, 0) NULL,
	[Monto_Cantidad_Contratado_o_Nocional] [numeric](15, 2) NULL,
	[Segunda_Unidad] [numeric](2, 0) NULL,
	[Segundo_Monto_Nocional] [numeric](15, 2) NULL,
	[Fecha_Vencimiento] [datetime] NULL,
	[Fecha_Liquidacion_Ejercicio_de_Opcion] [datetime] NULL,
	[Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion] [numeric](1, 0) NULL,
	[Precio_Mercado_Al_CIerre_o_Liquidacion] [float] NULL,
	[Valor_Justo_Contrato] [numeric](15, 0) NULL,
	[Resultado_Ejercicio] [numeric](15, 0) NULL,
	[Cuenta_Contable_Resultado_Ejercicio] [varchar](15) NULL,
	[Efecto_En_Patrimonio] [numeric](15, 0) NULL,
	[Cuenta_Contable_Registro_Patrimonio] [varchar](15) NULL,
	[Comision_Pactada] [numeric](15, 0) NULL,
	[Cuenta_Contable_Registro_Comision_Pactada] [varchar](15) NULL,
	[Prima_Total] [numeric](15, 0) NULL,
	[Cuenta_Contable_Registro_Prima_Total] [varchar](15) NULL,
	[Inversion_Inicial] [numeric](15, 0) NULL,
	[Cuenta_Contable_Registro_Inversion_Inicial] [numeric](15, 0) NULL,
	[Otros_Gastos_Asociados_Al_Contrato] [numeric](15, 0) NULL,
	[Cuenta_Contable_Otros_Gastos] [numeric](15, 0) NULL,
	[Otros_Ingresos_Asociados_Al_Contrato] [numeric](15, 0) NULL,
	[Cuenta_Contable_Otros_Ingresos] [numeric](15, 0) NULL,
	[Montos_Pagos_Al_Exterior_Efectuados] [numeric](15, 0) NULL,
	[Modalidad_Pago_Al_Exterior_Efectuados] [numeric](1, 0) NULL,
	[Saldo_Garantias_Al_Cierre] [numeric](15, 0) NULL,
	[Rut_Cliente_Emp] [numeric](13, 0) NULL,
	[Codigo_Cliente_Emp] [numeric](8, 0) NULL,
	[Modalidad_Cumplimiento_Emp] [varchar](1) NULL,
	[Posicion_Declarante_Emp] [varchar](1) NULL,
	[Producto_Emp] [varchar](5) NULL,
	[Moneda_transada_Emp] [numeric](5, 0) NULL,
	[moneda_compensacion_Emp] [numeric](5, 0) NULL,
	[Fecha_Curse_Contrato_Emp] [datetime] NULL,
	[Estado_Cliente] [varchar](40) NULL,
	[Subyacente_Papeles_de_RentaFija] [varchar](15) NULL,
	[Unidad_Precio_Subyacente_Emp] [numeric](5, 0) NULL,
	[Pais_Recidencia_Contraparte_Emp] [numeric](5, 0) NULL,
	[cacalcmpdol_Emp] [numeric](5, 0) NULL,
	[Moneda_Multiplica_Divide_Emp] [varchar](1) NULL,
	[Moneda_Conversion_Emp] [numeric](5, 0) NULL,
	[Modulo] [varchar](10) NOT NULL,
	[Precio_Fecha_Evento] [float] NULL,
	[Precio_Fecha_Cierre_Ejercicio] [float] NULL,
	[Monto_Pagado_MO_Al_Vcto_Compensado] [numeric](15, 0) NULL,
	[Monto_Pagado_CLP_Al_Vcto_Compensado] [numeric](15, 0) NULL,
	[Moneda_Vcto_Compensado] [numeric](15, 0) NULL,
	[Monto_Pagado_MO_Al_Anticipar] [float] NULL,
	[Monto_Pagado_CLP_Al_Anticipar] [float] NULL,
	[Moneda_Anticipar] [numeric](5, 0) NULL,
	[Monto_Pagado_MO_Al_Ejercer] [numeric](15, 0) NULL,
	[Monto_Pagado_CLP_Al_Ejercer] [numeric](15, 0) NULL,
	[Moneda_Ejercer] [numeric](5, 0) NULL,
	[Valor_Justo_Al_Evento] [numeric](15, 0) NULL,
	[Valor_Justo_Al_Cierre] [numeric](15, 0) NULL,
	[Valor_Justo_Al_CierreAnoAnt] [numeric](15, 0) NULL,
	[CVOpcion] [varchar](1) NULL,
	[CallPut] [varchar](4) NULL,
	[Tasa_Mercado_Al_Evento] [float] NULL,
	[Tasa_Mercado_Al_Cierre] [float] NULL,
	[Prima_Total_MO] [float] NULL,
	[Prima_Total_CLP] [float] NULL,
	[KeyCntId_sistema] [varchar](3) NOT NULL,
	[KeyCntProducto] [varchar](3) NULL,
	[KeyCntTipOper] [varchar](1) NULL,
	[KeyCntCallPut] [varchar](4) NULL,
	[KeyCntMoneda2] [varchar](5) NULL,
	[KeyCntMoneda1] [varchar](5) NULL,
	[KeyCntModalidad] [varchar](1) NULL,
	[KeyCntCarNormativa] [varchar](1) NULL,
	[KeyCntSubCarNormativa] [varchar](1) NULL,
	[CntPagoEvento] [numeric](15, 0) NULL,
	[CntCtaResultadoPos] [varchar](9) NULL,
	[CntCtaVRPos] [varchar](9) NULL,
	[CntCtaResultadoNeg] [varchar](9) NULL,
	[CntCtaVRNeg] [varchar](9) NULL,
	[CaNumEstructura] [int] NOT NULL,
	[VR_Al_1er_Dia_Ano] [float] NULL,
	[VR_AL_1er_Dia_Ano_Sig] [float] NULL,
	[Vigente_CierreAnoAnt] [varchar](1) NOT NULL,
	[Vigente_CierreAno] [varchar](1) NOT NULL,
	[CntCtaCarVRPos] [varchar](9) NULL,
	[CntCtaCarVRNeg] [varchar](9) NULL,
	[FolioEvento] [int] NULL,
	[CorrelativoGeneral] [int] NOT NULL,
	[Rut_Chileno] [numeric](13, 0) NULL,
	[Vigente_Corte_Inicial] [varchar](1) NOT NULL,
	[Monto_Util_PERD_CLP] [float] NULL,
	[ParCuentaVR] [varchar](19) NULL,
	[AVR_Cierre] [float] NULL,
	[AVR_Cierre_Ant] [float] NULL,
	[ParCuentaLiq] [varchar](19) NULL,
	[Total_Pagos_Acum] [float] NULL,
	[Total_Pagos_Mes] [float] NULL,
	[ParCuentaCarVR] [varchar](19) NULL,
	[Valida_VR] [varchar](12) NOT NULL,
	[Cta_Car_VR] [varchar](9) NULL,
	[Debe_VR] [numeric](15, 0) NULL,
	[Haber_VR] [numeric](15, 0) NULL,
	[Valida_Resultado_VR] [varchar](12) NOT NULL,
	[Cta_VR_Inicial] [varchar](9) NULL,
	[Debe_VR_Inicial] [numeric](15, 0) NULL,
	[Haber_VR_Inicial] [numeric](15, 0) NULL,
	[RectificacionNro] [numeric](5, 0) NULL,
	[RectificacionFecha] [datetime] NULL
) ON [PRIMARY]
GO
