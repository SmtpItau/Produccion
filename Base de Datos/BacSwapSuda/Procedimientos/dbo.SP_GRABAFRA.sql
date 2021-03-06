USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAFRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAFRA](     
	@Numero_Operacion  NUMERIC       (009)  ,  
       	                       	      @Cartera_Inversion INTEGER 		,
        	                      @Tipo_Operacion    CHAR	       (001) 	,
                	              @Moneda            INTEGER 		,
                        	      @Codigo_Cliente    NUMERIC       (009)	,
	                              @rut_Cliente       NUMERIC       (010) 	,
        	                      @Capital           FLOAT 			,
                	              @fecContrato       CHAR	       (008) 	,
                        	      @fecLiquida        CHAR	       (008) 	,
	                              @fecInicio         CHAR	       (008)	,
	                              @fecTermino        CHAR	       (008) 	,
        	                      @Tasa              INTEGER 		,
                	              @iPeriodo          INTEGER 		,
                        	      @mPeriodo          INTEGER 		,
        	                      @TasaContrato      FLOAT 			,
                	              @MonedaPago        INTEGER 		,
	                              @Forma_Pago        INTEGER 		,
        	                      @Usuario           CHAR	       (010) 	,
				      @Operador_Cliente	 NUMERIC       (010)	,		
				      @Observaciones   	 VARCHAR       (255) 	,
	@Hora   CHAR        (008) = '00:00:00'  
					)
WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON


DECLARE @Tipo_Swap 	  INTEGER

SELECT @Tipo_Swap = 3      -- Segun Tabla General (MDTC) 3=FRA


BEGIN TRANSACTION

      ----<< Agregando a Cartera y Movimiento Diario
      IF @Numero_Operacion = 0 
      BEGIN
           --<< Capturando Correlativo
           SELECT @Numero_Operacion = numero_operacion + 1 from SwapGeneral

           IF @Numero_Operacion = 0 OR @Numero_Operacion IS NULL
           BEGIN
                ROLLBACK TRANSACTION
                SELECT 'Error' = -1, 'Mensaje' = 'No se pudo capturar Numero de Operacion'
                RETURN
           END
                         
           UPDATE SwapGeneral SET numero_operacion = numero_operacion + 1 

           IF @@error <> 0
           BEGIN
                ROLLBACK TRANSACTION
                SELECT 'Error' = -1, 'Mensaje' = 'No se pudo Actualizar Correlativo de Operaciones'
                RETURN
           END

           INSERT INTO MovDiario( numero_operacion,numero_flujo, tipo_swap, estado_flujo,Hora)
                        VALUES(@Numero_Operacion,           0,@Tipo_Swap,         0,@Hora)

           IF @@error <> 0
           BEGIN
                ROLLBACK TRANSACTION
                SELECT 'Error' = -1, 'Mensaje' = 'No se pudo Agregar Operacion a Movimiento Diario'
                RETURN
           END


           --<< Insertando Operación
           INSERT INTO Cartera( numero_operacion,numero_flujo, tipo_swap,estado,estado_flujo,Hora)
                        VALUES(@Numero_Operacion,           0,@Tipo_Swap,    '',           0,@Hora)

           IF @@error <> 0
           BEGIN
                ROLLBACK TRANSACTION
                SELECT 'Error' = -1, 'Mensaje' = 'No se pudo Agregar Operacion a la Cartera'
                RETURN
           END

      END

      --<< Actualizando Operacion
      UPDATE MovDiario
         SET numero_operacion      = @Numero_Operacion    ,
             numero_flujo          = 0                    ,
             tipo_swap             = @Tipo_Swap           ,
             cartera_inversion     = @Cartera_Inversion   ,
             tipo_operacion        = @Tipo_Operacion      ,
             codigo_cliente        = @Codigo_Cliente      ,
             rut_cliente	   = @rut_Cliente      ,
             fecha_cierre          = @fecContrato         ,
             fecha_inicio          = @fecContrato         ,
             fecha_termino         = @fecLiquida          ,
             fecha_inicio_flujo    = @fecInicio           ,
             fecha_vence_flujo     = @fecTermino          ,

             compra_moneda         = @Moneda              ,
             compra_capital        = @Capital             ,
             compra_amortiza       = @Capital             ,
             compra_saldo          = 0                    ,
             compra_interes        = 0                    ,
             compra_spread         = 0                    ,
             compra_codigo_tasa    = @Tasa                ,
             compra_valor_tasa     = @TasaContrato        ,
             compra_valor_tasa_hoy = @TasaContrato        ,
             compra_codamo_capital = 0                    ,
             compra_mesamo_capital = 0                    ,
             compra_codamo_interes = @iPeriodo            ,
             compra_mesamo_interes = @mPeriodo            ,
             compra_base           = 360                  ,

             venta_moneda          = @Moneda              ,
             venta_capital         = @Capital             ,
             venta_amortiza        = @Capital             ,
             venta_saldo           = 0                    ,
             venta_interes         = 0                    ,
             venta_spread          = 0                    ,
             venta_codigo_tasa     = @Tasa                ,
             venta_valor_tasa      = @TasaContrato        ,
             venta_valor_tasa_hoy  = @TasaContrato        ,
             venta_codamo_capital  = 0                    ,
             venta_mesamo_capital  = 0                    ,
             venta_codamo_interes  = @iPeriodo            ,
             venta_mesamo_interes  = @mPeriodo            ,
             venta_base            = 360                  ,

             modalidad_pago        = 'C'                  ,

             pagamos_moneda        = @MonedaPago          ,
             pagamos_documento     = @Forma_Pago          ,
             pagamos_monto         = 0                    ,
             pagamos_monto_USD     = 0                    ,
             pagamos_monto_CLP     = 0                    ,

             recibimos_moneda      = @MonedaPago          ,
             recibimos_documento   = @Forma_Pago          ,
             recibimos_monto       = 0                    ,
             recibimos_monto_USD   = 0                    ,
             recibimos_monto_CLP   = 0                    ,

             operador              = @Usuario            ,
             operador_cliente      = @Operador_Cliente    ,

             estado_flujo          = 1                    ,  -- segun tablas generales 1=Vigente
             observaciones         = @Observaciones       ,
             fecha_modifica        = @fecContrato         ,
	     tipo_flujo		   = 1
       WHERE numero_operacion = @numero_operacion

      IF @@error <> 0
      BEGIN
           ROLLBACK TRANSACTION
           SELECT 'Error' = -1, 'Mensaje' = 'No se pudo Actualizar Operacion en Movimiento Diario'
           RETURN
      END



      --<< Actualizando Operacion en Cartera
      UPDATE Cartera
         SET numero_operacion      = @Numero_Operacion    ,
             numero_flujo          = 0                    ,
             tipo_swap             = @Tipo_Swap           ,
             cartera_inversion     = @Cartera_Inversion   ,
             tipo_operacion        = @Tipo_Operacion      ,
             codigo_cliente        = @Codigo_Cliente      ,
             rut_cliente	   = @rut_Cliente      ,
             fecha_cierre          = @fecContrato         ,
             fecha_inicio          = @fecContrato         ,
             fecha_termino         = @fecLiquida          ,
             fecha_inicio_flujo    = @fecInicio           ,
             fecha_vence_flujo     = @fecTermino          ,

             compra_moneda         = @Moneda              ,
             compra_capital        = @Capital             ,
             compra_amortiza       = @Capital             ,
             compra_saldo          = 0                    ,
             compra_interes        = 0                    ,
             compra_spread   = 0                    ,
             compra_codigo_tasa    = @Tasa                ,
             compra_valor_tasa     = @TasaContrato        ,
             compra_valor_tasa_hoy = @TasaContrato        ,
             compra_codamo_capital = 0                    ,
             compra_mesamo_capital = 0                    ,
             compra_codamo_interes = @iPeriodo            ,
             compra_mesamo_interes = @mPeriodo            ,
             compra_base           = 360                  ,

             venta_moneda          = @Moneda              ,
             venta_capital         = @Capital             ,
             venta_amortiza        = @Capital             ,
             venta_saldo           = 0                    ,
             venta_interes         = 0                    ,
             venta_spread          = 0                    ,
             venta_codigo_tasa     = @Tasa                ,
             venta_valor_tasa      = @TasaContrato        ,
             venta_valor_tasa_hoy  = @TasaContrato        ,
             venta_codamo_capital  = 0                    ,
             venta_mesamo_capital  = 0                    ,
             venta_codamo_interes  = @iPeriodo            ,
             venta_mesamo_interes  = @mPeriodo            ,
             venta_base            = 360                  ,

             modalidad_pago        = 'C'                  ,

             pagamos_moneda        = @MonedaPago          ,
             pagamos_documento     = @Forma_Pago          ,
             pagamos_monto         = 0                    ,
             pagamos_monto_USD     = 0                    ,
             pagamos_monto_CLP     = 0                    ,

             recibimos_moneda      = @MonedaPago          ,
             recibimos_documento   = @Forma_Pago          ,
             recibimos_monto       = 0                    ,
             recibimos_monto_USD   = 0                    ,
             recibimos_monto_CLP   = 0                    ,

             operador              = @Usuario            ,
             operador_cliente      = @Operador_Cliente    ,

             estado_flujo          = 1                    ,  -- segun tablas generales 1=Vigente
             observaciones         = @Observaciones       ,
             fecha_modifica        = @fecContrato         ,
	     tipo_flujo		   = 1
       WHERE numero_operacion = @numero_operacion

      IF @@error <> 0
      BEGIN
           ROLLBACK TRANSACTION
           SELECT 'Error' = -1, 'Mensaje' = 'No se pudo Actualizar Operacion en Cartera'
           RETURN
      END


      SELECT @numero_operacion

COMMIT TRANSACTION

END
GO
