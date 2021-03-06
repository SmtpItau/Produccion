USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_EXCEL_PHASBUN_BACINVEX]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CONSULTA_EXCEL_PHASBUN_BACINVEX]     
  ( @fecha as datetime )      
 AS BEGIN      
 set nocount on      
    
--  SP_CONSULTA_EXCEL_PHASBUN_BACINVEX '20111006'      
    
--  declare @fecha as DATETIME    
--  SELECT  @fecha =  '20120301'    
    declare @fechaAnt   DATETIME           
    ,       @fechaProc   DATETIME           
    ,       @fechaProx       DATETIME            
    ,       @FechaBusquedaValorizacion       DATETIME        
    ,       @FechaBusquedaValorizacionAyer   DATETIME        
    
        
    SELECT @fechaAnt = acfecante    
       ,   @fechaProc = acfecproc  
       ,   @fechaProx = acfecprox    
    FROM   BacBonosExtSuda.dbo.text_arc_ctl_dri   
    WHERE  acfecproc = @fecha      
      
    
  IF @fecha = @fechaProc and isnull((SELECT 1 FROM  text_rsu  where  rsfecpro = @fecha ), 0 ) <> 1  
    SET @fecha = @fechaAnt  
       
      
  
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
, monumoper  
, monumdocu  
, mocorrelativo  
, motipoper  
, cod_nemo  
, cod_familia  
, id_instrum  
, morutcli  
, mocodcli  
, mofecemi  
, mofecven  
, mofecneg  
, momonemi  
, momonpag  
, momontoemi  
, motasemi  
, mobasemi  
, morutemi  
, mofecpago  
, monominal  
, movpresen  
, movalvenc  
, momtps  
, momtum  
, motir  
, mopvp  
, movpar  
, moint_compra  
, moprincipal  
, movalcomp  
, movalcomu  
, mointeres  
, moreajuste  
, moutilidad  
, moperdida  
, movalven  
, monumucup  
, monumpcup  
, mousuario  
, mostatreg  
, moobserv  
, basilea  
, tipo_tasa  
, encaje  
, monto_encaje  
, codigo_carterasuper  
, tipo_cartera_financiera  
, sucursal  
, corr_bco_nombre  
, corr_bco_cta  
, corr_bco_aba  
, corr_bco_pais  
, corr_bco_ciud  
, corr_bco_swift  
, corr_bco_ref  
, corr_cli_nombre  
, corr_cli_cta  
, corr_cli_aba  
, corr_cli_pais  
, corr_cli_ciud  
, corr_cli_swift  
, corr_cli_ref  
, operador_contraparte  
, operador_Banco  
, calce  
, tipo_inversion  
, para_quien  
, nombre_custodia  
, confirmacion  
, forma_pago  
, base_tasa  
, cod_emi  
, mofecucup  
, mofecpcup  
, mohoraop  
, cusip  
, CapitalPeso  
, InteresPeso  
, SwImpresion  
, movpressb  
, modifsb  
, Hora  
, DurMacaulay  
, DurModificada  
, Convexidad  
, Id_Area_Responsable  
, Id_Libro  
, moDigitador  
into #Ventas        
from text_mvt_dri  
where 1 = 2      
  
  
  insert into #Ventas    
  select  
   mofecpro  
, morutcart  
, monumoper  
, monumdocu  
, mocorrelativo  
, motipoper  
, cod_nemo  
, cod_familia  
, id_instrum  
, morutcli  
, mocodcli  
, mofecemi  
, mofecven  
, mofecneg  
, momonemi  
, momonpag  
, momontoemi  
, motasemi  
, mobasemi  
, morutemi  
, mofecpago  
, monominal  
, movpresen  
, movalvenc  
, momtps  
, momtum  
, motir  
, mopvp  
, movpar  
, moint_compra  
, moprincipal  
, movalcomp  
, movalcomu  
, mointeres  
, moreajuste  
, moutilidad  
, moperdida  
, movalven  
, monumucup  
, monumpcup  
, mousuario  
, mostatreg  
, moobserv  
, basilea  
, tipo_tasa  
, encaje  
, monto_encaje  
, codigo_carterasuper  
, tipo_cartera_financiera  
, sucursal  
, corr_bco_nombre  
, corr_bco_cta  
, corr_bco_aba  
, corr_bco_pais  
, corr_bco_ciud  
, corr_bco_swift  
, corr_bco_ref  
, corr_cli_nombre  
, corr_cli_cta  
, corr_cli_aba  
, corr_cli_pais  
, corr_cli_ciud  
, corr_cli_swift  
, corr_cli_ref  
, operador_contraparte  
, operador_Banco  
, calce  
, tipo_inversion  
, para_quien  
, nombre_custodia  
, confirmacion  
, forma_pago  
, base_tasa  
, cod_emi  
, mofecucup  
, mofecpcup  
, mohoraop  
, cusip  
, CapitalPeso  
, InteresPeso  
, SwImpresion  
, movpressb  
, modifsb  
, Hora  
, DurMacaulay  
, DurModificada  
, Convexidad  
, Id_Area_Responsable  
, Id_Libro  
, moDigitador  
from text_mvt_dri  
where mofecpro = @fecha  
and   MoTipoper in ( 'VP')  
and   mostatreg <> 'A' 
   
  
  
  SELECT       
     rsinstser = C.cod_nemo    
   , rsfeccomp = C.rsfeccomp      
   , rsfecvcto = C.rsfecvcto    
   , rsnominal = C.rsnominal      
   , rstir     = C.rstir  
   , rsvalcomp = C.rsvalcomu     
   , rsinteres = C.rsinteres  
   , rsreajuste = C.rsreajuste     
   , rsnumoper  = C.rsnumoper     
   , rscorrela  = C.rscorrelativo      
   , inserie    = C.id_instrum     
   , emnombre   = E.emnombre      
   , valor_presente = C.rsvppresen      
   , tasa_mercado   = C.rstirmerc  
   , valor_mercado = C.rsvalmerc    
   , diferencia_mercado = (C.rsvppresen - C.rstirmerc)       
   , codigo_carterasuper = ltrim( rtrim( C.codigo_carterasuper ) ) + '/' + LTRIM(RTRIM(cNorma.tbglosa))  
   , rstipcart = ltrim( rtrim( C.Tipo_Cartera_Financiera ) ) + '/' + LTRIM(RTRIM(cFinan.tbglosa))     
   , tipo_operacion = C.rstipoper  
   , mnnemo   =  M.mnnemo  
   , rsnumdocu = C.rsnumdocu       
   , HayOperDia = '  ' --isnull( Mov.motipoper , 'NO' )               
   , TotalVenta = 10000000000.0000 * 0.0000      
      
               
  INTO #mdrs      
 FROM BacBonosExtSuda..text_rsu C   INNER JOIN BacBonosExtSuda..VIEW_EMISOR E  ON C.rsrutemis = E.emrut   
                                    INNER JOIN BacParamSuda..MONEDA M          ON C.rsmonemi = M.mncodmon  
    , BacParamSuda..TABLA_GENERAL_DETALLE cNorma   
    , BacParamSuda..TABLA_GENERAL_DETALLE cFinan       
 WHERE  C.rsfecpro  = @fecha  
   AND  cNorma.tbcateg = 1111 AND codigo_carterasuper = cNorma.tbcodigo1  
   AND  cFinan.tbcateg = 204  AND C.Tipo_Cartera_Financiera = cFinan.tbcodigo1  
  
     
  
 -- SELECT 'DEBUG ANTES', TotalVenta, rsnominal, rsinteres, rsreajuste, valor_presente, valor_mercado, diferencia_mercado , rsvalcomp FROM #mdrs      
      
 UPDATE #MDRS       
  SET   TotalVenta = isnull( ( select SUM( Mov.MoNominal )      
  FROM #Ventas Mov                  
  WHERE rsnumdocu = monumdocu   
  and  rsCorrela =  mocorrelativo), 0.0 )      
    
  
  UPDATE #MDRS       
  SET   rsvalcomp  =  Mov.movpresen   
      , tipo_operacion   = Mov.motipoper   
  FROM text_mvt_dri Mov                  
  WHERE rsnumdocu = monumdocu   
  and  rsCorrela =  mocorrelativo  
  and  rsfeccomp =  mofecpro           
      
 UPDATE #MDRS       
  SET   rsnominal = rsnominal - TotalVenta       
  ,  rsinteres = rsInteres * ( 1.0 - totalVenta / rsnominal  )      
  ,  rsreajuste = rsreajuste * ( 1.0 - totalVenta / rsnominal  )      
  ,  valor_presente = valor_presente * ( 1.0 - totalVenta / rsnominal  )      
  ,  valor_mercado  = valor_mercado  * ( 1.0 - totalVenta / rsnominal  )      
  ,  diferencia_mercado = diferencia_mercado * ( 1.0 - totalVenta / rsnominal )      
  ,  rsvalcomp  = rsvalcomp * ( 1.0 - totalVenta / rsnominal )       
  ,  HayOperDia  = ( case when TotalVenta <> 0 then 'Si' else 'No' end )      
      
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
               
                
 from #MDRS        
 ORDER BY rsnumdocu, rscorrela      
      
 -- SELECT 'DEBUG Despues', TotalVenta,  rsnominal, rsinteres, rsreajuste, valor_presente, valor_mercado, diferencia_mercado , rsvalcomp FROM #mdrs      
      
 drop table #Ventas      
 drop table #mdrs      
    
END  
GO
