USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_CARTERA_SWAP]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_CARTERA_SWAP]
AS
SELECT numero_operacion,numero_flujo,tipo_flujo,tipo_swap,cartera_inversion,tipo_operacion,codigo_cliente,
       rut_cliente,fecha_cierre,fecha_inicio,fecha_termino,fecha_inicio_flujo,fecha_vence_flujo,fecha_fijacion_tasa,
       compra_moneda,compra_capital,compra_amortiza,compra_saldo,compra_interes,compra_spread,compra_codigo_tasa,
       compra_valor_tasa,compra_valor_tasa_hoy,compra_codamo_capital,compra_mesamo_capital,compra_codamo_interes,
       compra_mesamo_interes,compra_base,venta_moneda,venta_capital,venta_amortiza,venta_saldo,venta_interes,
       venta_spread,venta_codigo_tasa,venta_valor_tasa,venta_valor_tasa_hoy,venta_codamo_capital,venta_mesamo_capital,
       venta_codamo_interes,venta_mesamo_interes,venta_base,operador,operador_cliente,estado_flujo,modalidad_pago,
       pagamos_moneda,pagamos_documento,pagamos_monto,pagamos_monto_USD,pagamos_monto_CLP,recibimos_moneda,
       recibimos_documento,recibimos_monto,recibimos_monto_USD,recibimos_monto_CLP,observaciones,fecha_modifica,
       devengo_dias,devengo_monto,devengo_monto_peso,devengo_monto_acum,devengo_monto_ayer,devengo_compra,
       devengo_compra_acum,devengo_compra_acum_peso,devengo_compra_ayer,devengo_compra_ayer_peso,devengo_venta,
       devengo_venta_acum,devengo_venta_acum_peso,devengo_venta_ayer,devengo_venta_ayer_peso,fecha_valoriza,
       compra_zcr,compra_mercado_tasa,compra_mercado,compra_mercado_usd,compra_mercado_clp,compra_duration_tasa,
       compra_duration_monto,compra_duration_monto_usd,compra_duration_monto_clp,compra_valor_presente,venta_zcr,
       venta_mercado_tasa,venta_mercado,venta_mercado_usd,venta_mercado_clp,venta_duration_tasa,venta_duration_monto,
       venta_duration_monto_usd,venta_duration_monto_clp,venta_valor_presente,monto_mtm,monto_mtm_usd,monto_mtm_clp,
       compra_valorizada,compra_variacion,venta_valorizada,venta_variacion,valorizacion_dia,estado,Estado_oper_lineas,
       Observacion_Lineas,Observacion_Limites,Especial,Codigo_Subproducto,Hora,keyid_desk_manager,libro_desk_manager,
       numero_pu,Pais,Plaza,Codigo_Area,Tasa_Anticipo,Resultado_Anticipo,Spot_Referencial,Fixing_USD,
       Referencial_Interes,Factor,Resultado_Factor,Gana_Mayor_Cero,diferido_super,devengo_hoy_super,reajuste,
       paridad_referencial,Cobertura,numero_op_extra,fecha_genera_anticipo,capital_rebajado
FROM trader..VIEW_CARTERA_SWAP




GO
