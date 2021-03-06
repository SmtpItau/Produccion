USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_GenCntVoucher]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GenCntVoucher]  
       (  
         @Fecha_Hoy   DATETIME  
       )  
AS  
BEGIN  
 /* STATUS: comlilado */  
   -- Retona:  
   /*  
------  
0  
  
o mensajes de errores.  
  
   */  
   -- Sp_GenCntVoucher '20100622'  -- 843 select * from cavencaja where canumcontrato = 787  
   -- Sp_GenCntVoucher '20081211'    
   -- Contrato N° 880 -- VOUCHER NO CUADRA OPT,LTE ,LTE, Perfil=1719, Corr.=7 ,LIQ TOTAL EN CLP   
   -- Contrato N° 866 -- VOUCHER NO CUADRA OPT,REV ,REV, Perfil=1720, Corr.=5 ,REV X VALUTA EN CLP       
   -- select * from cntContabiliza where CntContrato = 984   --  -- 133997876  
   -- select * from CaCaja  forma pago tx48 pagando CLP !!!    
   -- select * from CaDetContrato where canumcontrato = 880  
  
  
   -- Sp_GenCntVoucher '20081209'  
   -- sp_genCntVoucher '20081205'  
   -- Sp_GenCntVoucher '15122008'  
   -- Sp_GenCntVoucher '20081212'  
   -- Sp_GenCntVoucher '20090908'  
   -- MAP 23 Septiembre Se refresca la informacion de BAC hasta que se degrade el perfomance  
   -- MAP 28 Oct. Se corrige indicacion de linea de Perfil cuando se produce descuadre.  
   -- MAP D.Matamala correig mensaje que aun indicaba mal  
   -- MAP 13 Noviembre Entre 13 Nov.  
   -- Sp_GenCntVoucher '20121012'
  
   -- ASVG 25 Febrero 2011 Contabilidad Forward Americano no es en SAO, sino en Bac, por lo que no deben aparecer en los voucher.  
  
   SET NOCOUNT ON  
  
   DECLARE @Errores                INTEGER  
   Declare @ErrPrfCorr             integer  
  
   DECLARE @Control_Error          INTEGER  
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
   DECLARE @iSolobalance           INTEGER  
  
   Declare @Valor_Campo            VARCHAR(250)  
  
   -- Opciones  
   declare @CntSisCod              varchar(3)  
      ,      @CntTipoMovimiento    varchar(3)     
      ,      @CntTipoOperacion     varchar(5)  
      ,      @CntInstrumento       varchar(10)  
      ,      @CntMoneda            varchar(5)  
      ,      @CntContrato          numeric(10)  
      ,      @CntComponente        numeric(8)  
      ,      @CntFolio             numeric(10)  
      ,      @CntTesumenErrores    varchar(5000)  
  
   create table #MensajeParametros ( msg Varchar(300) )  
  
  
   declare @ErrorProc int  
   insert into #MensajeParametros  
   Exec @ErrorProc  = Sp_ImportaDataBacParamSuda  
   IF @ErrorProc <> 0  
   Begin           
      select convert( varchar(80) ,  'Faltan Parametros de Cierre en BAC' ) as MsgStatus  
      RETURN 1  
   end  
  
  
   BEGIN TRAN   
  
   SET @Control_Error = 0  
  
   SELECT @Numero_Voucher = ISNULL(VoucherNumero,0) + 1  FROM   opcionesgeneral    
   IF @@ERROR <> 0   
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Obteniendo Folio Voucher')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   SET @CntTesumenErrores = ''  
  
   Select @CntTesumenErrores = case when devengo = 0 then 'Falta Valorizar' else '' end from OpcionesGeneral  
   if @CntTesumenErrores <> '' Begin  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES (@CntTesumenErrores)  
      GOTO   FIN_PROCEDIMIENTO     
   end  -- Update Opcionesgeneral set devengo = 0   
  
  
   DELETE FROM CntContabiliza  
   DELETE FROM CntError    
  
   DELETE FROM OpcDetalleVOUCHER    
          FROM OpcVoucher,OpcDetalleVoucher   
         WHERE OpcVoucher.Numero_Voucher = OpcDetalleVOUCHER.Numero_Voucher    
           AND OpcVoucher.Fecha_Ingreso  = @Fecha_Hoy  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO OpcDetalleVoucher')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   
   DELETE FROM OpcVoucher     
         WHERE OpcVoucher.Fecha_Ingreso = @Fecha_Hoy  
  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA BORRANDO OpcVoucher')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   declare @CargaParamCierre numeric(3)  
   select  @CargaParamCierre = CargaParamSudaCierre -- , deberá actualizarse con el cierre de mesa  
           from OpcionesGeneral                                   
   IF @@ERROR <> 0   
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Obteniendo Swith de Carga Parametros BAC')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   if @CargaParamCierre = 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA No se han cargado Parametros BAC Abra y Cierre Mesa')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   SET    @Fecha          = CONVERT(CHAR(8),@Fecha_Hoy,112)  
  
   INSERT INTO CntError  
   EXECUTE @Control_Error = dbo.SP_GenCntContabiliza @Fecha   
  
     
   IF @Control_Error <> 0  Begin  
      SELECT @Control_Error = 1  
      -- INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA dbo.SP_GenCntContabiliza')  
      -- Se deben trasmitir los errores de CntContabiliza  
      GOTO   FIN_PROCEDIMIENTO  
      GOTO FIN_PROCEDIMIENTO  
   end  
  
   /*   PROD-13028 Se modifica criterio de descarte de operaciones
        a contabilizar en SAO   
   SELECT *   
   ,      Puntero = identity(Int)  
   INTO   #CntContabiliza  
   FROM   CntContabiliza AS Conta with (nolock)  
   --ASVG_20110225 Contabilidad Forward Americano no es en SAO, sino en Bac.  
          JOIN CaEncContrato AS Contrato ON Conta.CntContrato = Contrato.CaNumContrato  
   WHERE  CaCodEstructura <> '8'  
   */
   
   SELECT * 
   ,      Puntero = identity(Int)
   INTO   #CntContabiliza
   FROM   CntContabiliza AS Conta with (nolock)   
          JOIN CaEncContrato AS Contrato ON Conta.CntContrato = Contrato.CaNumContrato
          -- PROD-13028 Solo se contabilizan los productos que no tienen contabilidad externa
          JOIN OpcionEstructura AS Estruc ON Estruc.OpcEstCod = Contrato.CaCodEstructura
   WHERE  OpcContabExterna = 'N'

  
   DECLARE @iPuntero         INTEGER  
   DECLARE @iRegistros       INTEGER  
   DECLARE @iFound           INTEGER  
   DECLARE @iPunteroDetalle  INTEGER  
   DECLARE @iRegistroDetalle INTEGER  
  
   SELECT  @iRegistros = MAX(Puntero)  
   ,       @iPuntero   = MIN(Puntero)  
   FROM    #CntContabiliza   
  
   WHILE   @iRegistros >= @iPuntero  
   BEGIN   
      --SELECT @Mensaje_Error = ''  
      SELECT @CntSisCod           = CntSisCod  
      ,      @CntTipoMovimiento   = CntTipoMovimiento     
      ,      @CntTipoOperacion    = CntTipoOperacion  
      ,      @CntInstrumento      = CntInstrumento  
      ,      @CntMoneda           = CntMoneda  
      ,      @CntContrato         = CntContrato    
      ,      @CntComponente       = CntComponente  
      ,      @CntFolio            = CntFolio  
      ,      @iFound              = -1    
      ,      @Mensaje_Error       = 'Oper. N° ' + CONVERT(VARCHAR(10),@CntContrato ) + CONVERT(VARCHAR(10), @CntComponente )  
                                                + ' -- PERFIL NO EXISTE ' + @CntSisCod + ',' + @CntTipoMovimiento   
                                                + ',' + @CntTipoOperacion + ',' + @CntInstrumento + ',' + @CntMoneda  
      FROM   #CntContabiliza  
      WHERE  Puntero              = @iPuntero  
  
      SELECT @iFound              = 0  
      ,      @tipo_voucher        = tipo_voucher  
      ,      @Glosa_Perfil        = glosa_perfil  
      ,      @Folio_Perfil        = folio_perfil  
      FROM   BacParamSudaPERFIL_CNT with (nolock)  
      WHERE  id_sistema           = @CntSisCod  
      AND    tipo_movimiento      = @CntTipoMovimiento  
      AND    tipo_operacion       = @CntTipoOperacion  
      AND    codigo_instrumento   = @CntInstrumento  
      AND    moneda_instrumento   = @CntMoneda  
  
      IF @iFound = -1  
      BEGIN  
        SET @Control_Error = 1  
        INSERT INTO CntError (Mensaje) VALUES (@Mensaje_Error)  
        SET @CntTesumenErrores = rtrim(@CntTesumenErrores) + ' ' + @Mensaje_Error  
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
         FROM    BacparamSudaPERFIL_DETALLE_CNT  with (nolock)  
         WHERE   folio_perfil           = @Folio_Perfil  
  
         SELECT  @iRegistroDetalle      = MAX(Puntero)  
         ,       @iPunteroDetalle       = MIN(Puntero)  
         FROM    #PERFIL_DETALLE  
  
             SET @Correlativo_Voucher   = 0  
             SET @Total_Debe            = 0.0  
             SET @Total_Haber           = 0.0  
  
         WHILE   @iRegistroDetalle >= @iPunteroDetalle  
         BEGIN  
            select @Valor_Campo = ''  
            SELECT @codigo_campo            = codigo_campo  
            ,      @tipo_movimiento_cuenta  = tipo_movimiento_cuenta  
            ,      @perfil_fijo             = perfil_fijo  
            ,      @codigo_cuenta           = codigo_cuenta  
            ,      @correlativo_perfil      = correlativo_perfil  
            ,      @codigo_campo_variable   = codigo_campo_variable  
            ,      @Mensaje_Error           = 'Operacion N° ' + CONVERT(VARCHAR(10),@CntContrato) + ' -- No retorna monto a Contabilizar'  
            ,      @Correlativo_Voucher     = @Correlativo_Voucher + 1  
            FROM #PERFIL_DETALLE  
            WHERE  Puntero                  = @iPunteroDetalle  
    
            EXECUTE @Control_Error          = SP_RETORNA_MONTO_CONTABILIZA @CntSisCod  
                                                                         , @CntTipoMovimiento  
                                                                         , @CntTipoOperacion  
                                                                         , @CntContrato  
                                                                         , @CntFolio  
                                                                         , @CntComponente  
                                                                         , @Codigo_Campo  
                                                                         , @Reversa  
                                                                         , @Monto           OUTPUT  
--select 'debug', '@Monto', @Monto  
   
            IF @Control_Error <> 0  
            BEGIN  
               INSERT INTO CntERROR (Mensaje) VALUES (@Mensaje_Error)  
               GOTO FIN_PROCEDIMIENTO  
            END  
  
            SELECT @moneda = 0  
            IF @codigo_campo in ( 310, 328, 329, 330, 331 )  
            BEGIN  
               SELECT @Moneda = @CntMoneda             
            END  
            ELSE   
            BEGIN  
               IF @codigo_campo in ( 300 )  
                 SELECT @Moneda = @CntInstrumento     
               ELSE  
                 SELECT @Moneda = 999 -- Campo ML      
            END  
  
            IF @Monto <> 0.0  
      BEGIN  
               IF @Perfil_Fijo = 'N'  
               BEGIN  
                  EXECUTE @Control_Error = SP_RETORNA_CUENTA_CONTABILIZA @CntSisCod  
                                                                       , @CntTipoMovimiento  
                                                                       , @CntTipoOperacion  
                                                                       , @CntContrato  
                                                                       , @CntComponente  
                                                                       , @folio_perfil  
                                                                       , @correlativo_perfil  
                                                                       , @codigo_campo_variable  
                                                                       , @monto  
                                                                       , @codigo_cuenta  OUTPUT, @Valor_Campo   OUTPUT  
--sp_helptext SP_RETORNA_CUENTA_CONTABILIZA  
  
                  IF @Control_Error <> 0  
                  BEGIN  
                      SELECT  @Mensaje_Error = 'Cont. ' + CAST( ISNULL( @CntContrato, 0 ) AS VARCHAR(10) ) + ', ' +  
                                               'Comp. ' + CAST( ISNULL( @CntComponente, 0 ) AS VARCHAR(10) ) + ', ' +   
                                               'Perfil ' + CAST( ISNULL( @folio_perfil, 0 ) AS VARCHAR(10) ) + ', ' +   
                                               'Linea ' + CAST( ISNULL( @correlativo_perfil, 0 ) AS VARCHAR(10) ) + ', ' +  
                                               'Codigo' + LTRIM(RTRIM(@Valor_Campo) ) + ',' +  
                                               'ERROR_PROC Perfil incompleto '  
                                                 
                     INSERT INTO CntERROR (Mensaje) VALUES (@Mensaje_Error)  
                     GOTO FIN_PROCEDIMIENTO  
                 END  
  
               END -- Perfil Fijo = 'N'  
  
               -- MAP   
               -- select @ErrPrfCorr = 1   MAP 02 Noviembre 2009, Correcion de Logica  
               IF RTRIM(@Codigo_Cuenta) <> ''  
               BEGIN  
                  Select @ErrPrfCorr = @correlativo_perfil + 1 -- MAP 02 Noviembre 2009, Correcion Logica, se asume que el prox. puede fallar  
  
                     SET @Tipo_Movimiento_Cuenta = CASE WHEN @Monto < 0.0 and @Tipo_Movimiento_Cuenta = 'D' THEN 'H'  
                     WHEN @Monto < 0.0 and @Tipo_Movimiento_Cuenta = 'H' THEN 'D'  
                                                        ELSE @Tipo_Movimiento_Cuenta  
                                                   END  
                     SET @Monto                  = CASE WHEN @Moneda = 999 THEN ROUND(ABS(@Monto),0) ELSE ABS(@Monto) END  
  
                  IF @Tipo_Movimiento_Cuenta = 'D'  
                     SET @Total_Debe  = @Total_Debe  + @Monto  
  
                  IF @Tipo_Movimiento_Cuenta = 'H'  
                     SET @Total_Haber = @Total_Haber + @Monto  
  
  
  
                     INSERT INTO OpcDetalleVoucher  
                     (   Numero_Voucher  , Correlativo          , Cuenta         , Tipo_Monto              , Monto  , Moneda  )  
                     VALUES  
                     (   @Numero_Voucher , @Correlativo_Voucher , @Codigo_Cuenta , @Tipo_Movimiento_Cuenta , @Monto , @Moneda )  
  
                     IF @@ERROR <> 0   
                     BEGIN  
                        SELECT @Control_Error = 1  
                      SELECT  @Mensaje_Error = 'Cont. ' + CAST( ISNULL( @CntContrato, 0 ) AS VARCHAR(10) ) + ', ' +  
                                               'Comp. ' + CAST( ISNULL( @CntComponente, 0 ) AS VARCHAR(10) ) + ', ' +   
                                               'Perfil ' + CAST( ISNULL( @folio_perfil, 0 ) AS VARCHAR(10) ) + ', ' +   
                                               'Linea ' + CAST( ISNULL( @correlativo_perfil, 0 ) AS VARCHAR(10) ) + ', ' +  
                         'ERROR_PROC FALLA AGREGANDO DETALLE DE VOUCHER '  
  
                        INSERT CNTError (Mensaje) VALUES (@Mensaje_Error)  
                        GOTO   FIN_PROCEDIMIENTO  
                     END  
               --ELSE                   MAP 02 Noviembre 2009  
        --   select @ErrPrfCorr = @correlativo_perfil   MAP 02 Noviembre 2009  
               END ELSE  
               BEGIN  
                      SELECT  @Mensaje_Error = 'Cont. ' + CAST( ISNULL( @CntContrato, 0 ) AS VARCHAR(10) ) + ', ' +  
                                               'Comp. ' + CAST( ISNULL( @CntComponente, 0 ) AS VARCHAR(10) ) + ', ' +   
                                               'Perfil ' + CAST( ISNULL( @folio_perfil, 0 ) AS VARCHAR(10) ) + ', ' +   
                                               'Linea ' + CAST( ISNULL( @correlativo_perfil, 0 ) AS VARCHAR(10) ) + ', ' +  
                                               'Codigo ' + LTRIM(RTRIM(@Valor_Campo) ) + ', ' +  
                                               'Perfil incompleto '  
  
  
                  INSERT INTO CntERROR (Mensaje) VALUES (@Mensaje_Error)  
                  GOTO FIN_PROCEDIMIENTO  
               END  
  
            END -- Monto <> 0.0  
            SELECT @iPunteroDetalle = @iPunteroDetalle + 1  
         END -- While Detalle  
  
         DROP TABLE #PERFIL_DETALLE  
  
         IF @Total_Debe <> @Total_Haber     
         BEGIN  
---select 'debug', '@Total_Debe' , @Total_Debe , '@Total_Haber', @Total_Haber  
            SELECT @Control_Error = 1  
            SELECT @Mensaje_Error = 'Contrato N° ' + CONVERT(VARCHAR(10),@CntContrato) + ' -- VOUCHER NO CUADRA '   
                                      + @CntSisCod + ',' + @CntTipoMovimiento   
                                      + ' ,' + @CntTipoOperacion  
                                      + ', Perfil=' + convert( varchar(8), @folio_perfil  )   
                                      + ', Corr.=' + convert( varchar(3), @ErrPrfCorr  )  
                                      + ' ,' + @glosa_perfil  
            --INSERT INTO ERRORES_CNT (Mensaje) VALUES (@Mensaje_Error)  
            INSERT INTO CntError (Mensaje) VALUES (@Mensaje_Error)  
            GOTO FIN_PROCEDIMIENTO   
         END  
  
         
           INSERT INTO OpcVoucher  -- select * from OpcVoucher  
            (   Numero_Voucher  , Fecha_Ingreso , Glosa         , Tipo_Voucher  , Tipo_Operacion  , Operacion  , Componente,  Folio_Perfil  )  
           VALUES  
            (   @Numero_Voucher , @Fecha        , @Glosa_Perfil , @Tipo_Voucher , @CntTipoOperacion , @CntContrato , @CntComponente,  @Folio_Perfil )  
  
            IF @@ERROR <> 0  
            BEGIN  
               SELECT @Control_Error = 1  
               INSERT INTO CntError (Mensaje) VALUES ('ERROR_PROC FALLA AGREGANDO ENCABEZADO VOUCHER')  
               GOTO FIN_PROCEDIMIENTO  
            END  -- select * from cntcontabiliza  
  
         SET @Numero_Voucher = @Numero_Voucher + 1  
      END -- IF @iFound = -1  
      SET @iPuntero       = @iPuntero + 1  
   END -- While Perfil  
  
FIN_PROCEDIMIENTO:  
   COMMIT TRANSACTION -- para grabar todo y los errores  
  
   SELECT @errores = COUNT(isnull(mensaje,0)) FROM CntError with (nolock)  
  
   UPDATE OpcionesGeneral with (rowlock) SET VoucherNumero = @Numero_Voucher   
  
   IF @errores = 0  -- simula que no hay errores  
   begin  
      UPDATE OpcionesGeneral with (rowlock) SET contabilidad = '1'    
      select Convert( varchar(290) , '0' )  
   end  
   ELSE  
   begin  
      if @errores = 1 Select mensaje from CntError  
      else SELECT distinct @CntTesumenErrores from cntError  
   end  
END -- PROCEDURE  
GO
