USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_APPMVTCAR]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_APPMVTCAR]      
       (    
         @MoNumFolio numeric(8)    
       )    
AS    
BEGIN    
    
    -- return (0)    
    -- Sp_AppMvtCar 798     
    -- POR HACER: probar CREACION, ANULA, ANTICIPA y MODIFICA    
    -- Al anticipar se debe cambiar TipoTransaccion     
    -- y el estado , dejar vigente    
    
    -- MAP 22 Octubre 2009    
    -- Folio del la caja de los anticipos       
    -- No se genera Caja al Modificar otro dia    
    -- las operaciones.    
    
    -- MAP 28 Octubre 2009    
    -- Fecha de los movimientos siempre    
    -- debe ser la fecha de proceso       
    
    -- MAP 13 Nov. Entrega    
    -- Cabmio de fecha de creacion de registro, debe ser la misma que la fecha    
    -- de proceso, si no no resulta la contabilidad de movimientos    
    
 -- ASVG 25 Febrero 2011    
 -- Se filtra la prima que no existe para Forward Americano    
    
 -- PRD_10449 ASVG_20111103 Se agrega campo de relación producto estructurado (PAE - PRD10449)  
  
    SET NOCOUNT ON    
    
-- Por mientras    
    
/*    
        SELECT CONVERT( varchar(2) , 'SI' )    
             , CONVERT( varchar(80), 'Movimiento ' + LTRIM( RTRIM( 'TEMPORAL' ) ) + ' ' + RTRIM( CONVERT( character(9), 0 ) ) +    
               ' en cartera'  ) --+ @MsgLCR    
        RETURN (0)    
*/    
-- Por mientras    
    
    DECLARE @MoTipoTransaccion  varchar(10)    
    DECLARE @MoNumContrato      numeric(8)    
    DECLARE @MsgError           varchar(80)    
    DECLARE @PrcAnticipo        numeric(10,5)      
    DECLARE @PrcAnticipoRem     numeric(10,5)    
    DECLARE @ValidaAnticipo     numeric(1)    
    DECLARE @Modalidad          varchar(1)    
    DECLARE @MoRut              numeric(9)      
    DECLARE @MoCodigo           numeric(9)      
    DECLARE @MoOperador         varchar(15)    
    DECLARE @Proceso            datetime    
    DECLARE @EsCotizacion       varchar(1)    
    DECLARE @Observ             varchar(5000)  -- 08 Oct. 2009    
    DECLARE @MoFechaContratoOri datetime    
        
    -- Variables UnWind    
    DECLARE @MoFechaUnwind      datetime    
    DECLARE @MoNominalUnwind    float    
    DECLARE @MoUnwindMon        int    
    DECLARE @MoUnwind           float    
    DECLARE @MoUnwindML         float    
    DECLARE @MoFormPagoUnwind   float    
    DECLARE @MoUnwindCostoMon   int    
    DECLARE @MoUnwindCosto      float    
    DECLARE @MoUnwindCostoML    float    
    DECLARE @RutCliente         numeric    
    DECLARE @MoResultadoVenta   float -- MAP 20100415 Agregar Campo Resultado Venta    
    DECLARE @MoCodEstructura    int    
        
    SET @MoTipoTransaccion = ''    
    SET @MoNumContrato     = 0    
    SET @PrcAnticipo       = 0    
    SET @PrcAnticipoRem    = 0     
    SET @Modalidad         = ''    
    SET @MoFechaUnwind     = @Proceso    
    SET @MoNominalUnwind   = 0    
    SET @MoUnwindMon       = 0    
    SET @MoUnwind          = 0    
    SET @MoUnwindML        = 0    
    SET @MoFormPagoUnwind  = 0    
    SET @MoUnwindCostoMon  = 0    
    SET @MoUnwindCosto     = 0    
    SET @MoUnwindCostoML   = 0    
    SET @MoCodEstructura   = 0    
    
    SELECT @MoTipoTransaccion = MoTipoTransaccion    
         , @MoNumContrato     = MoNumContrato     
         , @PrcAnticipo       = 100  -- MoPrcAnticipo -- Ojo que falta en MoEncContrato    
         , @PrcAnticipoRem    = 100 - @PrcAnticipo      
         , @Modalidad         = 'C' -- MoModAnticipo -- Ojo que falta en MoEncContrato    
         , @MoRut             = MoRutCliente     
         , @MoCodigo          = MoCodigo     
         , @MoOperador        = MoOperador     
         , @MoFechaUnwind     = MoFechaUnwind    
         , @MoNominalUnwind   = MoNominalUnwind    
         , @MoUnwindMon       = MoUnwindMon    
         , @MoUnwind          = MoUnwind    
         , @MoUnwindML  = MoUnwindML    
         , @MoFormPagoUnwind  = MoFormPagoUnwind    
         , @MoUnwindCostoMon  = MoUnwindCostoMon    
         , @MoUnwindCosto     = MoUnwindCosto    
         , @MoUnwindCostoML   = MoUnwindCostoML    
         , @EsCotizacion      = CASE WHEN MoEstado = 'C' THEN 'S' ELSE 'N' END  -- MAP 25 Septiembre    
         , @MoResultadoVenta  = MoResultadoVentasML -- MAP 20100415 Agregar Campo Resultado     
         , @MoCodEstructura   = MoCodEstructura    
      FROM dbo.MoEncContrato    
     WHERE MoNumFolio         = @MoNumFolio    
    
    IF @MoTipoTransaccion = '' BEGIN    
        SET @MsgError =  'Error: .net No graba Movimiento '       
        BEGIN TRAN -- para tratar el error de la misma forma    
        GOTO FinProcesoError        
    END    
    
    SELECT @Proceso = fechaproc     
      FROM dbo.OpcionesGeneral    
    
    -- Si anticipo es Entrega Fisica debe generar registros de caja     
    -- con m1 y m2 indicados a nivel de contrato.    
    -- Por lo tanto, faltan los campos: MoPrcAnticipo, MoAntCodMon1 y ...2.    
    BEGIN TRANSACTION    
    
    IF @@error <> 0 BEGIN    
        SELECT @MsgError = 'Error: No Logro BEGIN TRAN'    
        GOTO FinProcesoError    
    END    
    
    IF @MoTipoTransaccion in ( 'ANTICIPA', 'ANULA')          
    BEGIN     
        -- Verificar que exista la cartera que se quiere modificar.    
        IF NOT EXISTS( SELECT 1 FROM dbo.CaEncContrato WHERE CaNumContrato = @MoNumContrato )     
        BEGIN                
            SET @MsgError =  'Error: no existe cartera para aplicar ' + ltrim( rtrim( @MoTipoTransaccion ) )      
            GOTO FinProcesoError            
        END    
             
        IF EXISTS( SELECT 1    
                     FROM dbo.CaCaja     
                    WHERE CaNumContrato = @MoNumContrato     
                      AND CaCajOrigen <> 'PP' )    
        BEGIN        
            SET @MsgError = 'Error: hay fijacion, mov. no se puede aplicar ' + ltrim( rtrim( @MoTipoTransaccion ) )        
            GOTO FinProcesoError    
        END    
        
        UPDATE dbo.MoEncContrato       
           SET MoFechaContrato       = @Proceso  -- MAP 28 Oct. 2009 Debe ser la fecha de proceso    
             , MoEstado              = CaEstado    
             , MoCarteraFinanciera   = CaCarteraFinanciera    
             , MoLibro               = CaLibro    
             , MoCarNormativa        = CaCarNormativa    
             , MoSubCarNormativa     = CaSubCarNormativa    
             , MoRutCliente          = CaRutCliente    
             , MoCodigo              = CaCodigo    
             , MoTipoContrapartida   = CaTipoContrapartida    
             , MoOperador            = CaOperador    
             , MoCodEstructura       = CaCodEstructura    
             , MoCVEstructura        = CaCVEstructura    
             , MoSistema             = CaSistema    
             , MoMonPrimaTrf         = CaMonPrimaTrf    
             , MoPrimaTrf            = CaPrimaTrf    
             , MoPrimaTrfML          = CaPrimaTrfML    
             , MoMonPrimaCosto       = CaMonPrimaCosto    
             , MoPrimaCosto          = CaPrimaCosto    
             , MoPrimaCostoML        = CaPrimaCostoML    
             , MoCodMonPagPrima      = CaCodMonPagPrima    
             , MoPrimaInicial        = CaPrimaInicial    
             , MofPagoPrima          = CafPagoPrima    
             , MoMonCarryPrima       = CaMonCarryPrima    
             , MoCarryPrima          = CaCarryPrima    
             , MoParM2Spot           = CaParM2Spot    
             , MoParMdaPrima         = CaParMdaPrima    
             , MoFechaPagoPrima      = CaFechaPagoPrima    
             , MoMondelta            = CaMondelta    
             , MoMon_gamma           = CaMon_gamma    
             , MoMon_vega            = CaMon_vega    
             , MoMon_vanna           = CaMon_vanna    
             , MoMon_volga           = CaMon_volga    
             , MoMon_theta           = CaMon_theta    
             , MoMon_rho             = CaMon_rho    
             , MoMon_rhof            = CaMon_rhof    
             , MoMon_charm           = CaMon_charm    
             , MoMon_zomma           = CaMon_zomma    
     , MoMon_speed           = CaMon_speed    
             , MoPrimaBSSpotCont     = CaPrimaBSSpotCont    
             , MoDeltaSpotCont       = CaDeltaSpotCont    
             , MoDeltaForwardCont    = CaDeltaForwardCont    
             , MoGammaSpotCont       = CaGammaSpotCont    
             , MoVegaCont            = CaVegaCont    
             , MoVannaSpotCont       = CaVannaSpotCont    
             , MoVolgaCont           = CaVolgaCont    
             , MoThetaCont  = CaThetaCont    
             , MoRhoDomCont          = CaRhoDomCont    
             , MoRhoForCont          = CaRhoForCont    
             , MoCharmSpotCont       = CaCharmSpotCont    
             , MoZommaSpotCont       = CaZommaSpotCont    
             , MoSpeedSpotCont       = CaSpeedSpotCont    
             , MoFechaUnwind         = @MoFechaUnwind    
             , MoGammaFwdCont        = CaGammaFwdCont    
             , MoVannaFwdCont        = CaVannaFwdCont    
             , MoCharmFwdCont        = CaCharmFwdCont    
             , MoZommaFwdCont        = CaZommaFwdCont    
             , MoSpeedFwdCont        = CaSpeedFwdCont    
             , MoImpreso             = ' '    
    -- , MoFecValorizacion     = CaFecValorizacion    
          -- , MoMon_vr              = CaMon_vr    
          -- , MoVr                  = CaVr    
          -- , MoNominalUnwind       = CaNominalUnwind --MAP no es necesario para anulacion, para anticipo trae el valor de Anticipo    
          -- , MoUnwindMon           = CaUnwindMon     
          -- , MoUnwind              = CaUnwind         
          -- , MoUnwindML            = CaUnwindML    
          -- , MoFormPagoUnwind      = CaFormPagoUnwind    
          -- , MoUnwindTransfMon     = CaUnwindTransfMon    
          -- , MoUnwindTransf        = CaUnwindTransf    
          -- , MoUnwindTransfML      = CaUnwindTransfML    
          -- , MoVr_Costo            = CaVr_Costo    
          -- , MoGlosa               = CaGlosa    
          -- , MoUnwindCostoMon      = CaUnwindCostoMon    
          -- , MoUnwindCosto         = CaUnwindCosto    
          -- , MoUnwindCostoML       = CaUnwindCostoML    
    , MoRelacionaPAE        = CaRelacionaPAE --ASVG_20111103 PRD_10449  
          FROM dbo.CaEncContrato    
         WHERE CaNumContrato         = @MoNumContrato    
           AND MoNumFolio            = @MoNumFolio    
    
        IF @@error <> 0 BEGIN    
           SET @MsgError = 'Error: dbo.Sp_AppMvtCar Update de Mov'     
           GOTO FinProcesoError    
        END    
    
        -- Rescata DetContrato de     
        -- cartera antes de Anular - Anticipar    
        INSERT INTO dbo.MoDetContrato (    
                                        MoNumFolio    
                                      , MoNumEstructura    
                                      , MoVinculacion    
                                      , MoTipoOpc    
                                      , MoSubyacente    
                                      , MoTipoPayOff    
                                      , MoCallPut    
                                      , MoCVOpc    
                                      , MoTipoEmisionPT    
                                      , MoFechaInicioOpc    
                                      , MoFechaFijacion    
                                      , MoFechaVcto    
                                      , MoFormaPagoMon1    
                                      , MoFechaPagMon1    
                                      , MoFormaPagoMon2    
                      , MoFechaPagMon2    
                                      , MoFechaPagoEjer    
                                      , MoCodMon1    
                                      , MoMontoMon1    
                                      , MoCodMon2    
                                      , MoMontoMon2    
                                      , MoModalidad    
                                      , MoMdaCompensacion    
                                      , MoBenchComp    
                              , MoParStrike    
                                      , MoStrike    
                                      , MoPorcStrike    
                                      , MoTipoEjercicio    
                                      , MoCurveMon1    
                                      , MoCurveMon2    
                                      , MoCurveSmile    
                                      , MoWf_mon1    
                                      , MoWf_mon2    
                                      , MoVol    
                                      , MoFwd_teo    
                                      , MoDelta_spot    
                                      , MoDelta_spot_num  
                                      , MoDelta_fwd  
                                      , MoDelta_fwd_num    
                                      , MoGamma_spot    
                                      , MoGamma_spot_num    
                                      , MoGamma_fwd    
                                      , MoGamma_fwd_num    
                                      , MoVega    
                                      , MoVega_num    
                                      , MoVanna_spot    
                                      , MoVanna_spot_num    
                                      , MoVanna_fwd    
                                      , MoVanna_fwd_num    
                         , MoVolga    
                                      , MoVolga_num    
                                      , MoTheta    
                                      , MoTheta_num    
                                      , MoRho    
                                      , MoRho_num    
                                      , MoRhof    
                                      , MoRhof_num    
                                      , MoCharm_spot    
                                      , MoCharm_spot_num    
                                      , MoCharm_fwd    
                                      , MoCharm_fwd_num    
                                      , MoZomma_spot    
                                      , MoZomma_spot_num    
                                      , MoZomma_fwd    
                                      , MoZomma_fwd_num    
                                      , MoSpeed_spot    
                                      , MoSpeed_spot_num    
                                      , MoSpeed_fwd    
                                      , MoSpeed_fwd_num    
                                      , MoVrDet    
                                      , MoSpotDet    
                                      , MoSpotDetCosto    
                                      , MoWf_Mon1_Costo    
                                      , MoWf_Mon2_Costo    
                                      , MoVol_Costo    
                                      , MoFwd_Teo_Costo    
                                      , MoVr_CostoDet    
                                      , MoPrimaBSSpotDet    
                                      , MoIteAsoSis    
                                      , MoIteAsoCon    
                                      , MoFormaPagoComp    
                                      , MoVrDetML    
                                      , MoPrimaInicialDet    
                                      , MoWf_ML    
                                      , MoPrimaInicialDetML    
                                      )    
                                 SELECT @MoNumFolio        
                                      , CaNumEstructura        
                                      , CaVinculacion        
                                      , CaTipoOpc        
                                      , CaSubyacente        
                                      , CaTipoPayOff        
                                      , CaCallPut        
                                      , CaCVOpc        
                                      , CaTipoEmisionPT        
                                      , CaFechaInicioOpc    
                                      , CaFechaFijacion    
                                      , CaFechaVcto    
                                      , CaFormaPagoMon1    
                                      , CaFechaPagMon1    
                                      , CaFormaPagoMon2    
                                      , CaFechaPagMon2    
                                      , CaFechaPagoEjer    
                                      , CaCodMon1    
                                      , CaMontoMon1    
                                      , CaCodMon2    
                                      , CaMontoMon2    
                                      , CaModalidad    
                                      , CaMdaCompensacion    
                                      , CaBenchComp    
      , CaParStrike    
                                      , CaStrike    
                                      , CaPorcStrike    
                                      , CaTipoEjercicio    
            , CaCurveMon1    
                                      , CaCurveMon2    
                                      , CaCurveSmile    
                                      , CaWf_mon1    
                                      , CaWf_mon2    
                                      , CaVol    
                                      , CaFwd_teo    
                                      , CaDelta_spot    
                                      , CaDelta_spot_num    
                                     , CaDelta_fwd    
                                      , CaDelta_fwd_num    
                                      , CaGamma_spot    
                                      , CaGamma_spot_num    
                                      , CaGamma_fwd    
                                      , CaGamma_fwd_num    
                                      , CaVega    
                                      , CaVega_num    
                                      , CaVanna_spot    
                                      , CaVanna_spot_num    
                                      , CaVanna_fwd    
                                      , CaVanna_fwd_num    
                                      , CaVolga    
                                      , CaVolga_num    
                                      , CaTheta    
                                      , CaTheta_num    
                                      , CaRho    
                                      , CaRho_num    
                                      , CaRhof    
                                      , CaRhof_num    
                                      , CaCharm_spot    
                                      , CaCharm_spot_num    
                                      , CaCharm_fwd    
                                      , CaCharm_fwd_num    
                                      , CaZomma_spot    
                                      , CaZomma_spot_num    
                                      , CaZomma_fwd    
                                      , CaZomma_fwd_num    
                                      , CaSpeed_spot    
                                      , CaSpeed_spot_num    
                                      , CaSpeed_fwd    
                                      , CaSpeed_fwd_num    
                                      , CaVrDet    
                                      , CaSpotDet    
                                      , CaSpotDetCosto    
                                      , CaWf_Mon1_Costo    
                                      , CaWf_Mon2_Costo    
                                      , CaVol_Costo    
                                      , CaFwd_Teo_Costo    
                                      , CaVr_CostoDet    
                                      , CaPrimaBSSpotDet    
                                      , CaIteAsoSis    
                                      , CaIteAsoCon    
                                      , CaFormaPagoComp    
                                      , CaVrDetML    
                       , CaPrimaInicialDet    
                                      , CaWf_ML     
                                      , CaPrimaInicialDetML    
                                   FROM dbo.CaDetContrato    
                                  WHERE CaNumContrato = @MoNumContrato    
    
        IF @@error <> 0 BEGIN    
          SET @MsgError = 'Error: dbo.Sp_AppMvtCar Copia CaDet en Mov'     
          GOTO FinProcesoError    
        END    
    
        INSERT INTO dbo.MoFixing (    
                                   MoNumFolio    
                                 , MoNumEstructura    
                                 , MoFixFecha    
                                 , MoFixNumero    
                                 , MoPesoFij    
                                 , MoVolFij    
                                 , MoFijacion    
                                 , MoFixBenchComp    
                                 , MoFixParBench    
            , MoFixEstado    
                                 )    
                          SELECT @MoNumFolio    
                               , CaNumEstructura    
        , CaFixFecha    
    , CaFixNumero    
                               , CaPesoFij    
                               , CaVolFij    
                               , CaFijacion    
                               , CaFixBenchComp    
                               , CaFixParBench    
                               , CaFixEstado    
                            FROM dbo.CaFixing    
                           WHERE CaNumContrato = @MoNumContrato    
    
        IF @MoTipoTransaccion in ( 'ANULA' ) BEGIN    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Copia CaFixing en Mov'     
                GOTO FinProcesoError    
            END    
    
            DELETE dbo.CaFixing      WHERE CaNumContrato = @MoNumContrato    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.|x Delete CaFixing'     
                GOTO FinProcesoError    
            END    
    
            DELETE dbo.CaDetContrato WHERE CaNumContrato = @MoNumContrato     
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaDetContrato'     
                GOTO FinProcesoError    
            END    
    
            DELETE dbo.CaEncContrato WHERE CaNumContrato = @MoNumContrato    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaEncContrato'     
                GOTO FinProcesoError    
            END    
    
        END    
    
        -- Anticipa y Anula elimina Caja si hubiere      
        DELETE dbo.CaCaja        WHERE CaNumContrato = @MoNumContrato    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaCaja'     
            GOTO FinProcesoError    
        END    
    
        IF @MoTipoTransaccion in ( 'ANTICIPA' ) BEGIN    
            UPDATE dbo.CaEncContrato    
               SET CaTipoTransaccion = 'ANTICIPA'    
                 , CaFechaUnwind     = @MoFechaUnwind    
                 , CaNominalUnwind   = @MoNominalUnwind    
                 , CaUnwindMon       = @MoUnwindMon    
                 , CaUnwind          = @MoUnwind    
                 , CaUnwindML        = @MoUnwindML    
                 , CaFormPagoUnwind  = @MoFormPagoUnwind    
                 , CaUnwindCostoMon  = @MoUnwindCostoMon    
                 , CaUnwindCosto     = @MoUnwindCosto    
                 , CaUnwindCostoML   = @MoUnwindCostoML    
                 , CaEstado          = ''            -- Vigente select * from caEncContrato    
                 , CaNumFolio        = @MoNumFolio    
                 , CaResultadoVentasML = @MoResultadoVenta  -- MAP 20100415 Agregar Campo Resultado     
             WHERE CaNumContrato     = @MoNumContrato    
    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar update CaEncContrato ANTICIPA'     
    GOTO FinProcesoError    
            END    
    
            -- Para descarte de procesos SIGIR    
            UPDATE dbo.CaDetContrato       
               SET CaFechaPagoEjer = @Proceso    
             WHERE CaNumContrato   = @MoNumContrato    
    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar update CaDetContrato ANTICIPA'     
                GOTO FinProcesoError    
            END    
    
            -- Ajuste de calcupa para distribucion de     
            -- Pago de Anticipo    
            -- Algoritmo para corregir casos singurales    
            -- Cuando existe mtm de compra y de venta y podrían ser iguales    
            select    E.CaNumContrato, CaCodEstructura, E.CaCVEstructura    
               ,   CaMtmPos = sum( case when CaVrdet > 0 then CaVrDet else 0 end )    
               ,   CaMtmNeg = sum( case when CaVrdet < 0 then CaVrDet else 0 end )    
               ,   CaUnwind, CaUnwindML, CaVr     -- 17/02/2010    
               ,   RatioVtaCmp = 0.0 * 100000000.00000000    
               ,   PesoVta = 0.0     * 100000000.00000000    
               ,  PesoCmp = 0.0     * 100000000.00000000    
               ,   UnwindComprado = 0.0     * 100000000.00000000    
               ,   UnwindVendido  = 0.0     * 100000000.00000000    
       ,   UnwindCompradoML = 0.0     * 100000000.00000000    
               ,   UnwindVendidoML  = 0.0     * 100000000.00000000    
               into #MTMPosNeg    
               from cadetcontrato D, CaEncContrato E    
            where     D.CaNumContrato = E.CaNumContrato    
                  and D.CaNumCOntrato = @MoNumContrato    
            Group by E.CaNumContrato,  CaCodEstructura, CaUnwind, CaUnwindML, CaVr, E.CaCVEstructura    
    
            IF @@ERROR <> 0     
             Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar gernerando #MTMPosNeg'     
               GOTO FinProcesoError    
             end    
    
            update  #MTMPosNeg              -- 17/02/2010    
            set    
             PesoCmp = case when CaVr < 0 then -CaMtmPos / CaVr       -- Caso 1.1    
                            when CaVr = 0 then  1.0                   -- Caso 2.1    
                            when CaVr > 0 then  CaMTMPos / CaVr end   -- Caso 3.1    
           , PesoVta = case when CaVr < 0 then -CaMtmNeg / CaVr       -- Caso 1.2    
                            when CaVr = 0 then -2.0                   -- Caso 2.2    
                            when CaVr > 0 then  CaMTMNeg / CaVr end   -- Caso 3.2    
    
    
            /*    
    
            delete #MTMPosNeg where CaMtmPos = 0 or CaMtmNeg = 0      
            IF @@ERROR <> 0     
            Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar update #MTMPosNeg'     
               GOTO FinProcesoError    
            end    
            Por mientras */    
    
            update  #MTMPosNeg    
             set    
   /*    RatioVtaCmp   = round( CaMtmNeg / CaMtmPos , 8 ) * 1.00000000 -- Formula se aplicará solo en caso Mixto    
     
                  , */    UnwindComprado = case when CaVr <= 0 then                 -- 17/02/2010                       
                                           case when CaUnwind < 0     
                                                 then PesoCmp * -CaUnwind        -- CASO 1.1, ver doc.    
                                                 else PesoVta * -CaUnwind        -- CASO 2.1, ver doc.    
    
                                                 end     
                                       else    
                                            case when CaUnwind <= 0           
                                                 then PesoVta * ( CaUnwind )  -- CASO 3.1, ver doc.    
                                                 else PesoCmp * ( CaUnwind )  -- CASO 4.1, ver doc.    
                                                 end    
                                       end     
                   ,   UnwindVendido = case when CaVr <=0 then     
                                            case when CaUnwind < 0     
                                                 then PesoVta * - CaUnwind        -- CASO 1.2, ver doc.    
                                                 else PesoCmp * - CaUnwind         -- CASO 2.2, ver doc.    
                                                 end     
                                       else    
                                            case when CaUnwind <= 0           
                                                 then PesoCmp * ( CaUnwind )      -- CASO 3.2, ver doc.    
                                                 else PesoVta * ( CaUnwind )  -- CASO 4.2, ver doc.    
                                                 end    
                                       end    
    
                  ,    UnwindCompradoML = case when CaVr <= 0 then     
                                            case when CaUnwind < 0     
                                                 then PesoCmp * -CaUnwindML        -- CASO 1.1, ver doc.    
                                                 else PesoVta * -CaUnwindML        -- CASO 2.1, ver doc.    
                                                 end     
                                       else    
                                     case when CaUnwind <= 0           
                                                 then PesoVta * ( CaUnwindML )  -- CASO 3.1, ver doc.    
                                                else PesoCmp * ( CaUnwindML )  -- CASO 4.1, ver doc.    
                                                 end    
                                       end     
                   ,   UnwindVendidoML = case when CaVr <=0 then     
                                            case when CaUnwind < 0     
                                                 then PesoVta * - CaUnwindML    -- CASO 1.2, ver doc.    
                                                 else PesoCmp * - CaUnwindML    -- CASO 2.2, ver doc.    
                                                 end     
                                       else    
                                            case when CaUnwind <= 0           
                                                 then PesoCmp * ( CaUnwindML )  -- CASO 3.2, ver doc.    
                                                 else PesoVta * ( CaUnwindML )  -- CASO 4.2, ver doc.    
    
    
                                                 end    
    
                                       end    
    
    
            IF @@ERROR <> 0     
             Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar update #MTMPosNeg'     
               GOTO FinProcesoError    
             end    
    
    
    
/*    
             update  #MTMPosNeg    
              set   PesoVta = case when RatioVtaCmp = -1.0     
                    then -2    
                    else    
                           case when CaUnwind < 0 -- MAP      
                              then -1.0 + 1.0 / ( 1.0 + RatioVtaCmp ) * 1.0    
                              else 1.0 - 1.0 / ( 1.0 + RatioVtaCmp ) * 1.0    
    
    
    
    
    
    
                           end    
                  end * ( Case when CaUnwind > 0 then 1.0 else -1.0 end )   -- sp_Helptext Sp_SumaValVertical    
             where CaMtmPos <> 0 and CaMtmNeg <> 0    
             IF @@ERROR <> 0     
             Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar update #MTMPosNeg'     
               GOTO FinProcesoError    
             end    
    
             update #MTMPosNeg    
             set PesoCmp = case when CaUnwind > 0 then - 1.0 - PesoVta else  1.0 - PesoVta  end    
             IF @@ERROR <> 0     
             Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar update #MTMPosNeg'     
               GOTO FinProcesoError    
             end    
    
             update #MTMPosNeg    
             set    
                UnwindComprada   = PesoCmp * abs( CaUnwind )    
              , UnwindVendida = PesoVta * abs( CaUnwind )    
              , UnwindCompradaML = PesoCmp * abs( CaUnwindML )    
              , UnwindVendidaML  = PesoVta * abs( CaUnwindML )    
    
*/  --  17/02/2010 Se comenta    
        IF @@ERROR <> 0     
        Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar update #MTMPosNeg'     
               GOTO FinProcesoError    
        end    
    
        select  CaUnWind, CaUnwindML, CaCodEstructura, CaCVOpc, CaVrDet    
           , A.CaNumContrato    
           , CaNumEstructura    
           , CaUnwindProrrateado   = case when CaVrDet > 0     
                                          then UnwindComprado * CaVrDet / case when CaMtmPos = 0 then 1 else CaMtmPos end   -- 17/02/2010 Se corrige por caída división por Cero.    
                                          else UnwindVendido  * CaVrDet / case when CaMtmNeg = 0 then 1 else CaMtmNeg end   -- 17/02/2010 Se corrige por caída división por Cero.    
                                     end    
           , CaUnwindProrrateadoML   = case when CaVrDet > 0     
                                          then UnwindCompradoML * CaVrDet / case when CaMtmPos = 0 then 1 else CaMtmPos end  -- 17/02/2010 Se corrige por caída división por Cero.    
                                          else UnwindVendidoML  * CaVrDet / case when CaMtmNeg = 0 then 1 else CaMtmNeg end  -- 17/02/2010 Se corrige por caída división por Cero.    
                        end    
           , CaMtmPos    
           , CaMtmNeg    
           , CaCVEstructura    
        into  #MTMUnwindDistribuida    
              from #MTMPosNeg A, CaDetContrato B    
        where B.CaNumContrato = A.CaNumContrato    
    
         IF @@ERROR <> 0     
            Begin    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert #MTMUnwindDistribuida'     
               GOTO FinProcesoError    
         end    
        
    
         -- Distribuir pago de anticipo    
         -- Pendiente: utilizar en la generacion de Caja    
    
    
         INSERT INTO dbo.CaCaja (    
                                     CaNumContrato    
                                   , CaNumEstructura    
                                   , CaCajFolio    
                                   , CaCajFechaGen    
                                   , CaCajFecPago    
                                   , CaCajFDeMon1    
                                   , CaCajMtoMon1    
                                   , CaCajFDeMon2    
                                   , CaCajMtoMon2    
                                   , CaCajEstado    
                                   , CaMTMImplicito    
            , CaCajFormaPagoMon1    
                                   , CaCajFormaPagoMon2    
                                   , CaCajMdaM1    
                                   , CaCajMdaM2    
                                   , CaCajOrigen    
                                   , CaCajMotorPago    
                                   , CaCajModalidad    
                                   , CaCajFechaPagMon1    
                                   , CaCajFechaPagMon2    
                                   )    
                              SELECT  CaNumContrato        = @MoNumContrato     
                                    , CaNumEstructura      = Det.CaNumEstructura    
                                    --, CaCajFolio = 2                              30/11/2009    
                                    , CaCajFolio           = ISNULL( ( SELECT MAX( CaCajFolio ) FROM dbo.CaVenCaja WHERE CaNumContrato = @MoNumContrato ), 1 ) + 1   -- 30/11/2009     
    
    
                                    , CaCajFechaGen       = @Proceso       
                                    , CaCajFecPago        = @Proceso     
                                    , CaCajFDeMon1        = 1                                        
                                    , CaCajMtoMon1    =   case when Det.CaVinculacion  = 'Individual' then   -- 17/02/2010 Se corrige, debido aque condición en algunos casos  no funcionaba.    
          UnWindDet.CaUnWind                                      
                                                      else    
                                                                 CaUnwindProrrateado    
                                                      end    
                                    , CaCajFDeMon2        = 1                                            
                                    , CaCajMtoMon2        = 0                                         
                                    , CaCajEstado         = 'E'  -- Por definición el flujo que probiene de Pago prima debe ser ejercido    
                                    , CaMTMImplicito      = 0                                          
                                    , CaCajFormaPagoMon1  = MoFormPagoUnwind -- deberia ser MoFormPagoUnwind    
                                    , CaCajFormaPagoMon2  = 0    
                                    , CaCajMdaM1          = MoUnwindMon                                        
                                    , CaCajMdaM2          = 0    
                                    , CaCajOrigen         = 'PA' -- Pago de Unwind    
                                    , CaCajMotorPago      = 'P'  -- Pendiente en generar Motor de Pagos BAC    
                                    , CaCajModalidad      = 'C'  -- Unwind por definición se considera como compensación    
                                    , CaCajFechaPagMon1   = @Proceso  -- Por mientras, se debe agregar la valuta de la forma de pago    
                                    , CaCajFechaPagMon2   = @Proceso  -- Por mientras, se debe agregar la valuta de la forma de pago    
                                FROM MoEncContrato Mov    
     , CaEncContrato Enc    
     , CaDetContrato Det     
                                        , #MTMUnwindDistribuida UnwindDet    
    WHERE MoNumFolio = @MoNumFolio    
     AND  Enc.CaNumContrato = Mov.MoNumContrato    
     AND  Det.CaNumContrato = Enc.CaNumContrato     
                                        AND  UnwindDet.CaNumContrato   = Enc.CaNumContrato    
                                        AND  UnwindDet.CaNumEstructura = Det.CaNumEstructura    
    
            IF @@error <> 0 BEGIN    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaCaja de Anticipo'     
               GOTO FinProcesoError    
            END    
    
                
            EXECUTE SP_AJUSTAR_CaCAJA_ANULACION @MoNumContrato 
    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaCaja lin 214'     
                GOTO FinProcesoError    
            END    
        END    
    END -- ANULA - ANTICPA    
    
    IF @MoTipoTransaccion = 'MODIFICA'    
    BEGIN    
     UPDATE dbo.MoEncContrato    
        SET MoPrimaCosto      = CaPrimaCosto    
             , MoPrimaCostoML    = CaPrimaCostoML    
             , MoPrimaInicial    = CaPrimaInicial    
             , MoFechaPagoPrima  = CaFechaPagoPrima    
             , MoFechaContrato   = CaFechaContrato    
             , MoPrimaInicialML  = CaPrimaInicialML    
             , MoFechaCreacionRegistro = @Proceso +   getdate() - convert( varchar(8) , getdate(), 112 )    
       FROM dbo.CaEncContrato    
      WHERE CaNumContrato     = MoNumContrato         
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Update MoEncContrato'     
            GOTO FinProcesoError    
        END    
         
        DELETE dbo.CaCaja         WHERE CaNumContrato = @MoNumContrato    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaCaja'     
            GOTO FinProcesoError    
        END    
    
        DELETE dbo.CaFixing       WHERE CaNumContrato = @MoNumContrato    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaFixing'     
            GOTO FinProcesoError    
 END    
    
        DELETE dbo.CaDetContrato  WHERE CaNumContrato = @MoNumContrato    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaDetContrato'     
            GOTO FinProcesoError    
        END    
    
        DELETE dbo.CaEncContrato  WHERE CaNumContrato = @MoNumContrato    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Delete CaEncContrato'     
            GOTO FinProcesoError    
        END    
    
    END    
    
    /* Ejerce Contrato */    
    IF @MoTipoTransaccion = 'EJERCE'    
    BEGIN    
        IF NOT EXISTS( SELECT 1 FROM CaEncContrato WHERE CaNumContrato = @MoNumContrato )    
        BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar movimiento no puede ser aplicado en Cartera'    
            GOTO FinProcesoError    
        END    
            
        --    
        -- ASVG_20110307 Solamente código 8. IF (@MoCodEstructura IN ( 8, 9))    
  IF (@MoCodEstructura = 8)    
        BEGIN    
            DECLARE @Nocional            FLOAT    
            DECLARE @NocionalEjercicio   FLOAT    
            DECLARE @MoModalidad         VARCHAR(1)    
    
    
            SELECT @Nocional          = CaMontoMon1    
              FROM dbo.CaDetContrato    
             WHERE CaNumContrato      = @MoNumContrato    
    
            SELECT @NocionalEjercicio = MoMontoMon1    
                 , @MoModalidad       = MoModalidad    
              FROM dbo.MoDetContrato    
             WHERE MoNumFolio         = @MoNumFolio    
    
            IF (@Nocional = @NocionalEjercicio)    
            BEGIN    
                UPDATE dbo.CaDetContrato    
                   SET CaFechaPagMon1  = @Proceso    
                     , CaFechaPagMon2  = @Proceso    
                     , CaFechaFijacion = @Proceso    
                     , CaFechaVcto     = @Proceso    
                     , CaFechaPagoEjer = @Proceso    
                 WHERE CaNumContrato      = @MoNumContrato    
    
            END ELSE    
            BEGIN    
                UPDATE dbo.CaDetContrato    
                   SET CaMontoMon1        = CaMontoMon1 - @NocionalEjercicio    
                     , CaMontoMon2        = (CaMontoMon1 - @NocionalEjercicio) * CaStrike    
                 WHERE CaNumContrato      = @MoNumContrato    
    
            END    
    
IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Actualizar Ejercicio'     
                GOTO FinProcesoError    
            END    
    
            UPDATE dbo.CaEncContrato    
               SET CaEstado           = ''    
             WHERE CaNumContrato      = @MoNumContrato    
    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Actualizar Estado Ejercicio'     
                GOTO FinProcesoError    
            END    
    
            -- Genera Caja Por el Ejercicio    
            INSERT INTO dbo.CaCaja (    
                                     CaNumContrato    
                                   , CaNumEstructura    
                                   , CaCajFolio    
                                   , CaCajFechaGen    
                                   , CaCajFecPago    
                                   , CaCajFDeMon1    
                                   , CaCajMtoMon1    
                                   , CaCajFDeMon2    
                                   , CaCajMtoMon2    
                                   , CaCajEstado    
                                   , CaMTMImplicito    
                                   , CaCajFormaPagoMon1    
                                   , CaCajFormaPagoMon2    
                                   , CaCajMdaM1    
                                   , CaCajMdaM2    
                                   , CaCajOrigen    
                                   , CaCajMotorPago    
                                   , CaCajModalidad    
                                   , CaCajFechaPagMon1    
     , CaCajFechaPagMon2    
                                   )    
                            SELECT CaNumContrato       = @MoNumContrato     
                                 , CaNumEstructura     = Det.MoNumEstructura    
                                 , CaCajFolio          = ISNULL( ( SELECT MAX( CaCajFolio ) FROM dbo.CaVenCaja WHERE CaNumContrato = @MoNumContrato ), 1 ) + 1   -- 30/11/2009     
                                 , CaCajFechaGen       = @Proceso    
                                 , CaCajFecPago        = @Proceso    
                                 , CaCajFDeMon1        = 1    
                                 , CaCajMtoMon1     = CASE WHEN Det.MoModalidad = 'E' THEN Det.MoMontoMon1     ELSE Det.MoVrDet         END    
                                 , CaCajFDeMon2        = 1    
                                 , CaCajMtoMon2        = CASE WHEN Det.MoModalidad = 'E' THEN Det.MoMontoMon2     ELSE 0                   END    
                                 , CaCajEstado         = CASE WHEN Det.MoModalidad = 'E' THEN 'P'                 ELSE 'E'                 END -- Por definición el flujo que probiene de Pago prima debe ser ejercido    
                                 , CaMTMImplicito      = 0                                          
                                 , CaCajFormaPagoMon1  = CASE WHEN Det.MoModalidad = 'E' THEN Det.MoFormaPagoMon1 ELSE Det.MoFormaPagoComp END    
                                 , CaCajFormaPagoMon2  = CASE WHEN Det.MoModalidad = 'E' THEN Det.MoFormaPagoMon2 ELSE 0                   END    
                                 , CaCajMdaM1          = CASE WHEN Det.MoModalidad = 'E' THEN Det.MoCodMon1       ELSE Det.MoCodMon2       END    
                                 , CaCajMdaM2          = CASE WHEN Det.MoModalidad = 'E' THEN Det.MoCodMon2       ELSE 0                   END    
  , CaCajOrigen         = 'PV'                 -- Ejercicio    
                                 , CaCajMotorPago      = 'P'                  -- Pendiente en generar Motor de Pagos BAC    
                                 , CaCajModalidad      = Det.MoModalidad      -- Unwind por definición se considera como compensación    
                                 , CaCajFechaPagMon1   = @Proceso             -- Por mientras, se debe agregar la valuta de la forma de pago    
                                 , CaCajFechaPagMon2   = @Proceso             -- Por mientras, se debe agregar la valuta de la forma de pago    
                            FROM dbo.MoEncContrato Mov    
                               , dbo.MoDetContrato Det    
                           WHERE Det.MoNumFolio        = @MoNumFolio    
                             AND Mov.MoNumFolio        = Det.MoNumFolio    
    
            IF @@error <> 0 BEGIN    
               SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaCaja de Ejercicio'     
               GOTO FinProcesoError    
            END    
    
    
        END    
    
    END    
    
    IF @MoTipoTransaccion in ( 'CREACION', 'MODIFICA' ) BEGIN    
        IF EXISTS( SELECT 1 FROM CaEncContrato WHERE CaNumContrato = @MoNumContrato )    
        BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar movimiento aplicado en Cartera'    
            GOTO FinProcesoError    
        END    
    END    
    
    IF @MoTipoTransaccion in ( 'CREACION', 'MODIFICA' )    
    BEGIN    
        -- Asegurar que tengan la misma estructura    
        -- si no este código debe ser campo a campo    
        INSERT INTO CaEncContrato (    
                                    CaNumFolio    
                                  , CaTipoTransaccion    
                                  , CaNumContrato    
                                  , CaFechaContrato    
                                  , CaEstado    
                                  , CaCarteraFinanciera    
                                  , CaLibro    
                                  , CaCarNormativa    
                                  , CaSubCarNormativa    
                   , CaRutCliente    
                                  , CaCodigo    
                                  , CaTipoContrapartida    
                                  , CaOperador    
 , CaCodEstructura    
                                  , CaCVEstructura    
                                  , CaSistema    
                                  , CaMonPrimaTrf    
                                  , CaPrimaTrf    
                                  , CaPrimaTrfML    
                                  , CaMonPrimaCosto    
                                  , CaPrimaCosto    
                                  , CaPrimaCostoML    
                                  , CaCodMonPagPrima    
       , CaPrimaInicial    
                                  , CafPagoPrima    
                                  , CaMonCarryPrima    
                                  , CaCarryPrima    
                                  , CaParM2Spot    
                                  , CaParMdaPrima    
                                  , CaFechaPagoPrima    
                   , CaFecValorizacion    
                                  , CaMon_vr    
                                  , CaVr    
                                  , CaMondelta    
                                  , CaMon_gamma    
                                  , CaMon_vega    
                                  , CaMon_vanna    
                                  , CaMon_volga    
                                  , CaMon_theta    
                                  , CaMon_rho    
                                  , CaMon_rhof    
                                  , CaMon_charm    
                                  , CaMon_zomma    
                                  , CaMon_speed    
                                  , CaPrimaBSSpotCont    
                                  , CaDeltaSpotCont    
                                  , CaDeltaForwardCont    
                                  , CaGammaSpotCont    
                                  , CaVegaCont    
                , CaVannaSpotCont    
                                  , CaVolgaCont    
    , CaThetaCont    
                                  , CaRhoDomCont    
                                  , CaRhoForCont    
                                  , CaCharmSpotCont    
                                  , CaZommaSpotCont    
                                  , CaSpeedSpotCont    
                                  , CaFechaUnwind    
                                  , CaNominalUnwind    
                                  , CaUnwindMon    
                                  , CaUnwind    
                                  , CaUnwindML    
                                  , CaFormPagoUnwind    
                                  , CaUnwindTransfMon    
                                  , CaUnwindTransf    
                                  , CaUnwindTransfML    
                                  , CaVr_Costo    
                                  , CaGlosa    
                                  , CaUnwindCostoMon    
                                  , CaUnwindCosto    
                                  , CaUnwindCostoML    
                                  , CaGammaFwdCont    
                                  , CaVannaFwdCont    
                                  , CaCharmFwdCont    
                                  , CaZommaFwdCont    
                                  , CaSpeedFwdCont    
                                  , CaImpreso    
                                  , CaPrimaInicialML    
                                  , CaFechaCreacionRegistro    
                                  , CaResultadoVentasML -- MAP 20100415 Agregar Campo Resultado     
          , CaRelacionaPAE  --ASVG_20111103 PRD_10449  
                                  )    
                             SELECT MoNumFolio    
                                  , MoTipoTransaccion    
                                  , MoNumContrato    
                                  , MoFechaContrato    
                                , MoEstado    
                                  , MoCarteraFinanciera    
                                  , MoLibro    
                                  , MoCarNormativa    
                                  , MoSubCarNormativa    
                                  , MoRutCliente    
      , MoCodigo    
                                  , MoTipoContrapartida    
                                  , MoOperador    
                                  , MoCodEstructura    
                                  , MoCVEstructura    
                                  , MoSistema    
                                  , MoMonPrimaTrf    
                                  , MoPrimaTrf    
                                  , MoPrimaTrfML    
                                  , MoMonPrimaCosto    
                                  , MoPrimaCosto    
                                  , MoPrimaCostoML    
                                  , MoCodMonPagPrima    
                                  , MoPrimaInicial    
                                  , MofPagoPrima    
                                  , MoMonCarryPrima    
                                  , MoCarryPrima    
                                  , MoParM2Spot    
                                  , MoParMdaPrima    
                     , MoFechaPagoPrima    
                                  , MoFecValorizacion    
                                  , MoMon_vr    
                                  , MoVr    
                                  , MoMondelta    
                                  , MoMon_gamma    
                                  , MoMon_vega    
                                  , MoMon_vanna    
                                  , MoMon_volga    
                                  , MoMon_theta    
                                  , MoMon_rho    
                                  , MoMon_rhof    
                                  , MoMon_charm    
                                  , MoMon_zomma    
                                  , MoMon_speed    
                                  , MoPrimaBSSpotCont    
                                  , MoDeltaSpotCont    
                                  , MoDeltaForwardCont    
                            , MoGammaSpotCont    
                                  , MoVegaCont    
                                  , MoVannaSpotCont    
                                  , MoVolgaCont    
                                  , MoThetaCont    
                                  , MoRhoDomCont    
                                  , MoRhoForCont    
                                  , MoCharmSpotCont    
                                  , MoZommaSpotCont    
                                  , MoSpeedSpotCont    
                                  , MoFechaUnwind    
                                  , MoNominalUnwind    
                                  , MoUnwindMon    
                                  , MoUnwind    
                                  , MoUnwindML    
                                  , MoFormPagoUnwind    
                                  , MoUnwindTransfMon    
                                  , MoUnwindTransf    
                                  , MoUnwindTransfML    
                                  , MoVr_Costo    
                                  , MoGlosa    
                                  , MoUnwindCostoMon    
                                  , MoUnwindCosto    
                                  , MoUnwindCostoML    
                                  , MoGammaFwdCont    
                                  , MoVannaFwdCont    
                                  , MoCharmFwdCont    
                                  , MoZommaFwdCont    
                                  , MoSpeedFwdCont    
                                  , MoImpreso    
                                  , MoPrimaInicialML    
                                  , MoFechaCreacionRegistro    
                                  , MoResultadoVentasML -- MAP 20100415 Agregar Campo Resultado     
          , MoRelacionaPAE  --ASVG_20111103 PRD_10449  
                               FROM dbo.MoEncContrato    
                              WHERE MoNumFolio = @MoNumFolio    
    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaEncContrato'     
            GOTO FinProcesoError    
        END    
    
        -- MAP 22 Octubre 2009    
        -- Si se modifica operacion de otro    
        -- dia no se debe generar Caja    
        IF @MoTipoTransaccion <> 'MODIFICA'  begin      
            INSERT INTO dbo.CaCaja (    
              CaNumContrato    
                                   , CaNumEstructura    
                                   , CaCajFolio    
                                   , CaCajFechaGen    
                                   , CaCajFecPago    
                                   , CaCajFDeMon1    
                                   , CaCajMtoMon1    
                                   , CaCajFDeMon2    
                                   , CaCajMtoMon2    
                                   , CaCajEstado    
                                   , CaMTMImplicito    
                                   , CaCajFormaPagoMon1    
                                   , CaCajFormaPagoMon2    
                                   , CaCajMdaM1    
                                   , CaCajMdaM2    
                                   , CaCajOrigen    
                                   , CaCajMotorPago    
                                   , CaCajModalidad    
                                   , CaCajFechaPagMon1    
                                   , CaCajFechaPagMon2    
                                   )    
                              SELECT CaNumContrato      = @MoNumContrato     
                                   , CaNumEstructura    = 1 --Det.MoNumEstructura    
                                   , CaCajFolio         = ISNULL( ( SELECT MAX( CaCajFolio )     
                                                                      FROM dbo.CaCaja    
                                                                     WHERE CaNumContrato = @MoNumContrato ), 1 ) + 1    
                                   , CaCajFechaGen      = Enc.MoFechaPagoPrima      
                                   , CaCajFecPago       = Enc.MoFechaPagoPrima     
                                   , CaCajFDeMon1       = 1    
, CaCajMtoMon1       = MoPrimaInicial    
                                   , CaCajFDeMon2       = 1                                            
                                   , CaCajMtoMon2       = 0                                         
                                   , CaCajEstado        = 'E'  -- Por definición el flujo que probiene de Pago prima debe ser ejercido    
                                   , CaMTMImplicito     = 0                                          
                                   , CaCajFormaPagoMon1 = MofPagoPrima    
                                   , CaCajFormaPagoMon2 = 0    
                                   , CaCajMdaM1         = MoCodMonPagPrima     
                                   , CaCajMdaM2         = 0    
                                   , CaCajOrigen        = 'PP' -- Pago de Prima    
                                   , CaCajMotorPago     = 'P'  -- Pendiente en generar Motor de Pagos BAC    
                                   , CaCajModalidad     = 'C'  -- Prima por definición se considera como compensación    
                                   , CaCajFechaPagMon1  = @Proceso    
                                   , CaCajFechaPagMon2  = @Proceso    
                                FROM dbo.MoEncContrato Enc    
                                    JOIN dbo.OpcionEstructura As Estruc ON Estruc.OpcEstCod = Enc.moCodEstructura
                               WHERE MoNumFolio         = @MoNumFolio    
								 --AND MoCodEstructura <> '8'  -- ASVG 20110225 Fwd. Americano no tiene prima
                                 AND Estruc.OpcPagaPrima = 'S' -- PROD-13028
    
            IF @@error <> 0 BEGIN    
                SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaCaja lin 214'     
                GOTO FinProcesoError    
            END    
               
        END    
    
        -- De esta manera se tiene que hacer los insert en el resto de las tablas    
        -- Se programa version para cumplir la funcionalidad    
        INSERT INTO dbo.CaDetContrato (    
                                        CaNumContrato    
                                      , CaNumEstructura    
                                      , CaVinculacion    
                                      , CaTipoOpc    
                                      , CaSubyacente    
                                      , CaTipoPayOff    
                                      , CaCallPut    
                                      , CaCVOpc    
                    , CaTipoEmisionPT    
                                      , CaFechaInicioOpc    
                                      , CaFechaFijacion    
                                      , CaFechaVcto    
                                      , CaFormaPagoMon1    
                                      , CaFechaPagMon1    
                                      , CaFormaPagoMon2    
                                      , CaFechaPagMon2    
                                      , CaFechaPagoEjer    
                                      , CaCodMon1    
                                      , CaMontoMon1    
                                      , CaCodMon2    
                                      , CaMontoMon2    
                   , CaModalidad    
                                      , CaMdaCompensacion    
      , CaBenchComp    
                                      , CaParStrike    
                                      , CaStrike    
                                      , CaPorcStrike    
                      , CaTipoEjercicio    
                                      , CaCurveMon1    
                                      , CaCurveMon2    
                                      , CaCurveSmile    
                                      , CaWf_mon1    
                                      , CaWf_mon2    
                                      , CaVol    
                                      , CaFwd_teo    
                                      , CaDelta_spot    
                                      , CaDelta_spot_num    
                                      , CaDelta_fwd    
                                      , CaDelta_fwd_num    
                                      , CaGamma_spot    
                                      , CaGamma_spot_num    
                                      , CaGamma_fwd    
                                      , CaGamma_fwd_num    
                                      , CaVega    
                                      , CaVega_num    
                                      , CaVanna_spot    
                                      , CaVanna_spot_num    
                                      , CaVanna_fwd    
                                      , CaVanna_fwd_num    
                                      , CaVolga    
                                      , CaVolga_num    
                                      , CaTheta    
                                      , CaTheta_num    
                                      , CaRho    
                                      , CaRho_num    
                                      , CaRhof    
                                      , CaRhof_num    
                                      , CaCharm_spot    
                                      , CaCharm_spot_num    
                                      , CaCharm_fwd    
                                      , CaCharm_fwd_num    
                                      , CaZomma_spot    
                                      , CaZomma_spot_num    
                                      , CaZomma_fwd    
                                      , CaZomma_fwd_num    
                                      , CaSpeed_spot    
                                      , CaSpeed_spot_num    
                                      , CaSpeed_fwd    
     , CaSpeed_fwd_num    
                                      , CaVrDet    
                                      , CaSpotDet    
                                      , CaSpotDetCosto    
                                      , CaWf_Mon1_Costo    
                                      , CaWf_Mon2_Costo    
                                      , CaVol_Costo    
                                      , CaFwd_Teo_Costo    
                                      , CaVr_CostoDet    
                                      , CaPrimaBSSpotDet    
                                      , CaIteAsoSis    
                                      , CaIteAsoCon    
                                      , CaFormaPagoComp    
                                      , CaVrDetML    
                                      , CaPrimaInicialDet    
                                      , CaWf_ML    
                                      , CaPrimaInicialDetML    
                                      )    
                                 SELECT @MoNumContrato    
                                      , MoNumEstructura    
                                      , MoVinculacion    
                                      , MoTipoOpc    
                                      , MoSubyacente    
                                      , MoTipoPayOff    
                                      , MoCallPut    
                                      , MoCVOpc    
                                      , MoTipoEmisionPT    
                                      , MoFechaInicioOpc    
                                   , MoFechaFijacion    
                                      , MoFechaVcto    
                                      , MoFormaPagoMon1    
                                      , MoFechaPagMon1    
                                      , MoFormaPagoMon2    
            , MoFechaPagMon2    
                                      , MoFechaPagoEjer    
                                      , MoCodMon1    
                                      , MoMontoMon1    
                                      , MoCodMon2    
                                      , MoMontoMon2    
                                      , MoModalidad    
                                      , MoMdaCompensacion    
                                      , MoBenchComp    
                                      , MoParStrike    
                                      , MoStrike    
                                      , MoPorcStrike    
                                      , MoTipoEjercicio    
                                      , MoCurveMon1    
                                      , MoCurveMon2    
       , MoCurveSmile    
                                      , MoWf_mon1    
                                      , MoWf_mon2    
                                      , MoVol    
                                      , MoFwd_teo    
                                      , MoDelta_spot    
                                      , MoDelta_spot_num    
                                      , MoDelta_fwd    
                                      , MoDelta_fwd_num    
                                      , MoGamma_spot    
                                      , MoGamma_spot_num    
                                      , MoGamma_fwd    
                                      , MoGamma_fwd_num    
                                      , MoVega    
                                      , MoVega_num    
                                      , MoVanna_spot    
                                      , MoVanna_spot_num    
                                      , MoVanna_fwd    
                                      , MoVanna_fwd_num    
                                      , MoVolga    
                                      , MoVolga_num    
                                      , MoTheta    
                                      , MoTheta_num    
                                      , MoRho    
                                      , MoRho_num    
               , MoRhof    
                                      , MoRhof_num    
                                      , MoCharm_spot    
                                      , MoCharm_spot_num    
                                      , MoCharm_fwd    
                                      , MoCharm_fwd_num    
                                      , MoZomma_spot    
                                      , MoZomma_spot_num    
                                      , MoZomma_fwd    
                                      , MoZomma_fwd_num    
                                      , MoSpeed_spot    
                                      , MoSpeed_spot_num    
                                      , MoSpeed_fwd    
                                      , MoSpeed_fwd_num    
                                      , MoVrDet    
                                      , MoSpotDet    
                                      , MoSpotDetCosto    
                                  , MoWf_Mon1_Costo    
                                      , MoWf_Mon2_Costo    
                                      , MoVol_Costo    
                                      , MoFwd_Teo_Costo    
                                      , MoVr_CostoDet    
                                      , MoPrimaBSSpotDet    
                     , MoIteAsoSis    
                                      , MoIteAsoCon    
                                      , MoFormaPagoComp    
                                      , MoVRDetML    
                                      , MoPrimaInicialDet    
                                      , MoWf_ML    
                                      , MoPrimaInicialDetML    
                                   FROM dbo.MoDetContrato    
                                  WHERE MoNumFolio = @MoNumFolio    
    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaDetContrato'     
            GOTO FinProcesoError    
        END    
    
        INSERT INTO dbo.CaFixing (    
                                   CaNumContrato    
                                 , CaNumEstructura    
                                 , CaFixFecha    
                                 , CaFixNumero    
                                 , CaPesoFij    
                                 , CaVolFij    
                                 , CaFijacion    
                                 , CaFixBenchComp    
                                 , CaFixParBench    
                                 , CaFixEstado    
                                 )    
                            SELECT @MoNumContrato    
                                 , MoNumEstructura    
                                 , MoFixFecha    
                                 , MoFixNumero    
, MoPesoFij    
                                 , MoVolFij    
                                 , MoFijacion    
                                 , MoFixBenchComp         
                                 , MoFixParBench        
                                 , MoFixEstado    
                              FROM dbo.MoFixing    
                             WHERE MoNumFolio = @MoNumFolio    
    
        IF @@error <> 0 BEGIN    
            SET @MsgError = 'Error: dbo.Sp_AppMvtCar Insert CaFixing'     
            GOTO FinProcesoError    
        END    
    
    END    -- CREACION     
    
    IF NOT EXISTS( SELECT Clnombre FROM BacparamSudaCliente WHERE Clrut = @MoRut AND Clcodigo = @MoCodigo )    
    BEGIN    
        INSERT INTO dbo.BacparamSudaCliente    
                    (    
                      Clrut    
                    , Cldv    
                    , Clcodigo    
                    , Clnombre    
                    , Clgeneric    
                    , Cldirecc    
                    , Clcomuna    
                    , Clregion    
                    , Cltipcli    
                    , Clfecingr    
                    , Clctacte    
                    , Clfono    
                    , Clfax    
                    , Clapelpa    
                    , Clapelma    
                    , Clnomb1    
                    , Clnomb2    
                    , Clapoderado    
                    , Clciudad    
                    , Clmercado    
                    , Clgrupo    
                    , Clpais    
                    , Clcalidadjuridica    
                    , Cltipoml    
                    , Cltipomx    
                    , Clbanca    
                    , Clrelac    
                    , Clnumero    
                    , Clcomex    
                    , Clchips    
                    , Claba    
                    , Clswift    
                    , Clnfm    
                    , Clfmutuo    
                    , Clfeculti    
                    , Clejecuti    
                    , Clentidad    
                    , Clgraba    
                    , Clcompint    
                    , Clcalle    
                    , Clctausd    
                    , Clcaljur    
                    , Clnemo    
                    , Climplic    
                    , Clopcion    
                    , Clcalidad    
   , Cltipode    
                    , Clrelacion    
                    , Clcatego    
  , Clsector    
                    , Clestado    
                    , Clclsbif    
                    , Clfesbif    
                    , Clclbco    
                    , Clfecbco    
                    , Clactivida    
                    , Cltelef    
                    , Usuario    
                    , Cltipemp    
                    , Relbco    
                    , Fecact    
                    , Cltipsis    
                    , Poder    
                    , Firma    
                    , Feca85    
                    , Relcia    
                    , Relcor    
                    , Infosoc    
  , Art85    
                    , Dec85    
                    , Clconres    
                    , Clcodban    
                    , Cod_Inst    
                    , Rut_Grupo    
                    , Clcodfox    
                    , Clcrf    
                    , Clerf    
  , Clvctolineas    
                    , Clvalidalinea    
                    , Oficinas    
                    , Clclaries    
                    , Codigo_Otc    
                    , Bloqueado    
                    , CLFECCONDGRL    
                    , clcosto    
                    , mxcontab    
                    , clrutcliexterno    
                    , cldvcliexterno    
                    , clBrokers    
                    , RutBancoReceptor    
                    , CodBancoReceptor    
                    , clCondicionesGenerales    
                    , clFechaFirma_cond    
                    , fecha_escritura    
                    , nombre_notaria    
                    , ClCompBilateral    
                    )    
               SELECT Clrut    
                    , Cldv    
                    , Clcodigo    
                    , Clnombre    
                    , Clgeneric    
                    , Cldirecc    
                    , Clcomuna    
                    , Clregion    
                    , Cltipcli    
                    , Clfecingr    
                    , Clctacte    
                    , Clfono    
                    , Clfax    
                    , Clapelpa    
                    , Clapelma    
                    , Clnomb1    
                    , Clnomb2    
                    , Clapoderado    
                    , Clciudad    
                    , Clmercado    
                    , Clgrupo    
                    , Clpais    
                    , Clcalidadjuridica    
                    , Cltipoml    
                    , Cltipomx    
                    , Clbanca    
                    , Clrelac    
                    , Clnumero    
                    , Clcomex    
                    , Clchips    
                    , Claba    
                    , Clswift    
                    , Clnfm    
                    , Clfmutuo    
                    , Clfeculti    
               , Clejecuti    
                    , Clentidad    
                    , Clgraba    
                    , Clcompint    
                    , Clcalle    
                    , Clctausd    
                    , Clcaljur    
                    , Clnemo    
                    , Climplic    
                    , Clopcion    
                    , Clcalidad    
                    , Cltipode    
                    , Clrelacion    
                    , Clcatego    
                    , Clsector    
                    , Clestado    
                    , Clclsbif    
                    , Clfesbif    
                    , Clclbco    
                    , Clfecbco    
                    , Clactivida    
                    , Cltelef    
                    , Usuario    
                    , Cltipemp    
                    , Relbco    
                    , Fecact    
              , Cltipsis    
                    , Poder    
                    , Firma    
                    , Feca85    
                    , Relcia    
                    , Relcor    
                    , Infosoc    
                    , Art85    
                    , Dec85    
                    , Clconres    
                    , Clcodban    
                    , Cod_Inst    
                    , Rut_Grupo    
                    , Clcodfox    
                    , Clcrf    
                    , Clerf    
                    , Clvctolineas    
              , Clvalidalinea    
                    , Oficinas    
                    , Clclaries    
                    , Codigo_Otc    
                    , Bloqueado    
                    , CLFECCONDGRL    
                    , clcosto    
                    , mxcontab    
                    , clrutcliexterno    
                    , cldvcliexterno    
                    , clBrokers    
                    , RutBancoReceptor    
                    , CodBancoReceptor    
                    , clCondicionesGenerales    
                    , clFechaFirma_cond    
                    , fecha_escritura    
                    , nombre_notaria    
                    , ClCompBilateral    
                 FROM LnkBac.bacparamsuda.dbo.VIEW_CLIENTEParaOpc    
                WHERE Clrut    = @MoRut    
                  AND Clcodigo = @MoCodigo     
    
    END    
    
FinProcesoOK:    
    COMMIT  -- Se grabara igual aunque fallen las LCR    
    
    DECLARE @ErroLCR int    
    DECLARE @MsgLCR  varchar(5000) -- 08 Oct. 2009    
    
    SET @ErroLCR = 0    
/*  
    IF @MoTipoTransaccion = 'CREACION' AND @EsCotizacion = 'N' BEGIN   -- MAP 25 Septiembre    
        UPDATE dbo.MoEncContrato     
           SET MoEstado   = 'P'    -- La operacion queda pendiente de inmediato    
         WHERE MoNumFolio = @MoNumFolio     
    
        EXECUTE @ErroLCR = sp_Lineas_opciones 'OPT', @MoRut, @MoCodigo, 0, @MoOperador, @MoNumContrato                 
    
        EXECUTE LNKBAC.BacLineas.dbo.Sp_Trae_Msj_Errores 'OPT', @MoNumContrato , @Observ OUTPUT    -- 08 Oct. 2009 - Si existen errores de lineas o limites los debe mostrar en papeleta    
        SET @MsgLCR =  convert( Varchar(5000),@Observ)  -- 08 Oct. 2009     
    
    
    END ELSE    
    BEGIN    
    
         IF @MoTipoTransaccion = 'ANULA'     
         BEGIN     
            EXECUTE LNKBAC.BacLineas..Sp_Lineas_Anula @Proceso, 'OPT', @MoNumContrato     
            SET @MsgLCR = ' CON CONTROL LCR'    
                
         END ELSE    
         BEGIN            
         SET @MsgLCR = ' SIN CONTROL LCR'    
        END    
    
    END    
*/  
    --IF @ErroLCR = 0 BEGIN  
    
    IF @MoTipoTransaccion = 'CREACION' AND @EsCotizacion = 'N' BEGIN    
        UPDATE dbo.MoEncContrato     
        SET MoEstado   = 'P'    -- La operacion queda pendiente de inmediato    
        WHERE MoNumFolio = @MoNumFolio  
    END  
    
    SELECT  '', @MoNumContrato  
        RETURN(0)    
  
    --END ELSE  
    --BEGIN   
    --    SET @MsgError = 'Error: sp_Lineas_opciones '  
    --    SELECT convert( varchar(2) , 'SI' )  
    --         , CONVERT( varchar(80), 'Movimiento '  + LTRIM( RTRIM( @MoTipoTransaccion ) ) + ' '  + RTRIM( CONVERT( character(9), @MoNumContrato ) ) +  
    --           ' Error procesos LCR ' )  
    --    RETURN(0)  
    --END  
    
FinProcesoError:    
    SELECT convert( varchar(2) , 'NO' )    
         , convert( varchar(80), @MsgError )    
    
    ROLLBACK    
    RETURN (-1)      
    
END 

GO
