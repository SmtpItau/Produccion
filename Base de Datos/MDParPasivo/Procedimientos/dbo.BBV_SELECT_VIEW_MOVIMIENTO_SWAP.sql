USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_SWAP]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_SWAP]
AS
SELECT numero_operacion,numero_flujo,tipo_flujo,tipo_swap,cartera_inversion,tipo_operacion,codigo_cliente,rut_cliente,
       fecha_cierre,fecha_inicio,fecha_termino,fecha_inicio_flujo,fecha_vence_flujo,fecha_fijacion_tasa,compra_moneda,
       compra_capital,compra_amortiza,compra_saldo,compra_interes,compra_spread,compra_codigo_tasa,compra_valor_tasa,
       compra_valor_tasa_hoy,compra_codamo_capital,compra_mesamo_capital,compra_codamo_interes,compra_mesamo_interes,
       compra_base,venta_moneda,venta_capital,venta_amortiza,venta_saldo,venta_interes,venta_spread,venta_codigo_tasa,
       venta_valor_tasa,venta_valor_tasa_hoy,venta_codamo_capital,venta_mesamo_capital,venta_codamo_interes,
       venta_mesamo_interes,venta_base,operador,operador_cliente,estado_flujo,modalidad_pago,pagamos_moneda,
       pagamos_documento,pagamos_monto,pagamos_monto_USD,pagamos_monto_CLP,recibimos_moneda,recibimos_documento,
       recibimos_monto,recibimos_monto_USD,recibimos_monto_CLP,observaciones,fecha_modifica,Estado_oper_lineas,
       Observacion_Lineas,Observacion_Limites,Especial,Codigo_Subproducto,Impreso,keyid_desk_manager,libro_desk_manager,
       numero_pu,Pais,Plaza,Fecha_proceso,Codigo_Area,Spot_Referencial,Fixing_USD,Referencial_Interes,Factor,
       Gana_Mayor_Cero,Cobertura,numero_op_extra
 FROM VIEW_MOVIMIENTO_SWAP 
GO
