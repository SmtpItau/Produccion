USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_EXCEL_PHASBUN]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CONSULTA_EXCEL_PHASBUN]  
  ( @fecha as datetime )   
 AS BEGIN         
 set nocount on          
  
-- SP_CONSULTA_EXCEL_PHASBUN '20111007'  
      
--  declare @fecha as DATETIME      
--  SELECT  @fecha =  '20120423'      
 declare @fechaAnt datetime        
    ,       @fechaProx       DATETIME              
    ,       @FechaBusquedaValorizacion       DATETIME          
    ,       @FechaBusquedaValorizacionAyer   DATETIME          
      
          
 SELECT @fechaAnt = acfecante       
       ,   @fechaProx = acfecprox      
    FROM   BactraderSuda.dbo.fechas_proceso       
 where  acfecproc = @fecha        
        
        
 IF DATEPART(MONTH,@fecha) <> DATEPART(MONTH,@fechaProx)          
 BEGIN          
  SET @FechaBusquedaValorizacion = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@fechaProx,112),1,6) + '01') --FIN DE MES (ACTUAL) HABIL O NO HABIL          
 END ELSE           
 BEGIN          
  SET @FechaBusquedaValorizacion = @fecha --FECHA HOY          
 END          
          
 IF DATEPART(MONTH,@fechaAnt) <> DATEPART(MONTH,@fecha)           
 BEGIN          
  SET @FechaBusquedaValorizacionAyer = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@fecha,112),1,6) + '01') --FIN DE MES (ANTERIOR) HABIL O NO HABIL          
 END ELSE           
 BEGIN          
  SET @FechaBusquedaValorizacionAyer = @fechaAnt          
 END          
        
 select         
  mofecpro        
 , morutcart        
 , motipcart        
 , monumdocu        
 , mocorrela        
 , monumdocuo        
 , mocorrelao        
 , monumoper        
 , motipoper        
 , motipopero        
 , moinstser        
 , momascara        
 , mocodigo        
 , moseriado        
 , mofecemi        
 , mofecven        
 , momonemi        
 , motasemi        
 , mobasemi        
 , morutemi        
 , monominal        
 , movpresen        
 , momtps        
 , momtum        
 , momtum100        
 , monumucup        
 , motir        
 , mopvp        
 , movpar        
 , motasest        
 , mofecinip        
 , mofecvenp        
 , movalinip        
 , movalvenp        
 , motaspact        
 , mobaspact        
 , momonpact        
 , moforpagi        
 , moforpagv        
 , motipobono        
 , mocondpacto        
 , mopagohoy        
 , morutcli        
 , mocodcli        
 , motipret        
 , mohora        
 , mousuario        
 , moterminal        
 , mocapitali        
 , mointeresi        
 , moreajusti        
 , movpreseni        
 , mocapitalp        
 , mointeresp        
 , moreajustp        
 , movpresenp        
 , motasant        
 , mobasant        
 , movalant        
 , mostatreg        
 , movpressb        
 , modifsb        
 , monominalp        
 , movalcomp        
 , movalcomu        
 , mointeres        
 , moreajuste        
 , mointpac        
 , moreapac        
 , moutilidad        
 , moperdida        
 , movalven        
 , mocontador        
 , monsollin        
 , moobserv        
 , moobserv2        
 , movvista        
 , movviscom        
 , momtocomi        
 , mocorvent        
 , modcv        
 , moclave_dcv        
 , mocodexceso        
 , momtoPFE        
 , momtoCCE        
 , mointermesc        
 , moreajumesc        
 , mointermesvi        
 , moreajumesvi        
 , fecha_compra_original        
 , valor_compra_original        
 , valor_compra_um_original        
 , tir_compra_original        
 , valor_par_compra_original        
 , porcentaje_valor_par_compra_original        
 , codigo_carterasuper        
 , Tipo_Cartera_Financiera        
 , Mercado        
 , Sucursal        
 , Id_Sistema        
 , Fecha_PagoMañana        
 , Laminas        
 , Tipo_Inversion        
 , Cuenta_Corriente_Inicio        
 , Cuenta_Corriente_Final        
 , Sucursal_Inicio        
 , Sucursal_Final        
 , motipoletra        
 , moreserva_tecnica1        
 , movalvenc        
 , movaltasemi        
 , moprimadesc        
 , MtoCompraPM        
 , MtoVentaPM        
 , SorteoLchr        
 , Dcrp_Confirmador        
 , Dcrp_Codigo        
 , Dcrp_Glosa        
 , Dcrp_HoraConfirm        
 , Dcrp_OperConfirm        
 , Dcrp_OpeCnvConfirm        
 , moTirTran   
 , moPvpTran      
 , moVPTran        
 , moDifTran_MO        
 , moDifTran_CLP        
 , moDigitador        
 into #Ventas        
  from bactradersuda..mdmo         
 where 1 = 2        
        
 if @fecha <> ( select acfecproc from BacTradersuda..mdac )        
  insert into #Ventas         
   select         
    mofecpro     
   , morutcart        
   , motipcart        
   , monumdocu        
   , mocorrela        
   , monumdocuo        
   , mocorrelao        
   , monumoper        
   , motipoper        
   , motipopero        
   , moinstser        
   , momascara        
   , mocodigo        
   , moseriado        
   , mofecemi        
   , mofecven        
   , momonemi        
   , motasemi        
   , mobasemi        
   , morutemi        
   , monominal        
   , movpresen        
   , momtps        
   , momtum        
   , momtum100        
   , monumucup        
   , motir        
   , mopvp        
   , movpar        
   , motasest        
   , mofecinip        
   , mofecvenp        
   , movalinip        
   , movalvenp        
   , motaspact        
   , mobaspact        
   , momonpact        
   , moforpagi        
   , moforpagv        
   , motipobono        
   , mocondpacto        
   , mopagohoy        
   , morutcli        
   , mocodcli        
   , motipret        
   , mohora        
   , mousuario        
   , moterminal        
   , mocapitali        
   , mointeresi        
   , moreajusti        
   , movpreseni        
   , mocapitalp        
   , mointeresp        
   , moreajustp        
   , movpresenp        
   , motasant        
   , mobasant        
   , movalant        
   , mostatreg        
   , movpressb        
   , modifsb        
   , monominalp        
   , movalcomp        
   , movalcomu        
   , mointeres        
   , moreajuste        
   , mointpac        
   , moreapac        
   , moutilidad        
   , moperdida        
   , movalven        
   , mocontador        
   , monsollin        
   , moobserv        
   , moobserv2        
   , movvista        
   , movviscom        
   , momtocomi        
   , mocorvent        
   , modcv        
   , moclave_dcv        
   , mocodexceso        
   , momtoPFE        
   , momtoCCE        
   , mointermesc        
   , moreajumesc        
   , mointermesvi        
   , moreajumesvi        
   , fecha_compra_original        
   , valor_compra_original        
   , valor_compra_um_original        
   , tir_compra_original        
   , valor_par_compra_original        
   , porcentaje_valor_par_compra_original        
   , codigo_carterasuper        
   , Tipo_Cartera_Financiera        
   , Mercado        
   , Sucursal        
   , Id_Sistema        
   , Fecha_PagoMañana        
   , Laminas        
   , Tipo_Inversion        
   , Cuenta_Corriente_Inicio        
   , Cuenta_Corriente_Final        
   , Sucursal_Inicio        
   , Sucursal_Final        
   , motipoletra        
   , moreserva_tecnica1        
   , movalvenc        
   , movaltasemi        
   , moprimadesc        
   , MtoCompraPM        
   , MtoVentaPM        
   , SorteoLchr        
   , Dcrp_Confirmador        
   , Dcrp_Codigo        
   , Dcrp_Glosa        
   , Dcrp_HoraConfirm        
   , Dcrp_OperConfirm        
   , Dcrp_OpeCnvConfirm        
   , moTirTran        
   , moPvpTran        
   , moVPTran        
   , moDifTran_MO        
   , moDifTran_CLP        
   , moDigitador        
  from BacTradersuda..MDMH where MoTipoper in ( 'VP'/*, 'VI'*/ ) and mofecpro = @fecha        
  and mostatreg <> 'A'    
  and Fecha_PagoMañana <> @fechaProx   
 else        
  insert into #ventas        
  select         
    mofecpro        
   , morutcart        
   , motipcart        
   , monumdocu        
   , mocorrela        
   , monumdocuo        
   , mocorrelao        
   , monumoper        
   , motipoper        
   , motipopero        
   , moinstser        
   , momascara        
   , mocodigo        
   , moseriado        
   , mofecemi        
   , mofecven        
   , momonemi        
   , motasemi        
   , mobasemi        
   , morutemi        
   , monominal        
   , movpresen      
   , momtps      
   , momtum    
   , momtum100        
   , monumucup        
   , motir        
   , mopvp        
   , movpar        
   , motasest        
   , mofecinip        
   , mofecvenp        
   , movalinip        
   , movalvenp        
   , motaspact        
   , mobaspact        
   , momonpact        
   , moforpagi        
   , moforpagv        
   , motipobono        
   , mocondpacto        
   , mopagohoy        
   , morutcli        
   , mocodcli        
   , motipret        
   , mohora        
   , mousuario        
   , moterminal        
   , mocapitali        
   , mointeresi        
   , moreajusti        
   , movpreseni        
   , mocapitalp        
   , mointeresp        
   , moreajustp        
   , movpresenp  
   , motasant        
   , mobasant        
   , movalant        
   , mostatreg        
   , movpressb        
   , modifsb        
   , monominalp        
   , movalcomp        
   , movalcomu        
   , mointeres        
   , moreajuste        
   , mointpac        
   , moreapac        
   , moutilidad        
   , moperdida        
   , movalven        
   , mocontador        
   , monsollin        
   , moobserv        
   , moobserv2        
   , movvista        
   , movviscom        
   , momtocomi        
   , mocorvent        
   , modcv        
   , moclave_dcv        
   , mocodexceso        
   , momtoPFE        
   , momtoCCE        
   , mointermesc        
   , moreajumesc        
   , mointermesvi        
   , moreajumesvi        
   , fecha_compra_original        
   , valor_compra_original        
   , valor_compra_um_original        
   , tir_compra_original        
   , valor_par_compra_original        
   , porcentaje_valor_par_compra_original        
   , codigo_carterasuper        
   , Tipo_Cartera_Financiera        
   , Mercado        
   , Sucursal        
   , Id_Sistema        
   , Fecha_PagoMañana        
   , Laminas        
   , Tipo_Inversion        
   , Cuenta_Corriente_Inicio        
   , Cuenta_Corriente_Final        
   , Sucursal_Inicio        
   , Sucursal_Final        
   , motipoletra        
   , moreserva_tecnica1        
   , movalvenc        
   , movaltasemi        
   , moprimadesc        
   , MtoCompraPM        
   , MtoVentaPM        
   , SorteoLchr        
   , Dcrp_Confirmador        
   , Dcrp_Codigo        
   , Dcrp_Glosa        
   , Dcrp_HoraConfirm        
   , Dcrp_OperConfirm        
   , Dcrp_OpeCnvConfirm        
   , moTirTran        
   , moPvpTran        
   , moVPTran        
   , moDifTran_MO        
   , moDifTran_CLP        
   , moDigitador        
   from BacTradersuda..MDMO where MoTipoper in ( 'VP'/*, 'VI'*/ )        
   and mostatreg <> 'A'      
  
-- SELECT  '#ventas', motipoper,monominal,*  FROM #ventas      
        
 SELECT         
     MDRS.rsinstser        
   , MDRS.rsfeccomp        
   , MDRS.rsfecvcto        
   , rsnominal = MDRS.rsnominal         
   , MDRS.rstir        
   , MDRS.rsvalcomp        
   , rsinteres = MDRS.rsinteres         
   , rsreajuste = MDRS.rsreajuste         
   , MDRS.rsnumoper        
   , MDRS.rscorrela        
   , VIEW_INSTRUMENTO.inserie        
   , VIEW_EMISOR.emnombre        
   , valor_presente = VALORIZACION_MERCADO.valor_presente         
   , VALORIZACION_MERCADO.tasa_mercado         
   , valor_mercado = VALORIZACION_MERCADO.valor_mercado         
   , diferencia_mercado = VALORIZACION_MERCADO.diferencia_mercado         
   , VALORIZACION_MERCADO.codigo_carterasuper        
   , MDRS.rstipcart        
   , VALORIZACION_MERCADO.tipo_operacion        
         , MONEDA.mnnemo      
         , MDRS.rsnumdocu         
         , HayOperDia = '  ' --isnull( Mov.motipoper , 'NO' )                 
   , TotalVenta = 10000000000.0000 * 0.0000           
                 
 INTO #Temp_mdrs        
 FROM bactradersuda.dbo.MDRS MDRS        
    , bactradersuda.dbo.VALORIZACION_MERCADO VALORIZACION_MERCADO        
    , Baclineas.dbo.VIEW_EMISOR VIEW_EMISOR        
    , bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO        
       , bacparamsuda.dbo.MONEDA      
      
           
 WHERE VALORIZACION_MERCADO.rut_emisor = VIEW_EMISOR.emrut         
   AND VALORIZACION_MERCADO.rmnumoper = MDRS.rsnumoper    --- ??????         
   AND VALORIZACION_MERCADO.rmcorrela = MDRS.rscorrela         
   AND MDRS.rscodigo = VIEW_INSTRUMENTO.incodigo         
   AND VALORIZACION_MERCADO.rmcodigo = VIEW_INSTRUMENTO.incodigo         
   AND MDRS.rsmonemi = MONEDA.mncodmon         
   AND MDRS.rsnumdocu = VALORIZACION_MERCADO.rmnumdocu    -- ?????        
   AND MDRS.rscodigo = VALORIZACION_MERCADO.rmcodigo              
   AND MDRS.rsrutemis = VALORIZACION_MERCADO.rut_emisor         
   AND MDRS.rsrutemis = VIEW_EMISOR.emrut         
   AND ((VALORIZACION_MERCADO.fecha_valorizacion=@FechaBusquedaValorizacionAyer)       
   AND (VIEW_EMISOR.emrut<>97023000)         
   AND (MDRS.rsfecha= @fecha)  -- ?         
   AND (MDRS.rscartera In ('114','111'))         
   AND (MDRS.rstipoper='DEV'))        
   
  
          
  -- SELECT 'DEBUG ANTES', TotalVenta, rsnominal, tipo_operacion,rsnumdocu, rsCorrela,rsinteres, rsreajuste, valor_presente, valor_mercado, diferencia_mercado , rsvalcomp FROM #mdrs        
/*  
  SELECT 'DEBUG ANTES #Temp_mdrs'  
   , rsinstser        
   , rsfeccomp        
   , rsfecvcto        
   , rsnominal  
   , rstir        
   , rsvalcomp        
   , rsinteres  
   , rsreajuste  
   , rsnumoper        
   , rscorrela        
   , inserie        
   , emnombre        
   , valor_presente  
   , tasa_mercado         
   , valor_mercado  
   , diferencia_mercado  
   , codigo_carterasuper        
   , rstipcart        
   , tipo_operacion        
   , mnnemo      
   , rsnumdocu         
   , HayOperDia   
   , TotalVenta   
FROM #Temp_mdrs  
  
*/  
  
select     rsinstser  
         , rsfeccomp  
         , rsfecvcto   
         , rsnominal = SUM(rsnominal)  
         , rstir    
         , rsvalcomp = SUM(rsvalcomp)  
         , rsinteres = SUM(rsinteres)   
         , rsreajuste = SUM(rsreajuste)  
         , rsnumoper  = MIN(rsnumoper)  
         , rscorrela  = MIN(rscorrela)  
         , inserie  
         , emnombre  
         , valor_presente = SUM(valor_presente)  
         , tasa_mercado   
         , valor_mercado = SUM(valor_mercado)  
         , diferencia_mercado = SUM(diferencia_mercado)  
         , codigo_carterasuper   
         , rstipcart  
         , tipo_operacion  = 'CP'  
         , mnnemo  
         , rsnumdocu  
         , HayOperDia  
         , TotalVenta = SUM(TotalVenta)       
         , Contador = count(1)  
           
  into #mdrs_agrupada   
  from #Temp_mdrs  
  group by rsinstser  
         , rsfeccomp  
         , rsfecvcto   
         , rstir                      
         , inserie  
         , emnombre  
         , tasa_mercado  
         , codigo_carterasuper  
         , rstipcart           
         , mnnemo  
         , rsnumdocu  
         , HayOperDia  
     
  
 SELECT    rsinstser  
   , rsfeccomp  
   , rsfecvcto  
   , rsnominal  
   , rstir  
   , rsvalcomp  
   , rsinteres  
   , rsreajuste  
   , rsnumoper  
   , rscorrela  
   , inserie  
   , emnombre  
   , valor_presente  
   , tasa_mercado  
   , valor_mercado  
   , diferencia_mercado  
   , codigo_carterasuper  
   , rstipcart  
   , tipo_operacion  
   , mnnemo  
   , rsnumdocu  
   , HayOperDia  
   , TotalVenta  
            , Contador  
    INTO #mdrs  
 FROM #mdrs_agrupada  
  
       
 UPDATE #mdrs  
  SET   TotalVenta = isnull( ( select SUM( Mov.MoNominal )        
           FROM #Ventas Mov                    
           WHERE rsnumdocu = Mov.MoNumDocuo        
           and  rsCorrela = Mov.MoCorrela        
             ), 0.0 )        
   
                
-- SELECT 'DEBUG DESPUES', TotalVenta, rsnominal,tipo_operacion,rsnumdocu, rsCorrela, rsinteres, rsreajuste, valor_presente, valor_mercado, diferencia_mercado , rsvalcomp FROM #mdrs        
        
 UPDATE #MDRS         
  SET   rsnominal = rsnominal - TotalVenta         
  ,  rsinteres = rsInteres * ( 1.0 - totalVenta / rsnominal  )        
  ,  rsreajuste = rsreajuste * ( 1.0 - totalVenta / rsnominal  )        
  ,  valor_presente = valor_presente * ( 1.0 - totalVenta / rsnominal  )        
  ,  valor_mercado  = valor_mercado  * ( 1.0 - totalVenta / rsnominal  )        
  ,  diferencia_mercado = diferencia_mercado * ( 1.0 - totalVenta / rsnominal )        
  ,  rsvalcomp  = rsvalcomp * ( 1.0 - totalVenta / rsnominal )         
  ,  HayOperDia  = ( case when TotalVenta <> 0 then 'Si' else 'No' end )        
  
  
-- SELECT  '#mdrs',*  FROM  #mdrs  
  
 SELECT         
     'Nemotécnico' = rsinstser        
   , 'Fecha Compra' = rsfeccomp        
   , 'Fecha Vcto'   = rsfecvcto        
   , 'Nominal'      = rsnominal         
   , 'Tasa Compra'  = rstir        
   , 'Compra Capital' = rsvalcomp        
   , 'Interes Diario' = rsinteres         
   , 'Reajuste Diario' =rsreajuste         
   , 'N°Oper'    = rsnumoper           
   , 'Correlativo' = rscorrela        
   , 'Serie'     = inserie        
   , 'Nombre Emisor' = emnombre        
   , 'Valor Pte.'  = valor_presente         
   , 'Tasa Merc.' = tasa_mercado         
   , 'Valor Merc.' = valor_mercado         
   , 'MktoM' = diferencia_mercado         
   , 'Cartera Super' = codigo_carterasuper        
   , 'Cartra Financiera'= rstipcart        
   , 'Pacto o No' = tipo_operacion        
   , 'Moneda'     = mnnemo       
   , 'HayOperDia' = HayOperDia           
   , 'TotalVenta' = TotalVenta         
   , 'N°Docu'   = rsnumdocu         
   , 'Agrupadas' = Contador                  
                  
 from #MDRS      --WHERE rsinstser LIKE '%PDBC%' -- cam         
 ORDER BY rsnumdocu, rscorrela        
        
 -- SELECT 'DEBUG Despues', TotalVenta,  rsnominal, rsinteres, rsreajuste, valor_presente, valor_mercado, diferencia_mercado , rsvalcomp FROM #mdrs        
        
 drop table #Ventas        
 drop table #mdrs        
 drop table #mdrs_agrupada  
 drop table #Temp_mdrs  
      
  
END
GO
