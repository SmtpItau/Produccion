USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZACION]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONTABILIZACION] 
       (
        @Fecha_Hoy      DATETIME
       )
AS
BEGIN

   SET NOCOUNT ON


   DECLARE @Control_Error		INTEGER
   DECLARE @Mensaje_Error          	VARCHAR(255)
   DECLARE @Numero_Voucher         	NUMERIC(10)
   DECLARE @Correlativo_Voucher    	NUMERIC(05)
   DECLARE @Tipo_Voucher           	CHAR(01)
   DECLARE @Existe		   	CHAR(01)

   DECLARE @ID_Sistema             	CHAR(03)
   DECLARE @Tipo_Movimiento        	CHAR(03)
   DECLARE @Tipo_Operacion         	CHAR(05)
   DECLARE @Operacion              	NUMERIC(10)
   DECLARE @Documento              	NUMERIC(10)
   DECLARE @Correlativo            		NUMERIC(05)
   DECLARE @Codigo_Instrumento     	CHAR(10)
   DECLARE @Moneda_Instrumento     	CHAR(06)
   DECLARE @Instrumento            	CHAR(12)
   DECLARE @Tipo_Perfil            		CHAR(01)
   DECLARE @Glosa_Perfil           	CHAR(70)
   DECLARE @Monto                  		FLOAT
   DECLARE @Total_Debe             	NUMERIC(19,04)
   DECLARE @Total_Haber            	NUMERIC(19,04)
   DECLARE @Folio_Perfil           		NUMERIC(05)

   DECLARE @Codigo_Campo           	NUMERIC(03)
   DECLARE @Tipo_Movimiento_Cuenta 	CHAR(01)
   DECLARE @Perfil_Fijo            		CHAR(01)
   DECLARE @Codigo_Cuenta          	CHAR(20)
   DECLARE @Correlativo_Perfil     	NUMERIC(03)
   DECLARE @Codigo_Campo_Variable  	NUMERIC(03)
   DECLARE @tipo_cliente	   	CHAR(1)
   DECLARE @fecha_proceso	   	CHAR(10)
   DECLARE @MonedaCuenta	   	NUMERIC(05)
   DECLARE @CtaCtbleCorr	   	CHAR(10)

   SELECT @Control_Error = 0
	SELECT @Mensaje_Error = ''

   /*===================================================================================================================*/
   /* Borra Voucher ya generados                                                                                        */
   /*===================================================================================================================*/

   DELETE bac_cnt_errores WHERE fecha_proceso = @Fecha_Hoy

	DELETE  bac_cnt_detalle_voucher
	FROM	bac_cnt_voucher a
	WHERE	a.numero_voucher = bac_cnt_detalle_voucher.numero_voucher 
	AND	a.fecha_ingreso  = @Fecha_Hoy
        AND   a.fecha_ingreso  = @Fecha_Hoy

   IF @@error <> 0 BEGIN
	  INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 1, 'CTB001: Fallo borrando encabezado Voucher' )
      RETURN

   END


   DELETE bac_cnt_voucher WHERE fecha_ingreso = @Fecha_Hoy

   IF @@error <> 0 BEGIN
	  INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 1, 'CTB002: Fallo Borrando detalle Voucher' )
      RETURN

   END

   /*================================================================================================================*/
	/* Busca el Número de Voucher a ocupar                                                                            */
   /*================================================================================================================*/
   SELECT @Numero_Voucher = ISNULL( MAX( Numero_Voucher ), 0 ) + 1 FROM bac_cnt_voucher

   EXECUTE @Control_Error = sp_llena_ctb_BonEx @Fecha_Hoy

 
   IF @Control_Error <> 0 BEGIN
	  INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 1, 'CTB003: Fallo el llenado de la tabla Movimientos Contables' )
      RETURN

   END

   /*=================================== =============================================================================*/
   /* Comienza contabilizacion                               												    */
   /*================================================================================================================*/


   DECLARE Cursor_Movimiento SCROLL CURSOR FOR
           SELECT   ID_Sistema,
                           Tipo_Movimiento,
                           Tipo_Operacion,
                           Operacion,
                           Correlativo,
                           Codigo_Instrumento,
		Moneda_Instrumento,
                           Instser,
		Documento,
		tipo_cliente,
		convert(char(10),fecha_proceso,112),
		ctacblecorresponsal				
                  FROM     bac_cnt_contabiliza_resumen
	     ORDER BY Operacion

   /*================================================================================================================*/
   /*================================================================================================================*/
   OPEN Cursor_Movimiento

   /*================================================================================================================*/
   /*================================================================================================================*/
   FETCH FIRST FROM Cursor_Movimiento
      INTO          	@ID_Sistema,
                    	@Tipo_Movimiento,
                    	@Tipo_Operacion,
                    	@Operacion,
                    	@Correlativo,
                    	@Codigo_Instrumento,
                    	@Moneda_Instrumento,
                    	@Instrumento,
                    	@Documento,
		@tipo_cliente,
		@fecha_proceso,
		@CtaCtbleCorr	

      WHILE @@fetch_status = 0 BEGIN
	SELECT @Mensaje_Error = ' Sistema (' + @ID_Sistema +
						  '), Tipo movimiento (' + @Tipo_Movimiento +
						  '), Tipo operacion (' + @Tipo_Operacion +
						  '), Instrumento (' + @Codigo_Instrumento +
						  '), Moneda (' + @Moneda_Instrumento +
						  '), Numero operacion (' + CONVERT( VARCHAR(10), @Operacion ) + 
						  '), Numero Voucher (' + CONVERT( VARCHAR(10), ISNULL( @Numero_Voucher, 0 ) ) +
						  '), Correlativo Voucher (' + CONVERT( VARCHAR(10), ISNULL( @Correlativo_Voucher, 0 ) ) + ')'

      SELECT       @Existe            = 'N'

      SELECT       @Existe            = 'S',
                   @Tipo_Voucher      = Tipo_Voucher,
                   @Glosa_Perfil      = Glosa_Perfil,
                   @Folio_Perfil      = Folio_Perfil
             FROM  VIEW_PERFIL_CNT
             WHERE ID_Sistema         = @ID_Sistema         AND
                   Tipo_Movimiento    = @Tipo_Movimiento    AND
                   Tipo_Operacion     = @Tipo_Operacion     AND
                   Codigo_Instrumento = @Codigo_Instrumento AND
                   Moneda_Instrumento = @Moneda_Instrumento

      IF @Existe = 'N'
      BEGIN

   	   INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB004: Perfil no existe.' + @Mensaje_Error )

      END
      ELSE      
      BEGIN
  	   SELECT @Mensaje_Error = @Mensaje_Error + ', Perfil (' + CONVERT( VARCHAR(10), @Folio_Perfil ) + ')'

           SELECT                Codigo_Campo		,
                                 	Tipo_Movimiento_Cuenta,
                                 	Perfil_Fijo		,
                                 	Codigo_Cuenta		,
                                 	Correlativo_Perfil		,
                                 	Codigo_Campo_Variable
                        INTO     #paso
                        FROM     VIEW_PERFIL_DETALLE_CNT
                        WHERE    Folio_Perfil = @Folio_Perfil
                ORDER BY Folio_Perfil, Correlativo_Perfil


         DECLARE Cursor_Detalle SCROLL CURSOR FOR
                 SELECT         Codigo_Campo		,
                                 	Tipo_Movimiento_Cuenta,
			Perfil_Fijo		,
     			Codigo_Cuenta		,
  			Correlativo_Perfil		,
                                 	Codigo_Campo_Variable
                        FROM     #paso

                  
         OPEN Cursor_Detalle

      FETCH FIRST FROM Cursor_Detalle
               INTO       @Codigo_Campo,
                          @Tipo_Movimiento_Cuenta,
                          @Perfil_Fijo,
                          @Codigo_Cuenta,
                          @Correlativo_Perfil,
                          @Codigo_Campo_Variable

         SELECT @Correlativo_Voucher = 1
         SELECT @Total_Debe          = 0.0
         SELECT @Total_Haber         = 0.0
		
        

         WHILE @@FETCH_STATUS = 0 
         BEGIN
	    IF @Codigo_Campo=19  oR    @Codigo_Campo = 20 or @Codigo_Campo =  21 or @Codigo_Campo =  23 or @Codigo_Campo =  24 or @Codigo_Campo = 26 or @Codigo_Campo =208 or @Codigo_Campo =209 -- 19 = Capital Peso / 20 = interes Peso
		BEGIN

			SELECT @MonedaCuenta 	= 999
		END
	    ELSE
		BEGIN
			SELECT @MonedaCuenta 	= CONVERT (CHAR (5) , @Moneda_Instrumento )
		END

            EXECUTE @Control_Error = sp_retorna_monto_contabiliza 
                                        @ID_Sistema      ,
                                        @Tipo_Movimiento ,
			@Tipo_Operacion  ,
        		              @Operacion ,
			@Correlativo,
			@Documento       ,
                                        @Codigo_Campo    ,
			@fecha_proceso  , 	
                                        @Monto           OUTPUT

			IF @Control_Error <> 0 
			BEGIN
				INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB005: Fallo el proceso sp_retorna_monto_contabiliza.' + @Mensaje_Error )
               SELECT @Control_Error = 1

            END
            ELSE 
            IF @Monto <> 0.0
            BEGIN
               /*===============================================================*/
               /* Si no es perfil fijo busca la cuenta segun condiciones        */
               /*===============================================================*/

				IF @Perfil_Fijo = 'N' 
				BEGIN
					EXECUTE @Control_Error = sp_retorna_cuenta_contabiliza 
									@ID_Sistema            ,
									@Tipo_Movimiento   ,
									@Tipo_Operacion     ,
									@Operacion             	,
									@Correlativo           	,
									@Documento           	,
									@Folio_Perfil          	,
									@Correlativo_Perfil    ,
									@Codigo_Campo_Variable ,
									@Codigo_Cuenta      OUTPUT

					IF @Control_Error <> 0 
					BEGIN
						INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB006: Fallo el proceso sp_retorna_cuenta_contabiliza.' + @Mensaje_Error )
                     SELECT @Control_Error = 1

                  END

               END

		IF RTRIM(@Codigo_Cuenta) <> ''
		BEGIN
                  IF @Monto < 0.0
                   BEGIN
			IF @Tipo_Movimiento_Cuenta = 'D'
	                     BEGIN
							SELECT @Tipo_Movimiento_Cuenta = 'H'
						END
						ELSE
                     BEGIN
							SELECT @Tipo_Movimiento_Cuenta = 'D'
                     END
                     SELECT @Monto = @Monto * -1.0
                  END

			IF @Tipo_Movimiento_Cuenta = 'D'
                  BEGIN
                     SELECT @Total_Debe  = @Total_Debe  + @Monto

		  END
                ELSE
                BEGIN
                     SELECT @Total_Haber = @Total_Haber + @Monto
                  END

                  /*============================================================*/
                  /* Graba detalle del voucher                                  */
                  /*============================================================*/

                  INSERT INTO     bac_cnt_detalle_voucher
              (
		Numero_Voucher		,
		Correlativo			,
		Cuenta				,
		Tipo_Monto			,
		Monto				,
		MonedaCuenta			,
		CtaCorresponsal 
                                )
					VALUES 
						(
	                         	@Numero_Voucher		,
                                  	@Correlativo_Voucher		,
                                  	@Codigo_Cuenta		,
                                  	@Tipo_Movimiento_Cuenta	,
                                 	(CASE WHEN @MonedaCuenta=999 THEN  round (@Monto,0,0) ELSE @Monto END)	,
			@MonedaCuenta		,
                      	          	@CtaCtbleCorr
	              )
			
				IF @@error <> 0 
				BEGIN
					INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB007: Fallo al agregar detalle de Voucher.' + @Mensaje_Error )
                     SELECT @Control_Error = 1
	                   END

                  SELECT @Correlativo_Voucher = @Correlativo_Voucher + 1

				END
				ELSE
				BEGIN
					INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB010: Perfil Logico No Encontrado.' + @Mensaje_Error )
                  SELECT @Control_Error = 1
               END


            END

            FETCH NEXT FROM Cursor_Detalle
                  INTO      @Codigo_Campo,
                            @Tipo_Movimiento_Cuenta,
                            @Perfil_Fijo,
                            @Codigo_Cuenta,
                            @Correlativo_Perfil,
                            @Codigo_Campo_Variable

         END

         /*=====================================================================*/
         /* Fin ciclo recorre detalle perfil                                    */
         /*=====================================================================*/
         CLOSE Cursor_Detalle
         DEALLOCATE Cursor_Detalle

         DROP TABLE #paso

         /*=====================================================================*/
         /* Graba encabezado del voucher                                        */
   /*=====================================================================*/
         INSERT INTO bac_cnt_voucher
                       (
                         Numero_Voucher	,
                         Fecha_Ingreso	,
                         Glosa		,
                         Tipo_Voucher	,
                         Tipo_Operacion	,
                         Operacion	,
                         correlativo	,
                         instser	,
                         Documento	,
	            codigo_producto,
	            MonedaOperacion	
                       )
                VALUES 
                       (
                         	@Numero_Voucher	,
				@Fecha_Hoy		,
				rtrim(@Glosa_Perfil)	,
				@Tipo_Voucher		,
				@Tipo_Operacion	,
				@Operacion		,
				@Correlativo		,
				@Instrumento		,
				@Documento		,
				@codigo_instrumento	,
				@Moneda_Instrumento
                        )

		IF @@error <> 0 
		BEGIN
			INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB008: Fallo al agregar encabezado de Voucher.' + @Mensaje_Error )
       	SELECT @Control_Error = 1

         END

		IF @Total_Debe  <>  @Total_Haber  
		BEGIN
			INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB009: Voucher no cuadra.' + @Mensaje_Error )
            	SELECT @Control_Error = 0

         END

		IF @control_error = 1 
		BEGIN
         	DELETE bac_cnt_detalle_voucher WHERE numero_voucher = @Numero_Voucher
         	DELETE bac_cnt_voucher         WHERE numero_voucher = @Numero_Voucher
		END
		ELSE
		BEGIN
          	SELECT @Numero_Voucher = @Numero_Voucher + 1

         END

      END


      FETCH NEXT FROM Cursor_Movimiento
            INTO      @ID_Sistema,
		@Tipo_Movimiento,
		@Tipo_Operacion,
		@Operacion,
		@Correlativo,
		@Codigo_Instrumento,
		@Moneda_Instrumento,
		@Instrumento,
		@Documento,
		@tipo_cliente,
		@fecha_proceso,
		@CtaCtbleCorr		
   END

   /*========================================================================*/
   /* Fin ciclo recorre movimientos                                          */
   /*========================================================================*/

	IF @@error <> 0 
	BEGIN
		INSERT INTO bac_cnt_errores VALUES ( @Fecha_Hoy, 2, 'CTB011: Fallo del proceso de actualizaci¢n del par metro contable' )
   	SELECT @Control_Error = 1

   END

   CLOSE Cursor_Movimiento
   DEALLOCATE Cursor_Movimiento

	IF EXISTS(SELECT Fecha_proceso FROM  bac_cnt_errores WHERE fecha_proceso = @Fecha_Hoy)
	BEGIN
		SELECT 'ERROR'
	END
	ELSE
	BEGIN
		UPDATE text_arc_ctl_dri SET acsw_co = '1'
		SELECT 'SI'
   END

	UPDATE	BAC_CNT_VOUCHER 	 
	SET 	fpagoentre 	= forma_pago_entregamos,
				   	fpago		= forma_pago		  ,
				        	BAC_CNT_VOUCHER.plazo		= c.plazo			  ,
					BAC_CNT_VOUCHER.condicion_pacto = c.condicion_pacto    	  ,		
					BAC_CNT_VOUCHER.clasificacion_cliente = c.clasificacion_cliente
				FROM BAC_CNT_CONTABILIZA_RESUMEN c
				WHERE FECHA_INGRESO = @FECHA_HOY 
				AND    c.operacion =  BAC_CNT_VOUCHER.operacion 
			        	AND    c.correlativo =  BAC_CNT_VOUCHER.correlativo 
				AND    c.documento =  BAC_CNT_VOUCHER.documento     
			        	AND    c.tipo_operacion =  BAC_CNT_VOUCHER.tipo_operacion
				AND    c.codigo_instrumento = BAC_CNT_VOUCHER.codigo_producto

	-- Ejecuta el Procedimiento que busca las cuentas para las interfaces
   EXECUTE sp_Buscador_de_cuentas_bonos

   SET NOCOUNT OFF

   RETURN @Control_Error

END

GO
