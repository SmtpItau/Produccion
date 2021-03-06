USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZACION]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTABILIZACION]  
   (   @Fecha_Hoy   DATETIME   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @Errores                INT  
  
   DECLARE @Control_Error          INT  
   DECLARE @Mensaje_Error          VARCHAR(100)  
   DECLARE @Numero_Voucher         NUMERIC(10)  
   DECLARE @Correlativo_Voucher    NUMERIC(5)  
   DECLARE @Tipo_Voucher           CHAR(1)  
  
   DECLARE @ID_Sistema             CHAR(3)  
   DECLARE @Tipo_Movimiento        CHAR(3)  
   DECLARE @Tipo_Operacion         CHAR(5)  
   DECLARE @Operacion              NUMERIC(10)  
   DECLARE @Reversa                NUMERIC(1)  
   DECLARE @Correlativo            NUMERIC(5)  
   DECLARE @Codigo_Instrumento     CHAR(10)  
   DECLARE @Moneda_Instrumento     CHAR(6)  
   DECLARE @Tipo_Perfil            CHAR(1)  
   DECLARE @Glosa_Perfil           CHAR(70)  
   DECLARE @Monto                  FLOAT  
   DECLARE @Total_Debe             FLOAT  
   DECLARE @Total_Haber            FLOAT  
   DECLARE @Folio_Perfil           NUMERIC(5)  
   DECLARE @Valor_Compra           NUMERIC(21,4)  
   DECLARE @Valor_Venta            NUMERIC(21,4)  
   DECLARE @nCodMon                NUMERIC(3)  
   DECLARE @nCodCnv                NUMERIC(3)  
   DECLARE @Moneda                 NUMERIC(3)  
   DECLARE @Moneda_compra          NUMERIC(3)  
   DECLARE @Moneda_venta           NUMERIC(3)  
   DECLARE @nCodPro                NUMERIC(2)  
   DECLARE @cTipOpe                CHAR(1)  
   DECLARE @codigo_producto        NUMERIC(2)  
  
   DECLARE @Codigo_Campo           NUMERIC(3)  
   DECLARE @Tipo_Movimiento_Cuenta CHAR(1)  
   DECLARE @Perfil_Fijo            CHAR(1)  
   DECLARE @Codigo_Cuenta          CHAR(20)  
   DECLARE @Correlativo_Perfil     NUMERIC(3)  
   DECLARE @Codigo_Campo_Variable  NUMERIC(3)  
   DECLARE @fecha                  CHAR(8)  
   DECLARE @iSolobalance           INT  
  
  
   BEGIN TRANSACTION  
  
   SET @Control_Error = 0  
  
   DELETE FROM BAC_CNT_CONTABILIZA  
   DELETE FROM ERRORES_CNT           
  
   DELETE FROM DETALLE_VOUCHER_CNT   
          FROM VOUCHER_CNT,detalle_voucher_cnt  
         WHERE voucher_cnt.Numero_Voucher = detalle_voucher_cnt.Numero_Voucher    
           AND voucher_cnt.Fecha_Ingreso  = @Fecha_Hoy  
  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT ERRORES_CNT (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO ENCABEZADO VOUCHER')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
   
   -- MAP 05 20070814 No se guardará más información histórica de esta tabla  
   TRUNCATE TABLE DETALLE_VOUCHER_CNT_BALANCE  
  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT ERRORES_CNT (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO ENCABEZADO VOUCHER')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   DELETE FROM VOUCHER_CNT   
         WHERE voucher_cnt.Fecha_Ingreso = @Fecha_Hoy  
  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT ERRORE_CNT (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO DETALLE VOUCHER')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   -- MAP 05 20070814 No se guardará más información histórica de esta tabla  
   TRUNCATE TABLE VOUCHER_CNT_BALANCE  
  
  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT ERRORE_CNT (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO DETALLE VOUCHER')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
  
   SELECT @Numero_Voucher = ISNULL(MAX(Numero_Voucher),0) + 1   
   FROM   VOUCHER_CNT     with (nolock)  
  
   SET    @Fecha          = CONVERT(CHAR(8),@Fecha_Hoy,112)  
  
  
   EXECUTE @Control_Error = dbo.SP_LLENA_CONTABILIZA @Fecha   
  
   IF @Control_Error <> 0  
      GOTO FIN_PROCEDIMIENTO  

/*---	20200709-Se omite porQUE NO HABRÁ CONTA DE OPCIONES POR PASAR A MUREX --  
   EXECUTE @Control_Error = dbo.SP_LLENA_CONTABILIZA_FAMERICANO @Fecha  
  
   IF @Control_Error <> 0  
      GOTO FIN_PROCEDIMIENTO  
*/
  
   SELECT *   
   ,      Puntero = identity(Int)  
   INTO   #MI_BAC_CNT_CONTABILIZA  
   FROM   BAC_CNT_CONTABILIZA   with (nolock)  
  
   DECLARE @iPuntero         INT  
   DECLARE @iRegistros       INT  
   DECLARE @iFound           INT  
   DECLARE @iPunteroDetalle  INT  
   DECLARE @iRegistroDetalle INT  
  
   SELECT  @iRegistros = MAX(Puntero)  
   ,       @iPuntero   = MIN(Puntero)  
   FROM   #MI_BAC_CNT_CONTABILIZA   
  
   WHILE   @iRegistros >= @iPuntero  
   BEGIN  
      SELECT @id_sistema          = id_sistema  
      ,      @tipo_movimiento     = Tipo_Movimiento     
      ,      @tipo_operacion      = Tipo_operacion  
      ,      @operacion           = Operacion  
      ,      @correlativo         = correlativo  
      ,      @codigo_instrumento  = codigo_instrumento  
      ,      @moneda_instrumento  = moneda_instrumento  
      ,      @valor_compra        = valor_compra  
      ,      @valor_venta         = valor_venta  
      ,      @codigo_producto     = codigo_producto  
      ,      @moneda_compra       = moneda_compra  
      ,      @moneda_venta        = moneda_venta  
      ,      @reversa             = reversa  
      ,      @ctipope             = CASE WHEN tipo_opcion = '1' THEN 'C' ELSE 'V' END  
      ,      @iFound              = -1  
      ,      @iSolobalance        = cantidad_cortes  
      ,      @Mensaje_Error       = 'Oper. N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- PERFIL NO EXISTE ' + @id_sistema + ',' + @tipo_movimiento + ',' + @tipo_operacion + ',' + @codigo_instrumento + ',' + @moneda_instrumento  
      FROM   #MI_BAC_CNT_CONTABILIZA  
      WHERE  Puntero              = @iPuntero  
  
      SELECT @iFound              = 0  
      ,      @tipo_voucher        = tipo_voucher  
      ,      @Glosa_Perfil        = glosa_perfil  
      ,      @Folio_Perfil        = folio_perfil  
      FROM   BacParamSuda..PERFIL_CNT with (nolock)  
      WHERE  id_sistema           = @id_sistema  
      AND    tipo_movimiento      = @Tipo_Movimiento  
      AND    tipo_operacion       = @Tipo_Operacion  
      AND    codigo_instrumento   = @Codigo_Instrumento  
      AND    moneda_instrumento   = @Moneda_Instrumento  
  
      IF @iFound = -1  
      BEGIN  
        SET @Control_Error = 1  
        INSERT INTO ERRORES_CNT (Mensaje) VALUES (@Mensaje_Error)  
      END ELSE  
      BEGIN  
         SELECT  codigo_campo           = codigo_campo  
         ,       tipo_movimiento_cuenta = tipo_movimiento_cuenta  
         ,       perfil_fijo            = perfil_fijo  
         ,       codigo_cuenta          = codigo_cuenta  
         ,       correlativo_perfil     = correlativo_perfil  
         ,       codigo_campo_variable  = codigo_campo_variable  
         ,       Puntero                = identity(INT)  
         INTO    #PERFIL_DETALLE  
         FROM    BacparamSuda..PERFIL_DETALLE_CNT  with (nolock)  
         WHERE   folio_perfil           = @Folio_Perfil  
  
         SELECT  @iRegistroDetalle      = MAX(Puntero)  
         ,       @iPunteroDetalle       = MIN(Puntero)  
         FROM    #PERFIL_DETALLE  
  
             SET @Correlativo_Voucher   = 0  
             SET @Total_Debe            = 0.0  
             SET @Total_Haber           = 0.0  
  
         WHILE   @iRegistroDetalle >= @iPunteroDetalle  
         BEGIN  
  
            SELECT @codigo_campo            = codigo_campo  
            ,      @tipo_movimiento_cuenta  = tipo_movimiento_cuenta  
            ,      @perfil_fijo             = perfil_fijo  
            ,      @codigo_cuenta           = codigo_cuenta  
            ,      @correlativo_perfil      = correlativo_perfil  
            ,      @codigo_campo_variable   = codigo_campo_variable  
            ,      @Mensaje_Error           = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- No retorna monto a Contabilizar'  
            ,      @Correlativo_Voucher     = @Correlativo_Voucher + 1  
            FROM   #PERFIL_DETALLE  
            WHERE  Puntero                  = @iPunteroDetalle  
  
            EXECUTE @Control_Error          = SP_RETORNA_MONTO_CONTABILIZA @id_sistema  
                                                                         , @Tipo_Movimiento  
                                                                         , @Tipo_Operacion  
                            , @Operacion  
                                                                         , @Correlativo  
                                                                      , @Codigo_Campo  
                                                                         , @Reversa  
                                                                         , @Monto           OUTPUT  
  
            IF @Control_Error <> 0  
            BEGIN  
               INSERT INTO ERRORES_CNT (Mensaje) VALUES (@Mensaje_Error)  
               GOTO FIN_PROCEDIMIENTO  
            END  
  
            SELECT @moneda = 0  
            IF @codigo_campo = 300  
            BEGIN  
               SELECT @Moneda = @moneda_compra  
            END  
  
  
            IF @codigo_producto IN(2,9)  
            BEGIN  
               IF @Tipo_Movimiento = 'VCT' AND @Tipo_Operacion = 'V2'  
               BEGIN  
                  SET @Moneda = CASE WHEN @Codigo_Campo IN(908,909) THEN 13  
                                     WHEN @Codigo_Campo IN(911,912) THEN 999  
                                     WHEN @Codigo_Campo IN(914)     THEN @moneda_compra  
                                     WHEN @Codigo_Campo IN(915)     THEN @moneda_venta  
                                     ELSE                                @Moneda  
                                END  
               END ELSE  
               BEGIN  
                  SET @Moneda = CASE WHEN ROUND(@valor_compra,0) = ROUND(@monto,0) THEN @moneda_compra  
                                     WHEN ROUND(@valor_venta,0)  = ROUND(@monto,0) THEN @moneda_venta  
                                     ELSE                                               @Moneda  
                                END  
               END  
            END  
  
  
            SET @moneda = CASE WHEN @Codigo_Campo IN(300)                             THEN @moneda_compra  
                               WHEN @Codigo_Campo IN(310)                             THEN @moneda_venta  
                               WHEN @Codigo_Campo IN(301,303,304,305,306,307,311,312) THEN 999  
                               WHEN @Codigo_Campo IN(308,309)                         THEN 999  
                               ELSE                                                        @Moneda  
                          END  
  
            IF @tipo_movimiento IN('LIA','ANT') AND @Codigo_Campo IN(609,905)  
  SET @Moneda = @Codigo_Instrumento  
  
            IF @moneda = 0    
            BEGIN  
               SET @moneda = 999  
            END  
  
  
            IF @Monto <> 0.0  
            BEGIN  
               IF @Perfil_Fijo = 'N'  
               BEGIN  
                  SELECT  @Mensaje_Error = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- No retorna Cuenta Contable '  
                  EXECUTE @Control_Error = SP_RETORNA_CUENTA_CONTABILIZA @id_sistema  
                                                                       , @tipo_movimiento  
                                                                       , @tipo_operacion  
                                                                       , @operacion  
                                                                       , @correlativo  
                                                                       , @folio_perfil  
                                                                       , @correlativo_perfil  
                                                                       , @codigo_campo_variable  
                                                                       , @monto  
                                                                       , @codigo_cuenta      OUTPUT  
                  IF @Control_Error <> 0  
                  BEGIN  
                     INSERT INTO ERRORES_CNT (Mensaje) VALUES (@Mensaje_Error)  
                     GOTO FIN_PROCEDIMIENTO  
                 END  
               END -- Perfil Fijo = 'N'  
  
               IF RTRIM(@Codigo_Cuenta) <> ''  
               BEGIN  
                  SELECT @Mensaje_Error          = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- ERROR_PROC FALLA AGREGANDO DETALLE DE VOUCHER'  
                     SET @Tipo_Movimiento_Cuenta = CASE WHEN @Monto < 0.0 and @Tipo_Movimiento_Cuenta = 'D' THEN 'H'  
                                                        WHEN @Monto < 0.0 and @Tipo_Movimiento_Cuenta = 'H' THEN 'D'  
                                                        ELSE                                                     @Tipo_Movimiento_Cuenta  
                                                   END  
                     SET @Monto                  = CASE WHEN @Moneda = 999 THEN ROUND(ABS(@Monto),0) ELSE ABS(@Monto) END  
  
                  IF @Tipo_Movimiento_Cuenta = 'D'  
                     SET @Total_Debe  = @Total_Debe  + @Monto  
  
                  IF @Tipo_Movimiento_Cuenta = 'H'  
                     SET @Total_Haber = @Total_Haber + @Monto  
  
  
                  INSERT INTO DETALLE_VOUCHER_CNT_BALANCE  
                  (   Numero_Voucher  , Correlativo          , Cuenta         , Tipo_Monto              , Monto  , Moneda  )  
                  VALUES  
                  (   @Numero_Voucher , @Correlativo_Voucher , @Codigo_Cuenta , @Tipo_Movimiento_Cuenta , @Monto , @Moneda )  
  
                  IF @iSolobalance = 1  
                  BEGIN  
                     INSERT INTO DETALLE_VOUCHER_CNT  
                     (   Numero_Voucher  , Correlativo          , Cuenta         , Tipo_Monto              , Monto  , Moneda  )  
                     VALUES  
                     (   @Numero_Voucher , @Correlativo_Voucher , @Codigo_Cuenta , @Tipo_Movimiento_Cuenta , @Monto , @Moneda )  
  
                     IF @@ERROR <> 0   
                     BEGIN  
                        SELECT @Control_Error = 1  
                        INSERT ERRORES_CNT (Mensaje) VALUES (@Mensaje_Error)  
                        GOTO   FIN_PROCEDIMIENTO  
                     END  
                  END  
  
               END -- Cuenta <> ''  
  
            END -- Monto <> 0.0  
            SELECT @iPunteroDetalle = @iPunteroDetalle + 1  
         END -- While Detalle  
  
         DROP TABLE #PERFIL_DETALLE  
  
         IF @Total_Debe <> @Total_Haber     
         BEGIN  
            SELECT @Control_Error = 1  
            SELECT @Mensaje_Error = 'Operacion N° ' + CONVERT(VARCHAR(10),@Operacion) + ' -- ERROR_PROC VOUCHER NO CUADRA ' + @id_sistema + ',' + @tipo_movimiento + ',' + @tipo_operacion + ',' + @glosa_perfil  
            INSERT INTO ERRORES_CNT (Mensaje) VALUES (@Mensaje_Error)  
         END  
  
         DECLARE @numero    VARCHAR(10)  
             SET @numero    = CONVERT(CHAR(3),@correlativo)  
             SET @numero    = REPLICATE('0', 3 - LTRIM(RTRIM(LEN(@numero)))) + LTRIM(RTRIM(@numero))  
  
             SET @numero    = RTRIM(CONVERT(CHAR(7),@operacion))  
             SET @operacion = CONVERT(NUMERIC(7),@numero)  
  
         INSERT INTO VOUCHER_CNT_BALANCE  
         (   Numero_Voucher  , Fecha_Ingreso , Glosa         , Tipo_Voucher     , Tipo_Operacion  , Operacion  , Folio_Perfil  )  
         VALUES  
         (   @Numero_Voucher , @Fecha        , @Glosa_Perfil , @Tipo_Voucher    , @Tipo_Operacion , @Operacion , @Folio_Perfil )  
  
          
         IF @iSolobalance = 1  
         BEGIN  
            INSERT INTO VOUCHER_CNT  
            (   Numero_Voucher  , Fecha_Ingreso , Glosa         , Tipo_Voucher  , Tipo_Operacion  , Operacion  , Folio_Perfil  )  
            VALUES  
            (   @Numero_Voucher , @Fecha        , @Glosa_Perfil , @Tipo_Voucher , @Tipo_Operacion , @Operacion , @Folio_Perfil )  
  
            IF @@ERROR <> 0  
            BEGIN  
               SELECT @Control_Error = 1  
               INSERT INTO ERRORES_CNT (Mensaje) VALUES ('ERROR_PROC FALLA AGREGANDO ENCABEZADO VOUCHER')  
               GOTO FIN_PROCEDIMIENTO  
            END  
         END  
  
         SET @Numero_Voucher = @Numero_Voucher + 1  
      END -- IF @iFound = -1  
      SET @iPuntero    = @iPuntero + 1  
   END -- While Perfil  
  
FIN_PROCEDIMIENTO:  
   COMMIT TRANSACTION  
  
   SELECT @errores = COUNT(isnull(mensaje,0)) FROM ERRORES_CNT with (nolock)  
  
   IF @errores = 0  
      UPDATE MFAC with (rowlock) SET acsw_contafwd = '1' , acsw_fd = '0'  
  
   SELECT @errores  
END -- PROCEDURE  
GO
