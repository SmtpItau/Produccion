USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICASWAPS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MODIFICASWAPS]( @numoperacion   NUMERIC(10) ,  
                                       @FechaModif     DATETIME    ,
				       @Hora	       Char   (08) = '00:00:00'
				       )
AS
BEGIN
-- Swap: Guardar Como
SET NOCOUNT ON      --ADO

   /*=======================================================================*/
   /* Graba en Cartera Log						    */
   /*=======================================================================*/
   INSERT INTO CarteraLog (
		numero_operacion  	,
        	numero_flujo      	,
	        tipo_swap	  	,
		cartera_inversion 	,
	  	tipo_operacion	  	,
		codigo_cliente	  	,
		fecha_cierre	  	,
		fecha_inicio	  	,
		fecha_termino	  	,
		fecha_inicio_flujo  	,
		fecha_vence_flujo  	,
		compra_moneda		,
		compra_capital		,
		compra_amortiza		,
		compra_saldo		,
		compra_interes		,
		compra_spread		,
		compra_codigo_tasa	,
		compra_valor_tasa	,
		compra_valor_tasa_hoy	,
		compra_codamo_capital	,
		compra_mesamo_capital	,
		compra_codamo_interes	,
		compra_mesamo_interes	,
		compra_base		,
		venta_moneda		,
		venta_capital		,
		venta_amortiza		,
		venta_saldo		,
		venta_interes		,
		venta_spread		,
		venta_codigo_tasa	,
		venta_valor_tasa	,
		venta_valor_tasa_hoy	,
		venta_codamo_capital	,
		venta_mesamo_capital	,
		venta_codamo_interes	,
		venta_mesamo_interes	,
		venta_base		,
		operador		,
		operador_cliente	,
		estado_flujo		,
		modalidad_pago		,
		pagamos_moneda		,
		pagamos_documento	,
		pagamos_monto		,
		pagamos_monto_USD	,
		pagamos_monto_CLP	,
		recibimos_moneda	,
		recibimos_documento	,
		recibimos_monto		,
		recibimos_monto_USD	,
		recibimos_monto_CLP	,
		observaciones		,
	        fecha_modifica		,
		estado			,
		Hora			,
		log_area_responsable	,
		log_Cartera_normativa	,
		log_subcartera_normativa,
		log_libro 
		--> PRD 12712
		,  bEarlyTermination
		,  FechaInicio
		,  Periodicidad
                )
          SELECT
		numero_operacion  	,
        	numero_flujo      	,
	        tipo_swap	  	,
		cartera_inversion 	,
	  	tipo_operacion	  	,
		codigo_cliente	  	,
		fecha_cierre	  	,
		fecha_inicio	  	,
		fecha_termino	  	,
		fecha_inicio_flujo  	,
		fecha_vence_flujo  	,
		compra_moneda		,
		compra_capital		,
		compra_amortiza		,
		compra_saldo		,
		compra_interes		,
		compra_spread		,
		compra_codigo_tasa	,
		compra_valor_tasa	,
		compra_valor_tasa_hoy	,
		compra_codamo_capital	,
		compra_mesamo_capital	,
		compra_codamo_interes	,
		compra_mesamo_interes	,
		compra_base		,
		venta_moneda		,
		venta_capital		,
		venta_amortiza		,
		venta_saldo		,
		venta_interes		,
		venta_spread		,
		venta_codigo_tasa	,
		venta_valor_tasa	,
		venta_valor_tasa_hoy	,
		venta_codamo_capital	,
		venta_mesamo_capital	,
		venta_codamo_interes	,
		venta_mesamo_interes	,
		venta_base		,
		operador		,
		operador_cliente	,
		estado_flujo		,
		modalidad_pago		,
		pagamos_moneda		,
		pagamos_documento	,
		pagamos_monto		,
		pagamos_monto_USD	,
		pagamos_monto_CLP	,
		recibimos_moneda	,
		recibimos_documento	,
		recibimos_monto		,
		recibimos_monto_USD	,
		recibimos_monto_CLP	,
		observaciones		,
	        @fechaModif		,
		'M'			,
		@Hora			,
		car_area_responsable	,
		car_Cartera_normativa	,
		car_subcartera_normativa,
		car_libro 
		--> PRD 12712
		,  bEarlyTermination
		,  FechaInicio
		,  Periodicidad
       FROM     Cartera
       WHERE    numero_operacion = @numoperacion 
                and estado <> 'C'


   /*=======================================================================*/
   /* Eliminar operaci¢n de Cartera                                         */
   /*=======================================================================*/
   DELETE FROM Cartera WHERE numero_operacion = @numoperacion and Estado <> 'C'


   /*=======================================================================*/
   /* Eliminar operaci¢n de Movimiento Diario                               */
   /*=======================================================================*/
   DELETE FROM MovDiario WHERE numero_operacion = @numoperacion --and Estado <> 'C'

SET NOCOUNT OFF      --ADO

END

GO
