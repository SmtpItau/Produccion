USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTABILIZACION]
   (   @Fecha_Hoy   DATETIME   )

AS
BEGIN

   SET NOCOUNT ON

   DECLARE @imoneda                NUMERIC(9)
   DECLARE @control_error          INTEGER
   DECLARE @mensaje_error          VARCHAR(100)
   DECLARE @numero_voucher         NUMERIC(10)
   DECLARE @correlativo_voucher    NUMERIC(5)
   DECLARE @tipo_voucher           CHAR(1)
   DECLARE @id_sistema             CHAR(3)
   DECLARE @tipo_movimiento        CHAR(3)
   DECLARE @tipo_operacion         CHAR(5)
   DECLARE @operacion              NUMERIC(10)
   DECLARE @correlativo            NUMERIC(5)
   DECLARE @codigo_instrumento     CHAR(10)
   DECLARE @moneda_instrumento     CHAR(6)
   DECLARE @tipo_perfil            CHAR(1)
   DECLARE @glosa_perfil           CHAR(70)
   DECLARE @monto                  FLOAT
   DECLARE @total_debe             FLOAT
   DECLARE @total_haber            FLOAT
   DECLARE @folio_perfil           NUMERIC(5)
   DECLARE @codigo_campo           NUMERIC(3)
   DECLARE @tipo_movimiento_cuenta CHAR(1)
   DECLARE @perfil_fijo            CHAR(1)
   DECLARE @codigo_cuenta          CHAR(20)
   DECLARE @correlativo_perfil     NUMERIC(3)
   DECLARE @codigo_campo_variable  NUMERIC(3)
   DECLARE @fecha		   CHAR(8)
   DECLARE @glosita      	   CHAR(20)
   DECLARE @tiposwap	           NUMERIC(1)
   DECLARE @okconsolidar  	   NUMERIC(1)
   DECLARE @TipoMarca              CHAR(1)
   DECLARE @iiMonto                FLOAT
   DECLARE @iiMoneda               NUMERIC(21,4)

   BEGIN TRANSACTION

   SET @Control_Error = 0

   TRUNCATE TABLE ERRORES
   TRUNCATE TABLE BAC_CNT_CONTABILIZA
   
   DELETE  BAC_CNT_DETALLE_VOUCHER 
   FROM	   BAC_CNT_VOUCHER 
   WHERE   BAC_CNT_VOUCHER.Numero_Voucher = BAC_CNT_DETALLE_VOUCHER.Numero_Voucher  
   AND	   BAC_CNT_VOUCHER.Fecha_Ingreso  = @Fecha_Hoy

   IF @@ERROR <> 0
   BEGIN
      SET @Control_Error = 1
      INSERT INTO ERRORES (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO ENCABEZADO VOUCHER')
      GOTO FIN_PROCEDIMIENTO
   END

   DELETE  BAC_CNT_VOUCHER 
   WHERE   BAC_CNT_VOUCHER.Fecha_Ingreso = @Fecha_Hoy

   IF @@ERROR <> 0
   BEGIN
      SET @Control_Error = 1
      INSERT INTO ERRORES (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO DETALLE VOUCHER')
      GOTO FIN_PROCEDIMIENTO
   END

   --> Borra Toda la Tabla de Voucher para Interfaz de Balance
   TRUNCATE TABLE BAC_CNT_DETALLE_VOUCHER_BALANCE

   --> Borra Toda la Tabla de Voucher para Interfaz de Balance
   TRUNCATE TABLE BAC_CNT_VOUCHER_BALANCE

   SET @Numero_Voucher = (SELECT ISNULL(MAX(Numero_Voucher),0) + 1 FROM BAC_CNT_VOUCHER)

   DECLARE @PrimerDiaMes   CHAR(08)
   DECLARE @UltimoDiaMes   CHAR(08)
   DECLARE @Fecha_Proximo  CHAR(08)

   SET @Fecha_Proximo  = (SELECT CONVERT(CHAR(8),fechaprox,112) FROM SWAPGENERAL with(nolock) )

   SET @Fecha          = CONVERT(CHAR(8),@Fecha_Hoy,112)
   SET @PrimerDiaMes   = SUBSTRING(CONVERT(CHAR(08),@Fecha_Hoy,112) ,1,6) + '01'
   SET @UltimoDiaMes   = SUBSTRING(CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,35,@PrimerDiaMes)),112),1,6) + '01'
   SET @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@UltimoDiaMes)),112)

   ----<< Chequea si es el ultimo dia del Mes
   IF SUBSTRING(@UltimoDiaMes,5,2) <> SUBSTRING(@Fecha_Proximo,5,2) 
   BEGIN
      SET @fecha = @UltimoDiaMes
   END


   EXECUTE @Control_Error = SP_LLENA_CONTABILIZA @Fecha_Hoy -- @Fecha
   IF @Control_Error <> 0
      GOTO FIN_PROCEDIMIENTO

   CREATE TABLE #TMP_CNT_CONTABILIZA	
   (	Id_Sistema		CHAR(03)
   ,	Tipo_Movimiento		CHAR(03)
   ,	Tipo_Operacion		CHAR(05)
   ,	Operacion		NUMERIC(10,0)
   ,	Correlativo		NUMERIC(06,0)
   ,	Codigo_Instrumento	CHAR(10)
   ,	Moneda_Instrumento	CHAR(06)
   ,	Estado			CHAR(01)
   ,    TipoMarca               CHAR(1)
   ,    Puntero                 NUMERIC(9) identity(1,1)
   )

   /*
   CREATE CLUSTERED INDEX #TMP_CNT_CONT_001 ON #TMP_CNT_CONTABILIZA
   (	Id_Sistema , Tipo_Movimiento , Tipo_Operacion , Operacion , Estado ) 
   */

   CREATE TABLE #TMP_PERFIL_DETALLE_CNT
   (	codigo_campo		NUMERIC(03,0)
   ,	tipo_movimiento_cuenta	CHAR(01)
   ,	perfil_fijo		CHAR(01)
   ,	codigo_cuenta		CHAR(20)
   ,	correlativo_perfil	NUMERIC(03,0)
   ,	codigo_campo_variable	NUMERIC(03,0)
   ,	Estado			CHAR(01)
   ,	folio_perfil		NUMERIC(07,0) 
   ,    Indice                  NUMERIC(9) identity(1,1)
   )

   /*
   CREATE CLUSTERED INDEX TMP_PER_DET_CNT_001 ON #TMP_PERFIL_DETALLE_CNT
   (    Estado , codigo_campo , tipo_movimiento_cuenta ) 
   */

   INSERT INTO #TMP_CNT_CONTABILIZA
   SELECT id_sistema
   ,      tipo_movimiento
   ,      tipo_operacion
   ,      operacion
   ,      correlativo
   ,      codigo_instrumento
   ,      moneda_instrumento
   ,      'N'
   ,      TipOper
   FROM   BAC_CNT_CONTABILIZA 
       -- ORDER BY id_sistema , tipo_movimiento , tipo_operacion , operacion

	  


   DECLARE @Existe_Reg	CHAR(01)
   DECLARE @TIPOPER     CHAR(10)
   DECLARE @iRegistro   NUMERIC(9)
   DECLARE @iRegistros  NUMERIC(9)
   DECLARE @iFound      INTEGER

   SELECT  @iRegistro   = MIN(Puntero)
   ,       @iRegistros  = MAX(Puntero)
   FROM    #TMP_CNT_CONTABILIZA

   WHILE   @iRegistros >= @iRegistro --> 1 = 1
   BEGIN
      SELECT @id_sistema	   = id_sistema
      ,	     @tipo_movimiento	   = tipo_movimiento
      ,	     @tipo_operacion	   = tipo_operacion
      ,	     @operacion		   = operacion
      ,	     @correlativo	   = correlativo
      ,	     @codigo_instrumento   = codigo_instrumento
      ,	     @moneda_instrumento   = moneda_instrumento
      ,      @TipoMarca            = TipoMarca
      ,      @tiposwap             = 0
      ,      @iFound               = -1
      FROM   #TMP_CNT_CONTABILIZA
      WHERE  Puntero               = @iRegistro

      SET    @TipoSwap             = ( SELECT MAX(tipo_swap) FROM CARTERA WHERE Numero_operacion = @operacion)

      SELECT @iFound               = 1
      ,      @tipo_voucher         = tipo_voucher
      ,      @glosa_perfil         = glosa_perfil
      ,      @folio_perfil         = folio_perfil
      FROM   BacParamSuda..PERFIL_CNT
      WHERE  id_sistema            = @id_sistema
      AND    tipo_movimiento       = @tipo_movimiento
      AND    tipo_operacion        = @tipo_operacion
      AND    codigo_instrumento    = @codigo_instrumento
      AND    moneda_instrumento    = @moneda_instrumento

      IF @iFound = -1
      BEGIN
         SELECT	 @glosita        = descripcion
         FROM	 BacParamSuda..PRODUCTO
         WHERE	 codigo_producto = CASE WHEN @TipoSwap = 1 THEN 'ST' --> LTRIM(RTRIM(CONVERT(CHAR,@TipoSwap)))
                                        WHEN @TipoSwap = 2 THEN 'SM'
                                        WHEN @TipoSwap = 3 THEN 'FR'
                                        WHEN @TipoSwap = 3 THEN 'SP'
                                   END
          AND    id_sistema      = 'PCS'

         SET    @Control_Error   = 1
         SELECT @Mensaje_Error   = 'Oper. N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- PERFIL NO EXISTE ' + @ID_Sistema + ', ' + @GLOSITA + ' - ' + @Tipo_Movimiento + ',' + @Tipo_Operacion + ',' + @Codigo_Instrumento + ',' + @Moneda_Instrumento
         INSERT INTO ERRORES (Mensaje) VALUES (@Mensaje_Error)

      END ELSE
      BEGIN
         TRUNCATE TABLE #TMP_PERFIL_DETALLE_CNT

         INSERT	INTO #TMP_PERFIL_DETALLE_CNT
         SELECT	Codigo_Campo
         ,	Tipo_Movimiento_Cuenta
         ,	Perfil_Fijo
         ,	Codigo_Cuenta
         ,	Correlativo_Perfil
         ,	Codigo_Campo_Variable
         ,	'N'
		 , folio_perfil
         FROM	BacParamSuda..PERFIL_DETALLE_CNT
         WHERE	Folio_Perfil   = @Folio_Perfil
         ORDER BY Folio_Perfil , Correlativo_Perfil




         DECLARE @Id_Reg              INTEGER
         DECLARE @Existe_Reg2         CHAR(01)
         DECLARE @iIndice             NUMERIC(9)
 DECLARE @iCantidad           NUMERIC(9)

         SELECT  @iCantidad           = MAX(Indice)
         ,       @iIndice             = MIN(Indice)
         FROM    #TMP_PERFIL_DETALLE_CNT

         SET     @Correlativo_Voucher = 1
         SET     @Total_Debe          = 0.0
         SET     @Total_Haber         = 0.0
   
         WHILE   @iCantidad >= @iIndice --> 2 = 2 
         BEGIN
            SELECT @codigo_campo	   = codigo_campo
            ,	   @tipo_movimiento_cuenta = tipo_movimiento_cuenta
            ,	   @perfil_fijo		   = perfil_fijo
            ,	   @codigo_cuenta          = codigo_cuenta
            ,	   @correlativo_perfil	   = correlativo_perfil
            ,	   @codigo_campo_variable  = codigo_campo_variable
            ,	   @existe_reg2		   = 'S'
            FROM   #TMP_PERFIL_DETALLE_CNT
            WHERE  Indice                  = @iIndice

	    EXECUTE @Control_Error = SP_RETORNA_MONTO_CONTABILIZA @id_sistema
                                                               ,  @tipo_movimiento
                                                               ,  @tipo_operacion
                                                               ,  @operacion
                                                               ,  @correlativo
                                                               ,  @codigo_campo
                                                               ,  @monto           OUTPUT

				

            IF @Control_Error <> 0
            BEGIN
               SELECT @Mensaje_Error = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- No retorna monto a Contabilizar'
               INSERT INTO ERRORES (Mensaje) VALUES (@Mensaje_Error)
            END

            IF @Monto <> 0.0
            BEGIN
               IF @Perfil_Fijo = 'N'
               BEGIN
                  EXECUTE @Control_Error = SP_RETORNA_CUENTA_CONTABILIZA @id_sistema
                                                                      ,  @tipo_movimiento
                                                                      ,  @tipo_operacion
                                                                      ,  @operacion
                                                                      ,  @correlativo
                                                                      ,  @folio_perfil
                                                                      ,  @correlativo_perfil
                                                                      ,  @codigo_campo_variable
                                                                      ,  @codigo_cuenta         OUTPUT

                 

                  IF @Control_Error <> 0
                  BEGIN
                     SELECT @Mensaje_Error = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- No retorna Cuenta Contable '
                     INSERT INTO ERRORES (Mensaje) VALUES (@Mensaje_Error) 
                     GOTO FIN_PROCEDIMIENTO
                  END
               END
   
               IF RTRIM(@Codigo_Cuenta) <> ''
               BEGIN

			       

                  IF @Monto < 0.0
                  BEGIN
                     IF @Tipo_Movimiento_Cuenta = 'D'
                        SET @Tipo_Movimiento_Cuenta = 'H'
                     ELSE
                        SET @Tipo_Movimiento_Cuenta = 'D'

                     SET @Monto = @Monto * -1.0
                  END

				/*----------------------------------------------------*/
				/* PARA LOS CASOS DE MODIFICACION SE DEJO EL CORRE   -*/
				/* LATIVO EN 10000 + NUMERO DE FLUJO ,ASI PODREMOS DAR*/
				/* VUELTA LA PARTIDA DE MOVIMIENTO ORIGINADA POR EL   */
				/* EXEC SP_LLENA_CONTABILIZA_MODIFICA                 */
				/*--------------------------------------------------  */
  			      IF (@correlativo > 10000 AND @correlativo < 20000) AND @tipo_movimiento != 'DEV' BEGIN

                     IF @Tipo_Movimiento_Cuenta = 'D' BEGIN
                        SET @Tipo_Movimiento_Cuenta = 'H'
					 END
					 ELSE BEGIN
                       SET @Tipo_Movimiento_Cuenta = 'D'
					 END
			      END

				




                  IF @Tipo_Movimiento_Cuenta = 'D'
                     SET @Total_Debe  = @Total_Debe  + @Monto
                  ELSE
                     SET @Total_Haber = @Total_Haber + @Monto

                  IF @TipoSwap = 2
                  BEGIN
                     EXECUTE SP_RETORNA_CAMPO_MONEDA @id_sistema
                                                   , @tipo_movimiento
                                                   , @tipo_operacion
                                                   , @operacion
                     , @codigo_campo
                                                   , @imoneda          OUTPUT
                  END

                  SET @iiMonto   = CASE WHEN @Codigo_Campo IN(200,210,211,212,222,208,209,214,215,216,217) THEN CASE WHEN @Moneda_Instrumento = 999 THEN ROUND(@Monto,0) 
                                                                                                                     ELSE @Monto 
                                                                                                                END
                                        ELSE ROUND(@Monto,0)
                                   END
                  SET @iiMoneda  = CASE WHEN @Codigo_Campo IN(200,210,211,212,222,208,209,214,215,216,217) THEN @Moneda_Instrumento  -- MAP Contingencia Tecno
			                ELSE 999
                                   END


                  IF @TipoMarca <> 'V'
                  BEGIN
                     INSERT INTO BAC_CNT_DETALLE_VOUCHER_BALANCE
                     (   Numero_Voucher  , Correlativo          , Cuenta         , Tipo_Monto              , Monto    , Moneda   )
                     VALUES
                     (   @Numero_Voucher , @Correlativo_Voucher , @Codigo_Cuenta , @tipo_Movimiento_Cuenta , @iiMonto , @iiMoneda )

                     IF @@ERROR <> 0
                     BEGIN
                        SET    @Control_Error = 1
                        SELECT @Mensaje_Error = 'Operacion N° ' + Convert(VARCHAR(10),@Operacion) + ' -- ERROR_PROC FALLA AGREGANDO DETALLE DE VOUCHER'
                        INSERT INTO ERRORES (Mensaje) VALUES (@Mensaje_Error)
                        GOTO FIN_PROCEDIMIENTO
                     END
                  END


		

                  IF (@TipoMarca = 'N' OR @TipoMarca = 'V')
                  BEGIN
                     INSERT INTO BAC_CNT_DETALLE_VOUCHER
                     (   Numero_Voucher  , Correlativo          , Cuenta         , Tipo_Monto              , Monto    , Moneda    )
                     VALUES
                     (   @Numero_Voucher , @Correlativo_Voucher , @Codigo_Cuenta , @tipo_Movimiento_Cuenta , @iiMonto , @iiMoneda )

                     IF @@ERROR <> 0
                     BEGIN
                        SET    @Control_Error = 1
                        SELECT @Mensaje_Error = 'Operacion N° ' + Convert(VARCHAR(10),@Operacion) + ' -- ERROR_PROC FALLA AGREGANDO DETALLE DE VOUCHER'
                        INSERT INTO ERRORES (Mensaje) VALUES (@Mensaje_Error)
                        GOTO FIN_PROCEDIMIENTO
                     END
                  END


                  SET @Correlativo_Voucher = @Correlativo_Voucher + 1
               END   -->  Cta <> ''
            END   --> Mto <> 0.0

            SET @iIndice = @iIndice + 1
         END   --> While Perfil Detalle

         IF @Total_Debe <> @Total_Haber
         BEGIN
            SET    @Control_Error = 1
            SELECT @Mensaje_Error = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- ERROR_PROC VOUCHER NO CUADRA ' + @id_sistema + ',' + @tipo_movimiento + ',' + @tipo_operacion + ',' + @glosa_perfil
            INSERT INTO ERRORES ( Mensaje ) values ( @Mensaje_Error)
         END

		/*----------------------------------------------------------------*/
		/* SI EL CORRELATIVO DE LA TABLA ES MAYOR A 1000 SON PLANES       */
		/* DE MODIFICACION  POR LO QUE DEBO VOLVER AL AL CORRELATIVO      */
		/* ORIGINAL NUMERO DE FLUJO - 10000                               */
		/*----------------------------------------------------------------*/
   	      IF @correlativo > 10000 AND @correlativo < 20000 BEGIN
		      SET @correlativo = @correlativo  - 10000
			  SET @Glosa_Perfil = LTRIM(RTRIM(@Glosa_Perfil)) + '(MODIFICACION)'
		  END

		/*----------------------------------------------------------------*/
		/* SI ESTOS SON 20000 SON MOVIMIENTOS NORMALES                    */
		/*----------------------------------------------------------------*/
		  IF @correlativo > 20000 BEGIN
		      SET @correlativo = @correlativo  - 20000
			  SET @Glosa_Perfil = LTRIM(RTRIM(@Glosa_Perfil))
		  END




         DECLARE @numero VARCHAR(10)
         SET     @numero = RTRIM(CONVERT(CHAR(7),@operacion)) + REPLICATE('0',3-LEN(LTRIM(RTRIM(@correlativo)))) + LTRIM(RTRIM(@correlativo))

         IF @TipoMarca <> 'V'
         BEGIN
            INSERT INTO BAC_CNT_VOUCHER_BALANCE
            (   Numero_Voucher  , Fecha_Ingreso , Glosa         , Tipo_Voucher  , Tipo_Operacion  , Operacion , Folio_perfil  )
            VALUES
            (   @Numero_Voucher , @Fecha_Hoy    , @Glosa_Perfil , @Tipo_Voucher , @Tipo_Operacion , @numero   , @Folio_Perfil )

            IF @@ERROR <> 0
            BEGIN
               SET @Control_Error = 1
               INSERT INTO ERRORES (Mensaje) VALUES ('ERROR_PROC FALLA AGREGANDO ENCABEZADO VOUCHER')
               GOTO FIN_PROCEDIMIENTO
            END
         END

         IF (@TipoMarca = 'N' OR @TipoMarca = 'V')
         BEGIN
            INSERT INTO BAC_CNT_VOUCHER
            (   Numero_Voucher  , Fecha_Ingreso , Glosa         , Tipo_Voucher  , Tipo_Operacion , Operacion , Folio_perfil  )
            VALUES
            (   @Numero_Voucher , @Fecha_Hoy    , @Glosa_Perfil , @Tipo_Voucher , @Tipo_Operacion , @numero  , @Folio_Perfil )

            IF @@ERROR <> 0
            BEGIN
               SELECT @Control_Error = 1
               INSERT INTO ERRORES (Mensaje) VALUES ('ERROR_PROC FALLA AGREGANDO ENCABEZADO VOUCHER')
               GOTO FIN_PROCEDIMIENTO
            END
         END

         SET @Numero_Voucher = @Numero_Voucher + 1
      END   --> @iFound = -1

      SET @iRegistro = @iRegistro + 1   
   END   /* FIN CICLO RECORRE MOVIMIENTOS */


FIN_PROCEDIMIENTO:
   EXECUTE @OKconsolidar = SP_CONSOLIDACONTABILIDAD  

   IF @OKconsolidar <> 0
   BEGIN
      SELECT @Mensaje_Error = 'Problemas en Consilidación Contable'
      INSERT INTO ERRORES (Mensaje) VALUES (@Mensaje_Error)
   END
   COMMIT TRANSACTION

   SELECT COUNT(mensaje) FROM ERRORES

END
GO
