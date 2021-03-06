USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULAOPERSWAPS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ANULAOPERSWAPS]
   (   @numoperacion    NUMERIC(10)
   ,   @Hora  CHAR(08)   = '00:00:00'  
   )

AS
BEGIN
   SET NOCOUNT ON
   /*=======================================================================*/
   /*    Inicio de transaccion del proceso de Anulacion			    */
   /*=======================================================================*/

   DECLARE @ncodpos1    NUMERIC(02)
   DECLARE @ncodmda1    NUMERIC(03)
   DECLARE @ncodsuc1    NUMERIC(03)
   DECLARE @ncodpos2    NUMERIC(02)
   DECLARE @ncodmda2    NUMERIC(03)
   DECLARE @ctipoper    CHAR(01)
   DECLARE @dfecvcto    DATETIME

   
   /*=======================================================================*/
   /* Eliminar operación de CarteraLog                                 */
   /*=======================================================================*/
   DELETE FROM CARTERALOG
	   WHERE numero_operacion = @numoperacion


   /*=======================================================================*/

   /* Graba en Cartera Log						    */

   /*=======================================================================*/



   INSERT INTO CARTERALOG (

		numero_operacion  	,

       	numero_flujo      	,

		tipo_flujo			,

        tipo_swap	  		,

		cartera_inversion 	,

	  	tipo_operacion	  	,

		codigo_cliente	  	,

		rut_cliente			,

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

		Hora

		,  bEarlyTermination

		,  FechaInicio

		,  Periodicidad

		,  log_area_responsable

		,  log_cartera_normativa

		,  log_subcartera_normativa

		,  log_libro

                )

         SELECT numero_operacion  	,

        	numero_flujo      	,

	        tipo_flujo			,

			tipo_swap	  	,

		cartera_inversion 	,

	  	tipo_operacion	  	,

		codigo_cliente	  	,

		rut_cliente			,

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

		'A'			,

		@Hora

		,  bEarlyTermination

		,  FechaInicio

		,  Periodicidad

		,  car_area_responsable

		,  car_cartera_normativa

		,  car_subcartera_normativa

		,  car_libro


       FROM     CARTERA

       WHERE    numero_operacion = @numoperacion



   IF @@ERROR <> 0

   BEGIN

      SELECT -1, 'Error: al grabar tabla de Cartera Log.'  

      SET NOCOUNT OFF

      RETURN

   END



   /*=======================================================================*/

   /* Eliminar operaci¢n de Cartera                                 */

   /*=======================================================================*/

   DELETE FROM CARTERA

   WHERE numero_operacion = @numoperacion



	IF @@ERROR <> 0

	BEGIN

		SELECT -1, 'Error: al Eliminar Operacion de Cartera.'  

		SET NOCOUNT OFF

		RETURN

	END



   /*=======================================================================*/

   /* Eliminar operaci¢n de Movimiento Diario                               */

   /*=======================================================================*/

   DELETE FROM MOVDIARIO

         WHERE numero_operacion = @numoperacion



   IF @@ERROR <> 0

   BEGIN

      SELECT -1, 'Error: al Eliminar Operacion desde Movimiento Diario.'  

      SET NOCOUNT OFF

      RETURN

   END





   -- Eliminación de Coberturas --

   DECLARE @MiDerivado   NUMERIC(9)



   SELECT  @MiDerivado    = 0.0

   SELECT  @MiDerivado    = isnull(nCobertura,0.0)

     FROM  BacTraderSuda..COBERTURAS WITH (NoLock)

    WHERE  cModulo        = 'PCS' 

      AND  nDerivado      = @numoperacion



   DELETE BacTraderSuda..DETALLE_COBERTURAS 

   WHERE  nCobertura = @MiDerivado



   IF @@ERROR <> 0

   BEGIN

      SELECT -1, 'Error: al Eliminar Detalle de la Cobertura.'

      RETURN 

   END



   DELETE BacTraderSuda..COBERTURAS         

   WHERE  nCobertura = @MiDerivado



   IF @@ERROR <> 0

   BEGIN

      SELECT -1, 'Error: al Eliminar Cobertura.'

      RETURN 

   END

   -- Eliminación de Coberturas --

   /*=======================================================================*/

   /*    Anulación de Registro de Garantías (PRD-5521)                                                              */

   /*=======================================================================*/

   IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_registro_garantias

		WHERE Sistema = 'PCS' AND OperacionSistema = @numoperacion)

   BEGIN

	/* Ver si hay candidatos a eliminar en tbl_Garantias_Faltantes */

	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Garantias_Faltantes

		WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias

		WHERE Sistema  = 'PCS' AND OperacionSistema = @numOperacion))

			

		DELETE Bacparamsuda..tbl_Garantias_Faltantes

		WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias

		  WHERE Sistema = 'PCS' AND OperacionSistema = @numOperacion)

	

	/* Continuar con el proceso de eliminación del registro de garantías */

	DELETE Bacparamsuda..tbl_registro_garantias

	WHERE Sistema = 'PCS' AND OperacionSistema = @numoperacion

	IF @@ERROR <> 0

	BEGIN

		SELECT -1, 'Error al eliminar Registro de Garantías.'

		RETURN

	END

   END

   ---- Fin anulación de Registro de Garantías



   /*=======================================================================*/

   /* Fin Transaccion, se hacen efectivos los cambios en las tablas         */

   /*=======================================================================*/

   SELECT 'OK'

   SET NOCOUNT OFF

END
GO
