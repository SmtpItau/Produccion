USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAMOVIMIENTOSSWAPS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAMOVIMIENTOSSWAPS]  
   (    @actualizar		Numeric(1,0) 	,
	@numoperacion    	Numeric(7,0) 	,
        @numeroflujo      	NUMERIC(3,0) 	,  
        @tipoflujo      	NUMERIC(1,0) 	,  
        @tiposwap	  	NUMERIC(1,0) 	,
	@carterainversion 	NUMERIC(1,0) 	,
  	@tipooperacion	  	CHAR(1)      	,
	@codigocliente	  	NUMERIC(9,0) 	,
	@rutcliente	  	NUMERIC(9,0) 	,
	@fechacierre	  	DATETIME     	,
	@fechainicio	  	DATETIME     	,
	@fechatermino	  	DATETIME     	,
	@fechainicioflujo  	DATETIME     	,
	@fechavenceflujo  	DATETIME     	,
	@compramoneda		NUMERIC(3,0)	,
	@compracapital		NUMERIC(19,4)	,
	@compraamortiza		NUMERIC(19,4)	,
	@comprasaldo		NUMERIC(19,4)	,
	@comprainteres		NUMERIC(19,4)	,	
	@compraspread		NUMERIC(10,6)	,
	@compracodigotasa	NUMERIC(3,0)	,
	@compravalortasa	NUMERIC(10,6)	,
	@compravalortasa_hoy	NUMERIC(10,6)	,
	@compracodamocapital	NUMERIC(3,0)	,
	@compramesamocapital	NUMERIC(3,0)	,
	@compracodamointeres	NUMERIC(3,0)	,
	@compramesamointeres	NUMERIC(3,0)	,
	@comprabase		NUMERIC(3,0)	,	
	@ventamoneda		NUMERIC(3,0)	,
	@ventacapital		NUMERIC(19,4)	,
	@ventaamortiza		NUMERIC(19,4)	,
	@ventasaldo		NUMERIC(19,4)	,
	@ventainteres		NUMERIC(19,4)	,
	@ventaspread		NUMERIC(10,6)	,
	@ventacodigotasa	NUMERIC(3,0)	,
	@ventavalortasa		NUMERIC(10,6)	,
	@ventavalortasahoy	NUMERIC(10,6)	,
	@ventacodamocapital	NUMERIC(3,0)	,
	@ventamesamocapital	NUMERIC(3,0)	,
	@ventacodamointeres	NUMERIC(3,0)	,
	@ventamesamointeres	NUMERIC(3,0)	,
	@ventabase		NUMERIC(3,0)	,
	@operador		CHAR(10)	,
	@operadorcliente	numeric(9,0)	,
	@estadoflujo		NUMERIC(1,0)	,
	@modalidadpago		CHAR(1)		,
	@pagamosmoneda		NUMERIC(3,0)	,	
	@pagamosdocumento	NUMERIC(3,0)	,
	@pagamosmonto		NUMERIC(19,4)	,
	@pagamosmontoUSD	NUMERIC(19,4)	,
	@pagamosmontoCLP	NUMERIC(19,4)	,
	@recibimosmoneda	NUMERIC(3,0)	,
	@recibimosdocumento	NUMERIC(3,0)	,
	@recibimosmonto		NUMERIC(19,4)	,
	@recibimosmontoUSD	NUMERIC(19,4)	,
	@recibimosmontoCLP	NUMERIC(19,4)	,
	@observaciones		CHAR(99)	,
      	@fechamodifica	  	CHAR(8)		,
	@montoCom_usd		NUMERIC(19,4)	,
	@montoCom_clp		NUMERIC(19,4)	,
	@montoVen_usd		NUMERIC(19,4)	,
	@montoVen_clp		NUMERIC(19,4)	,
        @especial               INTEGER         ,
        @fechafijaciontasa      DATETIME	,
	@Hora_Operacion  Char (15) = '00:00:00',  
        @ParidadCompra          NUMERIC(21,4) = 0.0,
        @ParidadVenta           NUMERIC(21,4) = 0.0,
	@Area_Responsable	CHAR(06)	= ''	,
	@Cartera_Normativa	CHAR(06)	= ''	,
	@SubCartera_Normativa	CHAR(06)	= ''	,
	@Libro			CHAR(06)	= ''	
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @HORA CHAR(08)
   SELECT  @hora = SUBSTRING(@Hora_Operacion,2,LEN(@Hora_Operacion)-2)

   IF @actualizar = 1 
   BEGIN                   -- Se actualizara la tabla movdiario cuando sea modificacion
                           -- de flujos del dia y cuando sea una nueva operacion
      /*=======================================================================*/
      /* Insertar el nuevo registro en la tabla de movimiento diario de swaps. */
      /*=======================================================================*/
      INSERT INTO MovDiario 
      (         numero_operacion  	,
                numero_flujo      	,
		tipo_flujo		,
	        tipo_swap	  	,
		cartera_inversion 	,
	  	tipo_operacion	  	,
		codigo_cliente	  	,
		rut_cliente	  	,
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
	        fecha_modifica	        ,
                especial                ,
                fecha_fijacion_tasa	,
                Estado_oper_lineas      ,
		Hora                    , 
                ParidadCompra           ,
                ParidadVenta            ,
		mov_area_responsable	,
		mov_Cartera_Normativa	,
		mov_subcartera_normativa,
		mov_libro		
	   )
	   VALUES
           (    @Numoperacion		,
		@numeroflujo      	,
		@tipoflujo		,
	        @tiposwap	  	,
		@carterainversion 	,
	  	@tipooperacion	  	,
		@codigocliente	  	,
		@rutcliente	  	,
		@fechacierre	  	,
		@fechainicio	  	,
		@fechatermino	  	,
		@fechainicioflujo  	,
		@fechavenceflujo  	,
		@compramoneda		,
		@compracapital		,
		@compraamortiza		,
		@comprasaldo		,
		@comprainteres		,
		@compraspread		,
		@compracodigotasa	,
		@compravalortasa	,
		@compravalortasa_hoy	,
		@compracodamocapital	,
		@compramesamocapital	,
		@compracodamointeres	,
		@compramesamointeres	,
		@comprabase		,
		@ventamoneda		,
		@ventacapital		,
		@ventaamortiza		,
		@ventasaldo		,
		@ventainteres		,
		@ventaspread		,
		@ventacodigotasa	,
		@ventavalortasa		,
		@ventavalortasahoy	,
		@ventacodamocapital	,
		@ventamesamocapital	,
		@ventacodamointeres	,
		@ventamesamointeres	,
		@ventabase		,
		@operador		,
		@operadorcliente	,
		@estadoflujo		,
		@modalidadpago		,
		@pagamosmoneda		,
		@pagamosdocumento	,
		@pagamosmonto		,
		@pagamosmontoUSD	,
		@pagamosmontoCLP	,
		@recibimosmoneda	,
		@recibimosdocumento	,
		@recibimosmonto		,
		@recibimosmontoUSD	,
		@recibimosmontoCLP	,
		@observaciones		,
	        @fechamodifica	  	,
                @especial               ,
                @fechafijaciontasa	,
                'P'                     ,
		@Hora                   ,
                @ParidadCompra          ,
                @ParidadVenta           ,
		@Area_Responsable	,
		@Cartera_Normativa	,
		@SubCartera_Normativa	,
		@Libro			
           ) 	

      /*=======================================================================*/
      /*=======================================================================*/
      IF @@error <> 0 
      BEGIN
         SELECT -1 , 'Error: al crear el nuevo registro en la tabla de movimiento diario.'
         SET NOCOUNT OFF         --ADO
         RETURN
      END

      /*=======================================================================*/
      /*   Ingreso de datos en cartera LOG	*/
      /*=======================================================================*/
      INSERT INTO CARTERALOG 
      (         numero_operacion  	,
        	numero_flujo      	,
		tipo_flujo		,
	        tipo_swap	  	,
		cartera_inversion 	,
	  	tipo_operacion	  	,
		codigo_cliente	  	,
		rut_cliente	  	,
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
		estado                  ,
                especial                ,
                fecha_fijacion_tasa	,
		Hora                    ,
		log_area_responsable	,
		log_Cartera_Normativa	,
		log_SubCartera_Normativa	,
		log_Libro			
	)
	VALUES
	(
		@Numoperacion		,  
		@numeroflujo      	,
		@tipoflujo		,
	        @tiposwap	  	,
		@carterainversion 	,
	  	@tipooperacion	  	,
		@codigocliente	  	,
		@rutcliente	  	,
		@fechacierre	  	,
		@fechainicio	  	,
		@fechatermino	  	,
		@fechainicioflujo  	,
		@fechavenceflujo  	,
		@compramoneda		,
		@compracapital		,
		@compraamortiza		,
		@comprasaldo		,
		@comprainteres		,
		@compraspread		,
		@compracodigotasa	,
		@compravalortasa	,
		@compravalortasa_hoy	,
		@compracodamocapital	,
		@compramesamocapital	,
		@compracodamointeres	,
		@compramesamointeres	,
		@comprabase		,
		@ventamoneda		,
		@ventacapital		,
		@ventaamortiza		,
		@ventasaldo		,
		@ventainteres		,
		@ventaspread		,
		@ventacodigotasa	,
		@ventavalortasa		,
		@ventavalortasahoy	,
		@ventacodamocapital	,
		@ventamesamocapital	,
		@ventacodamointeres	,
		@ventamesamointeres	,
		@ventabase		,
		@operador		,
		@operadorcliente	,
		@estadoflujo		,
		@modalidadpago		,
		@pagamosmoneda		,
		@pagamosdocumento	,
		@pagamosmonto		,
		@pagamosmontoUSD	,
		@pagamosmontoCLP	,
		@recibimosmoneda	,
		@recibimosdocumento	,
		@recibimosmonto		,
		@recibimosmontoUSD	,
		@recibimosmontoCLP	,
		@observaciones		,
	        @fechamodifica	  	,
		'I'                     ,
                @especial               ,
                @fechafijaciontasa	,
		@Hora			,
		@Area_Responsable	,
		@Cartera_Normativa	,
		@SubCartera_Normativa	,
		@Libro			
	) 	

      /*=======================================================================*/
      /*=======================================================================*/
      IF @@error <> 0 
      BEGIN
         SELECT -1 , 'Error: al crear el nuevo registro en la tabla CarteraLog.'
         SET NOCOUNT OFF         --ADO
         RETURN
      END
      /*=======================================================================*/
      /*=======================================================================*/
   END 
   
   /*=======================================================================*/
   /* Insertar el nuevo registro en la tabla Cartera de Operacion de SWAPS. */
   /*=======================================================================*/
   INSERT INTO  CARTERA
   (            numero_operacion  	,
        	numero_flujo      	,
		tipo_flujo		,
	        tipo_swap	  	,
		cartera_inversion 	,
	  	tipo_operacion	  	,
		codigo_cliente	  	,
		rut_cliente	  	,
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
	        fecha_modifica	        ,
                especial                ,
                fecha_fijacion_tasa	,
		Estado_oper_lineas	,
		Hora			,
		car_Area_Responsable	,
		car_Cartera_Normativa	,
		car_SubCartera_Normativa	,
		car_Libro			
	)
	VALUES
	(       @Numoperacion		,  
		@numeroflujo      	,
		@tipoflujo		,
	        @tiposwap	  	,
		@carterainversion 	,
	  	@tipooperacion	  	,
		@codigocliente	  	,
		@rutcliente	  	,
		@fechacierre	  	,
		@fechainicio	  	,
		@fechatermino	  	,
		@fechainicioflujo  	,
		@fechavenceflujo  	,
		@compramoneda		,
		@compracapital		,
		@compraamortiza		,
		@comprasaldo		,
		@comprainteres		,
		@compraspread		,
		@compracodigotasa	,
		@compravalortasa	,
		@compravalortasa_hoy	,
		@compracodamocapital	,
		@compramesamocapital	,
		@compracodamointeres	,
		@compramesamointeres	,
		@comprabase		,
		@ventamoneda		,
		@ventacapital		,
		@ventaamortiza		,
		@ventasaldo		,
		@ventainteres		,
		@ventaspread		,
		@ventacodigotasa	,
		@ventavalortasa		,
		@ventavalortasahoy	,
		@ventacodamocapital	,
		@ventamesamocapital	,
		@ventacodamointeres	,
		@ventamesamointeres	,
		@ventabase		,
		@operador		,
		@operadorcliente	,
		@estadoflujo		,
		@modalidadpago		,
		@pagamosmoneda		,
		@pagamosdocumento	,
		@pagamosmonto		,
		@pagamosmontoUSD	,
		@pagamosmontoCLP	,
		@recibimosmoneda	,
		@recibimosdocumento	,
		@recibimosmonto		,
		@recibimosmontoUSD	,
		@recibimosmontoCLP	,
		@observaciones		,
	        @fechamodifica	  	,
                @especial               ,
                @fechafijaciontasa	,
		'P'			,
		@Hora			,
		@Area_Responsable	,
		@Cartera_Normativa	,
		@SubCartera_Normativa	,
		@Libro			
      ) 	

      /*=======================================================================*/
      /*=======================================================================*/
      IF @@error <> 0 
      BEGIN
         SELECT -1 , 'Error: al crear el nuevo registro en la tabla Cartera.'
         SET NOCOUNT OFF         --ADO
         RETURN
      END
      /*=======================================================================*/
      /*=======================================================================*/

      /*=======================================================================*/
      /* Insertar el nuevo registro en la tabla CARTERALOG de Operacion de SWAPS. */
      /*=======================================================================*/
      SELECT  'OK'
      SET NOCOUNT OFF
END
GO
