USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_CONTABILIZACION '20200408'
--select * from bac_cnt_errores
--SELECT * FROM bac_cnt_contabiliza

--SELECT Forma_Pago_MN FROM BAC_CNT_CONTABILIZA WHERE ID_Sistema='BCC' AND Tipo_Movimiento='MOV' AND Tipo_Operacion='CMXA' AND Operacion=1023726 AND Correlativo=617 AND Documento=0
--SELECT Codigo_Cuenta,* FROM VIEW_PERFIL_VARIABLE_CNT WHERE Folio_Perfil     =        1003 AND correlativo_perfil =           6 AND Valor_Dato_Campo = '0'


CREATE PROCEDURE [dbo].[SP_CONTABILIZACION]

                  (

                  @Fecha_Hoy    DATETIME

                  )

AS BEGIN	   

SET NOCOUNT ON	    

   DECLARE @Rut_Cliente            NUMERIC(10,00)

   DECLARE @Codigo_Cliente         NUMERIC(9,00)

   DECLARE @Tipo_Cambio            NUMERIC(19,04)

   DECLARE @Codigo_Campo           NUMERIC(03)

   DECLARE @Correlativo_Perfil     NUMERIC(03)

   DECLARE @Codigo_Campo_Variable  NUMERIC(03)

   DECLARE @Operacion              NUMERIC(10)

   DECLARE @Documento              NUMERIC(10)

   DECLARE @Correlativo            NUMERIC(05)

   DECLARE @Numero_Voucher         NUMERIC(10)

   DECLARE @Correlativo_Voucher    NUMERIC(05)

   DECLARE @Codigo_Corresponsal    NUMERIC(10)

   DECLARE @Folio_Perfil           NUMERIC(05)

   DECLARE @TIPO_CLIENTE           NUMERIC(05)

   DECLARE @Valor_Campo            VARCHAR(30)

   DECLARE @Mensaje_Error          VARCHAR(255)

   DECLARE @Tipo_Mercado           CHAR(04)

   DECLARE @Tipo_Voucher           CHAR(01)

   DECLARE @Codigo_Moneda          CHAR(03)

   DECLARE @ID_Sistema             CHAR(03)

   DECLARE @Tipo_Movimiento        CHAR(03)

   DECLARE @Tipo_Operacion         CHAR(05)

   DECLARE @Codigo_Instrumento     CHAR(10)

   DECLARE @Moneda_Instrumento     CHAR(06)

   DECLARE @Tipo_Perfil            CHAR(01)

   DECLARE @Glosa_Perfil           CHAR(70)

   DECLARE @Tipo_Movimiento_Cuenta CHAR(01)

   DECLARE @Perfil_Fijo            CHAR(01)

   DECLARE @Codigo_Cuenta          CHAR(20)

   DECLARE @Fecha_Ctb              DATETIME

   DECLARE @Control_Error          INTEGER

   DECLARE @Monto                  FLOAT

   DECLARE @Total_Debe             FLOAT

   DECLARE @Total_Haber            FLOAT



   SELECT @Control_Error = 0

   SELECT @Mensaje_Error = ''

   /****************************************************************************************************/

   /****************************************************************************************************/

   DELETE bac_cnt_errores WHERE fecha_proceso = @Fecha_Hoy

   /****************************************************************************************************/

   /***** Borra Voucher ya generados *******************************************************************/

   /****************************************************************************************************/

   DELETE bac_cnt_detalle_voucher

   FROM   bac_cnt_voucher a

   WHERE a.numero_voucher = bac_cnt_detalle_voucher.numero_voucher AND

         a.fecha_ingreso  = @Fecha_Hoy

   IF @@error <> 0 BEGIN

      INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 1, 'CTB001: Fallo borrando encabezado Voucher')

      RETURN

   END

   /****************************************************************************************************/

   /****************************************************************************************************/

   DELETE bac_cnt_voucher WHERE fecha_ingreso = @Fecha_Hoy

       IF @@error <> 0 BEGIN

            INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 1, 'CTB002: Fallo Borrando detalle Voucher')

            RETURN

      END

   /****************************************************************************************************/

   /***** Busca el Número de Voucher a ocupar **********************************************************/

   /****************************************************************************************************/

   /****************************************************************************************************/

   SELECT @Numero_Voucher = ISNULL(MAX(Numero_Voucher), 0) + 1 FROM bac_cnt_voucher --(INDEX=Numero_Voucher)

   /****************************************************************************************************/

   /***** Llena archivo con datos a contabilizar *******************************************************/

   /****************************************************************************************************/

   EXECUTE @Control_Error = sp_llena_ctb_cambios @Fecha_Hoy

 

   IF @Control_Error <> 0 

   BEGIN

      IF @Control_Error = -5

         INSERT INTO BAC_CNT_ERRORES VALUES(@Fecha_Hoy, 1, 'Dolar de Representacion Contable para Arbitrajes no esta Cargado.')

      ELSE

      INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 1, 'CTB003: Fallo el llenado de la tabla Movimientos Contables')

      RETURN

   END



   /***** Elimina operaciones con Telex Hoy ************************************************************/

   DELETE bac_cnt_contabiliza WHERE tipo_operacion IN('ACMX', 'AVMX', 'ACAR', 'AVAR','AVMN','ACMN','AOVE')AND

                                    Fecha_Contable = Fecha_Proceso

   /****************************************************************************************************/

   /***** Comienza contabilizacion *********************************************************************/

   /****************************************************************************************************/

   DECLARE Cursor_Movimiento SCROLL CURSOR FOR

      SELECT ID_Sistema		,

             Tipo_Movimiento	,

             Tipo_Operacion	,

             Operacion		,

             Correlativo	,

             Codigo_Instrumento	,

             Moneda_Instrumento	,

             Documento		,

             Fecha_Contable	,

             Codigo_Moneda	,

             Tipo_Mercado	,

             Rut_Cliente	,

             Codigo_Cliente	,

             Tipo_Cambio

      FROM bac_cnt_contabiliza
    Order By  tipo_operacion desc ,operacion


   /****************************************************************************************************/

   /****************************************************************************************************/

   OPEN Cursor_Movimiento

   /****************************************************************************************************/

   /****************************************************************************************************/

   FETCH FIRST FROM Cursor_Movimiento

      INTO   @ID_Sistema	,

             @Tipo_Movimiento	,

             @Tipo_Operacion	,

             @Operacion		,

             @Correlativo	,

             @Codigo_Instrumento,

             @Moneda_Instrumento,

             @Documento		,

             @Fecha_Ctb		,

             @Codigo_Moneda	,

             @Tipo_Mercado	,

             @Rut_Cliente	,

             @Codigo_Cliente	,

             @Tipo_Cambio

   /****************************************************************************************************/

   /****************************************************************************************************/

   /****************************************************************************************************/

   SELECT @Correlativo_Voucher = 1

   WHILE @@fetch_status = 0 BEGIN

      SELECT @Mensaje_Error = ' Sistema ('              + @ID_Sistema          +

                              '), Tipo movimiento ('    + @Tipo_Movimiento     +

                              '), Tipo operacion ('     + @Tipo_Operacion      +

                              '), Instrumento ('        + @Codigo_Instrumento  +

                              '), Moneda ('             + @Moneda_Instrumento  +

                              '), Numero operacion ('   + CONVERT(VARCHAR(10), @Operacion) + 

                              '), Numero Voucher ('     + CONVERT(VARCHAR(10), @Numero_Voucher) +

                              '), Correlativo Voucher ('+ CONVERT(VARCHAR(10), @Correlativo_Voucher) + ')'

   /****************************************************************************************************/

   /****************************************************************************************************/

   IF NOT EXISTS(SELECT id_sistema FROM VIEW_PERFIL_CNT WHERE ID_Sistema         = @ID_Sistema         AND

                                                              Tipo_Movimiento    = @Tipo_Movimiento    AND

                                                              Tipo_Operacion     = @Tipo_Operacion     AND

           Codigo_Instrumento = @Codigo_Instrumento AND

          Moneda_Instrumento = @Moneda_Instrumento) BEGIN 

         INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB004: Perfil no existe.' + @Mensaje_Error)

       /****************************************************************************************************/

       /***** Rescata informacion del perfil ***************************************************************/

       /****************************************************************************************************/

   END ELSE BEGIN

         SELECT @Tipo_Voucher  = Tipo_Voucher	,

                @Glosa_Perfil  = Glosa_Perfil	,

                @Folio_Perfil  = Folio_Perfil

         FROM  VIEW_PERFIL_CNT

         WHERE ID_Sistema         = @ID_Sistema         AND

               Tipo_Movimiento    = @Tipo_Movimiento    AND

               Tipo_Operacion     = @Tipo_Operacion     AND

               Codigo_Instrumento = @Codigo_Instrumento AND

               Moneda_Instrumento = @Moneda_Instrumento

         SELECT @Mensaje_Error = @Mensaje_Error + ', Perfil (' + CONVERT(VARCHAR(10), @Folio_Perfil) + ')'

         /**********************************************************************/

         /***** Recorre el detalle del perfil **********************************/

         /**********************************************************************/

         SELECT Codigo_Campo		,

                Tipo_Movimiento_Cuenta	,

                Perfil_Fijo		,

                Codigo_Cuenta		,

                Correlativo_Perfil	,

                Codigo_Campo_Variable

         INTO   #PASO

         FROM   VIEW_PERFIL_DETALLE_CNT

         WHERE  Folio_Perfil  = @Folio_Perfil

         ORDER BY Folio_Perfil, Correlativo_Perfil



         DECLARE Cursor_Detalle SCROLL CURSOR FOR

            SELECT Codigo_Campo,

                   Tipo_Movimiento_Cuenta,

                   Perfil_Fijo,

                   Codigo_Cuenta,

                   Correlativo_Perfil,

                   Codigo_Campo_Variable

            FROM   #paso

         /**********************************************************************/

         /**********************************************************************/

         OPEN Cursor_Detalle

         /**********************************************************************/

         /**********************************************************************/

         FETCH FIRST FROM Cursor_Detalle

            INTO   @Codigo_Campo		,

                   @Tipo_Movimiento_Cuenta	,

                   @Perfil_Fijo			,

                   @Codigo_Cuenta		,

                   @Correlativo_Perfil		,

                   @Codigo_Campo_Variable

         /**********************************************************************/

         /**********************************************************************/

         SELECT @Correlativo_Voucher = 1  ,

                @Total_Debe          = 0.0,

                @Total_Haber         = 0.0

         /**********************************************************************/

         /**********************************************************************/

         WHILE @@FETCH_STATUS = 0 BEGIN

         EXECUTE @Control_Error = sp_retorna_monto_contabiliza @ID_Sistema      ,

                                                               @Tipo_Movimiento ,

                                                               @Tipo_Operacion  ,

                                                               @Operacion       ,

                                                               @Correlativo     ,

                                                               @Documento       ,

                                                               @Codigo_Campo    ,

                                   @Monto           OUTPUT

            IF @Control_Error <> 0 BEGIN

               INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB005: Fallo el proceso sp_retorna_monto_contabiliza.' + @Mensaje_Error)

               SELECT @Control_Error = 1

            END ELSE IF @Monto <> 0.0 BEGIN

               /**********************************************************************/

               /***** Si no es perfil fijo busca la cuenta segun condiciones *********/

               /**********************************************************************/

               IF @Perfil_Fijo = 'N' BEGIN

                  SELECT  @Codigo_Cuenta = ''


                  EXECUTE @Control_Error = sp_retorna_cuenta_contabiliza @ID_Sistema            ,

                                                                         @Tipo_Movimiento       ,

                                                                         @Tipo_Operacion        ,

                                                                         @Operacion             ,

                                                                         @Correlativo           ,

                                                                         @Documento             ,

                                                                         @Folio_Perfil          ,

                                                                         @Correlativo_Perfil    ,

                                                                         @Codigo_Campo_Variable ,

                                                                         @Codigo_Cuenta   OUTPUT,

                                                                         @Valor_Campo     OUTPUT



                  IF @Control_Error <> 0 BEGIN

                     INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB006: Fallo el proceso sp_retorna_cuenta_contabiliza.' + @Mensaje_Error)

                     SELECT @Control_Error = 1

			RETURN





                  END

               END

               SELECT @Valor_Campo = CASE WHEN @Codigo_Campo = 501 THEN @Codigo_Moneda

                                          WHEN @Codigo_Campo = 502 THEN 13  -- 'USD'

					  WHEN @Codigo_Campo = 512 THEN @Codigo_Moneda

                                          WHEN @Codigo_Campo = 503 THEN 999 -- 'CLP'

                                          ELSE '   '

                                     END

               SELECT @Codigo_Corresponsal = 0

               SELECT @TIPO_CLIENTE = ISNULL(CLTIPCLI, 4) FROM VIEW_CLIENTE WHERE CLRUT = @Rut_Cliente AND CLCODIGO = @Codigo_Cliente

               -- CLTIPCLI = 4  ==> CORREDORA

               IF RTRIM(@Codigo_Cuenta) <> '' BEGIN

                  -- Buscar Corresponsal

                  -- Inicio de Operaciones



                  IF @Codigo_Cuenta IN('27300', '68114', '31229', '00182') BEGIN

                     IF @Codigo_Campo_Variable IN (505, 506, 507, 502) BEGIN

                        IF @Tipo_Operacion = 'CMXN' BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

                              SELECT @Codigo_Corresponsal = mncodcorrespC

                              FROM  view_moneda, view_corresponsal

                              WHERE mnnemo        = CONVERT(VARCHAR(03), @Valor_Campo) AND

                                    mncodcorrespC = codigo_corres

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBancoC

                              FROM  view_moneda, view_corresponsal

                              WHERE mnnemo        = CONVERT(VARCHAR(03), @Valor_Campo) AND

                                    mncodBancoC   = codigo_corres

                           END

                        END ELSE IF @Tipo_Operacion = 'VMXN' BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

    SELECT @Codigo_Corresponsal = mncodcorrespV

                              FROM  view_moneda, view_corresponsal

                              WHERE mnnemo        = @Valor_Campo   AND

               mncodcorrespV = codigo_corres

			   END ELSE BEGIN

      			      SELECT @Codigo_Corresponsal = mncodBancoV

                              FROM   view_moneda, view_corresponsal

                              WHERE  mnnemo        = @Valor_Campo   AND

                                     mncodBancoV   = codigo_corres

                           END		 

                        END ELSE IF @Tipo_Operacion = 'CMXA' AND @Valor_Campo <> 13 /*'USD'*/ BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

                              SELECT @Codigo_Corresponsal = mncodcorrespC

                              FROM  view_moneda

                              WHERE mnnemo   = @Valor_Campo

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBancoC

                              FROM  view_moneda

                              WHERE mnnemo   = @Valor_Campo

                           END

                        END ELSE IF @Tipo_Operacion = 'CMXA' AND @Valor_Campo  = 13 /*'USD'*/ BEGIN

                           SELECT @Codigo_Corresponsal = mocorres

                           FROM memo

                           WHERE monumope = @Operacion

                        END ELSE IF @Tipo_Operacion = 'VMXA' AND @Valor_Campo <> 13 /*'USD'*/ BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

                              SELECT @Codigo_Corresponsal = mncodcorrespV

                              FROM view_moneda

                              WHERE mnnemo = @Valor_Campo

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBANCOV

                              FROM view_moneda

                              WHERE mnnemo = @Valor_Campo

                           END

                        END ELSE IF @Tipo_Operacion = 'VMXA' AND @Valor_Campo  = 13 /*'USD'*/ BEGIN

                           SELECT @Codigo_Corresponsal = mocorres

                           FROM memo

                           WHERE monumope = @Operacion

                        END

                        IF @Codigo_Cuenta = '31229' BEGIN

                           SELECT @Codigo_Corresponsal = 01000100

                        END

                     END

                   

                     IF @Tipo_Operacion = 'ACMX' BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

                              SELECT @Codigo_Corresponsal = mncodcorrespC

                              FROM view_moneda, view_corresponsal

                              WHERE mnnemo        = CONVERT(VARCHAR(03), @Valor_Campo)  AND

                                    mncodcorrespC = codigo_corres

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBancoC

                              FROM view_moneda, view_corresponsal

                              WHERE mnnemo        = CONVERT(VARCHAR(03), @Valor_Campo)  AND

                                    mncodBancoC = codigo_corres

                           END

                     END ELSE IF @Tipo_Operacion = 'AVMX' BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

                              SELECT @Codigo_Corresponsal = mncodcorrespV

                              FROM view_moneda, view_corresponsal

                              WHERE mnnemo        = @Valor_Campo   AND

                                    mncodcorrespV = codigo_corres

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBancoV

                              FROM view_moneda, view_corresponsal

                              WHERE mnnemo        = @Valor_Campo AND

                                    mncodBancoV   = codigo_corres

                           END

                     END ELSE IF @Tipo_Operacion = 'ACAR' AND @Valor_Campo <> 13 /*'USD'*/ BEGIN

     IF @TIPO_CLIENTE = 4 BEGIN --- corredora

			      SELECT @Codigo_Corresponsal = mncodcorrespC

                              FROM view_moneda

                              WHERE mnnemo = @Valor_Campo

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBancoC

                              FROM view_moneda

                              WHERE mnnemo = @Valor_Campo

                           END

                     END ELSE IF @Tipo_Operacion = 'ACAR' AND @Valor_Campo  = 13 /*'USD'*/ BEGIN

                           SELECT @Codigo_Corresponsal = mocorres

                           FROM memo

                           WHERE monumope = @Operacion

                     END ELSE IF @Tipo_Operacion = 'AVAR' AND @Valor_Campo <> 13 /*'USD'*/ BEGIN

                           IF @TIPO_CLIENTE = 4 BEGIN --- corredora

                              SELECT @Codigo_Corresponsal = mncodcorrespV

                              FROM view_moneda

                              WHERE mnnemo = @Valor_Campo

                           END ELSE BEGIN

                              SELECT @Codigo_Corresponsal = mncodBancoV

                              FROM view_moneda

                              WHERE mnnemo = @Valor_Campo

                           END

                     END ELSE IF @Tipo_Operacion = 'AVAR' AND @Valor_Campo  = 13 /*'USD'*/ BEGIN

                           SELECT @Codigo_Corresponsal = mocorres

                           FROM memo

                           WHERE monumope = @Operacion

                     END

                  END

                  SELECT @Codigo_Corresponsal = ISNULL(@Codigo_Corresponsal, 0)

                  IF @Monto < 0.0 BEGIN

                     IF @Tipo_Movimiento_Cuenta = 'D' BEGIN

                        SELECT @Tipo_Movimiento_Cuenta = 'H'

                     END ELSE BEGIN

                        SELECT @Tipo_Movimiento_Cuenta = 'D'

                     END

                     SELECT @Monto = @Monto * -1.0

                  END

                  IF @Tipo_Movimiento_Cuenta = 'D' BEGIN

                     SELECT @Total_Debe  = @Total_Debe  + @Monto

                  END ELSE BEGIN

                     SELECT @Total_Haber = @Total_Haber + @Monto

                  END

		  -- Numero de Voucher del Vencimiento Igual al de la Contabilización de la Operación

--		  Select 'Antes' = @Tipo_Operacion , 'Voucher' = @NUMERO_VOUCHER

		  If @Tipo_Operacion  IN('ACMX','AVMX','ACAR','AVAR','AVMN','ACMN','AOVE') Begin



			SELECT @NUMERO_VOUCHER = NUMERO_VOUCHER 

			FROM   BAC_CNT_VOUCHER 

			WHERE  OPERACION       = @OPERACION 

			  AND  ID_SISTEMA      = 'BCC'

			  AND  Fecha_Ingreso   = @Fecha_Hoy

			  AND  TIPO_OPERACION NOT IN('ACMX','AVMX','ACAR','AVAR','AVMN','ACMN','AOVE')

--			select 'DES','@Tipo_Operacion' = @Tipo_Operacion,'@OPERACION'  = @OPERACION ,'@NUMERO_VOUCHER' = @NUMERO_VOUCHER

		  End 

-- 		  Else

--			select 'ANT','@Tipo_Operacion' = @Tipo_Operacion,'@OPERACION'  = @OPERACION ,'@NUMERO_VOUCHER' = @NUMERO_VOUCHER

--		  Select 'Antes' = @Tipo_Operacion , 'Voucher' = @NUMERO_VOUCHER

                  /**************************************************************/

                  /***** Graba detalle del voucher ******************************/

                  /**************************************************************/

                  INSERT INTO bac_cnt_detalle_voucher

                             (

                             Numero_Voucher	,

                             Correlativo	,

                             Cuenta		,

                             Tipo_Monto		,

                             Monto		,

                             Codigo_Corresponsal,

         Valor_Campo	,

			     Tipo_Operacion	,

			     Operacion

                             )

                  VALUES     (

                             @Numero_Voucher		,

                             @Correlativo_Voucher	,

                             @Codigo_Cuenta		,

                    	     @Tipo_Movimiento_Cuenta	,

                             @Monto			,

                             @Codigo_Corresponsal	,

                             @Valor_Campo		,

			     @Tipo_Operacion		,

			     @OPERACION

                             )

                  IF @@error <> 0 BEGIN

                     INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB007: Fallo al agregar detalle de Voucher.' + @Mensaje_Error)

                     SELECT @Control_Error = 1

                  END

                  SELECT @Correlativo_Voucher = @Correlativo_Voucher + 1

               END

            END

            FETCH NEXT FROM Cursor_Detalle

            INTO @Codigo_Campo,

                 @Tipo_Movimiento_Cuenta,

                 @Perfil_Fijo,

                 @Codigo_Cuenta,

                 @Correlativo_Perfil,

                 @Codigo_Campo_Variable

 END

      /************************************************************************/

      /***** Fin ciclo recorre detalle perfil *********************************/

      /************************************************************************/

         CLOSE Cursor_Detalle

         DEALLOCATE Cursor_Detalle

         DROP TABLE #paso

         /************************************************************************/

         /***** Graba encabezado del voucher *************************************/

         /************************************************************************/

         INSERT INTO bac_cnt_voucher

                     (

                     id_sistema		,

                     Numero_Voucher	,

                     Fecha_Ingreso	,

                     Fecha_Contable	,

                     Glosa		,

                     Tipo_Voucher	,

                     Tipo_Operacion	,

                     Operacion		,

                     correlativo	,

                     Documento		,

                     codigo_producto	,

                     Moneda_Operacion	,

                     Mercado		,

                     Rut_cliente	,

                     Codigo_Cliente	,

                     tipo_cambio

                     )

         VALUES      (

                     @ID_Sistema	,

                     @Numero_Voucher	,

                     @Fecha_Hoy		,

                     @Fecha_Ctb		,

                     @Glosa_Perfil	,

                     @Tipo_Voucher	,

                     @Tipo_Operacion	,

                     @Operacion		,

                     @Correlativo	,

                     @Documento		,

                     @codigo_instrumento,

                     @Codigo_Moneda	,

                     @Tipo_Mercado	,

                     @Rut_Cliente	,

                     @Codigo_Cliente	,

                     @tipo_cambio

                     )

         IF @@error <> 0 BEGIN

            INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB008: Fallo al agregar encabezado de Voucher.' + @Mensaje_Error)

            SELECT @Control_Error = 1

         END



	IF @Total_Debe <> @Total_Haber BEGIN

            INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB009: Voucher no cuadra.' + @Mensaje_Error)

            SELECT @Control_Error = 0

         END

         IF @control_error = 1 BEGIN

           DELETE bac_cnt_detalle_voucher WHERE numero_voucher = @Numero_Voucher

           DELETE bac_cnt_voucher         WHERE numero_voucher = @Numero_Voucher

         END ELSE BEGIN

            SELECT @Numero_Voucher = @Numero_Voucher + 1

         END

      END

      FETCH NEXT FROM Cursor_Movimiento

            INTO @ID_Sistema,

                 @Tipo_Movimiento,

                 @Tipo_Operacion,

                 @Operacion,

                 @Correlativo,

@Codigo_Instrumento,

                 @Moneda_Instrumento,

                 @Documento,

                 @Fecha_Ctb,

                 @Codigo_Moneda,

           @Tipo_Mercado,

                 @Rut_Cliente,

                @Codigo_Cliente,

                 @Tipo_Cambio

      END

      /*************************************************************************/

      /*************************************************************************/

      /***** Fin ciclo recorre movimientos *************************************/

      /*************************************************************************/

      /*************************************************************************/

      /*************************************************************************/

      IF @@error <> 0 BEGIN

         INSERT INTO bac_cnt_errores VALUES(@Fecha_Hoy, 2, 'CTB011: Fallo del proceso de actualización del parametro contable')

         SELECT @Control_Error = 1

      END

   CLOSE Cursor_Movimiento

   DEALLOCATE Cursor_Movimiento



   IF EXISTS(SELECT Fecha_proceso FROM bac_cnt_errores /*(INDEX=Fecha_Proceso)*/WHERE fecha_proceso = @Fecha_Hoy) BEGIN

         SELECT 'ERROR'

   END ELSE BEGIN

    SELECT 'SI'

   END

   SET NOCOUNT OFF

   RETURN @Control_Error

END


GO
