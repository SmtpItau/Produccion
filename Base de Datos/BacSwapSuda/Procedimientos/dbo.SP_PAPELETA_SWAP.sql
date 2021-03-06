USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PAPELETA_SWAP]
   (   @iNumeroOperacion   NUMERIC(9)  
   ,   @cUsuario           VARCHAR(15)  
   ,   @cOrigen            VARCHAR(01) = 'N'  
   )  
AS  
BEGIN  
  
   -- Swap: Guardar Como          
   SET NOCOUNT ON          
  
   DECLARE @xMensajeThreshold           VARCHAR(100)          
       SET @xMensajeThreshold           = ISNULL(( SELECT TOP 1 SUBSTRING(Mensaje, 1, 70)          
                                                     FROM BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD          
                                                    WHERE Id_Sistema   = 'PCS'          
                                                      AND Num_Contrato = @iNumeroOperacion ), '')          
          
 DECLARE @xMensajeBloqueos   VARCHAR(100)    
 SET @xMensajeBloqueos    = ISNULL(( SELECT Mensaje_Error FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE    
            WHERE Id_Sistema = 'PCS' AND NumeroOperacion = @iNumeroOperacion    
            AND Error = 'S'    
            AND Linea_Transsaccion = 'BLQCLI' ), '')    
                   
   DECLARE @iInvierte                   INTEGER          
       SET @iInvierte                   = 0          
          
   DECLARE @FechaProceso                CHAR(10)          
   DECLARE @FechaEmision                CHAR(10)          
   DECLARE @HoraEmision                 CHAR(10)          
   DECLARE @Tasa_Tranfer_Recibo  NUMERIC(19,5)          
   DECLARE @Spread_Transfer_Recibo NUMERIC(19,5)          
   DECLARE @Tasa_Tranfer_Pago  NUMERIC(19,5)          
   DECLARE @Spread_Transfer_Pago NUMERIC(19,5)          
   DECLARE @ResMesaDistCLP  NUMERIC(21,0)          
   DECLARE @ResMesaDistUSD  NUMERIC(19,5)          
   DECLARE @xFechaFlujo                 DATETIME          
          
   SELECT  @FechaProceso   = CONVERT(CHAR(10),fechaproc,103)          
   ,       @FechaEmision   = CONVERT(CHAR(10),GetDate(),103)          
   ,       @HoraEmision    = CONVERT(CHAR(10),GetDate(),108)          
   ,       @xFechaFlujo    = fechaproc          
   FROM    SWAPGENERAL          
          
   CREATE TABLE #Cabecera          
   (   NumOperacion               NUMERIC(9)          
   ,   RutCliente                 VARCHAR(12)          
   ,   NomCliente                 VARCHAR(30)          
   ,   Tikker                     VARCHAR(20)          
   ,   vMercadoUsd                NUMERIC(21,4)          
   ,   vMercadoMx                 NUMERIC(21,4)          
   ,   vRazAjusDo                 NUMERIC(21,4)          
   ,   vRazAjusMn                 NUMERIC(21,4)          
   ,   vResMesaDistCLP           NUMERIC(21,0)          
   ,   vResMesaDistUSD           NUMERIC(19,5)          
   )          
          
   DECLARE @ENC_CARTERA_FINANCIERA     VARCHAR(25)          
   DECLARE @ENC_CARTERA_NORMATIVA      VARCHAR(25)          
   DECLARE @ENC_SUBCARTERA_NORMATIVA   VARCHAR(25)          
   DECLARE @ENC_LIBRO                  VARCHAR(25)          
   DECLARE @ENC_AREA_RESPONSABLE       VARCHAR(25)          
          
   SELECT  @ENC_CARTERA_FINANCIERA     = Financiera.tbglosa          
      ,    @ENC_CARTERA_NORMATIVA      = Normativa.tbglosa          
      ,    @ENC_SUBCARTERA_NORMATIVA   = SubCartera.tbglosa          
      ,    @ENC_LIBRO                  = Negociacion.tbglosa          
      ,    @ENC_AREA_RESPONSABLE       = Negociacion.tbglosa          
   FROM    CARTERA          
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg  = 204  AND convert(int,Financiera.tbcodigo1)  = cartera_inversion          
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg   = 1111 AND Normativa.tbcodigo1   = car_Cartera_Normativa          
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Negociacion ON Negociacion.tbcateg = 1552 AND Negociacion.tbcodigo1 = car_Libro          
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg = 1553 AND Responsable.tbcodigo1 = car_area_Responsable           
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg  = 1554 AND SubCartera.tbcodigo1  = car_SubCartera_Normativa           
   WHERE   numero_operacion            = @iNumeroOperacion          
     AND   tipo_flujo                  = 1          
     AND   numero_flujo                = ( SELECT MIN( numero_flujo ) FROM CARTERA WHERE numero_operacion = @iNumeroOperacion AND tipo_flujo = 1)          
          
   DECLARE @FlujoAdicionalActivo FLOAT          
   SELECT  @FlujoAdicionalActivo = 560.23          
          
   DECLARE @FlujoAdicionalPasivo FLOAT          
   SELECT  @FlujoAdicionalPasivo = 565.08          
          
   SELECT DISTINCT          
          @Tasa_Tranfer_Recibo   = Tasa_Transfer         
      ,   @Spread_Transfer_Recibo = Spread_Transfer          
      ,   @ResMesaDistCLP   = Res_Mesa_Dist_CLP          
      ,   @ResMesaDistUSD   = Res_Mesa_Dist_USD          
   FROM   MOVDIARIO          
   WHERE  numero_operacion   = @iNumeroOperacion          
   AND   tipo_flujo    = 1          
          
   SELECT DISTINCT          
          @Tasa_Tranfer_Pago   = Tasa_Transfer          
      ,   @Spread_Transfer_Pago   = Spread_Transfer          
      ,   @ResMesaDistCLP   = Res_Mesa_Dist_CLP          
      ,   @ResMesaDistUSD   = Res_Mesa_Dist_USD          
   FROM   MOVDIARIO          
   WHERE  numero_operacion   = @iNumeroOperacion          
   AND   tipo_flujo    = 2          
          
   IF @Tasa_Tranfer_Recibo IS NULL AND @Spread_Transfer_Recibo IS NULL AND @Tasa_Tranfer_Pago IS NULL AND @Spread_Transfer_Pago IS NULL           
   BEGIN          
      SELECT DISTINCT          
             @Tasa_Tranfer_Recibo    = Tasa_Transfer          
         ,   @Spread_Transfer_Recibo = Spread_Transfer          
         ,   @ResMesaDistCLP      = Res_Mesa_Dist_CLP          
         ,   @ResMesaDistUSD      = Res_Mesa_Dist_USD          
      FROM   MOVHISTORICO          
      WHERE  numero_operacion      = @iNumeroOperacion           
      AND    Tipo_Flujo       = 1          
          
      SELECT DISTINCT          
             @Tasa_Tranfer_Pago      = Tasa_Transfer          
         ,   @Spread_Transfer_Pago   = Spread_Transfer          
         ,   @ResMesaDistCLP      = Res_Mesa_Dist_CLP          
         ,   @ResMesaDistUSD      = Res_Mesa_Dist_USD          
      FROM   MOVHISTORICO          
      WHERE  numero_operacion      = @iNumeroOperacion           
      AND    Tipo_Flujo       = 2          
          
   END          
          
   SET @Tasa_Tranfer_Recibo = ISNULL(@Tasa_Tranfer_Recibo,0.)          
   SET @Spread_Transfer_Recibo = ISNULL(@Spread_Transfer_Recibo,0.)          
   SET @Tasa_Tranfer_Pago = ISNULL(@Tasa_Tranfer_Pago,0.)          
   SET @Spread_Transfer_Pago = ISNULL(@Spread_Transfer_Pago,0.)          
   SET @ResMesaDistCLP  = ISNULL(@ResMesaDistCLP,0)          
   SET @ResMesaDistUSD  = ISNULL(@ResMesaDistUSD,0.)          
          
   SELECT * INTO #CARTERA      FROM CARTERA    WHERE 1 = 2          
   SELECT * INTO #CARTERA_HIST FROM CARTERAHIS WHERE numero_operacion = @iNumeroOperacion AND estado <> 'N'          


   IF @corigen = 'N'          
   BEGIN          
      INSERT INTO #CARTERA          
           SELECT * FROM CARTERA WHERE numero_operacion = @iNumeroOperacion AND estado <> 'N'          
  
      INSERT INTO #CARTERA          
            SELECT his.* FROM #CARTERA_HIST his          
  
   END ELSE          
   BEGIN          
          
      DECLARE @fFechaAnticipo DATETIME          
          SET @fFechaAnticipo = ISNULL(( SELECT MAX(fechaanticipo) FROM CARTERA_UNWIND WHERE numero_operacion = @iNumeroOperacion ),'')          
          
      INSERT INTO #cartera          
      SELECT  numero_operacion          
 , tipo_flujo          
 , numero_flujo          
 , tipo_swap          
 , cartera_inversion          
 , tipo_operacion          
 , codigo_cliente    
 , rut_cliente          
 , fecha_cierre          
 , fecha_inicio          
 , fecha_termino          
 , fecha_inicio_flujo          
 , fecha_vence_flujo          
 , fecha_fijacion_tasa          
 , compra_moneda          
 , compra_capital          
 , compra_amortiza          
 , compra_saldo          
 , compra_interes          
 , compra_spread          
 , compra_codigo_tasa          
 , compra_valor_tasa          
 , compra_valor_tasa_hoy          
 , compra_codamo_capital          
 , compra_mesamo_capital          
 , compra_codamo_interes          
 , compra_mesamo_interes          
 , compra_base          
 , venta_moneda          
 , venta_capital          
 , venta_amortiza          
 , venta_saldo          
 , venta_interes          
 , venta_spread          
 , venta_codigo_tasa          
 , venta_valor_tasa          
 , venta_valor_tasa_hoy          
 , venta_codamo_capital          
 , venta_mesamo_capital          
 , venta_codamo_interes          
 , venta_mesamo_interes          
 , venta_base          
 , operador          
 , operador_cliente          
 , estado_flujo          
 , modalidad_pago       
 , pagamos_moneda          
 , pagamos_documento          
 , pagamos_monto          
 , pagamos_monto_USD          
 , pagamos_monto_CLP          
 , recibimos_moneda          
 , recibimos_documento          
 , recibimos_monto          
 , recibimos_monto_USD          
 , recibimos_monto_CLP          
 , observaciones          
 , fecha_modifica          
 , devengo_dias          
 , devengo_monto          
 , devengo_monto_peso          
 , devengo_monto_acum          
 , devengo_monto_ayer          
 , devengo_compra          
 , devengo_compra_acum          
 , devengo_compra_acum_peso          
 , devengo_compra_ayer          
 , devengo_compra_ayer_peso          
 , devengo_venta          
 , devengo_venta_acum          
 , devengo_venta_acum_peso          
 , devengo_venta_ayer          
 , devengo_venta_ayer_peso          
 , fecha_valoriza          
 , compra_zcr          
 , compra_mercado_tasa          
 , compra_mercado          
 , compra_mercado_usd          
 , compra_mercado_clp          
 , compra_duration_tasa          
 , compra_duration_monto          
 , compra_duration_monto_usd          
 , compra_duration_monto_clp          
 , compra_valor_presente          
 , venta_zcr          
 , venta_mercado_tasa          
 , venta_mercado          
 , venta_mercado_usd          
 , venta_mercado_clp          
 , venta_duration_tasa          
 , venta_duration_monto          
 , venta_duration_monto_usd          
 , venta_duration_monto_clp          
 , venta_valor_presente          
 , monto_mtm          
 , monto_mtm_usd          
 , monto_mtm_clp          
 , compra_valorizada          
 , compra_variacion          
 , venta_valorizada          
 , venta_variacion          
 , valorizacion_dia          
 , estado          
 , Estado_oper_lineas          
 , Observacion_Lineas          
 , Observacion_Limites          
 , Especial          
 , Capital_Pesos_Actual          
 , Capital_Pesos_Ayer          
 , Hora          
 , Tasa_Compra_Curva          
 , Tasa_Venta_Curva          
 , Activo_MO_C08          
 , Pasivo_MO_C08          
 , Activo_USD_C08          
 , Pasivo_USD_C08          
 , Activo_CLP_C08          
 , Pasivo_CLP_C08          
 , Tasa_Compra_CurvaVR          
 , Tasa_Venta_CurvaVR          
 , Activo_FlujoMO          
 , Activo_FlujoUSD          
 , Activo_FlujoCLP          
 , Pasivo_FlujoMO          
 , Pasivo_FlujoUSD          
 , Pasivo_FlujoCLP          
 , Valor_RazonableMO          
 , Valor_RazonableUSD          
 , Valor_RazonableCLP          
 , Monto_Spread  
, Monto_diferido_inicial          
 , Monto_diferido_diario          
 , Monto_diferido_acumulado          
 , TC_MO_Inicial          
 , Monto_TC_Diario          
 , Monto_TC_Acumulado          
 , Monto_Reajuste_Diario          
 , Monto_Reajuste_Acumulado          
 , Monto_Valorizacion          
 , Monto_Capital_TC_ini          
 , car_area_Responsable          
 , car_Cartera_Normativa          
 , car_SubCartera_Normativa          
 , car_Libro          
 , DevAntPromCam          
 , vRazAjustado_Mo          
 , vRazAjustado_Mn          
 , vRazAjustado_Do          
 , vRazActivoAjus_Mo          
 , vRazPasivoAjus_Mo          
 , vRazActivoAjus_Mn          
 , vRazPasivoAjus_Mn          
 , vRazActivoAjus_Do          
 , vRazPasivoAjus_Do          
 , vTasaActivaAjusta          
 , vTasaPasivaAjusta          
 , vDurMacaulActivo          
 , vDurMacaulPasivo          
 , vDurModifiActivo          
 , vDurModifiPasivo          
 , vDurConvexActivo          
 , vDurConvexPasivo          
 , FeriadoFlujoChile          
 , FeriadoFlujoEEUU          
 , FeriadoFlujoEnglan          
 , FeriadoLiquiChile          
 , FeriadoLiquiEEUU          
 , FeriadoLiquiEnglan          
 , Convencion          
 , DiasReset          
 , FechaEfectiva          
 , PrimerPago          
 , PenultimoPago          
 , Madurez          
 , Note          
 , IntercPrinc          
 , Tikker          
 , FechaLiquidacion          
 , FechaReset          
 , CompraTasaProyectada          
 , VentaTasaProyectada          
 , estado_sinacofi          
 , fecha_sinacofi          
 , Moneda_Valorizacion          
 , Valor_Mercado_Activo_Mda_Val          
 , Devengo_Recibido_Mda_Val          
 , Valor_Mercado_Pasivo_Mda_Val          
 , Devengo_Pagar_Mda_Val          
 , Principal_Mda_Val          
 , Devengo_Neto_Mda_Val          
 , Valor_Mercado_Mda_Val          
 , Porcentaje_Margen          
 , Monto_Margen          
 , Monto_Margen_CLP          
 , OrigenCurva          
 , ActivoTir          
 , PasivoTir          
 , ActivoTirCnv          
 , PasivoTirCnv          
 , FxRate          
 , Compra_amortiza_Prc          
 , Venta_amortiza_Prc          
 , Compra_Flujo_Adicional          
 , Venta_Flujo_Adicional          
 , FechaValuta          
 , CompraPerResetCod          
 , VentaPerResetCod          
 , CompraLiqDefault          
 , VentaLiqDefault          
 , CompraResetDefault          
 , VentaResetDefault          
 , Compra_DV01_Forward          
 , Venta_DV01_Forward          
 , Compra_DV01_Descuento          
 , Venta_DV01_Descuento          
 , Compra_curva_TIR          
 , Venta_curva_TIR          
 , Compra_Curva_Descont          
 , Venta_Curva_Descont          
 , Compra_Curva_Forward          
 , Venta_Curva_Forward          
 , Monto_LCR_Matriz          
 , Monto_LCR_Ajuste_AVR          
 , Trader_Contraparte          
 , Especifica_Negocio          
 , Compra_Tasa_Forward_larga          
 , Compra_Tasa_Forward_corta          
 , PlazoFlujo          
 , PortaFolio          
 , Threshold          
        FROM    CARTERA_UNWIND WHERE numero_operacion = @iNumeroOperacion AND fechaanticipo=@fFechaAnticipo           
   END          
          
  
   SELECT @iInvierte       = 1          
   FROM   #CARTERA          
   WHERE  numero_operacion = @iNumeroOperacion          
   AND    tipo_operacion   = 'T'          
          
   DECLARE @iMinFlujoActivo   INTEGER          
   DECLARE @iMinFlujoPasivo   INTEGER          
       SET @iMinFlujoActivo   = ( SELECT MIN(numero_flujo) FROM #CARTERA WHERE fecha_vence_flujo >= @xFechaFlujo and tipo_flujo = 1)          
       SET @iMinFlujoPasivo   = ( SELECT MIN(numero_flujo) FROM #CARTERA WHERE fecha_vence_flujo >= @xFechaFlujo and tipo_flujo = 2)          
  
   if (@iMinFlujoActivo is null)  
       SET @iMinFlujoActivo   = ( SELECT MIN(numero_flujo) FROM #CARTERA WHERE tipo_flujo = 1)     
  
   if (@iMinFlujoPasivo is null)  
       SET @iMinFlujoPasivo   = ( SELECT MIN(numero_flujo) FROM #CARTERA WHERE tipo_flujo = 2)  


       INSERT INTO #Cabecera
       SELECT  'NumOperacion'            = Cartera.Numero_Operacion
             ,      'RutCliente'        = Cli.xRut
             ,      'NomCliente'        = CONVERT(CHAR(30),Cli.Nombre)
             ,      'Tikker'                   = CONVERT(CHAR(20),LTRIM(RTRIM(Cartera.Tikker)))
             ,      'vMercadoUSD'       = vMerUSD.vMercadoUSD
             ,      'vMercadoMx'        = vMerMX.vMercadoMX
             ,      'vRazAdjusDo'       = Cartera.Valor_RazonableUSD          
             ,      'vRazAdjusMn'       = Cartera.Valor_RazonableCLP    
             ,   'vResMesaDistCLP'   = @ResMesaDistCLP          
             ,      'vResMesaDistUSD'   = @ResMesaDistUSD          
       FROM   #CARTERA     Cartera
                    inner join ( SELECT Numero_Operacion    = Numero_Operacion
                                               ,            Numero_Flujo        = MIN( Numero_Flujo )
                                               FROM   #CARTERA 
                                               where  tipo_Flujo   =      1
                                               GROUP 
                                               BY           Numero_Operacion
                                        )      Grp          On     Grp.Numero_Operacion       = Cartera.Numero_Operacion
                                                            and Grp.Numero_Flujo              = Cartera.Numero_Flujo

                    inner join   (      select Numero_Operacion    = Numero_Operacion
                                                      ,      vMercadoUSD  = SUM(activo_usd_c08) - SUM(pasivo_usd_c08)
                                               from   #CARTERA
                                               where  tipo_Flujo   =      1
                                               group 
                                               by           Numero_Operacion
                                        )      vMerUSD      On     vMerUSD.Numero_Operacion   = Cartera.Numero_Operacion

                    inner join   (      select Numero_Operacion    = Numero_Operacion
                                                      ,      vMercadoMX   = SUM(activo_clp_c08) - SUM(pasivo_clp_c08)
                                               from   #CARTERA
                                               where  tipo_Flujo   =      1
                                               group 
                                               by           Numero_Operacion
                                        )      vMerMX On     vMerMX.Numero_Operacion    = Cartera.Numero_Operacion

                    inner join ( select Rut          = clrut
                                                      ,      Dv           = cldv
                                                      ,      Nombre = clnombre   
                                                      ,      Codigo = clcodigo
                                                      ,      xRut   = CONVERT(CHAR(12),REPLICATE(' ', 10 - LEN(LTRIM(RTRIM(clrut)))) + LTRIM(RTRIM(clrut)) + '-' + LTRIM(RTRIM(cldv)))          
                                               from   BacParamSuda.dbo.Cliente   with(nolock)
                                        )      Cli          On     Cli.Rut             =       Cartera.rut_cliente
                                                            and    Cli.Codigo   =       Cartera.codigo_cliente
       WHERE  Cartera.tipo_flujo  = 1

/*
   INSERT INTO #Cabecera          
   SELECT DISTINCT           
        'NumOperacion'             = cc.Numero_Operacion          
   ,    'RutCliente'               = CONVERT(CHAR(12),REPLICATE(' ', 10 - LEN(LTRIM(RTRIM(cc.Rut_Cliente)))) + LTRIM(RTRIM(cc.Rut_Cliente)) + '-' + LTRIM(RTRIM(cldv)))          
   ,    'NomCliente'               = CONVERT(CHAR(30),clnombre)          
   ,    'Tikker'                   = CONVERT(CHAR(20),LTRIM(RTRIM(cc.Tikker)))          
   ,    'vMercadoUSD'              = (SELECT SUM(activo_usd_c08) - SUM(pasivo_usd_c08) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo =1 )          
   ,    'vMercadoMx'               = (SELECT SUM(activo_clp_c08) - SUM(pasivo_clp_c08) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo =2 )          
   ,    'vRazAdjusDo'              = cc.Valor_RazonableUSD          
   ,    'vRazAdjusMn'              = cc.Valor_RazonableCLP          
   ,    'vResMesaDistCLP'          = @ResMesaDistCLP          
   ,    'vResMesaDistUSD'          = @ResMesaDistUSD          
   FROM   #CARTERA cc          
          INNER JOIN (     SELECT Numero_Operacion as xxNumoper, MIN(grup.numero_flujo) as xxFlujo           
                        FROM      #CARTERA grup          
                                        GROUP 
                                        BY           Numero_Operacion) grp      ON     grp.xxNumoper = cc.numero_operacion          
          LEFT JOIN BacParamSuda..CLIENTE   ON clrut = rut_cliente AND clcodigo = codigo_cliente          
          LEFT JOIN BacParamSuda..MONEDA  m ON m.mncodmon = compra_moneda          
          
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg  = 204  AND convert(int,Financiera.tbcodigo1)  = cartera_inversion          
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg   = 1111 AND Normativa.tbcodigo1   = car_Cartera_Normativa          
  LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Negociacion ON Negociacion.tbcateg = 1552 AND Negociacion.tbcodigo1 = car_Libro          
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg = 1553 AND Responsable.tbcodigo1 = car_area_Responsable           
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg  = 1554 AND SubCartera.tbcodigo1  = car_SubCartera_Normativa           
   WHERE  cc.numero_operacion       = @iNumeroOperacion          
    AND   cc.numero_flujo           = xxFlujo          
*/

   UPDATE #Cabecera        
      SET RutCliente       = CONVERT(CHAR(12),REPLICATE(' ', 10 - LEN(LTRIM(RTRIM(Rut_Cliente)))) + LTRIM(RTRIM(Rut_Cliente)) + '-' + LTRIM(RTRIM(cldv)))          
      ,   NomCliente       = CONVERT(CHAR(30),clnombre)        
     FROM CARTERA        
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = Rut_Cliente and clcodigo = codigo_cliente        
    WHERE Numero_Operacion = @iNumeroOperacion        
          
          
   SELECT DISTINCT           
          'MonedaCompra'           = LTRIM(RTRIM(m.mnnemo)) + ' - ' + LTRIM(RTRIM(m.mnglosa))          
   ,      'NocionalesCompra'       = CONVERT(NUMERIC(21,4),compra_capital)          
   ,      'IndicadorCompra'        = CONVERT(CHAR(10),tbglosa)          
   ,      'TasaCompra'             = CONVERT(NUMERIC(21,5),compra_valor_tasa)          
   ,      'SpreadCompra'           = CONVERT(NUMERIC(21,5),compra_spread)          
   ,      'FrecPagoCompra'         = CONVERT(CHAR(10),i.glosa)          
   ,      'FrecCapitalCompra'      = CONVERT(CHAR(10),ii.glosa)          
   ,      'ConteoDiasCompra'       = CONVERT(CHAR(10),b.glosa)          
   ,      'FecEfectivaCompra'      = CONVERT(CHAR(10),FechaEfectiva,103)          
   ,     'FecPrimerPagoCompra'    = CONVERT(CHAR(10),PrimerPago,103)          
   ,      'FecPenultimoPagoCompra' = CONVERT(CHAR(10),PenultimoPago,103)          
   ,      'FecMadurezCompra'       = CONVERT(CHAR(10),Madurez,103)          
   ,      'MonedaPagoCompra'       = LTRIM(RTRIM(p.mnnemo)) + ' - ' + LTRIM(RTRIM(p.mnglosa))          
   ,      'MedioPagoCompra'        = LTRIM(RTRIM(f.glosa))          
   ,      'FeriadoVctoCompra'      = CASE WHEN FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END          
                                   + CASE WHEN FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END          
                                   + CASE WHEN FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END          
   ,      'FeriadoLiquCompra'      = CASE WHEN FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END          
                                   + CASE WHEN FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END          
                                   + CASE WHEN FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END          
   ,      'AjustHabilesCompra'     = Convencion          
   ,      'ConvencionCompra'       = 'Normal - Adelante'          
   ,      'DiasResetCompra'        = DiasReset          
   ,      'MacaulayCompra'         = vDurMacaulActivo          
   ,      'ModificadaCompra'       = vDurModifiActivo          
   ,      'ConvexidadCompra'       = vDurConvexActivo          
   ,     'Tasa Transfer_C'           = @Tasa_Tranfer_Recibo          
   ,     'Spread_Tranfer_C'          = @Spread_Transfer_Recibo          
   INTO   #Compras          
   FROM   #CARTERA          
          LEFT JOIN BacParamSuda..MONEDA               m  ON m.mncodmon = compra_moneda           
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE   ON tbcateg    = 1042  AND tbcodigo1 = compra_codigo_tasa          
          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION i  ON i.sistema  = 'PCS' AND i.tabla   = 1044 AND i.codigo  = compra_codamo_interes          
          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ii ON ii.sistema = 'PCS' AND ii.tabla  = 1043 AND ii.codigo = compra_codamo_capital          
    LEFT JOIN BASE                 b  ON b.codigo   = compra_base          
          LEFT JOIN BacParamSuda..MONEDA               p  ON p.mncodmon = recibimos_moneda          
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO        f  ON f.codigo   = recibimos_documento          
   WHERE  numero_operacion       = @iNumeroOperacion          
   AND    tipo_flujo             = 1          
   AND    numero_flujo           = @iMinFlujoActivo          
-- AND    numero_flujo           = (SELECT MIN(numero_flujo) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo = 1)          
          
   SELECT DISTINCT           
          'MonedaVenta'           = LTRIM(RTRIM(m.mnnemo)) + ' - ' + LTRIM(RTRIM(m.mnglosa))          
   ,      'NocionalesVenta'       = CONVERT(NUMERIC(21,4),venta_capital)          
   ,      'IndicadorVenta'        = CONVERT(CHAR(10),tbglosa)          
   ,      'TasaVenta'             = CONVERT(NUMERIC(21,5),venta_valor_tasa)          
   ,      'SpreadVenta'           = CONVERT(NUMERIC(21,5),venta_spread)          
   ,      'FrecPagoVenta'         = CONVERT(CHAR(10),i.glosa)          
   ,      'FrecCapitalVenta'      = CONVERT(CHAR(10),ii.glosa)         
   ,      'ConteoDiasVenta'       = CONVERT(CHAR(10),b.glosa)          
   ,      'FecEfectivaVenta'      = CONVERT(CHAR(10),FechaEfectiva,103)          
   ,      'FecPrimerPagoVenta'    = CONVERT(CHAR(10),PrimerPago,103)          
   ,      'FecPenultimoPagoVenta' = CONVERT(CHAR(10),PenultimoPago,103)          
   ,      'FecMadurezVenta'       = CONVERT(CHAR(10),Madurez,103)          
   ,      'MonedaPagoVenta'       = LTRIM(RTRIM(p.mnnemo)) + ' - ' + LTRIM(RTRIM(p.mnglosa))          
   ,      'MedioPagoVenta'        = LTRIM(RTRIM(f.glosa))          
   ,      'FeriadoVctoVenta'      = CASE WHEN FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END          
                                  + CASE WHEN FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END          
                                  + CASE WHEN FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END          
   ,      'FeriadoLiquVenta'      = CASE WHEN FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END          
                                  + CASE WHEN FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END          
                                  + CASE WHEN FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END          
   ,      'AjustHabilesVenta'     = Convencion          
   ,      'ConvencionVenta'       = 'Normal - Adelante'          
   ,      'DiasResetVenta'        = DiasReset          
   ,      'MacaulayVenta'         = vDurMacaulPasivo          
   ,      'ModificadaVenta'       = vDurModifiPasivo          
   ,      'ConvexidadVenta'       = vDurConvexPasivo          
   ,     'Tasa Transfer_V'          = @Tasa_Tranfer_Pago           
   ,      'Spread_Tranfer_V'        = @Spread_Transfer_Pago          
   INTO   #Ventas          
   FROM   #CARTERA          
          LEFT JOIN BacParamSuda..MONEDA               m  ON m.mncodmon = venta_moneda           
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE   ON tbcateg    = 1042  AND tbcodigo1 = venta_codigo_tasa          
          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION i  ON i.sistema  = 'PCS' AND i.tabla   = 1044 AND i.codigo  = venta_codamo_interes          
          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ii ON ii.sistema = 'PCS' AND ii.tabla  = 1043 AND ii.codigo = venta_codamo_capital          
          LEFT JOIN BASE                               b  ON b.codigo   = venta_base          
          LEFT JOIN BacParamSuda..MONEDA               p  ON p.mncodmon = pagamos_moneda          
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO        f  ON f.codigo = pagamos_documento          
   WHERE  numero_operacion       = @iNumeroOperacion          
   AND    tipo_flujo             = 2          
   AND    numero_flujo           = @iMinFlujoPasivo          
-- AND    numero_flujo        = (SELECT MIN(numero_flujo) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo = 2)          
          
   IF @iInvierte = 1          
   BEGIN          
      SELECT * INTO #TEMP FROM #Compras          
          
      DELETE #Compras          
      INSERT INTO #Compras SELECT * FROM #Ventas          
                
      DELETE #Ventas          
      INSERT INTO #Ventas  SELECT * FROM #TEMP          
   END          
          
   DECLARE @Supervisor1     VARCHAR(20)          
   ,       @Supervisor2     VARCHAR(20)          
          
   SELECT  @Supervisor1     = ISNULL(Firma1,'')          
   ,       @Supervisor2     = ISNULL(Firma2,'')          
   FROM    BacLineas..DETALLE_APROBACIONES          
   WHERE   Numero_Operacion =  @iNumeroOperacion          
   AND     Id_Sistema       = 'PCS'     
   
   declare @metodologia as int
select @metodologia = ISNULL(ClRecMtdCod,'')
from CARTERA        
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = Rut_Cliente and clcodigo = codigo_cliente        
    WHERE Numero_Operacion = @iNumeroOperacion    
       


  /*-----------------------------------------------------------------------------*/
  /* CORRECCION DE OPERADOR PARA EL CASO DE LAS MODIFICACIONES                   */
  /* SOLICITUD     : CARLOS BASTERRICA                                           */
  /* REALIZADO POR : ROBERTO MORA DROGUETT                                       */
  /* FECHA         : 03/05/2016                                                  */
  /*-----------------------------------------------------------------------------*/
    IF EXISTS(SELECT 1
	            FROM Cartera 
		       WHERE numero_operacion = @iNumeroOperacion) BEGIN

	    UPDATE OPE
	       SET operador  = CAR.operador 
	      FROM #CARTERA    OPE
		 INNER JOIN 
		       CARTERA     CAR
		    ON CAR.numero_operacion = OPE.numero_operacion
	END



  /*-----------------------------------------------------------------------------*/
  /* CORRECCION DE ESTADO SI EXISTE UN P DEBIERAN SER TODOS PENDIENTES           */
  /* SOLICITUD     : CARLOS BASTERRICA                                           */
  /* REALIZADO POR : ROBERTO MORA DROGUETT                                       */
  /* FECHA         : 03/05/2016                                                  */
  /*-----------------------------------------------------------------------------*/
    IF EXISTS(SELECT 1
	            FROM #Cartera 
		       WHERE Estado_oper_lineas = 'P') BEGIN

	    UPDATE #CARTERA
	       SET Estado_oper_lineas  = 'P'
		 WHERE numero_operacion = @iNumeroOperacion

	END




          
   SELECT #Cabecera.*          
   ,      #Compras.*          
   ,      #Ventas.*          
   ,      'TipoFlujo'           = Tipo_Flujo          
   ,      'NumeroFlujo'         = numero_flujo          
   ,      'Fijacion'            = CONVERT(CHAR(10),fecha_fijacion_tasa,103)          
   ,      'Vencimiento'         = CONVERT(CHAR(10),fecha_vence_flujo,103)          
   ,      'Liquidacion'         = CONVERT(CHAR(10),FechaLiquidacion,103)          
          
   ,      'Interes'             = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_interes)           
                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_interes)          
                   END          
   ,      'Amortizacion'        = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_amortiza)          
                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_amortiza)          
                                  END          
   ,      'Saldo'               = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_saldo + compra_Amortiza)          
                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_saldo + venta_Amortiza)          
                                  END          
   ,      'FechaProceso'        = @FechaProceso          
   ,      'FechaEmision'        = @FechaEmision          
   ,      'HoraEmision'         = @HoraEmision          
   ,      'Usuario'             = @cUsuario          
   ,      'Estado'              = Estado_oper_lineas          
   ,      'TipoSwao'            = CASE WHEN tipo_swap = 1 THEN 'SWAP DE TASAS         '          
                                       WHEN tipo_swap = 2 THEN 'SWAP DE MONEDAS       '          
                                       WHEN tipo_swap = 3 THEN 'FORWARD RATE AGREEMENT'          
                                     WHEN tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA  '          
                                  END          
   ,      'Modalidad'           = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END          
          
   ,      'CarteraFinanciera'   = @ENC_CARTERA_FINANCIERA   --> Financiera.tbglosa          
   ,      'CarteraNormativa'    = @ENC_CARTERA_NORMATIVA    --> Normativa.tbglosa          
   ,      'LibroNegociacion'    = @ENC_LIBRO                --> Negociacion.tbglosa          
   ,      'AreaResponsalble'    = @ENC_AREA_RESPONSABLE     --> Responsable.tbglosa          
   ,      'SubCarteraNormativa' = @ENC_SUBCARTERA_NORMATIVA --> SubCartera.tbglosa          
   --,      'Lineas'              = Observacion_Lineas   
   ,      'Lineas'              = Case when @metodologia  in (2,3,5) then 'LCR es consumo total de todos los derivados' else '' end    
   ,      'Limites'             = Observacion_Limites + ' ' + @xMensajeThreshold + ' ' + @xMensajeBloqueos       
          
   ,      'Observaciones'       = CASE WHEN IntercPrinc = 1 THEN 'Operación afecta a Intercambio de Capital' + CHAR(10) + CHAR(13)           
                                       ELSE                      ''           
END  + ltrim(rtrim( observaciones ))          
   ,      'Operador'            = operador          
   ,      'Supervisor1'         = @Supervisor1          
   ,      'Supervisor2'         = @Supervisor2          
   ,      'tipoSwap'            = tipo_swap          
   ,      'tipo_operacion'      = CASE WHEN tipo_swap  = 3 AND tipo_operacion = 'P' THEN 'PRESTAMISTA'          
                                       WHEN tipo_swap  = 3 AND tipo_operacion = 'T' THEN 'TOMADOR'          
                                       WHEN tipo_swap <> 3 AND tipo_operacion = 'C' THEN 'COMPRA'          
                                       WHEN tipo_swap <> 3 AND tipo_operacion = 'V' THEN 'VENTA'          
                                  END          
   ,      'modalidad_pago'      = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION'          
                                       WHEN modalidad_pago = 'E' THEN 'ENTREGA FISICA'          
                                  END          
   ,      'Dias'                = datediff(day,FechaEfectiva,Madurez)          
   ,      'FechaCierre'         = fecha_cierre          
   ,      'GuardadaComo'        = Estado          
   ,      'FlujoAdicional'      = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_Flujo_Adicional )           
                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4), venta_Flujo_Adicional )          
                                  END
   ,      'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)                                                         
     
   FROM   #CARTERA          
   ,      #Cabecera , #Compras , #Ventas          
   WHERE  numero_operacion      = @iNumeroOperacion          
   ORDER BY tipo_Flujo , numero_flujo          
          






END

GO
