USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGAMIENTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEVENGAMIENTO]  
 (  @dFecPro        DATETIME        , -- 1 Fecha de Proceso  
          @dFecProAnt       DATETIME        , -- 2 Fecha Proceso Anterior  
   @dFecProxPro    DATETIME        , -- 3 Proxima Fecha Habil  
   @dFecUDMPro           DATETIME        , -- 4 Ultimo D¡a Mes de Proceso  
   @dFecUDMAnt            DATETIME        , -- 5 Ultimo D¡a Mes de Proceso Anterior  
   @cLastHabil            CHAR(2)   , -- 6 Indica si es el Ultimo D¡a H bil  
   @cFirstHabil  CHAR(2)  , -- 7 Indica si es el Primer D¡a H bil  
          @nValorUF_Ant    NUMERIC(12,04)  , -- 8 Uf Dia Anterior  
   @nValorUF_Pro  NUMERIC(12,04)  , -- 9 Uf de Proceso  
          @nValorUF_UDM         NUMERIC(12,04)  , -- 10 Uf Fin de Mes  
   @nValUsd_Pro  NUMERIC(12,4) , -- 11 Valor D¢lar Observado Proceso  
    @nValUsd_Ant  NUMERIC(12,4) , -- 12 Valor D¢lar Observado Anterior  
   @nvalusd_udma         NUMERIC(12,4) , -- 13 Valor D¢lar Observado Ultimo Día Mes Anterior  
                 @iEjecucionIniDia      INT     = 0  
 )  
WITH RECOMPILE  
AS  
BEGIN   
  
   SET NOCOUNT ON  
  
 DECLARE @dFecEfectivaRegla DATETIME  
 ,  @iRefMercado  INT  
  
 --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
 DECLARE @FechaCalculos    DATETIME  
    
 SET @FechaCalculos    = CASE WHEN DATEPART(MONTH, @dFecPro) = DATEPART(MONTH, @dFecProxPro) THEN @dFecPro  
                                         ELSE @dFecUDMPro END  
    
 DECLARE @iFound   INT  
    
 SELECT @iFound   = 0  
 SELECT @iFound   = COUNT(1)  
 FROM   MFCA  
 WHERE  cacodpos1 = 10  
 AND    caestado  = ''  
 AND    cabroker  NOT IN( SELECT DISTINCT instrumento   
     FROM BENCH_MARCK  
                               WHERE fecha = CASE WHEN @iEjecucionIniDia = 0 THEN @dFecPro   
           ELSE @dFecProAnt END)  
    
 IF @iFound > 0 BEGIN  
  SELECT -1 , 'Se deben ingresar las tasa Bench Marck antes de Devengar.'  
  RETURN -1  
 END  
    
 SET @iFound   = 0  
    
 SELECT @iFound   = COUNT(1)  
 FROM   MFCA       INNER JOIN BENCH_MARCK   
    ON fecha = CASE WHEN @iEjecucionIniDia = 0 THEN @dFecPro   
           ELSE @dFecProAnt END  
    AND cabroker= instrumento   
    AND tasa = 0  
 WHERE  cacodpos1 = 10  
 AND    caestado  = ''  
    
 IF @iFound > 0 BEGIN  
  SELECT -1 , 'Se deben ingresar las tasa Bench Marck distinta de Cero.'  
  RETURN -1  
 END  
    
 SET @iFound   = 0  
    
 SELECT @iFound   = COUNT(1)  
 FROM   MFCA  
 WHERE  cacodpos1 = 11  
 AND    caestado  = ''  
 AND    caserie  NOT IN( SELECT DISTINCT instrumento   
    FROM BENCH_MARCK_INVEX   
    where fecha = CASE WHEN @iEjecucionIniDia = 0 THEN @dFecPro   
          ELSE @dFecProAnt END)  
    
 IF @iFound > 0 BEGIN  
  SELECT -1 , 'Se deben ingresar las tasa Bench Marck INV.EXT antes de Devengar.'  
  RETURN -1  
 END  
    
 SET @iFound   = 0  
 SELECT @iFound   = COUNT(1)  
 FROM   MFCA       INNER JOIN BENCH_MARCK_INVEX   
    ON fecha = CASE WHEN @iEjecucionIniDia = 0 THEN @dFecPro   
          ELSE @dFecProAnt END  
    AND caserie = instrumento   
    AND tasa = 0  
    
 WHERE  cacodpos1 = 11  
 AND    caestado  = ''  
    
 IF @iFound > 0 BEGIN  
  SELECT -1 , 'Se deben ingresar las tasa Bench Marck INV. EXT.  distinta de Cero.'  
  RETURN -1  
 END  
    
 SET @iFound      = -1  
    
 SELECT @iFound      = 0  
 FROM   BacparamSuda..VALOR_MONEDA_CONTABLE  
 WHERE  Fecha        = CASE WHEN @iEjecucionIniDia = 1 THEN @dFecProAnt   
        ELSE @dFecPro END  
 AND    Tipo_Cambio <> 0.0  
    
 IF @iFound = -1 BEGIN  
  SELECT -1 , 'No Existen Valores de Monedas Contables a la Fecha de Proceso...'  
  RETURN   
 END  
    
 --> Agregado para Convertir el Monto de Compensacion a DOLARES para Clientes Extranjeros. en Mercado Local  
 DECLARE @nValorDolar   FLOAT  
 DECLARE @vUfHoy   FLOAT  
    
 SET @nValorDolar = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmfecha = @dFecPro AND vmcodigo = 994)  
 SET @vUfHoy  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmfecha = @dFecPro AND vmcodigo = 998)  
    
 DECLARE @Tasa_uf05     FLOAT  
 , @Tasa_uf10     FLOAT  
    
 DECLARE @Valorizador   VARCHAR(50)  
 , @nError        INT  
 , @Mon_inst      NUMERIC(9)  
 , @Mon_pago      NUMERIC(9)  
 , @Fec_inic      DATETIME  
 , @Fec_Vcto      DATETIME  
 , @Mon_Nominal   NUMERIC(21,4)  
 , @Mon_VpresPe   NUMERIC(21,0)  
 , @Mon_VPresUm   NUMERIC(21,4)  
 , @Mon_VMercado  NUMERIC(21,0)  
 , @Tir_Forward   NUMERIC(21,4)  
 , @Tir_Mercado   NUMERIC(21,4)  
 , @ReajusteDia   NUMERIC(21,4)  
 , @ReajusteAcum  NUMERIC(21,4)  
 , @VariacionDia  NUMERIC(21,4)  
 , @VariacionAcum NUMERIC(21,4)  
 , @dFechaVctoIns DATETIME  
 , @Seriedo       CHAR(1)  
 , @Fec_Calc      DATETIME  
 , @Cod_inst      NUMERIC(9)  
 , @Ser_Inst      VARCHAR(20)  
 , @Fec_Emis      DATETIME  
 , @Tas_Emis      NUMERIC(21,4)  
 , @Bas_Emis      NUMERIC(9)  
 , @Mon_Emis      NUMERIC(9)  
 , @Tas_Est       NUMERIC(21,4)  
 , @Fec_UltDev    DATETIME  
 , @fPvp          FLOAT  
 , @fMt           FLOAT  
 , @fMtum         FLOAT  
 , @fMt_cien      FLOAT  
 , @fVan          FLOAT  
 , @fVpar         FLOAT  
 , @nNumucup      INT  
 , @dFecucup      DATETIME  
 , @fIntucup      FLOAT  
 , @fAmoucup      FLOAT  
 , @fSalucup      FLOAT  
 , @nNumpcup      INT  
 , @dFecpcup      DATETIME  
 , @fIntpcup      FLOAT  
 , @fAmopcup      FLOAT  
 , @fSalpcup      FLOAT  
 , @fDurat        FLOAT  
 , @fConvx        FLOAT  
 , @fDurmo        FLOAT  
 , @TipoOper      char(1)  
 , @BenchMarck    CHAR(1)  
 , @iCalculaVAyer INT  
 , @nTasa1        FLOAT            
 , @nTasa2        FLOAT            
 , @TipoCurvaMon  VARCHAR(5)       
 , @TipoCurvaCnv  VARCHAR(5)       
    
 DECLARE @nNumOpe                NUMERIC(10,00)  , -- N£mero de Operaci¢n  
  @nCarter      NUMERIC(02,00)  , -- Tipo de Cartera  
  @cTipOpe         CHAR(01)        , -- Tipo de Operaci¢n  
  @nCodMon         NUMERIC(03,00)  , -- Moneda Origen  
  @nMtoMex         NUMERIC(21,04)  , -- Monto Origen  
  @nMtoClp_i    NUMERIC(21,00) , -- Pesos al Inicio Por los D¢lares  
  @nCodCnv         NUMERIC(03,00)  , -- Moneda Conversi¢n  
  @nMtoCnv         NUMERIC(21,04)  , -- Monto Conversi¢n  
  @nMtoCnv_i    NUMERIC(21,00) , -- Pesos al Inicio Por moneda Cnv ($$-UF)  
  @dFecIni         DATETIME        , -- Fecha Inicio  
  @dFecVto         DATETIME        , -- Fecha Vencimiento  
  @dFecAux   DATETIME , -- Fecha Auxiliar  
  @dFecVctop   DATETIME , -- Fecha Vcto.  
  @nPlazoOpe        NUMERIC(04,00)  , -- Plazo Operaci¢n  
  @nPlazoVto   NUMERIC(04,00) , -- Plazo al Vencimiento  
  @nPlazoVctop   NUMERIC(04,00) , -- Plazo al Vencimiento  
  @nPlazoCal   NUMERIC(04,00) , -- Plazo Calculado hasta Hoy  
  @nPlazoCal_a   NUMERIC(04,00) , -- Plazo Calculado hasta Ayer  
  @nDiaDev         NUMERIC(04,00)  , -- Dias de Devengamiento  
  @nValorUF   NUMERIC(12,04)  , -- Valor UF de Calculo  
  @nValUsd_C   NUMERIC(12,04) , -- Valor USD de C lculo  
  @nMonRef         NUMERIC(03,00)  , -- Moneda Referencial   
  @nMtoDif   NUMERIC(21,00) , -- Valor a Diferir  
  @nDelUsd   NUMERIC(12,04) , -- Variaci¢n del Tipo de Cambio  
  @nDelUf           NUMERIC(12,04) , -- Variaci¢n de la UF  
  @nDelUsd_a   NUMERIC(12,04) , -- Variaci¢n del Tipo de Cambio Ayer  
  @nDelUf_a   NUMERIC(12,04) , -- Variaci¢n de la UF Ayer  
  @nPerDif    NUMERIC(21,00) , -- P'rdida Diferida  
  @nUtiDif    NUMERIC(21,00) , -- Utilidad Diferida  
  @nPerDev    NUMERIC(21,00) , -- P'rdida Devengada  
  @nUtiDev    NUMERIC(21,00) , -- Utilidad Devengada  
  @nPerAcu    NUMERIC(21,00) , -- P'rdida Acumulada  
  @nUtiAcu    NUMERIC(21,00) , -- Utilidad Acumulada  
  @nPerAcu_a    NUMERIC(21,00) , -- P'rdida Acumulada Ayer  
  @nUtiAcu_a    NUMERIC(21,00) , -- Utilidad Acumulada Ayer  
  @nPerSal    NUMERIC(21,00) , -- Saldo por devengar de la P'rdida Diferida  
  @nUtiSal    NUMERIC(21,00) , -- Saldo por devengar de la utilidad Diferida  
  @nClp_Mex   NUMERIC(21,00) , -- Pesos de la Moneda1 Hoy  
  @nClp_Cnv   NUMERIC(21,00) , -- Pesos de la Moneda2 Hoy  
  @nCtaCamb_a    NUMERIC(21,00) , -- Valor de la Cuenta Cambio Ayer  
  @nCtaCamb_c    NUMERIC(21,00) , -- Valor de la Cuenta Cambio Hoy  
  @nReaUFDia    NUMERIC(21,00) , -- Reajustes de la UF Hoy  
  @nReaTCDia    NUMERIC(21,00) , -- Reajustes de la T/C Hoy  
  @nValMex_i   FLOAT  , -- Valor de la Moneda1 al Inicio  
  @nValCnv_i   FLOAT  , -- Valor de la Moneda2 al Inicio  
  @nPreFut   FLOAT  , -- Precio Futuro  
  @nValorDia   NUMERIC(21,00)  , -- Valorizaci½n del D­a  
  @nRevUsd   NUMERIC(21,00)  , -- Valorizaci½n Acumulada de los D½lares  
  @nRevUF           NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF  
  @nRevUsd_a   NUMERIC(21,00)  , -- Valorizaci½n Acumulada de los D½lares Ayer  
  @nRevUF_a   NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF Ayer  
  @nRevTot   NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF + los D½lares  
  @nRevTot_a   NUMERIC(21,00)  , -- Valorizaci½n Acumulada de la UF + los D½lares ayer  
  @nMtoComp   NUMERIC(21,04)  , -- Monto a Compensar  
  @nMarktomarket   NUMERIC(21,04)  , -- Monto del Mark To Market  
  @nPrecioMtm   NUMERIC(21,04)  , -- Precio Mark To Market  
  @nmonto_mtm_usd   NUMERIC(21,04) , -- MTM Moneda USD  
  @nmonto_mtm_cnv   NUMERIC(21,04) , -- MTM Moneda Conversión  
  @nmonto_var_usd   NUMERIC(21,04) , -- VAR Moneda USD  
  @nmonto_var_cnv   NUMERIC(21,04) , -- VAR Moneda CNV  
  @ntasausd_mtm           FLOAT  , -- Tasa MTM USD  
  @ntasacnv_mtm           FLOAT  , -- Tasa MTM CNV  
  @ntasausd_var    FLOAT  , -- Tasa VAR USD  
  @ntasacnv_var    FLOAT  , -- Tasa VAR CNV  
  @nObserAyer   NUMERIC(21,10) , -- Variable para dejar el observado de Ayer  
  @nptofwdvcto   FLOAT  , -- Puntos Forward al Vencimiento  
  @preciospot   FLOAT         , -- Calculo Precio Spot  
  @valormtm_usd   FLOAT         , -- Valor MTM en USD  
  @valorpte_usd   FLOAT  , -- Valor Presente USD  
  @cfuerte                 CHAR ( 1 )      , -- Moneda fuerte o debil  
  @preciofwd               FLOAT           , -- Paridad  
  @ntipcamval              FLOAT           , -- Paridad de valorizaci¢n  
  @ntccierre               FLOAT           , -- Tipo de Cambio Cierre Arbitrajes  
  @CodPais            INT         , -- Codigo pais CHILE segun tabla paises  
  @ctipcli                 CHAR ( 1 )      , -- Tipo Cliente L=local  E=externo  
  @cModal           CHAR ( 1 ) , -- Modalidad de la Operación (C-Compensación, E-Entrega Física)  
  @nmtoini1     NUMERIC(21,4) , -- Monto USD Inicial Oper. Posición-1446  
  @nmtofin1     NUMERIC(21,4) , -- Monto USD Final Oper. Posición-1446  
  @nmtoini2     NUMERIC(21,4) , -- Monto CNV Inicial Oper. Posición-1446    
  @nmtofin2     NUMERIC(21,4) , -- Monto CNV Final Oper. Posición-1446  
  @ntasausd     FLOAT  , -- Tasa USD Posición-1446  
  @ntasacnv   FLOAT  , -- Tasa CNV Posición-1446  
  @nMtoDif_usd   NUMERIC(21,04) , -- Valor a Diferir de los USD de Posición-1446  
  @nMtoDif_cnv   NUMERIC(21,04) ,  -- Valor a Diferir de la Conversión de Posición-1446  
  @ndevengo_Acu_usd_hoy          NUMERIC(21,04) ,   
  @ndevengo_Acu_cnv_hoy          NUMERIC(21,04) ,    
  @ndevengo_Acu_usd_ayer         NUMERIC(21,04) ,    
  @ndevengo_Acu_cnv_ayer         NUMERIC(21,04) ,    
  @clp_nMtoDif_usd   NUMERIC(21,00) ,    
  @clp_nMtoDif_cnv   NUMERIC(21,00) ,    
  @clp_ndevengo_usd   NUMERIC(21,00) ,    
  @clp_ndevengo_cnv   NUMERIC(21,00) ,    
  @clp_ndevengo_Acu_usd   NUMERIC(21,00) ,    
  @clp_ndevengo_Acu_cnv   NUMERIC(21,00) ,    
  @clp_nSaldo_diferido_usd  NUMERIC(21,00) ,    
  @clp_nSaldo_diferido_cnv  NUMERIC(21,00) ,  
  @tc_calculo_mes_actual  NUMERIC(12,4) ,  
  @tc_calculo_mes_anterior  NUMERIC(21,4) , -- 12,4  
  @npremio    NUMERIC(24,4) ,  
  @canticipo    CHAR(1) ,  
  @vencimiento_original  DATETIME ,  
  @nPlazoVtoanterior    NUMERIC(4,0) ,  
  @nefecto_cambiario_mon1  NUMERIC(21,00) ,  
  @nefecto_cambiario_mon2  NUMERIC(21,00) ,  
  @ndevengo_tasa_mon1  NUMERIC(21,00) ,  
  @ndevengo_tasa_mon2  NUMERIC(21,00) ,  
  @ncambio_tasa_mon1  NUMERIC(21,00) ,  
  @ncambio_tasa_mon2  NUMERIC(21,00) ,  
  @nresiduo   NUMERIC(21,00) ,  
  @nmonto_mtm_mon1_ayer  NUMERIC(21,00) ,  
  @nmonto_mtm_mon2_ayer  NUMERIC(21,00) ,  
  @ndolar_estimado  NUMERIC(12,04) ,  
  @Compensacion_estimada  NUMERIC(21,00) ,  
  @nmonto_final    NUMERIC(21,04) ,  
  @precio_spot_inicial   FLOAT  ,  
  @factor_moneda2   FLOAT  ,  
  @factor_moneda1   FLOAT  ,  
  @monto_factor    FLOAT  ,  
  @monto_moneda2    NUMERIC(21,4) ,  
  @moneda2    NUMERIC(3) ,  
  @monto_pesos2    NUMERIC(21,00) ,  
  @valor_actual_cnv  NUMERIC(21,04) ,  
  @devengo1   NUMERIC(21,00) ,  
  @monto_acumulado_mon1   NUMERIC(21,04) ,  
  @monto_acumulado_mon2   NUMERIC(21,04) ,  
  @valor_ayer     NUMERIC(21,00) ,  
  @PrimerDiaMes        CHAR(8)  ,  
  @plazo_uso_moneda1  NUMERIC(05,00) ,  
  @plazo_uso_moneda2  NUMERIC(05,00) ,  
  @fecha    DATETIME ,  
  @Valor_Obtenido   FLOAT  , --Precio Proyectado  
  @Resultado   FLOAT    , --  
  @ResultadoMTM   FLOAT  , -- RESULTADO MARKTOMARKET  
  @CaTasaSinteticaM1  FLOAT  ,    
  @CaTasaSinteticaM2  FLOAT  ,    
  @CaPrecioSpotVentaM1  FLOAT  ,   
  @CaPrecioSpotVentaM2  FLOAT  ,   
  @CaPrecioSpotCompraM1  FLOAT  ,  
  @CaPrecioSpotCompraM2   FLOAT  ,  
  @dFecEfectiva     DATETIME        , -- Fecha Efectiva   
  @nPlazoVtoEfec   FLOAT  , -- Fecha Vcto efectiva  
  @ValorRazonableActivo           FLOAT           ,     
  @ValorRazonablePasivo           FLOAT           ,  
  @nCorrelativo   INT      
  
 DECLARE @fTe_pcdus   FLOAT  
 , @fTe_pcduf   FLOAT  
 , @fTe_ptf   FLOAT  
 , @ValorMoneda_Hoy  FLOAT  
 , @ValorMoneda_Mañ  FLOAT  
  
 SELECT @fTe_pcdus        = ISNULL(vmvalor,0.0)  
 FROM   bacparamsuda..VALOR_MONEDA  
 WHERE  vmcodigo          = 300   
 AND    vmfecha           = @dFecPro  
    
 SELECT @fTe_pcduf        = ISNULL(vmvalor,0.0)  
 FROM   bacparamsuda..VALOR_MONEDA  
 WHERE  vmcodigo          = 301  
 AND    vmfecha           = @dFecPro  
    
 SELECT @fTe_ptf          = ISNULL(vmvalor,0.0)  
 FROM   bacparamsuda..VALOR_MONEDA   
 WHERE  vmcodigo          = 302  
 AND    vmfecha           = @dFecPro  
  
 SELECT @PrimerDiaMes   = SUBSTRING(CONVERT(CHAR(8),@dfecpro,112),1,6) + '01'  
 SELECT @nValUsd_c  = @nValUsd_Pro  
 SELECT @nObserAyer = @nValUsd_Ant  
  
 SELECT  @CodPais    = acpais  
 FROM  mfac  
  
 -- Dólar Estimado, esto es para la proyección de los Vencimientos  
 SELECT  @ndolar_estimado = tasa_compra   
 FROM VIEW_TASA_FWD  
 WHERE codigo = 2   
 AND fecha = @dfecpro  
  
 -- |------------------------------------  
 -- | Limpia Resultados de Hoy   
 -- |------------------------------------  
 UPDATE RESULTADO  
 SET saldo_usd   = 0 ,  
  saldo_uf    = 0 ,   
  variacion_tc   = 0 ,  
  variacion_uf   = 0 ,  
  devengo        = 0 ,  
  devengo_pesos   = 0 ,  
  devengo_uf      = 0 ,  
  neto_dia        = 0 ,  
  acumulado_tc     = 0 ,  
  acumulado_uf     = 0 ,  
  acumulado_devengo   = 0 ,  
  acumulado_devengo_pesos  = 0 ,  
  acumulado_devengo_uf     = 0 ,  
  acumulado_neto           = 0  
 WHERE fecha = @dFecPro  
  
 SELECT *   
 INTO #temp_a   
 FROM RESULTADO   
 WHERE fecha = @dFecProAnt   
  
 UPDATE  a   
 SET  a.acumulado_tc    = b.acumulado_tc  ,  
  a.acumulado_uf    = b.acumulado_uf  ,  
  a.acumulado_devengo   = b.acumulado_devengo  ,  
  a.acumulado_devengo_pesos  = b.acumulado_devengo_pesos ,  
  a.acumulado_devengo_uf  = b.acumulado_devengo_uf ,  
  a.acumulado_neto   = b.acumulado_neto        
 FROM  resultado  a  
 , #temp_a  b    
 WHERE   a.fecha = @dFecPro  
 AND a.tipo = b.tipo   
  
 -- Para el Primer Día del Mes  
 IF @cFirstHabil = 'SI' BEGIN  
  UPDATE  a   
  SET  a.acumulado_tc    = 0   
  , a.acumulado_uf    = 0   
  , a.acumulado_devengo   = 0   
  , a.acumulado_devengo_pesos  = 0   
  , a.acumulado_devengo_uf   = 0   
  , a.acumulado_neto   = 0  
  FROM  resultado a  
  WHERE a.fecha  = @dFecPro  
  AND a.tipo NOT LIKE '%NET%'  
 END  
  
 -- Para el Primer Día del Año  
 IF SUBSTRING(@PrimerDiaMes,1,4) <> SUBSTRING(CONVERT(CHAR(8),@dFecProAnt,112),1,4) BEGIN  
  UPDATE  a   
  SET  a.acumulado_tc    = 0   
  , a.acumulado_uf    = 0   
  , a.acumulado_devengo   = 0   
  , a.acumulado_devengo_pesos  = 0   
  , a.acumulado_devengo_uf   = 0   
  , a.acumulado_neto   = 0  
  FROM  RESULTADO a  
  WHERE @dFecPro = a.fecha   
 END    

 BEGIN TRANSACTION  /************************************************************************************/  
  
 --*****************************************************************************************************************************  
 --******************************************* N U E V O   D E V E N G A M I E N T O *******************************************  
 --*****************************************************************************************************************************  
  
 EXEC SP_DEVENGAMIENTO_OPT_BFW @dFecPro -- 1 Fecha de Proceso  
             , @dFecProAnt -- 2 Fecha Proceso Anterior  
             , @dFecProxPro -- 3 Proxima Fecha Habil  
             , @dFecUDMPro -- 4 Ultimo D¡a Mes de Proceso  
             , @dFecUDMAnt -- 5 Ultimo D¡a Mes de Proceso Anterior  
             , @cLastHabil -- 6 Indica si es el Ultimo D¡a H bil  
             , @cFirstHabil -- 7 Indica si es el Primer D¡a H bil  
             , @nValorUF_Ant -- 8 Uf Dia Anterior  
             , @nValorUF_Pro -- 9 Uf de Proceso  
             , @nValorUF_UDM -- 10 Uf Fin de Mes  
             , @nValUsd_Pro -- 11 Valor D¢lar Observado Proceso  
             , @nValUsd_Ant -- 12 Valor D¢lar Observado Anterior  
             , @nvalusd_udma -- 13 Valor D¢lar Observado Ultimo Día Mes Anterior  
      , @iEjecucionIniDia  
  
 IF @iEjecucionIniDia = 0  
        BEGIN     
  EXEC SP_MTM_SegCam_SegInf  @dFecPro -- 1 Fecha de Proceso  
  EXEC SP_MTM_ARBITRAJES_MX_USD @dFecPro -- 1 Fecha de Proceso  
 END  
  
 /***************************** FIN NUEVO PROCESO DE DEVENGAMIENTO ********************************/  
  
-- |---------------------------------------------------------------------------|  
-- | Declaraci¢n del Cursor          |  
-- |---------------------------------------------------------------------------|  
  
 DECLARE Tmp_CurMFCA   SCROLL CURSOR FOR    
 SELECT canumoper      --1  
 , cacodpos1      --2  
 , catipoper      --3  
 , cacodmon1      --4  
 , camtomon1    --5  
 , FLOOR( caequmon1 )  --6  
 , capremon1      --7  
 , cacodmon2      --8  
 , camtomon2      --9  
 , FLOOR( caequmon2 )  --10  
 , capremon2      --11  
 , cafecha        --12  
 , cafecvcto      --13  
 , catipcam       --14  
 , camdausd       --15  
 , caprecal       --16  
 , catipmoda      --17  
 , camtomon1fin   --18  
 , camtomon1ini   --19  
 , camtomon2fin   --20  
 , camtomon2ini   --21  
 , catasausd   --22  
 , catasacon   --23  
 , tc_calculo_mes_actual  --24  
 , tc_calculo_mes_anterior  --25  
 , capremio   --26  
 , caantici   --27  
 , cafecvenor   --28  
 , cavalorayer   --29  
 , cafecEfectiva   --30  
 , 0 AS   correlativo --31   
 FROM BACFWDSUDA..MFCA WITH (NOLOCK)  
 WHERE cafecvcto = CASE WHEN @iEjecucionIniDia = 1 THEN @dFecPro ELSE cafecvcto END  
 AND cacodpos1 in (10, 11, 12)  
  
  
-- |---------------------------------------------------------------------------|  
-- | Apertura del Cursor.                  |  
-- |---------------------------------------------------------------------------|  
 OPEN Tmp_CurMFCA  
-- |---------------------------------------------------------------------------|  
-- | Primer registro del CURSOR (lectura secuencial de la tabla MFCA)     |  
-- |---------------------------------------------------------------------------|*/  
  
  
 FETCH FIRST FROM Tmp_CurMFCA  
        INTO  @nNumOpe    , --1  
       @nCarter    , --2   --  
       @cTipOpe    , --3  
       @nCodMon  , --4  
    @nMtoMex  , --5  
       @nMtoClp_i  , --6  
       @nValMex_i  , --7   --  
       @nCodCnv    , --8  
       @nMtoCnv    , --9  
       @nMtoCnv_i  , --10  
       @nValCnv_i  , --11  --  
       @dFecIni    , --12  
      @dFecVto    , --13  
       @nPreFut    , --14  --  
       @nMonRef    , --15  
                 @ntccierre  , --16  --  
       @cModal     , --17  
       @nmtofin1   , --18  
       @nmtoini1   , --19  
       @nmtofin2   , --20  
       @nmtoini2   , --21  
       @ntasausd   , --22  --  
       @ntasacnv   , --23  --  
       @tc_calculo_mes_actual  , --24  
       @tc_calculo_mes_anterior , --25  
       @npremio , --26  
       @canticipo , --27  
       @vencimiento_original  , --28  
       @valor_ayer , --29  
   @dFecEfectiva , --30  
   @nCorrelativo   --31   
  
--   |------------------------------------------------------------------------|  
--   | Carga Cursor                   |  
--   |------------------------------------------------------------------------|  
  
 WHILE ( @@FETCH_STATUS = 0 ) BEGIN  
  
  SELECT  @nPlazoOpe   = 0  
  , @nPlazoVto    = 0    
  , @nPlazoCal    = 0   
  , @nPlazoCal_a    = 0   
  , @nDiaDev    = 0    
  , @nValorUF    = 0   
  , @nMtoDif    = 0   
  , @nDelUsd    = 0   
  , @nDelUf           = 0   
  , @nDelUsd_a    = 0   
  , @nDelUf_a    = 0   
  , @nPerDif    = 0   
  , @nUtiDif    = 0   
  , @nPerDev    = 0   
  , @nUtiDev    = 0   
  , @nPerAcu    = 0   
  , @nUtiAcu    = 0   
  , @nPerAcu_a    = 0   
  , @nUtiAcu_a    = 0   
  , @nPerSal    = 0    
  , @nUtiSal    = 0   
  , @nClp_Mex    = 0  
  , @nClp_Cnv           = 0   
  , @nCtaCamb_a           = 0   
  , @nCtaCamb_c           = 0   
  , @nReaUFDia           = 0   
  , @nReaTCDia           = 0   
  , @nValorDia           = 0   
  , @nMtoComp           = 0  
  , @nRevUsd           = 0  
  , @nRevUF           = 0  
  , @nRevUsd_a           = 0  
  , @nRevUF_a           = 0  
  , @nRevTot           = 0  
  , @nRevTot_a           = 0  
  , @nMarktomarket           = 0  
  , @nMtoDif_usd           = 0  
  , @nMtoDif_cnv           = 0   
  , @ndevengo_Acu_usd_hoy    = 0  
  , @ndevengo_Acu_cnv_hoy    = 0   
  , @ndevengo_Acu_usd_ayer   = 0   
  , @ndevengo_Acu_cnv_ayer   = 0   
  , @clp_nMtoDif_usd         = 0   
  , @clp_nMtoDif_cnv         = 0   
  , @clp_ndevengo_usd        = 0   
  , @clp_ndevengo_cnv        = 0   
  , @clp_ndevengo_Acu_usd    = 0   
  , @clp_ndevengo_Acu_cnv    = 0   
  , @clp_nSaldo_diferido_usd = 0  
  , @clp_nSaldo_diferido_cnv = 0  
  , @nmonto_mtm_usd          = 0  
  , @nmonto_mtm_cnv          = 0   
  , @nmonto_var_usd          = 0  
  , @nmonto_var_cnv          = 0  
  , @ntasausd_mtm            = 0  
  , @ntasacnv_mtm            = 0  
  , @ntasausd_var            = 0  
  , @ntasacnv_var            = 0  
  , @nPlazoVtoanterior       = 0  
  , @nefecto_cambiario_mon1  = 0  
  , @nefecto_cambiario_mon2  = 0  
  , @ndevengo_tasa_mon1      = 0  
  , @ndevengo_tasa_mon2      = 0  
  , @ncambio_tasa_mon1       = 0  
  , @ncambio_tasa_mon2       = 0  
  , @nresiduo                = 0  
  , @nmonto_mtm_mon1_ayer    = 0  
  , @nmonto_mtm_mon2_ayer    = 0  
  , @Compensacion_estimada   = 0  
  , @nmonto_final            = 0  
  , @precio_spot_inicial     = 0  
  , @factor_moneda2          = 0  
  , @factor_moneda1          = 0  
  , @monto_factor           = 0  
  , @ntipcamval              = 0  
  , @monto_pesos2            = 0  
  , @valor_actual_cnv        = 0  
  , @devengo1                = 0  
  , @monto_acumulado_mon1    = 0  
  , @monto_acumulado_mon2    = 0  
  , @plazo_uso_moneda1       = 0  
  , @plazo_uso_moneda2       = 0  
  , @nValUsd_Ant             = @nObserAyer   
  , @monto_moneda2   = @nMtoCnv  
  , @moneda2                 = @nCodCnv  
  , @nPlazoVtoEfec           = 0  
  
  
  SELECT @VariacionDia  = 0.0  
  , @Mon_VpresPe   = 0.0  
  , @Mon_VMercado  = 0.0  
  , @VariacionDia  = 0.0  
  , @ReajusteDia   = 0.0  
  , @VariacionAcum = 0.0  
  , @ReajusteAcum  = 0.0  
  , @fPvp          = 0.0  
  , @fMt           = 0.0  
  , @fMtum         = 0.0  
  , @fMt_cien      = 0.0  
  , @fVan          = 0.0  
  , @fVpar         = 0.0  
  , @nNumucup      = 0.0  
  , @dFecucup      = 0.0  
  , @fIntucup      = 0.0  
  , @fAmoucup      = 0.0  
  , @fSalucup      = 0.0  
  , @nNumpcup      = 0  
  , @dFecpcup      = ''  
  , @fIntpcup      = 0.0  
  , @fAmopcup      = 0.0  
  , @fSalpcup      = 0.0  
  , @fDurat        = 0.0  
  , @fConvx        = 0.0  
  , @fDurmo        = 0.0  
  , @Fec_UltDev    = ''  
     
  SELECT  @nPlazoOpe = DATEDIFF( dd, @dFecIni, @dFecVto )    
     
  IF @nPlazoOpe = 0  
   SET @nPlazoOpe = 1  
  
  /*********************************/  
  /******** Tipo de Cliente ********/  
  /*********************************/  
  SELECT @cTipCli = (CASE clpais WHEN @CodPais THEN 'L' ELSE 'E' END)  
  FROM MFCA  
  , VIEW_CLIENTE  
  WHERE canumoper = @nNumOpe   
  AND clrut  = cacodigo   
  AND clcodigo = cacodcli  
  
  /*----Plazo al Vencimiento--------*/  
  IF @dFecVto < @dFecPro BEGIN  
   SET @nPlazoVto = 0  
   SET @nPlazoVtoEfec = 0  
  END ELSE   
  BEGIN  
   SET @nPlazoVto      = DATEDIFF(DAY, @FechaCalculos, @dFecVto)      --> DATEDIFF( dd , @dFecPro , @dFecVto )  
   SET @nPlazoVtoEfec  = DATEDIFF(DAY, @FechaCalculos, @dFecEfectiva) --> DATEDIFF( dd , @dFecPro , @dFecEfectiva )   
  END  
  
  --Plazo Residual al Día Anterior  
  SELECT @nPlazoVtoanterior = 0  
     
  IF @dFecini < @dFecPro   
   SET @nPlazoVtoanterior = DATEDIFF( dd , @dFecProAnt , @dFecVto )  
            
--  |---------------------------------------------------------------------|  
--  | Plazo de Cálculo hasta Hoy            |  
--  |---------------------------------------------------------------------|  
  IF @dFecPro = @dFecVto  BEGIN  
   SET @nPlazoCal   = DATEDIFF(DAY, @dFecIni, @FechaCalculos) -->  DATEDIFF( dd, @dFecIni, @dFecPro)  
  END   
  ELSE BEGIN  
   IF @dFecVto < @dFecPro BEGIN  
    SET @nPlazoCal = DATEDIFF( dd, @dFecIni, @dFecVto )  
   END   
   ELSE BEGIN  
    SET @nPlazoCal = DATEDIFF( dd, @dFecIni, @dFecProxPro )  
   END  
      
   IF @cLastHabil = 'SI' AND @dFecVto <> @dFecPro BEGIN  
    SET @nPlazoCal = DATEDIFF( dd , @dFecIni , (@dFecUDMPro + 1))  
   END  
  END  
  
  IF @canticipo = 'A'   
   SET @nPlazoCal = DATEDIFF( dd, @dFecIni, @vencimiento_original )  
    
  IF @dFecIni < @dFecPro  
   SET @nPlazoCal_a = DATEDIFF(DAY, @dFecIni, @FechaCalculos) -->  DATEDIFF( dd, @dFecIni, @dFecPro )  
     
  IF @cFirstHabil = 'SI' AND @dFecIni < @dFecPro  
   SET @nPlazoCal_a = DATEDIFF( dd , @dFecIni , (@dFecUDMAnt + 1))  
  
  /*********************/  
  /* FIN PLAZO CALCULO */  
  /*********************/  
     
--  |---------------------------------------------------------------------|  
--  | Dias de Devengamiento            |  
--  |---------------------------------------------------------------------|  
  IF @dFecVto < @dFecPro BEGIN  
   SELECT @dFecAux = @dFecVto  
  END   
  ELSE BEGIN  
   IF @canticipo = 'A' BEGIN  
    SELECT @dFecAux = @vencimiento_original  
   END   
   ELSE BEGIN  
    SELECT @dFecAux = @dFecProxPro  
   END  
  END  
     
  SET @nDiaDev = DATEDIFF(DAY, @FechaCalculos, @dFecAux ) --> DATEDIFF( dd ,  @dFecPro ,@dFecAux ) --Dias de Devengo en Período Normal  
     
  IF @cFirstHabil = 'SI' BEGIN  --Primer Día Hábil  
   IF @dFecIni < @dFecPro BEGIN --Vigentes al Mes Anterior  
    IF @dFecVto = @dFecPro   
     SET @nDiaDev = DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecPro )     --SUDAMERICANO SUMA 1 Día en el Fin de Mes  
    ELSE  
     SET @nDiaDev = DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecProxPro ) --SUDAMERICANO SUMA 1 Día en el Fin de Mes  
   END  
  END  
  
  IF @cLastHabil = 'SI' BEGIN --Ultimo Día Hábil  
   SELECT @nDiaDev = DATEDIFF( dd , @dFecPro , ( @dFecUDMPro + 1 ) )  --SUDAMERICANO SUMA 1 Día en el Fin de Mes  
  END  
     
  IF @dFecVto <= @dFecPro AND @canticipo <> 'A' AND @cFirstHabil = 'NO' BEGIN  
   SELECT @nDiaDev = 0   
  END  
  
  /*****************************/  
  /* FIN DIAS DE DEVENGAMIENTO */  
  /*****************************/  
  
--  |---------------------------------------------------------------------|  
--  | Valor UF a Utilizar en el Cálculo        |  
--  | Lo General es que la UF de Cálculo Sea la Misma del día, sin Embargo|  
--  | a Fin de Mes se debe Utilizar la UF del Ultimo Día del Mes Excepto  |  
--  | Para Aquellas Operaciones que Vencen ese Día       |  
--  |---------------------------------------------------------------------|  
  
  SET @nValorUF = @nValorUF_Pro   
    
  IF @dFecPro <> @FechaCalculos  
   SET @nValorUF = @nValorUF_UDM  
     
  IF @cLastHabil = 'SI' AND  @dFecVto <> @dFecPro BEGIN  
   SELECT @nValorUF = @nValorUF_UDM    
  END  
     
--  |---------------------------------------------------------------------|  
--  |---------   Aqui Comienzan El Proceso de Devengamiento     ---------|  
--  |---------  y Valorizaci¢n        ---------|  
--  |---------------------------------------------------------------------|  
--  |---------------------------------------------------------------------|  
--  | Cálculo de Devengo y Valorizaci¢n                                   |  
--  |---------------------------------------------------------------------|  
  
  
 IF @nCarter = 10  
 BEGIN  
  -- Forward Bond Trades --  
  SELECT  @Mon_inst      = cacodmon1  
         ,       @Mon_pago      = cacodmon2  
  ,       @Fec_inic      = cafecha  
  ,       @Fec_Vcto      = cafecvcto  
  ,       @Mon_Nominal   = camtomon1  
  ,       @Mon_VpresPe   = caequmon1  
  ,       @Mon_VPresUm   = camtomon2  
  ,       @Mon_VMercado  = caequusd2  
  ,       @Tir_Forward   = catipcam  
  ,       @Tir_Mercado   = capremon1 -- @Tasa_uf05  
  ,       @Seriedo       = caseriado  
  ,       @Ser_Inst      = caserie  
  ,       @Cod_inst      = cabroker  
  ,       @Fec_Calc      = @dFecPro  
  , @Tas_Est       = 0  
  ,       @Fec_UltDev    = fechaemision    
  ,       @ReajusteAcum  = pesos_devengo_acum_cnv  
  ,       @VariacionAcum = pesos_devengo_acum_usd  
  ,       @ReajusteDia   = 0.0  
  ,       @VariacionDia  = 0  
  ,       @TipoOper      = catipoper  
  ,       @BenchMarck    = '*'  
  ,       @iCalculaVAyer = CASE WHEN cafecha = @dFecPro THEN 0 ELSE 1 END  
  FROM    MFCA  
  WHERE   canumoper      = @nNumOpe  
  
  IF @Seriedo = 'S'  
  BEGIN  
   SELECT @Tas_Emis       = setasemi   
   ,      @Mon_Emis       = semonemi   
   ,      @Bas_Emis       = sebasemi   
   ,      @Fec_Emis       = sefecemi  
   ,      @dFechaVctoIns  = sefecven  
   FROM   bacparamsuda..SERIE  
   WHERE  semascara       = @Ser_Inst  
  END ELSE   
  BEGIN  
     
   SET ROWCOUNT 1  
   SELECT @Tas_Emis          = nstasemi   
   ,      @Mon_Emis          = nsmonemi   
   ,      @Bas_Emis          = nsbasemi   
   ,      @Fec_Emis          = nsfecemi  
   ,      @dFechaVctoIns     = nsfecven  
                        FROM   bacparamsuda..NOSERIE  
   WHERE  nsserie         = @Ser_Inst  
   SET ROWCOUNT 0  
  END  
  
  IF EXISTS(SELECT 1 FROM BacParamSuda..INSTRUMENTO WHERE incodigo = @Cod_inst)  
  BEGIN  
   SELECT @Valorizador = 'bactradersuda..SP_' + LTRIM(RTRIM(inprog))  
   FROM   BacParamSuda..INSTRUMENTO  
   WHERE  incodigo     = @Cod_inst  
  
   IF @Mon_Emis <> 999  
   BEGIN  
    SELECT @Tas_Est = CASE WHEN @Cod_inst = 1 THEN @fTe_pcdus  
                         WHEN @Cod_inst = 2 THEN @fTe_pcduf  
                                                       WHEN @Cod_inst = 5 THEN @fTe_ptf  
                       ELSE                    CONVERT(FLOAT,0)  
               END  
   END  
  
   SELECT @ValorMoneda_Hoy = 0.0  
   SELECT @ValorMoneda_Hoy = vmvalor  
   FROM   VIEW_VALOR_MONEDA  
   WHERE  vmcodigo         = @Mon_Emis  
   AND    vmfecha          = CASE WHEN @Mon_Emis = 998 THEN @FechaCalculos ELSE @dFecPro END --> ¿ ADRIAN ?  
  
   SELECT @ValorMoneda_Mañ = 0.0  
   SELECT @ValorMoneda_Mañ = vmvalor  
   FROM   VIEW_VALOR_MONEDA  
   WHERE  vmcodigo         = @Mon_Emis  
   AND    vmfecha          = @dFecProxPro  
  
   IF @Fec_inic <= @dFecPro  
   BEGIN  
    SELECT @ReajusteDia = isnull((@ValorMoneda_Hoy - @ValorMoneda_Mañ),0) * isnull(@Mon_VPresUm,0.0)  
   END ELSE  
          BEGIN  
    SELECT @ReajusteDia = 0.0  
   END  
  
   IF @Fec_UltDev = @Fec_Calc  
   BEGIN  
    SELECT @ReajusteAcum = ISNULL(@ReajusteAcum,0.0)  
   END ELSE  
          BEGIN  
    SELECT @ReajusteAcum = ISNULL(@ReajusteAcum + @ReajusteDia,0.0)  
           END  
  END  
  
  
               -- Definir Tasa Mercado para la valorización (benchmarck)  --  
               DECLARE @nPlazo   INT  
               SET     @nPlazo   = DATEDIFF(YEAR, @FechaCalculos, @dFechaVctoIns)       -->  DATEDIFF(YEAR, @dFecPro,  @dFechaVctoIns)  
               SET     @nPlazo   = DATEDIFF(DAY,  @FechaCalculos, @dFechaVctoIns) / 360 -->  DATEDIFF(YEAR, @dFecPro,  @dFechaVctoIns)  
            -- SET     @nPlazo = DATEDIFF(YEAR, @Fec_Emis, @dFechaVctoIns)  
  
               SET    @Tir_Mercado = 0.0  
               SELECT @Tir_Mercado = ISNULL(Tasa,0.0)  
               ,      @BenchMarck  = ' '   
               FROM   BENCH_MARCK  
               WHERE  Instrumento  = @Cod_inst  
               AND    Moneda       = @Mon_Emis  
               AND    @nPlazo      BETWEEN Desde AND Hasta  
               AND    Fecha        = @dFecPro  
  
  IF @BenchMarck = '*' OR @Tir_Mercado IS NULL  
  BEGIN  
                  SET @Tir_Mercado = 0.0  
  END  
  
  -- ******************************************* --  
  EXECUTE @nError     = @Valorizador  
                        2                   -- @iModcal  
  ,                     @Fec_Calc           -- @dFeccal  
  ,                     @Cod_inst           -- @iCodigo  
  ,                     @Ser_Inst           -- @cInstser  
  ,                     @Mon_Emis           -- @iMonemi  
  ,                     @Fec_Emis           -- @dFecemi  
  ,                     @Fec_Vcto           -- @dFecven  
  ,                     @Tas_Emis           -- @fTasemi  
  ,                     @Bas_Emis           -- @fBasemi  
  ,                     @Tas_Est            -- @fTasest  
  ,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT  
  ,                     @Tir_Forward OUTPUT -- @fTir     OUTPUT  
  ,                     @fPvp        OUTPUT  
  ,                     @fMt         OUTPUT  
  ,                     @fMtum       OUTPUT  
  ,                     @fMt_cien    OUTPUT  
  ,                     @fVan        OUTPUT  
  ,                     @fVpar       OUTPUT  
  ,                     @nNumucup    OUTPUT  
  ,                     @dFecucup    OUTPUT  
  ,                     @fIntucup    OUTPUT  
  ,                     @fAmoucup    OUTPUT  
  ,        @fSalucup    OUTPUT  
  ,                     @nNumpcup    OUTPUT  
  ,                     @dFecpcup    OUTPUT  
  ,                     @fIntpcup    OUTPUT  
  ,                     @fAmopcup    OUTPUT  
  ,                     @fSalpcup    OUTPUT  
  ,                     @fDurat      OUTPUT  
  ,                     @fConvx      OUTPUT  
  ,         @fDurmo      OUTPUT  
  SET @Mon_VpresPe = ISNULL(@fMt,0)  
  
  EXECUTE @nError     = @Valorizador  
                        2                   -- @iModcal  
  ,                     @Fec_Calc           -- @dFeccal  
  ,                     @Cod_inst           -- @iCodigo  
  ,                     @Ser_Inst           -- @cInstser  
  ,                     @Mon_Emis           -- @iMonemi  
  ,                     @Fec_Emis           -- @dFecemi  
  ,                     @Fec_Vcto           -- @dFecven  
  ,                     @Tas_Emis           -- @fTasemi  
  ,                     @Bas_Emis           -- @fBasemi  
  ,                     @Tas_Est    -- @fTasest  
  ,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT  
  ,                     @Tir_Mercado OUTPUT -- @fTir     OUTPUT  
  ,                     @fPvp        OUTPUT  
  ,                     @fMt         OUTPUT  
  ,                     @fMtum       OUTPUT  
  ,                     @fMt_cien    OUTPUT  
  ,                     @fVan        OUTPUT  
  ,                     @fVpar       OUTPUT  
  ,                     @nNumucup    OUTPUT  
  ,                     @dFecucup    OUTPUT  
  ,                     @fIntucup    OUTPUT  
  ,                     @fAmoucup    OUTPUT  
  ,                     @fSalucup    OUTPUT  
  ,                     @nNumpcup    OUTPUT  
  ,                     @dFecpcup    OUTPUT  
  ,                     @fIntpcup    OUTPUT  
  ,                     @fAmopcup    OUTPUT  
  ,                     @fSalpcup    OUTPUT  
  ,                     @fDurat      OUTPUT  
  ,                     @fConvx      OUTPUT  
  ,                     @fDurmo      OUTPUT  
  
  SET @Mon_VMercado = ISNULL(@fMt,0)  
  SET @VariacionDia = ISNULL((@Mon_VpresPe - @Mon_VMercado),0)  
  
  IF @TipoOper = 'C'  
  BEGIN  
     SET @VariacionDia = ISNULL((@Mon_VMercado  - @Mon_VpresPe),0)  
  END ELSE  
  BEGIN  
     SET @VariacionDia = ISNULL((@Mon_VpresPe   - @Mon_VMercado),0)  
  END  
  
  IF @Fec_UltDev = @Fec_Calc  
  BEGIN  
                   SET @VariacionAcum = ISNULL(@VariacionAcum,0.0)  
  END ELSE  
  BEGIN  
     SET @VariacionAcum = ISNULL(@VariacionAcum + @VariacionDia,0.0)  
  END  
  
         ----<< Actualiza Cartera  
  UPDATE MFCA  
  SET    caplazoope        = @nPlazoOpe  
  ,      caplazovto        = @nPlazoVto  
  ,      caplazocal        = @nPlazoCal  
  ,      cadiasdev        = @nDiaDev  
  ,      cavalordia              = @VariacionDia  
  ,      diferido_cnv        = @VariacionDia  
  ,      devengo_acum_usd_hoy    = @Mon_VpresPe  
  ,      devengo_acum_cnv_hoy    = @Mon_VMercado  
  ,      pesos_devengo_usd       = isnull(@VariacionDia,0.0)  
  ,      pesos_devengo_cnv       = isnull(@ReajusteDia,0.0)  
  ,      pesos_devengo_acum_usd  = isnull(@VariacionAcum,0.0)  
  ,      pesos_devengo_acum_cnv  = isnull(@ReajusteAcum,0.0)  
  ,      fechaemision            = @Fec_Calc  
  ,      tc_calculo_mes_actual   = @Tir_Mercado  
  ,      caequmon1               = @Mon_VpresPe  
  ,      caequusd2               = @Mon_VMercado  
  ,      capremon1               = @Tir_Mercado  
                ,      caOrgCurvaMon           = 'TM'  
                ,      caOrgCurvaCnv           = 'TM'   
                ,      catasfwdcmp        = @fDurat   -- Se utilizó este campo para guardar duration   
  WHERE  canumoper               = @nNumOpe  
  
  EXECUTE SP_C08_ForwardBondTrades @nNumOpe , @iEjecucionIniDia  
  
  SELECT @VariacionDia  = 0.0  
     ,      @Mon_VpresPe   = 0.0  
     ,      @Mon_VMercado  = 0.0  
     ,      @VariacionDia  = 0.0  
     ,      @ReajusteDia   = 0.0  
     ,      @VariacionAcum = 0.0  
     ,      @ReajusteAcum  = 0.0  
        
 END  
  
  
 -- indicacion t-lock  
       if  @nCarter = 11  
 BEGIN  
  ----  
         UPDATE MFCA  -- Ojo Falta Revisar  
  SET    caplazoope       = @nPlazoOpe  
  ,      caplazovto       = @nPlazoVto  
  ,      caplazocal       = @nPlazoCal  
  ,      cadiasdev       = @nDiaDev  
  ,      cavalordia                    = @VariacionDia  
  ,      diferido_cnv              = @VariacionDia  
  ,      devengo_acum_usd_hoy          = @Mon_VpresPe  
  ,      devengo_acum_cnv_hoy          = @Mon_VMercado  
  ,      pesos_devengo_usd      = isnull(@VariacionDia,0.0)  
  ,      pesos_devengo_cnv      = isnull(@ReajusteDia,0.0)  
  ,      pesos_devengo_acum_usd        = isnull(@VariacionAcum,0.0)  
  ,      pesos_devengo_acum_cnv        = isnull(@ReajusteAcum,0.0)  
                ,      caOrgCurvaMon                 = 'TM'  
                ,      caOrgCurvaCnv                 = 'TM'   
  WHERE  canumoper = @nNumOpe  
  
                EXECUTE SP_C08_TLOCK @nNumOpe , @iEjecucionIniDia  
  
  SELECT @VariacionDia  = 0.0  
     ,      @Mon_VpresPe   = 0.0  
     ,      @Mon_VMercado  = 0.0  
     ,      @VariacionDia  = 0.0  
     ,      @ReajusteDia   = 0.0  
     ,      @VariacionAcum = 0.0  
     ,      @ReajusteAcum  = 0.0  
  
 END  
  
      /*  
      |---------------------------------------------------------------------|  
      | Grabar Registros de valorización      |    
      | Seguros de Cambio        |  
      | Seguros de Inflaci½n           |  
      |---------------------------------------------------------------------|*/  
/*  
      IF @nCarter = 1 OR @nCarter = 2 OR @nCarter = 3 OR @nCarter = 13  
      BEGIN  
            SELECT @dFecVctop   = @dFecVto  
            SELECT @nPlazoVctop = @nPlazoVto  
  
        
         ----<< Calculo MTM  
         IF @nCarter in ( 1 , 2 , 3 ,13 )   
  
          EXECUTE sp_marktomarket @nCarter    , --1  
                                               @nPlazoVctop    , --2  
                          @nCodCnv     , --3  
            @nValorUF     , --4  
            @nMtoMex      , --5  
            @dFecVctop    , --6  
            @cTipOpe     , --7  
           @nPreFut            , --8  
                       @nCodMon     , --9  
            @nNumOpe    , --10  
            @nMarkToMarket     OUTPUT        , --11  
           @nPrecioMtm        OUTPUT         , --12  
                                                @nmonto_mtm_usd   OUTPUT         , --13    
                            @nmonto_mtm_cnv    OUTPUT        , --14  --Valor Pasivo   
            @Valor_Obtenido         OUTPUT         , --15  --Valor Obtenido  
            @ResultadoMTM         OUTPUT         , --16  
            @cModal                 ,       --17 MODALIDAD DE PAGO  
      @CaTasaSinteticaM1  OUTPUT   ,  --18  
      @CaTasaSinteticaM2  OUTPUT   , --19  
      @CaPrecioSpotVentaM1 OUTPUT   , --20  
      @CaPrecioSpotVentaM2  OUTPUT   , --21  
      @CaPrecioSpotCompraM1   OUTPUT   , --22  
      @CaPrecioSpotCompraM2   OUTPUT    , --23   
                                                @ValorRazonableActivo   OUTPUT    , --24 MPNG20050825 TAG 002  
                                                @ValorRazonablePasivo   OUTPUT    , --25 MPNG20050825 TAG 002  
      @nTasa1                 OUTPUT  , --26  
      @nTasa2                 OUTPUT  , --27  
      @TipoCurvaMon           OUTPUT  , --28  
      @TipoCurvaCnv           OUTPUT  , --29  
                                                @iEjecucionIniDia  
  
    IF @nCorrelativo = 0 BEGIN  
       ----<< Actualiza Cartera  
  
      UPDATE  MFCA  SET   
       caplazoope                      = @nPlazoOpe  ,  
       caplazovto                      = @nPlazoVto  ,  
       caplazocal                      = @nPlazoCal  ,  
       cadiasdev                       = @nDiaDev  ,  
       cadiftipcam    = @nReaTCDia  , -- Diferencia  
          cadifuf    = @nReaUFDia  , -- Reajustes  
       carevusd   = @nRevUsd  ,  -- Inicio - Hoy  
       carevuf    = @nRevUF  ,  -- Inicio - Hoy  
       carevTot   = @nrevTot  ,  
       carevusd_ayer   = @nRevUsd_a  ,  -- Inicio - Ayer  
       carevuf_ayer   = @nRevUF_a  ,  -- Inicio - Ayer  
       carevTot_ayer   = @nrevTot_a  ,  
                                   cavalordia   = @nValorDia  ,  
       cactacambio_a   = @nctaCamb_a  ,  
       cactacambio_c   = @nctaCamb_c  ,  
          cautildiferir   = @nUtiDif   ,  
       caperddiferir    = @nPerDif  ,  
       cautildevenga    = @nUtiDev  ,  -- Utilida Diario  
       caperddevenga    = @nPerDev  ,  -- perdida Diario  
       cautilacum    = @nUtiAcu  ,  -- Acumulado         
       caperdacum    = @nPerAcu  ,  -- Acumulado  
       cautilacum_ayer   = @nUtiAcu_a  ,  -- Acumulado AYER  
       caperdacum_ayer   = @nPerAcu_a  ,  -- Acumulado AYER  
       cautilsaldo    = @nUtiSal  ,  -- Saldo       
       caperdsaldo    = @nPerSal  ,  
       caclpmoneda1    = @nClp_Mex   ,  -- Monto CLP Hoy   
       caclpmoneda2    = @nClp_Cnv   ,  --   
       cadelusd   = @nDelUsd  ,  
       cadeluf    = @ndelUf  ,  
       camtocomp         = @nMtoComp      ,  
       camarktomarket    = ISNULL(@nMarktomarket,0)  ,  
       capreciomtm   = ISNULL(@nPrecioMtm,0)  ,  
       catipcamval       = @ntipcamval   ,  
       diferido_usd   = @nMtoDif_usd   ,  
       diferido_cnv   = @nMtoDif_cnv   ,  
       camtodiferir   = @nmtodif    ,  
       devengo_acum_usd_hoy            = @ndevengo_Acu_usd_hoy  ,   
       devengo_acum_cnv_hoy   = @ndevengo_Acu_cnv_hoy  ,  
       devengo_acum_usd_ayer           = @ndevengo_Acu_usd_ayer ,   
       devengo_acum_cnv_ayer  = @ndevengo_Acu_cnv_ayer ,  
       pesos_diferido_usd  = @clp_nMtoDif_usd   ,  
       pesos_diferido_cnv  = @clp_nMtoDif_cnv   ,  
       pesos_devengo_usd  = @clp_ndevengo_usd   ,  
       pesos_devengo_cnv  = @clp_ndevengo_cnv   ,  
       pesos_devengo_acum_usd         = @clp_ndevengo_Acu_usd  ,  
       pesos_devengo_acum_cnv         = @clp_ndevengo_Acu_cnv  ,  
       pesos_devengo_saldo_usd         = @clp_nSaldo_diferido_usd  ,  
       pesos_devengo_saldo_cnv    = @clp_nSaldo_diferido_cnv  ,  
       valor_actual_cnv  = @valor_actual_cnv  ,  
       mtm_hoy_moneda1          = ISNULL(@nmonto_mtm_usd,0) ,  
       mtm_hoy_moneda2          = ISNULL(@nmonto_mtm_cnv,0) ,  
       var_moneda1   = @nmonto_var_usd   ,  
       var_moneda2   = @nmonto_var_cnv   ,  
       tasa_mtm_moneda1  = @ntasausd_mtm   ,  
       tasa_mtm_moneda2  = @ntasacnv_mtm  ,  
       tasa_var_moneda1  = @ntasausd_var   ,  
       tasa_var_moneda2  = @ntasacnv_var   ,  
       efecto_cambio_moneda1  = @nefecto_cambiario_mon1 ,  
       efecto_cambio_moneda2  = @nefecto_cambiario_mon2 ,  
       devengo_tasa_moneda1  = @ndevengo_tasa_mon1 ,  
       devengo_tasa_moneda2  = @ndevengo_tasa_mon2 ,  
       cambio_tasa_moneda1  = @ncambio_tasa_mon1  ,  
       cambio_tasa_moneda2  = @ncambio_tasa_mon2  ,  
       residuo    = @nresiduo    ,  
       mtm_ayer_moneda1  = @nmonto_mtm_mon1_ayer  ,  
       mtm_ayer_moneda2  = @nmonto_mtm_mon2_ayer  ,  
       caplazo_uso_moneda1  = @plazo_uso_moneda1  ,  
       caplazo_uso_moneda2  = @plazo_uso_moneda2    
      WHERE   canumoper                       =  @nNumOpe  
  
     END  
  
          EXECUTE sp_marktomarket @nCarter    , --1  
                                               @nPlazoVtoEfec    , --2 --JB 20050613  
                          @nCodCnv     , --3  
            @nValorUF     , --4  
            @nMtoMex      , --5  
            @dFecVctop    , --6  
            @cTipOpe     , --7  
                                               @nPreFut            , --8  
                                               @nCodMon             , --9  
            @nNumOpe    , --10  
            @nMarkToMarket     OUTPUT         , --11  
            @nPrecioMtm        OUTPUT         , --12  
                                               @nmonto_mtm_usd   OUTPUT         , --13  
                                          @nmonto_mtm_cnv    OUTPUT         , --14  
            @Valor_Obtenido    OUTPUT         , --15 new  
            @ResultadoMTM         OUTPUT         , --16  
            @cModal                 ,       --17 MODALIDAD DE PAGO  
      @CaTasaSinteticaM1  OUTPUT   ,  --18  
      @CaTasaSinteticaM2  OUTPUT   , --19  
      @CaPrecioSpotVentaM1 OUTPUT   , --20  
      @CaPrecioSpotVentaM2  OUTPUT   , --21  
      @CaPrecioSpotCompraM1   OUTPUT   , --22  
      @CaPrecioSpotCompraM2   OUTPUT    , --23    
                                                @ValorRazonableActivo   OUTPUT    , --24 MPNG20050825 TAG 002  
                           @ValorRazonablePasivo   OUTPUT    , --25 MPNG20050825 TAG 002  
      @nTasa1                 OUTPUT  , --26  
      @nTasa2                 OUTPUT  , --27  
      @TipoCurvaMon           OUTPUT  , --28  
      @TipoCurvaCnv           OUTPUT  , --29  
                                                @iEjecucionIniDia  
  
     IF @nCorrelativo = 0 BEGIN  
  
      UPDATE MFCA     
                                                SET fVal_Obtenido    = @Valor_Obtenido  ,      --new  
       fRes_Obtenido   = @ResultadoMTM  ,  --@nMtoMex *(@nPreFut - @Valor_Obtenido),  --new  
       CaTasaSinteticaM1  = @CaTasaSinteticaM1 ,  --new  
       CaTasaSinteticaM2  = @CaTasaSinteticaM2 , --new  
       CaPrecioSpotVentaM1  = @CaPrecioSpotVentaM1 , --new  
       CaPrecioSpotVentaM2  = @CaPrecioSpotVentaM2 ,  --new  
       CaPrecioSpotCompraM1  = @CaPrecioSpotCompraM1 , --new  
       CaPrecioSpotCompraM2  = @CaPrecioSpotCompraM2 , --new  
       CaFecEfectiva   = @dFecEfectiva         ,  
       ValorRazonableActivo            = @ValorRazonableActivo ,       -- MPNG20050825 TAG 002  
       ValorRazonablePasivo            = @ValorRazonablePasivo ,       -- MPNG20050825 TAG 002    
       catasadolar   = @nTasa1  ,  
       catasaufclp   = @nTasa2  ,  
       caOrgCurvaMon   = @TipoCurvaMon  ,  
       caOrgCurvaCnv   = @TipoCurvaCnv  
      WHERE canumoper                = @nNumOpe  
     END  
  
      ELSE BEGIN  
       UPDATE TBL_CARTERA_FLUJOS        
       SET Ctf_Valor_Razonable_Activo = @ValorRazonableActivo  
       , Ctf_Valor_Razonable_Pasivo = @ValorRazonablePasivo  
       , Ctf_Valor_Razonable  = @ResultadoMTM  
       , Ctf_Articulo84   = @nmtodif  
       , Ctf_Precio_Proyectado  = @Valor_Obtenido  
       WHERE Ctf_Numero_OPeracion  = @nNumOpe  
       AND Ctf_Correlativo   = @nCorrelativo  
  
       IF @dFecVto = @dFecpro BEGIN      
        EXEC SP_PRO_RECALCULA_MTOS_CARTERA @nNumOpe  
       END  
  
      END  
  
  
  SELECT @devengo1             = (@nPerDev + @nUtiDev)  
  SELECT @monto_acumulado_mon1 = @nMtoini1 + ABS(@ndevengo_Acu_usd_hoy)   
  SELECT @monto_acumulado_mon2 = @nMtoini2 + ABS(@ndevengo_Acu_cnv_hoy)   
  
  EXECUTE sp_llena_resultado @ncarter            ,  
      @dfecpro     ,  
      @dFecProAnt     ,  
      @ncodmon     ,  
      @ncodcnv     ,  
      @nReaTCDia     ,  
      @nReaUFDia     ,  
      @devengo1     ,  
      @cTipOpe     ,  
      @dFecVto     ,  
      @nMtoMex     ,  
      @nmtocnv     ,  
      @clp_ndevengo_usd    ,  
      @clp_ndevengo_cnv    ,  
      @monto_acumulado_mon1           ,  
      @monto_acumulado_mon2         ,  
      @nNumOpe     ,  
      @nMtoComp     ,  
      @nValorDia     ,  
      @valor_ayer  
  
  
  IF @@error <> 0   
                BEGIN  
   ROLLBACK TRANSACTION  
   SELECT -1 , 'Error: al actualizar el registro en la tabla de cartera.'  
   CLOSE Tmp_CurMFCA  
   DEALLOCATE Tmp_CurMFCA  
   RETURN -1  
  END  
 END  
*/  
  
 /*  
       |---------------------------------------------------------------------|  
 | Siguiente registro del CURSOR lectura secuencial de la tabla MFCA   |  
       |---------------------------------------------------------------------|*/  
        FETCH NEXT FROM Tmp_CurMFCA  
        INTO  @nNumOpe    , --1  
       @nCarter    , --2   --  
       @cTipOpe    , --3  
       @nCodMon    , --4  
       @nMtoMex    , --5  
       @nMtoClp_i  , --6  
       @nValMex_i  , --7   --  
       @nCodCnv    , --8  
       @nMtoCnv    , --9  
       @nMtoCnv_i  , --10  
       @nValCnv_i  , --11  --  
       @dFecIni    , --12  
       @dFecVto    , --13  
       @nPreFut    , --14  --  
       @nMonRef    , --15  
                 @ntccierre  , --16  --  
       @cModal     , --17  
       @nmtofin1   , --18  
       @nmtoini1   , --19  
       @nmtofin2   , --20  
       @nmtoini2   , --21  
       @ntasausd   , --22  --  
       @ntasacnv   , --23  --  
       @tc_calculo_mes_actual  , --24  
       @tc_calculo_mes_anterior , --25  
       @npremio , --26  
       @canticipo , --27  
       @vencimiento_original  , --28  
       @valor_ayer , --29  
   @dFecEfectiva ,--30  
   @nCorrelativo  --31  
  
  
    END -- While  
  
/*  
|---------------------------------------------------------------------------|  
| Cierra el CURSOR para abrierlo despues en el procedimiento almacenado.    |  
|---------------------------------------------------------------------------|*/  
 CLOSE Tmp_CurMFCA  
  
/*  
|---------------------------------------------------------------------------|  
| Borra la estructura del cursor         |  
|---------------------------------------------------------------------------|*/  
 DEALLOCATE Tmp_CurMFCA  
  
 IF @iEjecucionIniDia = 0  
 BEGIN  
  
      EXECUTE SP_DETALLE_VALOR_RAZONABLE @dFecPro, @dFecProxPro, @dFecProAnt  
 END  
  
  
 IF @iEjecucionIniDia = 0 --> Desde el Proceso de Valorizacion y No desde el Inicio de Día  
 BEGIN  
    UPDATE MFAC   
       SET acsw_devenfwd = '1', acsw_fd = '0', acsw_contafwd = '0'  
 END ELSE  
 BEGIN  
    UPDATE MFAC  
       SET acsw_devenfwd = '0', acsw_fd = '0', acsw_contafwd = '0'  
 END  
  
 IF @@error <> 0   
 BEGIN  
 ROLLBACK TRANSACTION  
 SELECT -1,  
 'Error: al grabar flags de tabla de parametros'  
 RETURN -1  
  
 END  
  
 COMMIT TRANSACTION  
 SELECT 'OK'  
  
 SET NOCOUNT OFF  
   
END

GO
