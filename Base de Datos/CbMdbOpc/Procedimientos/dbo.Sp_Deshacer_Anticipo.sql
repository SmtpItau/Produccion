USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Deshacer_Anticipo]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sp_Deshacer_Anticipo 8067,11825
CREATE PROC [dbo].[Sp_Deshacer_Anticipo](   @NumContrato numeric(8), @NumFolio numeric(8) ) AS BEGIN			

        -- MAP 28 Octubre 2009
        -- Eliminacion del registro de movimiento
        -- Se elimina el codigo que recupera Caja de Ayer (no aplica)
        -- Se mira directamente al motor de pagos para ver si se
        -- puede deshacer el anticipo o no

-- Sp_Deshacer_Anticipo 778, 945

         SET NOCOUNT ON 	


--         Por mientras, para terminar el .net
--         begin tran
--         Goto FinProcesoOK

		
         Declare  			
               @MoTipoTransaccion	[VARCHAR](10)
             , @MsgError			[VARCHAR](80)
             , @PrcAnticipo			[NUMERIC](10,5)  
             , @PrcAnticipoRem		[NUMERIC](10,5)
             , @ValidaAnticipo		[NUMERIC](1)
             , @Modalidad			[VARCHAR](1)
             , @MoRut				[NUMERIC](10)
             , @MoCodigo			[NUMERIC](1)
             , @MoOperador			[VARCHAR](15)
             , @Proceso				[DATETIME]
             , @ProcesoAnt			[DATETIME]
             , @MoUnwind			[float]


         select  @MoTipoTransaccion = ''
               , @PrcAnticipo       = 0
               , @PrcAnticipoRem    = 0 
               , @Modalidad         = ''
               , @MoUnwind          = 0.0
                

         Select   @MoTipoTransaccion = MoTipoTransaccion

               ,  @PrcAnticipo       = 100  -- MoPrcAnticipo -- Ojo que falta en MoEncContrato
               ,  @PrcAnticipoRem    = 100 - @PrcAnticipo  
               ,  @Modalidad         = 'C' -- MoModAnticipo -- Ojo que falta en MoEncContrato
               ,  @MoRut             = MoRutCliente 
               ,  @MoCodigo       = MoCodigo 
               ,  @MoOperador     = MoOperador 
               ,  @MoUnwind       = MoUnwind

            from MoEncCOntrato where MoNumFolio = @NumFolio 

         if @MoTipoTransaccion = '' begin
               SELECT  @MsgError =  'Error: .net No graba Movimiento Rpt. Sp_Deshacer_Anticipo'                                               
               GOTO FinProcesoError	
         end

         select  @Proceso    = fechaproc
                ,@ProcesoAnt = fechaant   from OpcionesGeneral   

 
         BEGIN TRANSACTION
         IF @@error <> 0 BEGIN
            SELECT  @MsgError = 'Error: No Logro BEGIN TRAN'
            GOTO FinProcesoError
         END

         -- Eliminar el Movimiento de Anticipo
         delete MoCaja        where MoNumFolio = @NumFolio 
         delete MoFixing      where MoNumFolio = @NumFolio
         delete MoDetContrato where MoNumFolio = @NumFolio
         delete MoEncContrato where MoNumFolio = @NumFolio


         if   @MoTipoTransaccion in ( 'ANTICIPA','EJERCE' )      
         Begin 
            -- Verificar que exista la cartera que se quiere modificar.
            if not Exists( select 1 from CaEncContrato where CaNumContrato = @NumContrato ) 
            Begin			
               SELECT  @MsgError =  'Error: no existe cartera para revertir anticipo ' 
                                               + ltrim( rtrim( @MoTipoTransaccion ) )  
               GOTO FinProcesoError		
            end 

            update CaEncContrato 
            set      CaTipoTransaccion = R.CaTipoTransaccion
                    ,CaNumFolio        = R.CaNumFolio
                    ,CaFechaContrato   = R.CaFechaContrato
                    ,CaEstado          = (CASE WHEN @MoTipoTransaccion = 'ANTICIPA' THEN 'N' 
											   WHEN @MoTipoTransaccion = 'EJERCE'   THEN 'E'END ) -- CaEstado Por mientras lo dejamos para anticipar
                    ,CaCarteraFinanciera= R.CaCarteraFinanciera
                    ,CaLibro= R.CaLibro
                    ,CaCarNormativa= R.CaCarNormativa
                    ,CaSubCarNormativa= R.CaSubCarNormativa
                    ,CaRutCliente= R.CaRutCliente
                    ,CaCodigo= R.CaCodigo
                    ,CaTipoContrapartida= R.CaTipoContrapartida
                    ,CaOperador= R.CaOperador
					,CaCodEstructura= R.CaCodEstructura
                    ,CaCVEstructura= R.CaCVEstructura
                    ,CaSistema= R.CaSistema
                    ,CaMonPrimaTrf= R.CaMonPrimaTrf
                    ,CaPrimaTrf= R.CaPrimaTrf
                    ,CaPrimaTrfML= R.CaPrimaTrfML
                    ,CaMonPrimaCosto= R.CaMonPrimaCosto
                    ,CaPrimaCosto= R.CaPrimaCosto
                    ,CaPrimaCostoML= R.CaPrimaCostoML
                    ,CaCodMonPagPrima= R.CaCodMonPagPrima
                    ,CaPrimaInicial= R.CaPrimaInicial
                    ,CaPrimaInicialML= R.CaPrimaInicialML
                    ,CafPagoPrima= R.CafPagoPrima
                    ,CaMonCarryPrima= R.CaMonCarryPrima
                    ,CaCarryPrima= R.CaCarryPrima
                    ,CaParM2Spot= R.CaParM2Spot
                    ,CaParMdaPrima= R.CaParMdaPrima
                    ,CaFechaPagoPrima= R.CaFechaPagoPrima
                    ,CaFecValorizacion= R.CaFecValorizacion
                    ,CaMon_vr= R.CaMon_vr
                    ,CaVr= R.CaVr
                    ,CaMondelta= R.CaMondelta
                    ,CaMon_gamma= R.CaMon_gamma
                    ,CaMon_vega= R.CaMon_vega
                    ,CaMon_vanna= R.CaMon_vanna
                    ,CaMon_volga= R.CaMon_volga
                    ,CaMon_theta= R.CaMon_theta
                    ,CaMon_rho= R.CaMon_rho
                    ,CaMon_rhof= R.CaMon_rhof
                    ,CaMon_charm= R.CaMon_charm
                    ,CaMon_zomma= R.CaMon_zomma
                    ,CaMon_speed= R.CaMon_speed
                    ,CaPrimaBSSpotCont= R.CaPrimaBSSpotCont
                    ,CaDeltaSpotCont= R.CaDeltaSpotCont
                    ,CaDeltaForwardCont= R.CaDeltaForwardCont
                    ,CaGammaSpotCont= R.CaGammaSpotCont
                    ,CaVegaCont= R.CaVegaCont
                    ,CaVannaSpotCont= R.CaVannaSpotCont
                    ,CaVolgaCont= R.CaVolgaCont
                    ,CaThetaCont= R.CaThetaCont
                    ,CaRhoDomCont= R.CaRhoDomCont
                    ,CaRhoForCont= R.CaRhoForCont
                    ,CaCharmSpotCont= R.CaCharmSpotCont
                    ,CaZommaSpotCont= R.CaZommaSpotCont
                    ,CaSpeedSpotCont= R.CaSpeedSpotCont
                    ,CaFechaUnwind= R.CaFechaUnwind
                    ,CaNominalUnwind= R.CaNominalUnwind 
                    ,CaUnwindMon= R.CaUnwindMon 
                    ,CaUnwind= R.CaUnwind 	
                    ,CaUnwindML= R.CaUnwindML
                    ,CaFormPagoUnwind= R.CaFormPagoUnwind
                    ,CaUnwindTransfMon= R.CaUnwindTransfMon
                    ,CaUnwindTransf= R.CaUnwindTransf
                    ,CaUnwindTransfML= R.CaUnwindTransfML
                    ,CaVr_Costo= R.CaVr_Costo
                    ,CaGlosa= R.CaGlosa
                    ,CaUnwindCostoMon= R.CaUnwindCostoMon
                    ,CaUnwindCosto= R.CaUnwindCosto
                    ,CaUnwindCostoML= R.CaUnwindCostoML
                    ,CaGammaFwdCont= R.CaGammaFwdCont
                    ,CaVannaFwdCont= R.CaVannaFwdCont
                    ,CaCharmFwdCont= R.CaCharmFwdCont
                    ,CaZommaFwdCont= R.CaZommaFwdCont
                    ,CaSpeedFwdCont= R.CaSpeedFwdCont
                    ,CaImpreso = ' '
                    ,CaResultadoVentasML = ISNULL(R.CaResultadoVentasML, 0.0) -- //5843
             from CaResEncContrato R
             where CaEncContrato.CaNumContrato = @NumContrato   
             and     R.CaNumContrato = @NumContrato 
             and     R.CaEncFechaRespaldo = @ProcesoAnt

            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: dbo.Sp_Deshacer_Anticipo Update de Cartera' 
               GOTO FinProcesoError
            END

            declare @MotorPago NUMERIC(1) --  character(1)

            select @MotorPago = 0 -- 'N'
--            select @MotorPago = 1 /*estado_envio*/ from LnkBac.BacParamSuda.dbo.VIEW_MOTOR --FMO quitar lnkbac link server 20201207
            select @MotorPago = 1 /*estado_envio*/ from BacParamSuda.dbo.VIEW_MOTOR 
            where fecha   = @Proceso 
            and sistema = 'OPT'
              and numero_operacion = @NumContrato and estado_envio not in('R')
            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: No se pudo ver Motor Pagos BAC' 
               GOTO FinProcesoError
            END 

--            IF @MotorPago = 'E' BEGIN
--               SELECT  @MsgError = 'Error: Pago realizado en Motor de Pagos, Anticipo permanece' 
--               GOTO FinProcesoError
--            END            
--            else  
--            begin  -- Eliminar registro del motor de pagos  28 OCtubre 2099
--               if @MotorPago <> 'N'  -- Exite Motor de Pagos
--                  Delete BacParamSuda.dbo.VIEW_MOTOR 
--                  where fecha   = @Proceso 
--                    and sistema = 'OPT'
--                    and numero_operacion = @NumContrato 
			   IF @MotorPago <> 0 /*'N' */ BEGIN
				   SELECT  @MsgError = 'No se puede Anular ya se encuentra en SADP' 
				   GOTO FinProcesoError  /* Continua si no se da este error */
               END    

--               IF @@error <> 0 BEGIN
--                  SELECT  @MsgError = 'Error: No se pudo examinar Motor Pagos BAC' 
--                  GOTO FinProcesoError
--               END    
--            end

            delete CaCaja where CaNumContrato = @NumContrato   -- La caja de ayer no hay que recuperarla

            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: dbo.dbo.Sp_Deshacer_Anticipo Delete CaCaja' 
               GOTO FinProcesoError
            END

            delete CaDetContrato where CaNumContrato = @NumContrato
            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: dbo.Sp_Deshacer_Anticipo Delete CaDetContrato' 
               GOTO FinProcesoError
            END 
            insert into CaDetContrato 
               select  @NumContrato
                ,	CaNumEstructura
                ,	CaVinculacion
                ,	CaTipoOpc
                ,	CaSubyacente
                ,	CaTipoPayOff
                ,	CaCallPut
                ,	CaCVOpc
                ,	CaTipoEmisionPT
                ,	CaFechaInicioOpc
                ,	CaFechaFijacion
                ,	CaFechaVcto
                ,	CaFormaPagoMon1
                ,	CaFechaPagMon1
                ,	CaFormaPagoMon2
                ,	CaFechaPagMon2
                ,	CaFechaPagoEjer
                ,	CaCodMon1
                ,	CaMontoMon1
                ,	CaCodMon2
                ,	CaMontoMon2
                ,	CaModalidad
                ,	CaMdaCompensacion
                ,	CaBenchComp
                ,	CaParStrike
                ,	CaStrike
                ,	CaPorcStrike
                ,	CaTipoEjercicio
                ,	CaCurveMon1
                ,	CaCurveMon2
                ,	CaCurveSmile
                ,	CaWf_mon1
                ,	CaWf_mon2
                ,	CaVol
                ,	CaFwd_teo
                ,	CaDelta_spot
                ,	CaDelta_spot_num
                ,	CaDelta_fwd
                ,	CaDelta_fwd_num
                ,	CaGamma_spot
                ,	CaGamma_spot_num
                ,	CaGamma_fwd
                ,	CaGamma_fwd_num
                ,	CaVega
                ,	CaVega_num
                ,	CaVanna_spot
                ,	CaVanna_spot_num
                ,	CaVanna_fwd
                ,	CaVanna_fwd_num
                ,	CaVolga
                ,	CaVolga_num
                ,	CaTheta
                ,	CaTheta_num
                ,	CaRho
                ,	CaRho_num
                ,	CaRhof
                ,	CaRhof_num
                ,	CaCharm_spot
                ,	CaCharm_spot_num
                ,	CaCharm_fwd
                ,	CaCharm_fwd_num
                ,	CaZomma_spot
    ,	CaZomma_spot_num
                ,	CaZomma_fwd
                ,	CaZomma_fwd_num
                ,	CaSpeed_spot
                ,	CaSpeed_spot_num
                ,	CaSpeed_fwd
                ,	CaSpeed_fwd_num
                ,   CaVrDet
                ,   CaSpotDet
                ,   CaSpotDetCosto
				,   CaWf_Mon1_Costo
                ,   CaWf_Mon2_Costo
				,   CaVol_Costo
                ,   CaFwd_Teo_Costo
                ,   CaVr_CostoDet
                ,   CaPrimaBSSpotDet
                ,   CaIteAsoSis
                ,   CaIteAsoCon
                ,   CaFormaPagoComp
                ,   CaVRDetML
                ,   CaPrimaInicialDet
                ,   CaWf_ML
                ,   CaPrimaInicialDetML
            from    CaResDetContrato R 
            where   R.CaNumContrato      = @NumContrato
            and     R.CaDetFechaRespaldo  = @ProcesoAnt
            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: dbo.Sp_Deshacer_Anticipo Insert CaDetContrato' 
               GOTO FinProcesoError
            END 

            delete CaFixing where CanumContrato = @NumContrato
            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: dbo.Sp_Deshacer_Anticipo Delete CaFixing' 
               GOTO FinProcesoError
            END 
            
            insert into CaFixing 
            select 
                    CaNumContrato
                ,	CaNumEstructura
                ,	CaFixFecha
                ,	CaFixNumero
                ,	CaPesoFij
                ,	CaVolFij
                ,	CaFijacion
                ,   CaFixBenchComp	 
                ,   CaFixParBench	
                ,   CaFixEstado
            from CaResFixing R where R.CaNumContrato = @NumContrato   
                               and    R.CaFixingFechaRespaldo = @ProcesoAnt
            IF @@error <> 0 BEGIN
               SELECT  @MsgError = 'Error: dbo.Sp_Deshacer_Anticipo Insert CaFixing' 
               GOTO FinProcesoError
            END
         end	 

FinProcesoOK:
            commit 	                
            SELECT   convert( varchar(80), 'Operación Restaurada Preparada para Anticipar' ) As Mensaje

            RETURN (0)
FinProcesoError:
         SELECT convert( varchar(80), @MsgError ) As Mensaje
         --SET NOCOUNT OFF	   --select * from CaCaja
         ROLLBACK
         RETURN (-1)  
END	
GO
