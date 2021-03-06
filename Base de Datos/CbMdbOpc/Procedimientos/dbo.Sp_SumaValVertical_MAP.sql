USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_SumaValVertical_MAP]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_SumaValVertical_MAP]  
AS
BEGIN

   set nocount on
   -- Calculo de Valutas:
   -- CaDetContrato y CaCaja
   -- en el caso de CaCaja que estàn con (CaCajFecPago o CaFechaPagoEjer) anterior a la fecha de proceso (pagos pendientes)
   -- se debe calcular fecha vencimiento de valuta segun la forma de pago y la fecha de proceso. 
   -- Si el pago no ha vencido debe calcular fecha vencimiento de valuta segùn la forma de pago y 
   -- la fecha CaCajFecPago (CaCaja) o segun la fecha CaFechaPagoEjer (CaDetContrato). .  

   -- MAP 08 de Octubre
   -- Generacion del Valor razonable en CLP a nivel de detalle.
  
   -- MAP 28 Octubre 2009
   -- Calculo de la prima inicial a nivel de detalle se realiza
   -- solamente cuando se graba la operacion.
   -- Entrega 13 Nov. , hay que sacar la recuperacion de la prima y poner en Sp_AppMvtCar
   -- Sp_SumaValVertical_MAP

   -- MAP 26 Enero 2010 
   -- Modifica Calculo de la prima inicial 
   -- Ultima Actualización 17/02/2010



   declare @Proceso datetime
   declare @Anterior datetime
   declare @Cursor        numeric(8)
         , @fechaAux      datetime
         , @FVctoValuta1  datetime
         , @FVctoValuta2  datetime   
         , @Val1          int
         , @Val2          int
         , @Modalidad     varchar(1)
         , @NumContrato   numeric(8)
         , @NumEstructura numeric(8)
         , @CajFolio      numeric(8)
         , @ProblemaCR    char(1)

   -- INtento Validación de COnfiguracion regional 
   -- (junto con el algoritmo distribución de primas)
   select  @ProblemaCR = 'N'
   select  @ProblemaCR = 'S' from CaDetContrato where CaDelta_spot/CaMontoMon1 > 1
   if @ProblemaCR = 'S' 
   begin
      update opcionesgeneral set devengo = 0 
      select convert( varchar(80) , 'Valorización Falló' ) as Mensaje
      return(1)  
   end


   select  @Proceso = fechaproc 
          , @Anterior = fechaant from OpcionesGeneral



   begin tran

   select 		
		CaDetnumContrato	= CaNumContrato
	,	CaVr	        = Sum(CaVrDet)
	,	CaCharmFwdCont	= Sum( case when CaCharm_fwd = 0 then CaCharm_fwd_num else CaCharm_fwd end )
	,	CaCharmSpotCont	= Sum( case when CaCharm_spot = 0 then CaCharm_spot_num else CaCharm_spot end )
	,	CaDeltaForwardCont	= Sum( case when CaDelta_fwd = 0 then CaDelta_fwd_num else CaDelta_fwd end )
	,	CaDeltaSpotCont	= Sum( case when CaDelta_spot = 0 then CaDelta_spot_num else CaDelta_spot end )
	,	CaGammaFwdCont	= Sum( case when CaGamma_fwd = 0 then CaGamma_fwd_num else CaGamma_fwd end )
	,	CaGammaSpotCont	= Sum( case when CaGamma_spot = 0 then CaGamma_spot_num else CaGamma_spot end )
	,	CaRhoDomCont	= Sum( case when CaRho = 0 then CaRho_num else CaRho end )
	,	CaRhoForCont	= Sum( case when CaRhof = 0 then CaRhof_num else CaRhof end )
	,	CaSpeedFwdCont	= Sum( case when CaSpeed_fwd = 0 then CaSpeed_fwd_num else CaSpeed_fwd end )
	,	CaSpeedSpotCont	= Sum( case when CaSpeed_spot = 0 then CaSpeed_spot_num else CaSpeed_spot end )
	,	CaThetaCont	= Sum( case when CaTheta = 0 then CaTheta_num else CaTheta end )
	,	CaVannaFwdCont	= Sum( case when CaVanna_fwd = 0 then CaVanna_fwd_num else CaVanna_fwd end )
	,	CaVannaSpotCont	= Sum( case when CaVanna_spot = 0 then CaVanna_spot_num else CaVanna_spot end )
	,	CaVegaCont	= Sum( case when CaVega = 0 then CaVega_num else CaVega end )
	,	CaVolgaCont	= Sum( case when CaVolga = 0 then CaVolga_num else CaVolga end )
	,	CaZommaFwdCont	= Sum( case when CaZomma_fwd = 0 then CaZomma_fwd_num else CaZomma_fwd end )
	,	CaZommaSpotCont	= Sum( case when CaZomma_spot = 0 then CaZomma_spot_num else CaZomma_spot end )
	into 	#CaEncContrato	
		from CaDetContrato	
		group by CaNumContrato	

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas rescatar info CaDetContrato' ) as Mensaje
      rollback
      RETURN 1
   end

   update	CaEncContrato	
      set		
		CaVr	        = DetSum.CaVr
	,	CaCharmFwdCont	= DetSum.CaCharmFwdCont
	,	CaCharmSpotCont	= DetSum.CaCharmSpotCont
	,	CaDeltaForwardCont	= DetSum.CaDeltaForwardCont
	,	CaDeltaSpotCont	= DetSum.CaDeltaSpotCont
	,	CaGammaFwdCont	= DetSum.CaGammaFwdCont
	,	CaGammaSpotCont	= DetSum.CaGammaSpotCont
	,	CaRhoDomCont	= DetSum.CaRhoDomCont
	,	CaRhoForCont	= DetSum.CaRhoForCont
	,	CaSpeedFwdCont	= DetSum.CaSpeedFwdCont
	,	CaSpeedSpotCont	= DetSum.CaSpeedSpotCont
	,	CaThetaCont	= DetSum.CaThetaCont
	,	CaVannaFwdCont	= DetSum.CaVannaFwdCont
	,	CaVannaSpotCont	= DetSum.CaVannaSpotCont
	,	CaVegaCont	= DetSum.CaVegaCont
	,	CaVolgaCont	= DetSum.CaVolgaCont
	,	CaZommaFwdCont	= DetSum.CaZommaFwdCont
	,	CaZommaSpotCont	= DetSum.CaZommaSpotCont
   From #CaEncContrato DetSum		
		where CaNumContrato = DetSum.CaDetnumContrato	

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas actualizado CaEncContrato' ) as Mensaje
      rollback
      RETURN 1
   end

   update CaDetContrato  
   -- MAP 13 Nov. recupera prima por modificacion , poner en el AppMvtcar
   -- aca se puso por contingencia
   -- Supesto: no se modifica en t0   select * from CaResDetContrato
   set   CaDetContrato.CaPrimaInicialDet = r.CaPrimaInicialDet
       , CaDetContrato.CaPrimaInicialDetML  = r.CaPrimaInicialDetML
   from CaResDetContrato r where r.CaNumContrato = CaDetContrato.CanumContrato   
                         and r.CaNumEstructura = CaDetContrato.CaNumEstructura 
                         and r.CaDetFechaRespaldo = @Anterior


   



   Update CaDetContrato
   -- MAP 15 Octubre Se corrige el signo para el cálculo de la Prima Inicial 
         Set CaPrimaInicialDet = round( case when Enc.CaFechaContrato = @Proceso then 
                                     abs( Enc.CaPrimaInicial ) * abs( CaVRDet / ( case when round(Enc.CaVr,2) <> 0 then  Enc.CaVr else 1 end ) )

                                                        * ( case when CaCVOpc = 'C' then -1 else +1 end )

                                 else CaPrimaInicialDet end, case when CaCodMonPagPrima = 999 then 0 else 2 end  )

           , CaPrimaInicialDetML = round( case when Enc.CaFechaContrato = @Proceso then 
                                    abs( Enc.CaPrimaInicialML ) * abs( CaVRDet / ( case when round(Enc.CaVr,2) <> 0 then  Enc.CaVr else 1 end ) )

                                                        * ( case when CaCVOpc = 'C' then -1 else +1 end )

                                    else CaPrimaInicialDetML end, case when CaCodMonPagPrima = 999 then 0 else 2 end  )

           -- MAP 08 de Octubre
           , CaVRDetML           = CaVRDet * isnull( ( select Tipo_Cambio 
                                                       from BacParamSudaVALOR_MONEDA_CONTABLE
                                                       where Fecha = @Proceso 
                                                         and Codigo_Moneda =  ( case when CaMon_vr = 13 then 994 else CaMon_vr end) ) , 1 )
            


         from CaEncContrato Enc
         where Enc.CaNumContrato = CaDetContrato.CaNumContrato --- and Enc.CaFechaContrato = @Proceso  -- MAP 28 Oct. 2009  13 Nov. 2009

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas actualizado CaDetContrato 01' ) as Mensaje
      rollback
      RETURN 1
   end

   -- Algoritmo para corregir casos singurales
   -- Cuando existe mtm de compra y de venta y podrían ser iguales
   select    E.CaNumContrato, CaCodEstructura
      ,   CaMtmPos = round( sum( case when CaVrdet > 0 then CaVrDet else 0 end ), 0 )  -- MAP 20091231
      ,   CaMtmNeg = round( sum( case when CaVrdet < 0 then CaVrDet else 0 end ), 0 )  -- MAP 20091231
      ,   CaPrimaInicial, CaPrimaInicialML, CaCodMonPagPrima, CaVr
      ,   CaVinculacion    -- 17/02/2010 Se agregan  CaVr y CaVinculacion.
      ,   RatioVtaCmp = convert( float, 0.0 * 100000000.00000000 )  -- MAP 20100102 todos los convert float
      ,   PesoVta = convert( float , 0.0     * 100000000.00000000 )
      ,   PesoCmp = convert( float, 0.0     * 100000000.00000000 )
      ,   PrimaComprada = convert( float, 0.0     * 100000000.00000000 )
      ,   PrimaVendida  = convert( float, 0.0     * 100000000.00000000 )
      ,   PrimaCompradaML = convert( float, 0.0     * 100000000.00000000 )
      ,   PrimaVendidaML  = convert(float, 0.0     * 100000000.00000000 )
      
      into #MTMPosNeg
      from cadetcontrato D, CaEncContrato E
   where D.CaNumContrato = E.CaNumContrato
     and E.CaFechaCOntrato = @Proceso  
     and D.CaVinculacion = 'Estructura'                        -- Solo aplica en estructuras 17/02/2010
   Group by E.CaNumContrato, CaPrimaInicial, CaCodEstructura, CaPrimaInicialML, CaCodMonPagPrima, CaVr, Cavinculacion



   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas generando #MTMPosNeg' ) as Mensaje
      rollback
      RETURN 1
   end

/*  17/02/2010
   delete #MTMPosNeg where CaMtmPos = 0 or CaMtmNeg = 0 -- 
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas delete #MTMPosNeg' ) as Mensaje
      rollback
      RETURN 1
   end
*/

   select 'debug', CaMtmPos, CaVr,  * from #MTMPosNeg where CaMtmPos = 0 or CaVr = 0

   -- select 'debug',  CaMtmNeg, CaMtmPos, * from #MTMPosNeg

   -- select 'debug', CaMtmNeg / CaMtmPos from #MTMPosNeg
   update  #MTMPosNeg
     set
        RatioVtaCmp   = round( CaMtmNeg / CaMtmPos , 15 ) * 1.00000000 -- Formula se aplicará solo en caso Mixto,, de 8 a 15 para igualar Excel

      , PesoCmp = case when CaVr < 0 then  CaMtmPos / CaVr    	      -- Caso 1.1
                            when CaVr = 0 then  -1.0                  -- Caso 2.1
                            when CaVr > 0 then  - CaMTMPos / CaVr end -- Caso 3.1
      , PesoVta = case when CaVr < 0 then CaMtmNeg / CaVr             -- Caso 1.2
                            when CaVr = 0 then  2.0                   -- Caso 2.2
                            when CaVr > 0 then  - CaMTMNeg / CaVr end -- Caso 3.2


   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas update #MTMPosNeg' ) as Mensaje
      rollback
      RETURN 1
   end

   update #MTMPosNeg
    set
       PrimaComprada = case when CaVr <=0 then 
                            case when CaPrimaInicial >= 0 
                                 then PesoCmp * CaPrimaInicial        -- CASO 1.1, ver doc.
                                 else PesoVta * CaPrimaInicial        -- CASO 2.1, ver doc.
                                 end 
                       else
                            case when CaPrimaInicial > 0       
                                 then PesoVta * ( - CaPrimaInicial )  -- CASO 3.1, ver doc.
                                 else PesoCmp * ( - CaPrimaInicial )  -- CASO 4.1, ver doc.
                                 end
                       end 

   ,   PrimaVendida = case when CaVr <=0 then 
                            case when CaPrimaInicial >= 0 
                                 then PesoVta * CaPrimaInicial        -- CASO 1.2, ver doc.
                                 else PesoCmp * CaPrimaInicial        -- CASO 2.2, ver doc.
                                 end 
                       else
                            case when CaPrimaInicial > 0       
                                 then PesoCmp * ( - CaPrimaInicial )  -- CASO 3.2, ver doc.
                                 else PesoVta * ( - CaPrimaInicial )  -- CASO 4.2, ver doc.
                                 end
                       end



  ,   PrimaCompradaML = case when CaVr <=0 then 
                            case when CaPrimaInicial >= 0 
                                 then PesoCmp * CaPrimaInicialML        -- CASO 1.1, ver doc.
                                 else PesoVta * CaPrimaInicialML        -- CASO 2.1, ver doc.
          end 
                       else
                            case when CaPrimaInicial > 0       
                                 then PesoVta * ( - CaPrimaInicialML )  -- CASO 3.1, ver doc.
                                 else PesoCmp * ( - CaPrimaInicialML )  -- CASO 4.1, ver doc.
                                 end
                       end 



   ,   PrimaVendidaML = case when CaVr <=0 then 
                            case when CaPrimaInicial >= 0 
                                 then PesoVta * CaPrimaInicialML        -- CASO 1.2, ver doc.
                                 else PesoCmp * CaPrimaInicialML        -- CASO 2.2, ver doc.
                                 end 
                       else
                            case when CaPrimaInicial > 0       
                                 then PesoCmp * ( - CaPrimaInicialML )  -- CASO 3.2, ver doc.
                                 else PesoVta * ( - CaPrimaInicialML )  -- CASO 4.2, ver doc.
                                 end
                       end





/*

   update  #MTMPosNeg
     set   PesoVta = case when RatioVtaCmp = -1.0 
                    then -2

                    else
                           case when CaPrimaInicialML < 0
                              then -1.0 + 1.0 / ( 1.0 + RatioVtaCmp ) * 1.0
                              else 1.0 - 1.0 / ( 1.0 + RatioVtaCmp ) * 1.0
                           end
                  end * ( Case when CaPrimaInicial > 0 then 1.0 else -1.0 end )
   where CaMtmPos <> 0 and CaMtmNeg <> 0
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas segundo update #MTMPosNeg' ) as Mensaje
      rollback
      RETURN 1
   end



   update #MTMPosNeg
     set PesoCmp = case when CaPrimaInicial < 0 then - 1.0 - PesoVta else  1.0 - PesoVta  end
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas tercer update #MTMPosNeg' ) as Mensaje
      rollback
      RETURN 1
   end
   update #MTMPosNeg
    set
       PrimaComprada = PesoCmp * abs( CaPrimaInicial )     -- MAP 20091231
     , PrimaVendida  = PesoVta * abs( CaPrimaInicial )     -- MAP 20091231
     , PrimaCompradaML = PesoCmp * abs( CaPrimaInicialML ) -- MAP 20091231
     , PrimaVendidaML  = PesoVta * abs( CaPrimaInicialML ) -- MAP 20091231
*/
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas cuarto update #MTMPosNeg' ) as Mensaje
      rollback
      RETURN 1
   end



   select  CaPrimaInicial, CaPrimaInicialML, CaCodEstructura, CaCVOpc, CaVrDet
           , A.CaNumContrato
           , CaNumEstructura
           , CaCaPrimaProrrateada =  dbo.FN_TRUNCATE_DECIMALS( case when CaVrDet > 0 
                                          then PrimaComprada * CaVrDet / case when CaMtmPos = 0 then 1 else CaMtmPos end  -- 17/02/2010 Se corrige por caída división por Cero.
                                          else PrimaVendida  * CaVrDet / case when CaMtmNeg = 0 then 1 else CaMtmNeg end  -- 17/02/2010 Se corrige por caída división por Cero.
                                           end , case when CaCodMonPagPrima = 999 then 0 else 2 end  )
           , CaPrimaProrrateadaML =  dbo.FN_TRUNCATE_DECIMALS( case when CaVrDet > 0 
                                          then PrimaCompradaML * CaVrDet / case when CaMtmPos = 0 then 1 else CaMtmPos end -- 17/02/2010 Se corrige por caída división por Cero.
                                          else PrimaVendidaML  * CaVrDet / case when CaMtmNeg = 0 then 1 else CaMtmNeg end -- 17/02/2010 Se corrige por caída división por Cero.
                                            end , 0 )
        into  #MTMPrimaDistribuida
              from #MTMPosNeg A, CaDetContrato B
        where B.CaNumContrato = A.CaNumContrato
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas crear #MTMPrimaDistribuida' ) as Mensaje
      rollback
      RETURN 1
   end
    

   Update CaDetContrato
   -- MAP 15 Octubre Se corrige el signo para el cálculo de la Prima Inicial 
         Set CaPrimaInicialDet = case when Enc.CaFechaContrato = @Proceso then 
                                     CaCaPrimaProrrateada
                                 else CaPrimaInicialDet end

           , CaPrimaInicialDetML = case when Enc.CaFechaContrato = @Proceso then 
                                     CaPrimaProrrateadaML
                         else CaPrimaInicialDetML end

         from CaEncContrato Enc, #MTMPrimaDistribuida Det
         where  Enc.CaNumContrato = CaDetContrato.CaNumContrato --- and Enc.CaFechaContrato = @Proceso  -- MAP 28 Oct. 2009  13 Nov. 2009
            and CaDetContrato.CaNumContrato = Det.CaNumContrato
            and CaDetContrato.CaNumEstructura = Det.CaNumEstructura  
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas actualizado CaDetContrato 02' ) as Mensaje
      rollback
      RETURN 1
   end


   -- Ajuste por Distribucion de prima
   select   E.CaNumContrato
          , Total             = CaPrimaInicial
          , TotalML           = CaPrimaInicialML
          , TotalRedondeado   = Sum( CaPrimaInicialDet )
          , TotalRedondeadoML = Sum( CaPrimaInicialDetML )
          , Dif               = CaPrimaInicial - Sum( CaPrimaInicialDet ) 
          , DifML             = CaPrimaInicialML - Sum( CaPrimaInicialDetML ) 
   into #TmpAjuste
   from CaDetContrato D, CaEncContrato E
   where     D.CaNumContrato = E.CaNumContrato
         and CaVinculacion = 'Estructura'
   group by E.CaNumContrato, E.CaPrimaInicial, E.CaPrimaInicialML     
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas Genera Ajuste' ) as Mensaje
      rollback
      RETURN 1
   end

   update CaDetContrato 
      set  CaPrimaInicialDet    = CaPrimaInicialDet + case   when CaNumEstructura = 1 then Dif else 0 end 
          , CaPrimaInicialDetML = CaPrimaInicialDetML + case when CaNumEstructura = 1 then DifML else 0 end 
      from  #TmpAjuste
      where    #TmpAjuste.CanumContrato = CaDetContrato.CaNumContrato 

   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas Actualizar Ajuste' ) as Mensaje
      rollback
      RETURN 1
   end



   -- Cambiado realizado por DMV el 29-10-2009
   -- Calculo de fecha Valuta Detalle
    UPDATE dbo.CaDetContrato
       SET CaFechaPagMon1 = CASE WHEN CaFechaPagoEjer < @Proceso THEN dbo.FN_DiasValuta( @Proceso, FM1.DiasValor, 6 )
                                                                 ELSE dbo.FN_DiasValuta( CaFechaPagoEjer, FM1.DiasValor, 6 )
                            END
         , CaFechaPagMon2 = CASE WHEN CaModalidad     = 'C'      THEN CaFechaPagMon2
                                 WHEN CaFechaPagoEjer < @Proceso THEN dbo.FN_DiasValuta( @Proceso, FM2.DiasValor, 6 )
                                                                 ELSE dbo.FN_DiasValuta( CaFechaPagoEjer, FM2.DiasValor, 6 )
                            END
      FROM CaDetContrato Det
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago  FComp  ON FComp.Codigo = Det.CaFormaPagoComp
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago  FM1    ON FM1.Codigo   = Det.CaFormaPagoMon1
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago  FM2    ON FM2.Codigo   = Det.CaFormaPagoMon2

    -- Calculo de fecha Valuta Caja
    UPDATE dbo.CaCaja 
       SET CaCajFechaPagMon1 = CASE WHEN CaCajFecPago   < @Proceso THEN dbo.FN_DiasValuta( @Proceso, FM1.DiasValor, 6 )
                                                                   ELSE dbo.FN_DiasValuta( CaCajFecPago, FM1.DiasValor, 6 )
                               END
         , CaCajFechaPagMon2 = CASE WHEN CaCajModalidad = 'C'      THEN CaCajFechaPagMon2
                                    WHEN CaCajFecPago < @Proceso   THEN dbo.FN_DiasValuta( @Proceso, FM2.DiasValor, 6 )
                                                                   ELSE dbo.FN_DiasValuta( CaCajFecPago, FM2.DiasValor, 6 )
                               END
      FROM dbo.CaCaja     Caj
           LEFT JOIN   LnkBac.BacParamSuda.dbo.Forma_de_Pago  FM1  ON FM1.Codigo = Caj.CaCajFormaPagoMon1    
           LEFT JOIN   LnkBac.BacParamSuda.dbo.Forma_de_Pago  FM2  ON FM2.Codigo = Caj.CaCajFormaPagoMon2  

   update OpcionesGeneral
   set devengo = 1
   IF @@ERROR <> 0 
   Begin
      select convert( varchar(80) , 'dbo.Sp_SumaValVertical: Problemas actualizado Opciones General' ) as Mensaje
      rollback
      RETURN 1
   end

   commit
   select convert( varchar(80) , 'Valorización OK' ) as Mensaje
   return(0)

End
GO
