USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSINTER_MODIFICACIONES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DATOSINTER_MODIFICACIONES]
   (   @cfecha CHAR(8)   )
AS
BEGIN

   SET NOCOUNT ON

/*
   SP_DATOSINTER_MODIFICACIONES '20111209'
   SP_DATOSINTER_MODIFICACIONES '20111213'
   SP_DATOSINTER '20111207'
*/
/*
   DECLARE @cfecha      CHAR(8)
   SELECT  @cfecha = '20111205' -- '20121003'
*/



   DECLARE @ntot1r      FLOAT
   DECLARE @ntot2e      FLOAT
   DECLARE @ntot3r      FLOAT
   DECLARE @ntot4e      FLOAT
   DECLARE @ncantop     NUMERIC(6,0)
   DECLARE @nTotSwap    NUMERIC(6,0)
   DECLARE @nTotOpc     NUMERIC(6,0)
   DECLARE @cfecproc    CHAR(10)
   DECLARE @ccodbcch    NUMERIC(3,0)
   DECLARE @ncantopOPC  NUMERIC(6,0)  
   DECLARE @ncantopSWAP NUMERIC(6,0)  
   DECLARE @nrutprop    NUMERIC(9)  
   DECLARE @cdigprop    CHAR(1)  

   DECLARE @compra_amortiza  FLOAT,
           @compra_interes   FLOAT, 
           @venta_amortiza   FLOAT,
           @venta_interes    FLOAT,
           @compra_moneda    FLOAT,
           @venta_moneda     FLOAT,
           @venta_valor_tasa FLOAT

  declare @TotSwapRecibe     FLOAT
  declare @TotSwapPaga       FLOAT
  declare @TotOptRecibe      FLOAT
  declare @TotOptPaga        FLOAT

  declare @FLoatCero         FLOAT
  declare @DoObs	     FLOAT	
  select  @FLoatCero = 0.0
  select  @DoObs = 0.0

  select  @nrutprop = acrutprop    ,  
          @cdigprop = acdigprop            
  FROM   mfac      


  select @DoObs = vmvalor  
  from BacParamSuda..Valor_Moneda    
  where vmFecha =@cfecha  
  And   vmcodigo =994


    SELECT vmfecha, vmcodigo, vmvalor
    INTO #VALOR_MONEDA
    FROM BacParamSuda..VALOR_MONEDA
    WHERE vmFecha    = @cfecha

    INSERT INTO #VALOR_MONEDA
    SELECT @cfecha, 999, 1.0

    INSERT INTO #VALOR_MONEDA
    SELECT @cfecha, 13, @DoObs


   SELECT @cfecproc = CONVERT(CHAR(8), acfecproc, 112), @ccodbcch = accodbcch
   FROM   MFAC

   SELECT 'CANTOPERA'       = 0 ,   --@ncantop           ,
          'TOTENT'          = CONVERT(FLOAT,0.0)   , --@ntot2e + @ntot4e  ,
          'TOTREC'          = CONVERT(FLOAT,0.0)   , --@ntot1r + @ntot3r  ,
          'FECHAPROC'       = @cfecha                       ,
          'RUTPROP'         = acrutprop                       ,
          'DIGPROP'         = acdigprop                       ,
          'FECHAINI'        = CONVERT(CHAR(8), cafecha,112)   ,
          'FECHAFIN'        = CONVERT(CHAR(8), cafecvcto,112) ,
          'catipoper'       = catipoper                       ,
          'camtomon1'       = camtomon1                       ,
          'camtomon2'       = camtomon2                       ,
          'RUTCLI'          = ISNULL( CASE WHEN a.clpais=acpais then cacodigo else a.clrutcliexterno END , 0 ) ,
          'DIGCLI'          = ISNULL( CASE WHEN a.clpais=acpais then a.cldv   else a.cldvcliexterno  END , 0 ) ,
          'NOMCLI'          = a.clnombre       ,
          'NUMOPER'         = CONVERT (NUMERIC(8),canumoper)  ,
          'plazo'           = caplazo                         ,
          'catipmoda'       = catipmoda                       ,
          'CODMREC'   = CASE WHEN catipoper = 'C'
                             THEN cacodmon1
                                   ELSE cacodmon2
                              END                             ,
          'CODMENT'   = CASE WHEN catipoper = 'C'
                             THEN cacodmon2
                                   ELSE cacodmon1 
                              END                             ,
          'MTOREC'          = CASE WHEN catipoper = 'C' THEN camtomon1
                                   ELSE  CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END
                              END                              ,
          'MTOENT'          = CASE WHEN catipoper = 'C' THEN CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END
                                   ELSE camtomon1
                              END             ,
      'CAPREMON1'       = Case when CaCodpos1 = 14 then CaPreMon1 else catipcamSpot end , --> capremon1,
          'PRECIOFUT'= CASE WHEN cacodpos1 = 1
                             THEN CASE WHEN cacodmon2 = 999
                                      THEN caparmon2
                                      ELSE caprecal
                                     END 
                            WHEN  cacodpos1 = 14 THEN 0.0
                                   ELSE caparmon2
                              END                              ,
          'CODBCCH'         = @ccodbcch  ,
          'CodigoIns'       = caoperrelaspot       ,  --'01'  ,
          'SectorEconomico' = a.clactivida ,
          'Prima'           = CONVERT(FLOAT,0.0)   ,               
	      'Flujos_SwapCCS'  = 0	   , 
          'Modulo'          = 'BFW',
          'Marca'           = 'M'            
   INTO   #tmp
   FROM   MFCA, MFAC , VIEW_CLIENTE a
   WHERE  @cfecha = CONVERT(CHAR(8),cafecha,112) 
     AND  cacodpos1 IN(1,2,12,11,14) -->RTG  JUNIO 2010                            -->CS
     AND (cacodigo = a.clrut and cacodcli = a.clcodigo) 
     AND  NumeroContratoCliente = 0                    -- MAP 20071106 Descarta operaciones Anticipo

   DELETE #TMP

   IF (@ncantop + @ncantopOPC + @ncantopSWAP) = 0 
   BEGIN   
   SELECT 'VACIO'     ='Vacio'                          ,
          'RUTPROP'   = acrutprop                       ,
          'DIGPROP'   = acdigprop                       ,
          'FECHAPROC' = @cfecproc                       ,
          'CODBCCH'   = @ccodbcch
   FROM   MFAC
   END
   ELSE
   BEGIN

-->> ********************************************************* <<--
-->>				 INICIO BLOQUE MODIFICACIONES FORWARD	   <<--
-->> ********************************************************* <<--


 INSERT INTO  #TMP            
 SELECT       'CANTOPERA' = 0   ,
              'TOTENT'    = 0.0 ,
              'TOTREC'    = 0.0 ,
              'FECHAPROC' = @cfecha       ,
              'RUTPROP'   = @nrutprop     ,
              'DIGPROP'   = @cdigprop	  ,
              'FECHAINI'  = CONVERT(CHAR(8), a.cafecha,112)   ,
              'FECHAFIN'  = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN CONVERT(CHAR(08),'',112) ELSE CONVERT(CHAR(08),e.cafecvcto,112) END, 	
			  'catipoper' = a.catipoper   ,  
              'camtomon1' = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1 then  0 else e.camtomon1 End  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else e.camtomon2 End          
                                  End ,  --a.camtomon1   ,

              'camtomon2' = Case a.catipoper when 'V' then   
                                       case  when a.camtomon1 = e.camtomon1 then 0 else e.camtomon1 End  
                                  Else   
                                       case  when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then 0.0 else e.camtomon2 End  
                                  End ,    -- a.camtomon2   ,
              'RUTCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then a.cacodigo else b.clrutcliexterno END , 0 ) ,  --a.cacodigo , --
              'DIGCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then b.cldv   else b.cldvcliexterno  END , '' ) ,  --b.cldv     , --           
              'NOMCLI'    = b.clnombre                      ,
              'NUMOPER'   = CONVERT (NUMERIC(8),a.canumoper),
              'plazo'     = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,a.cafecha, e.cafecvcto) END, 	
              'catipmoda' = Case  when a.catipmoda = e.catipmoda then ' ' else e.catipmoda end     , --a.catipmoda                     ,
			  'CODMREC'   = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,
			  'CODMENT'   = Case a.catipoper when 'V' then  
                                       case  when a.cacodmon1 = e.cacodmon1 then 0 else e.cacodmon1 End  
                                  Else     
                                       case  when a.cacodmon2 = e.cacodmon2 then 0 else e.cacodmon2 End       
                                  End, 
			  'MTOREC'    = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1 then  0.0 else e.camtomon1 End  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else e.camtomon2 End          
                                  End ,  
			  'MTOENT'   =  Case a.catipoper when 'V' then   
                                       case  when a.camtomon1 = e.camtomon1 then 0.0 else e.camtomon1 End  
                                  Else   
                                       case  when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then 0 else e.camtomon2 End  
                                  End ,    
			  'CAPREMON1' = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end   ,
                                    
			  'PRECIOFUT' = Case  when a.caprecal  = e.caprecal  then  0  else e.caprecal  end   ,                          

			  'CODBCCH'         = @ccodbcch      ,
              'CodigoIns'       = '00' , --e.caoperrelaspot ,  --'01'  ,
              'SectorEconomico' = 0 , -- b.clactivida   ,
              'Prima'           = 0.0 ,
	          'Flujos_SwapCCS'  = 0	  ,
              'Modulo'          = 'BFW',
              'Marca'           = 'M'                
  FROM  MFCA_LOG a with (nolock)        
  INNER JOIN BacParamSuda.dbo.cliente b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )     
  INNER JOIN BacParamSuda.dbo.Moneda  c with (nolock) ON   a.cacodmon1 = c.mncodmon  
  INNER JOIN BacParamSuda.dbo.Moneda  d with (nolock) ON   a.cacodmon2 = d.mncodmon  
  INNER JOIN mfca   e with (nolock) ON   a.canumoper  = e.canumoper  
  RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
        , MFAC g
  WHERE a.cafecmod   > a.cafecha  
  AND a.cafecmod   = @cfecha   
  AND a.caprimero = 'S'              
  AND a.catipoper IN ('C','V')       
  AND a.cacodpos1 IN (1,2,12,11,14) 
  AND e.NumeroContratoCliente = 0    

 UNION 
 SELECT       'CANTOPERA' = 0   ,
              'TOTENT'    = 0.0 ,
              'TOTREC'    = 0.0 ,
              'FECHAPROC' = @cfecha       ,
              'RUTPROP'   = @nrutprop     ,
              'DIGPROP'   = @cdigprop	  ,
              'FECHAINI'  = CONVERT(CHAR(8), a.cafecha,112)   ,
              'FECHAFIN'  = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN CONVERT(CHAR(08),'',112) ELSE CONVERT(CHAR(08),a.cafecvcto,112) END, 	 --a.cafecvcto
			  'catipoper' = a.catipoper   ,  


              'camtomon1' = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1 then  0 else e.camtomon1 End  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else e.camtomon2 End          
                                  End ,  --a.camtomon1   ,

              'camtomon2' = Case a.catipoper when 'V' then   
                                       case  when a.camtomon1 = e.camtomon1 then 0 else e.camtomon1 End  
                                  Else   
                                       case  when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then 0.0 else e.camtomon2 End  
                                  End ,    -- a.camtomon2   ,
   
              'RUTCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then a.cacodigo else b.clrutcliexterno END , 0 ) ,  --a.cacodigo , --
              'DIGCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then b.cldv   else b.cldvcliexterno  END , 0 ) ,  --b.cldv     , -- 
              'NOMCLI'    = b.clnombre                      ,
              'NUMOPER'   = CONVERT (NUMERIC(8),a.canumoper),
              'plazo'     = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,a.cafecha, a.cafecvcto) END, 	 --a.cafecvcto
              'catipmoda' = Case  when a.catipmoda = e.catipmoda then ' ' else e.catipmoda end     , --a.catipmoda                     ,
			  'CODMREC'   = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,
			  'CODMENT'   = Case a.catipoper when 'V' then  
                                       case  when a.cacodmon1 = e.cacodmon1 then 0 else e.cacodmon1 End  
                                  Else     
                                       case  when a.cacodmon2 = e.cacodmon2 then 0 else e.cacodmon2 End       
                                  End, 
			  'MTOREC'    = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1 then  0.0 else e.camtomon1 End  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else e.camtomon2 End          
                                  End ,  
			  'MTOENT'   =  Case a.catipoper when 'V' then   
                                       case  when a.camtomon1 = e.camtomon1 then 0.0 else e.camtomon1 End  
                                  Else   
                                       case  when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then 0 else e.camtomon2 End  
                                  End ,    
			  'CAPREMON1' = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end   ,
                                    
			  'PRECIOFUT' = Case  when a.caprecal  = e.caprecal  then  0  else e.caprecal  end   ,                          

			  'CODBCCH'         = @ccodbcch      ,
              'CodigoIns'       = '00', -- e.caoperrelaspot ,  --'01'  ,
              'SectorEconomico' = 0  , -- b.clactivida   ,
              'Prima'           = 0.0 ,
	          'Flujos_SwapCCS'  = 0	  ,
              'Modulo'          = 'BFW',
              'Marca'           = 'M'
  FROM  MFCAH a with (nolock)       
   INNER JOIN BacParamSuda.dbo.cliente b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
   INNER JOIN BacParamSuda.dbo.Moneda  c with (nolock) ON   a.cacodmon1 = c.mncodmon  
   INNER JOIN BacParamSuda.dbo.Moneda  d with (nolock) ON   a.cacodmon2 = d.mncodmon  
   INNER JOIN MFCA_LOG   e with (nolock) ON   a.canumoper  = e.canumoper  
   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
       , MFAC g
  WHERE a.cafecmod   > a.cafecha  
   AND a.cafecmod   = @cfecha   
   AND e.caprimero = 'S'              
   AND a.catipoper IN ('C','V')       
   AND a.cacodpos1 IN (1,2,12,11,14) 
   AND a.NumeroContratoCliente = 0   


   END
-->> ********************************************************* <<--
-->>		  TERMINA BLOQUE MODIFICACIONES FORWARD	           <<--
-->> ********************************************************* <<--

 /*=======================================================================*/  
--   Anticipos Forward
 /*=======================================================================*/  


   DECLARE @Fecha_ant_Habil DATETIME
   DECLARE @Fecha_Proceso   DATETIME
   SELECT  @Fecha_ant_Habil = acfecante 
        ,  @Fecha_Proceso 	= acfecproc  
   FROM mfac      

 SELECT   'CANTOPERA'       = 0 ,   --@ncantop                        ,
          'TOTENT'          = CONVERT(FLOAT,0.0)   , --@ntot2e + @ntot4e    ,
          'TOTREC'          = CONVERT(FLOAT,0.0) , --@ntot1r + @ntot3r  ,
          'FECHAPROC'       = @cfecha                       ,
          'RUTPROP'         = acrutprop                       ,
          'DIGPROP'         = acdigprop                       ,
          'FECHAINI'        = CONVERT(CHAR(8), cafecha,112)   ,
          'FECHAFIN'        = CONVERT(CHAR(8), cafecvcto,112) ,
          'catipoper'       = catipoper                       ,
          'camtomon1'       = camtomon1                       ,
          'camtomon2'       = camtomon2                       ,
          'RUTCLI'          = ISNULL( CASE WHEN a.clpais=acpais then cacodigo else a.clrutcliexterno END , 0 ) ,
          'DIGCLI'          = ISNULL( CASE WHEN a.clpais=acpais then a.cldv   else a.cldvcliexterno  END , 0 ) ,
          'NOMCLI'          = a.clnombre       ,
          'NUMOPER'         = CONVERT (NUMERIC(8),canumoper)  ,
          'plazo'           = caplazo                         ,
          'catipmoda'       = catipmoda                       ,
          'CODMREC'   = CASE WHEN catipoper = 'C'
                             THEN cacodmon1
                                   ELSE cacodmon2
                              END                             ,
          'CODMENT'   = CASE WHEN catipoper = 'C'
                             THEN cacodmon2
                                   ELSE cacodmon1 
                              END                             ,
          'MTOREC'          = CASE WHEN catipoper = 'C' THEN camtomon1
                                   ELSE  CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END
                              END , 
          'MTOENT'          = CASE WHEN catipoper = 'C' THEN CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END
                                   ELSE camtomon1
                              END                              , 
          'CAPREMON1'       = Case when CaCodpos1 = 14 then CaPreMon1 else catipcamSpot end , --> capremon1,
          'PRECIOFUT'		= CASE WHEN cacodpos1 = 1
                             THEN CASE WHEN cacodmon2 = 999
                                      THEN caparmon2
                                      ELSE caprecal
                                     END 
                            WHEN  cacodpos1 = 14 THEN 0.0
                                   ELSE caparmon2
                              END                              ,
							
          'CODBCCH'         = @ccodbcch  ,
          'CodigoIns'       = '00' , -- caoperrelaspot       ,  --'01'  ,
          'SectorEconomico' = 0 , -- a.clactivida ,
          'Prima'           = CONVERT(FLOAT, 0.0),
	      'Flujos_SwapCCS'  = 0	   , 
          'Modulo'          = 'BFW',
          'Marca'           = 'M'            
   INTO   #temp
   FROM   MFCA, MFAC , VIEW_CLIENTE a
   WHERE  @cfecha = CONVERT(CHAR(8),cafecha,112) 
     AND  cacodpos1 IN(1,2,12,11,14)
     AND (cacodigo = a.clrut and cacodcli = a.clcodigo) 
     AND  NumeroContratoCliente = 0                    

   DELETE #temp

IF  @cfecha = @Fecha_Proceso  
BEGIN
--- Anticipos Totales   
    INSERT INTO  #temp            
	SELECT    'CANTOPERA' = 0   ,
              'TOTENT'    = 0.0 ,
              'TOTREC'    = 0.0 ,
              'FECHAPROC' = @cfecha       ,
              'RUTPROP'   = @nrutprop     ,
              'DIGPROP'   = @cdigprop	  ,
              'FECHAINI'  = CONVERT(CHAR(08),ORIGINAL.cafecha  ,112) ,
              'FECHAFIN'  = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),ORIGINAL.cafecvcto,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),a.cafecvcto,112) END, 	 --CONVERT(CHAR(08),A.cafecvcto,112) ,   
			  'catipoper' = a.catipoper   , 
              'camtomon1' = Case a.catipoper when 'C' then 
								 case when a.camtomon1 = ORIGINAL.camtomon1  then  0.0 else a.camtomon1 end  
							Else 
								 case when a.camtomon2 = ORIGINAL.camtomon2 then  0.0 else a.camtomon2 end   
							End ,
              'camtomon2' = Case a.catipoper when 'V' then 
								 case  when a.camtomon1 = ORIGINAL.camtomon1 then 0.0 else a.camtomon1 end  
						    Else 
								 case  when a.camtomon2 = ORIGINAL.camtomon2 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
							End,
              'RUTCLI'    = ISNULL( CASE WHEN CLIENTE.clpais = g.acpais then a.cacodigo else CLIENTE.clrutcliexterno END , 0 ) ,  --a.cacodigo , --
              'DIGCLI'    = ISNULL( CASE WHEN CLIENTE.clpais = g.acpais then CLIENTE.cldv   else CLIENTE.cldvcliexterno  END , 0 ) ,  --b.cldv     , -- 
              'NOMCLI'    = CLIENTE.clnombre                      ,
              'NUMOPER'   = CONVERT (NUMERIC(8),a.canumoper),
              'plazo'     = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),ORIGINAL.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,ORIGINAL.cafecha, a.cafecvcto) END,
--case when a.caplazo = ORIGINAL.caplazo then 0 else a.caplazo end ,
              'catipmoda' = Case  when a.catipmoda = ORIGINAL.catipmoda then ' ' else a.catipmoda End ,
			  'CODMREC'   = case a.catipoper when ORIGINAL.catipoper then 0 else  case a.catipoper when'C' then a.cacodmon1 else a.cacodmon2 End End  ,    
			  'CODMENT'   = Case a.catipoper when 'V' then 
								   case  when a.cacodmon1 = ORIGINAL.cacodmon1 then 0 else a.cacodmon1 end  
							Else 
								   case  when a.cacodmon2 = ORIGINAL.cacodmon2 then 0 else a.cacodmon2 end       	
							End , 
			  'MTOREC'    = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = ORIGINAL.camtomon1  then  0.0 else a.camtomon1 end  
                                  Else   
                                       case when a.camtomon2 = ORIGINAL.camtomon2  or a.cacodpos1 = 14 then  0.0 else a.camtomon2 End          
                                  End ,  

			  'MTOENT'   = Case a.catipoper when 'V' then 
								case  when a.camtomon1 = ORIGINAL.camtomon1 then 0.0 else a.camtomon1 end  
						   Else 
						 		case  when a.camtomon2 = ORIGINAL.camtomon2 or a.cacodpos1 = 14 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
						   End ,
			  'CAPREMON1' = 0.0, --Case a.capremon1 when ORIGINAL.capremon1 then  0.0  else a.capremon1 end ,                                    
			  'PRECIOFUT' = 0.0, /*CASE  WHEN a.cacodpos1 = 3  THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)   
						   	  WHEN a.cacodpos1 = 13 THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)  
						      WHEN a.cacodpos1 = 11 THEN (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)  --> CS-AG  
						      WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end) ELSE (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)   END  
						     ELSE  (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end)   
				            END,*/                          

			  'CODBCCH'         = @ccodbcch      ,
              'CodigoIns'       = '00', -- a.caoperrelaspot ,  -- '01', -- e.caoperrelaspot ,  --'01'  ,
              'SectorEconomico' = 0 ,  -- CLIENTE.clactivida   ,
              'Prima'           = 0.0 ,
	          'Flujos_SwapCCS'  = 0	  ,
              'Modulo'          = 'BFW',
              'Marca'           = 'M'  

	FROM  MFCA AS a 
        , MFCARES AS ORIGINAL
		, BacParamSuda..MONEDA AS MONEDA1
		, BacParamSuda..MONEDA AS MONEDA2
		, BacParamSuda..MONEDA AS MONEDACOMP
		, VIEW_CLIENTE AS CLIENTE
        , view_pais  e  
        , MFAC g 
	WHERE a.cafecvcto      =  @cfecha -- @Fecha_usuario 
	AND   a.caantici       = 'A'
	AND   MONEDA1.MnCodMon     = a.CaCodMon1	
	AND   MONEDA2.MnCodMon     = a.CaCodMon2	
	AND   MONEDACOMP.MnCodMon  = a.Moneda_Compensacion
	AND   a.CaCodigo       = CLIENTE.ClRut
	AND   a.CaCodCli       = CLIENTE.ClCodigo     
	AND   ORIGINAL.CaFechaProceso = @Fecha_ant_Habil 
    AND   a.NumeroContratoCliente <> 0 
	AND   ORIGINAL.Canumoper    = a.NumeroContratoCliente
    AND   a.Canumoper           = a.NumeroContratoCliente 
    AND   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais  
    ORDER BY A.NumeroContratoCliente
 
--- Anticipos Parciales  
--- Saldo    
    SELECT a.canumoper
         , a.cafecvcto
         , a.NumeroContratoCliente  
    INTO #AntParcialSaldo
	FROM  MFCA AS a 
        , MFCARES AS ORIGINAL
		, BacParamSuda..MONEDA AS MONEDA1
		, BacParamSuda..MONEDA AS MONEDA2
		, BacParamSuda..MONEDA AS MONEDACOMP
		, VIEW_CLIENTE AS CLIENTE
        , view_pais  e  
	WHERE a.cafecvcto      =  @cfecha -- @Fecha_usuario 
	AND   a.caantici       = 'A'
	AND   MONEDA1.MnCodMon     = a.CaCodMon1	
	AND   MONEDA2.MnCodMon     = a.CaCodMon2	
	AND   MONEDACOMP.MnCodMon  = a.Moneda_Compensacion
	AND   a.CaCodigo       = CLIENTE.ClRut
	AND   a.CaCodCli       = CLIENTE.ClCodigo     
	AND   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
    AND   a.NumeroContratoCliente <> 0
	AND   ORIGINAL.Canumoper      = a.NumeroContratoCliente
    AND   a.Canumoper             <> a.NumeroContratoCliente 
    AND   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais  
    ORDER BY A.NumeroContratoCliente


 
	 INSERT INTO  #temp            
	 SELECT   'CANTOPERA' = 0   ,
              'TOTENT'    = 0.0 ,
              'TOTREC'    = 0.0 ,
              'FECHAPROC' = @cfecha       ,
              'RUTPROP'   = @nrutprop     ,
              'DIGPROP'   = @cdigprop	  ,
              'FECHAINI'  = CONVERT(CHAR(08),a.cafecha  ,112) ,
              'FECHAFIN'  = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),a.cafecvcto,112) END, --CONVERT(CHAR(08),A.cafecvcto,112) ,   
			  'catipoper' = a.catipoper   , 
              'camtomon1' = Case a.catipoper when 'C' then 
								 case when a.camtomon1 = e.camtomon1  then  0.0 else a.camtomon1 end  
							Else 
								 case when a.camtomon2 = e.camtomon2 then  0.0 else a.camtomon2 end          
							End ,
              'camtomon2' = Case a.catipoper when 'V' then 
								 case  when a.camtomon1 = e.camtomon1 then 0.0 else a.camtomon1 end  
						    Else 
								 case  when a.camtomon2 = e.camtomon2 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
							End,
              'RUTCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then a.cacodigo else b.clrutcliexterno END , 0 ) ,  --a.cacodigo , --
              'DIGCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then b.cldv   else b.cldvcliexterno  END , 0 ) ,  --b.cldv     , -- 
              'NOMCLI'    = b.clnombre                      ,
              'NUMOPER'   = CONVERT (NUMERIC(8),a.canumoper),
              'plazo'     = case when a.caplazo = e.caplazo then 0 else a.caplazo end ,
              'catipmoda' = Case  when a.catipmoda = e.catipmoda then ' ' else a.catipmoda End ,
			  'CODMREC'   = case a.catipoper when e.catipoper then 0 else  case a.catipoper when'C' then a.cacodmon1 else a.cacodmon2 End End  ,    
			  'CODMENT'   = Case a.catipoper when 'V' then 
								   case  when a.cacodmon1 = e.cacodmon1 then 0 else a.cacodmon1 end  
							Else 
								   case  when a.cacodmon2 = e.cacodmon2 then 0 else a.cacodmon2 end       	
							End , 
			  'MTOREC'    = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1  then  0.0 else e.camtomon1 end  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else e.camtomon2 End          
                                  End ,  

			  'MTOENT'   = Case a.catipoper when 'V' then 
								case  when a.camtomon1 = e.camtomon1 then 0.0 else e.camtomon1 end  
						   Else 
						 		case  when a.camtomon2 = e.camtomon2 or a.cacodpos1 = 14 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE e.camtomon2 END) End  	
						   End ,
			  'CAPREMON1' = Case a.capremon1 when e.capremon1 then  0.0  else a.capremon1 end ,                                    
			  'PRECIOFUT' = CASE  WHEN a.cacodpos1 = 3  THEN (Case  when a.capremon2  = e.capremon2  then  0  else a.capremon2  end)   
						   	  WHEN a.cacodpos1 = 13 THEN (Case  when a.capremon2  = e.capremon2  then  0  else a.capremon2  end)  
						      WHEN a.cacodpos1 = 11 THEN (Case  when a.catipcam  = e.catipcam  then  0  else a.catipcam end)  --> CS-AG  
						      WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN (Case  when a.caprecal  = e.caprecal  then  0  else a.caprecal end) ELSE (Case  when a.catipcam  = e.catipcam  then  0  else a.catipcam end)   END  
						     ELSE  (Case  when a.caprecal  = e.caprecal  then  0  else a.caprecal end)   
				            END,                          

			  'CODBCCH'         = @ccodbcch      ,
              'CodigoIns'       = '00' , -- e.caoperrelaspot , -- '01', -- e.caoperrelaspot ,  --'01'  ,
              'SectorEconomico' = 0 ,  --b.clactivida   ,
              'Prima'           = 0.0 ,
	          'Flujos_SwapCCS'  = 0	  ,
              'Modulo'          = 'BFW',
              'Marca'           = 'M'  
              	  
	   FROM  mfca_log a with (nolock)           
	   INNER JOIN view_cliente      b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
	   INNER JOIN view_moneda       c with (nolock) ON   a.cacodmon1 = c.mncodmon  
	   INNER JOIN view_moneda       d with (nolock) ON   a.cacodmon2 = d.mncodmon  
	   INNER JOIN mfca              e with (nolock) ON   a.canumoper  = e.canumoper  
	   INNER JOIN #AntParcialSaldo  AntParcial with (nolock) ON   AntParcial.NumeroContratoCliente = e.canumoper   
	   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
       , mfac g  
	   WHERE a.cafecmod   > a.cafecha  
		 AND a.cafecmod   = @cfecha   
		 AND a.caprimero = 'S'              
		 AND a.catipoper IN ('C','V')       
		 AND a.cacodpos1 IN (1,2,12,11,14)
         AND e.canumoper = e.NumeroContratoCliente

               

    END
    ELSE	
    BEGIN
		SELECT  @Fecha_ant_Habil = acfecante FROM mfach WHERE acfecproc = @cfecha -- @Fecha_usuario
		INSERT INTO  #temp            
		SELECT  'CANTOPERA' = 0   ,
				  'TOTENT'    = 0.0 ,
				  'TOTREC'    = 0.0 ,
				  'FECHAPROC' = @cfecha       ,
				  'RUTPROP'   = @nrutprop     ,
				  'DIGPROP'   = @cdigprop	  ,
				  'FECHAINI'  = CONVERT(CHAR(08),ORIGINAL.cafecha  ,112) ,
				  'FECHAFIN'  = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),ORIGINAL.cafecvcto,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),a.cafecvcto,112) END, -- CONVERT(CHAR(08),A.cafecvcto,112) ,   
				  'catipoper' = a.catipoper   , 
				  'camtomon1' = Case a.catipoper when 'C' then 
									 case when a.camtomon1 = ORIGINAL.camtomon1  then  0.0 else a.camtomon1 end  
								Else 
									 case when a.camtomon2 = ORIGINAL.camtomon2 then  0.0 else a.camtomon2 end          
								End ,
				  'camtomon2' = Case a.catipoper when 'V' then 
									 case  when a.camtomon1 = ORIGINAL.camtomon1 then 0.0 else a.camtomon1 end  
								Else 
									 case  when a.camtomon2 = ORIGINAL.camtomon2 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
								End,
				  'RUTCLI'    = ISNULL( CASE WHEN CLIENTE.clpais = g.acpais then a.cacodigo else CLIENTE.clrutcliexterno END , 0 ) ,  --a.cacodigo , --
				  'DIGCLI'    = ISNULL( CASE WHEN CLIENTE.clpais = g.acpais then CLIENTE.cldv   else CLIENTE.cldvcliexterno  END , 0 ) ,  --b.cldv     , -- 
				  'NOMCLI'    = CLIENTE.clnombre                 ,
				  'NUMOPER'   = CONVERT (NUMERIC(8),a.canumoper),
				  'plazo'     = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),ORIGINAL.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,ORIGINAL.cafecha, a.cafecvcto)  END, 
				  'catipmoda' = Case  when a.catipmoda = ORIGINAL.catipmoda then ' ' else a.catipmoda End ,
				  'CODMREC'   = case a.catipoper when ORIGINAL.catipoper then 0 else  case a.catipoper when'C' then a.cacodmon1 else a.cacodmon2 End End  ,    
				  'CODMENT'   = Case a.catipoper when 'V' then 
									   case  when a.cacodmon1 = ORIGINAL.cacodmon1 then 0 else a.cacodmon1 end  
								Else 
									   case  when a.cacodmon2 = ORIGINAL.cacodmon2 then 0 else a.cacodmon2 end       	
								End , 
				  'MTOREC'    = case a.catipoper when 'C' then   
										   case when a.camtomon1 = ORIGINAL.camtomon1  then  0.0 else a.camtomon1 end  
									  Else   
										   case when a.camtomon2 = ORIGINAL.camtomon2  or a.cacodpos1 = 14 then  0.0 else a.camtomon2 End          
									  End ,  

				  'MTOENT'   = Case a.catipoper when 'V' then 
									case  when a.camtomon1 = ORIGINAL.camtomon1 then 0.0 else a.camtomon1 end  
							   Else 
						 			case  when a.camtomon2 = ORIGINAL.camtomon2 or a.cacodpos1 = 14 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
							   End ,
				  'CAPREMON1' = 0.0 ,--Case a.capremon1 when ORIGINAL.capremon1 then  0.0  else a.capremon1 end ,                                    
				  'PRECIOFUT' = 0.0 ,/*CASE  WHEN a.cacodpos1 = 3  THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)   
						   		  WHEN a.cacodpos1 = 13 THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)  
								  WHEN a.cacodpos1 = 11 THEN (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)  --> CS-AG  
								  WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end) ELSE (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)   END  
								 ELSE  (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end)   
								END,*/ 
				  'CODBCCH'         = @ccodbcch      ,
				  'CodigoIns'       = '00' , -- a.caoperrelaspot ,-- '01', -- e.caoperrelaspot ,  --'01'  ,
				  'SectorEconomico' = 0    , -- CLIENTE.clactivida   ,
				  'Prima'           = 0.0 ,
				  'Flujos_SwapCCS'  = 0	  ,
				  'Modulo'          = 'BFW',
				  'Marca'           = 'M'  
		from  MFCARES As A , MFCARES As ORIGINAL
			, BacParamSuda..MONEDA As MONEDA1
			, BacParamSuda..MONEDA As MONEDA2
			, BacParamSuda..MONEDA As MONEDACOMP
			, VIEW_CLIENTE As CLIENTE
			, view_pais  e          
			, MFAC G
		where A.CaFechaProceso = @cfecha        --@Fecha_usuario
		and   A.cafecvcto      = @cfecha        -- @Fecha_usuario 
		and   A.caantici = 'A'
		and   MONEDA1.MnCodMon  = A.CaCodMon1	
		and   MONEDA2.MnCodMon  = A.CaCodMon2	
		and   MONEDACOMP.MnCodMon = A.Moneda_Compensacion
		and   A.CaCodigo = CLIENTE.ClRut
		and   A.CaCodCli = CLIENTE.ClCodigo 
		and   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
		and   ORIGINAL.Canumoper = A.NumeroContratoCliente  
		and   A.Canumoper        = A.NumeroContratoCliente 
		and   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais             
		ORDER BY A.NumeroContratoCliente


	-- Anticipos Parciales Saldo
	    
		SELECT a.canumoper
			 , a.cafecvcto
			 , a.NumeroContratoCliente  
		INTO #AntParcialSaldoHis
		FROM  MFCARES AS a 
			, MFCARES AS ORIGINAL
			, BacParamSuda..MONEDA AS MONEDA1
			, BacParamSuda..MONEDA AS MONEDA2
			, BacParamSuda..MONEDA AS MONEDACOMP
			, VIEW_CLIENTE AS CLIENTE
			, view_pais  e  
		WHERE a.CaFechaProceso = @cfecha        --@Fecha_usuario
		AND   a.cafecvcto      =  @cfecha		-- @Fecha_usuario 
		AND   a.caantici       = 'A'
		AND   MONEDA1.MnCodMon     = a.CaCodMon1	
		AND   MONEDA2.MnCodMon = a.CaCodMon2	
		AND   MONEDACOMP.MnCodMon  = a.Moneda_Compensacion
		AND   a.CaCodigo       = CLIENTE.ClRut
		AND   a.CaCodCli       = CLIENTE.ClCodigo     
		AND   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
		AND   ORIGINAL.Canumoper      = a.NumeroContratoCliente
		AND   a.Canumoper             <> a.NumeroContratoCliente 
		AND   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais  
		ORDER BY A.NumeroContratoCliente
	 


		 INSERT INTO  #temp            
		 SELECT     
				  'CANTOPERA' = 0   ,
				  'TOTENT'    = 0.0 ,
				  'TOTREC'    = 0.0 ,
				  'FECHAPROC' = @cfecha       ,
				  'RUTPROP'   = @nrutprop     ,
				  'DIGPROP'   = @cdigprop	  ,
				  'FECHAINI'  = CONVERT(CHAR(08),A.cafecha  ,112) ,
				  'FECHAFIN'  = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN CONVERT(CHAR(08),'',112) ELSE CONVERT(CHAR(08),a.cafecvcto,112) END,-- CONVERT(CHAR(08),A.cafecvcto,112) ,   
				  'catipoper' = a.catipoper   , 
				  'camtomon1' = Case a.catipoper when 'C' then 
									 case when a.camtomon1 = e.camtomon1  then  0.0 else a.camtomon1 end  
								Else 
									 case when a.camtomon2 = e.camtomon2 then  0.0 else a.camtomon2 end          
								End ,
				  'camtomon2' = Case a.catipoper when 'V' then 
									 case  when a.camtomon1 = e.camtomon1 then 0.0 else a.camtomon1 end  
								Else 
									 case  when a.camtomon2 = e.camtomon2 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
								End ,
				  'RUTCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then a.cacodigo else b.clrutcliexterno END , 0 ) ,  --a.cacodigo , --
				  'DIGCLI'    = ISNULL( CASE WHEN b.clpais = g.acpais then b.cldv   else b.cldvcliexterno  END , 0 ) ,  --b.cldv     , -- 
				  'NOMCLI'    = b.clnombre                      ,
				  'NUMOPER'   = CONVERT (NUMERIC(8),a.canumoper),
				  'plazo'     = case when a.caplazo = e.caplazo then 0 else a.caplazo end ,
				  'catipmoda' = Case  when a.catipmoda = e.catipmoda then ' ' else a.catipmoda End ,
				  'CODMREC'   = case a.catipoper when e.catipoper then 0 else  case a.catipoper when'C' then a.cacodmon1 else a.cacodmon2 End End  ,    
				  'CODMENT'   = Case a.catipoper when 'V' then 
									   case  when a.cacodmon1 = e.cacodmon1 then 0 else a.cacodmon1 end  
								Else 
									   case  when a.cacodmon2 = e.cacodmon2 then 0 else a.cacodmon2 end       	
								End , 
				  'MTOREC'    = case a.catipoper when 'C' then   
										   case when a.camtomon1 = e.camtomon1  then  0.0 else a.camtomon1 end  
									  Else   
										   case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else a.camtomon2 End          
									  End  ,  

				  'MTOENT'   = Case a.catipoper when 'V' then 
									case  when a.camtomon1 = e.camtomon1 then 0.0 else a.camtomon1 end  
							   Else 
						 			case  when a.camtomon2 = e.camtomon2 or a.cacodpos1 = 14 then 0.0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
							   End ,
				  'CAPREMON1' = Case a.capremon1 when e.capremon1 then  0.0  else a.capremon1 end ,                                    
				  'PRECIOFUT' = CASE  WHEN a.cacodpos1 = 3  THEN (Case  when a.capremon2  = e.capremon2  then  0  else a.capremon2  end)   
						   		  WHEN a.cacodpos1 = 13 THEN (Case  when a.capremon2  = e.capremon2  then  0  else a.capremon2  end)  
								  WHEN a.cacodpos1 = 11 THEN (Case  when a.catipcam  = e.catipcam  then  0  else a.catipcam end)  --> CS-AG  
								  WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN (Case  when a.caprecal  = e.caprecal  then  0  else a.caprecal end) ELSE (Case  when a.catipcam  = e.catipcam  then  0  else a.catipcam end)   END  
								 ELSE  (Case  when a.caprecal  = e.caprecal  then  0  else a.caprecal end)   
								END ,                          

				  'CODBCCH'         = @ccodbcch      ,
				  'CodigoIns'       = '00' , --  e.caoperrelaspot , -- '01', -- e.caoperrelaspot ,  --'01'  ,
				  'SectorEconomico' = 0 , --b.clactivida   ,
				  'Prima'           = 0.0 ,
				  'Flujos_SwapCCS'  = 0	  ,
				  'Modulo'          = 'BFW',
				  'Marca'           = 'M'  

		  
		   FROM  mfca_log a with (nolock)           
		   INNER JOIN view_cliente         b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
		   INNER JOIN view_moneda          c with (nolock) ON   a.cacodmon1 = c.mncodmon  
		   INNER JOIN view_moneda          d with (nolock) ON   a.cacodmon2 = d.mncodmon  
		   INNER JOIN MFCARES              e with (nolock) ON   a.canumoper  = e.canumoper  
		   INNER JOIN #AntParcialSaldoHis  AntParcial with (nolock) ON   AntParcial.NumeroContratoCliente = e.canumoper   
		   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
		   , MFAC G
		   WHERE a.cafecmod   > a.cafecha  
			 AND a.cafecmod   = @cfecha   
			 AND a.caprimero = 'S'              
			 AND a.catipoper IN ('C','V')       
			 AND a.cacodpos1 IN (1,2,12,11,14)
             AND e.canumoper = e.NumeroContratoCliente        
		END     


 /*=======================================================================*/  
--   Anticipos Forward
 /*=======================================================================*/  


		INSERT INTO #TMP
		SELECT  'CANTOPERA'			= 0   --@ncantop                       
			  , 'TOTENT'			= 0.0 --@ntot2e + @ntot4e  
			  , 'TOTREC'			= 0.0 --@ntot1r + @ntot3r     
			  , 'FECHAPROC'			= FECHAPROC  
			  , 'RUTPROP'			= RUTPROP                                 
			  , 'DIGPROP'			= DIGPROP  
			  , 'FECHAINI'			= FECHAINI  
			  , 'FECHAFIN'			= FECHAFIN
			  , 'catipoper'			= catipoper
			  , 'camtomon1'			= camtomon1                              
			  , 'camtomon2'			= camtomon2                               
			  , 'RUTCLI'			= RUTCLI                                   
			  , 'DIGCLI'			= DIGCLI 
			  , 'NOMCLI'			= NOMCLI                                                                  
			  , 'NUMOPER'			= NUMOPER                                  
			  , 'plazo'				= plazo                                     
			  , 'catipmoda'			= catipmoda
			  , 'CODMREC'			= CODMREC                                 
			  , 'CODMENT'			= CODMENT                                
			  , 'MTOREC'			= MTOREC                              
			  , 'MTOENT'			= MTOENT                                  
			  , 'CAPREMON1'			= CAPREMON1              
			  , 'PRECIOFUT'			= PRECIOFUT             
			  , 'CODBCCH'			= CODBCCH                                 
			  , 'CodigoIns'			= CodigoIns
			  , 'SectorEconomico'   = SectorEconomico                       
			  , 'Prima'             = Prima     
			  , 'Flujos_SwapCCS'    = Flujos_SwapCCS
			  , 'Modulo'			= Modulo   
			  , 'Marca'				= Marca
		  FROM  #temp


        SELECT @ncantop= COUNT(*)
        FROM #TMP 
        WHERE  Modulo = 'BFW'          
        

		SELECT  @ntot1r = ISNULL ( SUM ( MTOREC ), 0.0 ),    --rec
		  	    @ntot2e = ISNULL ( SUM ( MTOENT ), 0.0 )     --ent
		FROM   #TMP 
		WHERE  Modulo = 'BFW'
		  AND    catipoper = 'C'


		SELECT @ntot3r  = ISNULL ( SUM ( MTOENT ), 0.0 ), 
               @ntot4e  = ISNULL ( SUM ( MTOREC ), 0.0 )
        FROM   #TMP 
		WHERE  Modulo = 'BFW'
		  AND    catipoper = 'V'



/**************************************************OPCIONES*************************************************************/

-- MODIFICADAS   
 SELECT  'TipOpe'     = A.CaCVEstructura  
       , 'CaCVOpc'    = B.CaCVOpc   
       , 'NumOpe'     = RTRIM(CONVERT(CHAR(5),A.CaNumContrato)) + RTRIM(CONVERT(CHAR(5),B.CaNumEstructura))  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.CaRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(8), B.CaFechaInicioOpc,112)     
       , 'FecTer'     = CONVERT(CHAR(8), B.CaFechaPagoEjer,112)   
       , 'CodMdaRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2  
                END  
       , 'NemMonRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                             THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                           THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2  
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2   
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoEntrega' = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2   
                         END       
       , 'Modal'      = B.CaModalidad  
       , 'PreFut'     = B.CaStrike  
       , 'PreSpt'     = B.CaStrike  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'FecPro'     = @cfecha
       , 'Marca'      = 'I'  
       , 'Plazo'      = DATEDIFF(DD,B.CaFechaInicioOpc, B.CaFechaPagoEjer)  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')         
       , 'Sector'     = D.CLACTIVIDA  
       , 'CODBCCH'    = @ccodbcch   
       , 'cod_instru' = (CASE WHEN B.CaCallPut = 'Call' THEN '03' ELSE '04' END)  
       , 'Prima'      =  B.CaPrimaInicialDet -- ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
       , 'CodPagPrima'= A.CaCodMonPagPrima 
 INTO #TEMP_OPC     
 FROM LNKOPC.CbMdbOpc.dbo.CaEncContrato A --lnkopc.CbMdbOpc.dbo.CaEncContrato A  
  INNER JOIN LNKOPC.CbMdbOpc.dbo.CaDetContrato B/*lnkopc.CbMdbOpc.dbo.CaDetContrato B*/ ON A.CaNumContrato =  B.CaNumContrato   
  INNER JOIN VIEW_CLIENTE   D with (nolock) ON (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA    E with (nolock) ON  B.CaCodMon1     = E.mncodmon    
  INNER JOIN VIEW_MONEDA    F with (nolock) ON  B.CaCodMon2     = F.mncodmon   
  RIGHT OUTER JOIN VIEW_PAIS  G with (nolock) ON  CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN  #VALOR_MONEDA H ON A.CaCodMonPagPrima  = H.vmcodigo  
 WHERE @cfecha         = CONVERT(CHAR(8),A.CaFechaContrato,112)  
 AND   A.CaTipoTransaccion <> 'ANULA'  
    AND   A.CaEstado <> 'C'  

DELETE #TEMP_OPC       

 INSERT INTO  #TEMP_OPC  
 SELECT  distinct       
         'TipOpe'     = A.MoCVEstructura  
       , 'CaCVOpc'    = B.MoCVOpc   
       , 'NumOpe'     = RTRIM(CONVERT(CHAR(5),A.MoNumContrato)) + RTRIM(CONVERT(CHAR(5),B.MoNumEstructura)) 
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
       , 'FecTer'     = CASE WHEN CONVERT(CHAR(08),B.MoFechaPagoEjer,112) = CONVERT(CHAR(08),K.MoFechaPagoEjer,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),B.MoFechaPagoEjer,112) END  -- CONVERT(CHAR(8), B.MoFechaPagoEjer,112)   
       , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  -- B.MoCodMon1  
                              ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end        -- B.MoCodMon2  
                         END  
       , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                           ELSE          Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END       
       , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.MoModalidad 
       , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
       , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'FecPro'     =  @cfecha  
       , 'Marca'      = 'M'  
       , 'Plazo'      = Case when (DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer) = DATEDIFF(DD,K.MoFechaInicioOpc, K.MoFechaPagoEjer)) then 0 else DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)end-- DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')         
       , 'Sector'     = 0 --D.CLACTIVIDA  
       , 'CODBCCH'    = @ccodbcch   
       , 'cod_instru' = CASE WHEN B.MoCallPut = K.MoCallPut THEN  '00' ELSE   (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END)  END        
       , 'Prima'      = 0.0 -- CASE WHEN B.MoPrimaInicialDet = K.MoPrimaInicialDet THEN 0.0  ELSE B.MoPrimaInicialDet END -- ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
 , 'CodPagPrima'= A.MoCodMonPagPrima 
 FROM LNKOPC.CbMdbOpc.dbo.MoEncContrato A      
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
  ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
 WHERE @cfecha = CONVERT(CHAR(8),A.MoFechaCreacionRegistro,112)  
 AND  A.MoTipoTransaccion = 'MODIFICA'  
 AND  J.MoTipoTransaccion <> 'MODIFICA'   
 AND  A.MoNumContrato  = J.MoNumContrato  
 AND  B.MoNumEstructura = K.MoNumEstructura
 AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'MODIFICA'  and  MoNumContrato = A.MoNumContrato)
 AND  A.MoEstado <> 'C'  

 UNION
 SELECT  distinct       
         'TipOpe'     = A.MoCVEstructura  
       , 'CaCVOpc'    = B.MoCVOpc  
       , 'NumOpe'     = RTRIM(CONVERT(CHAR(5),A.MoNumContrato)) + RTRIM(CONVERT(CHAR(5),B.MoNumEstructura))  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
       , 'FecTer'     = CASE WHEN CONVERT(CHAR(08),B.MoFechaPagoEjer,112) = CONVERT(CHAR(08),K.MoFechaPagoEjer,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),B.MoFechaPagoEjer,112) END -- CONVERT(CHAR(8), B.MoFechaPagoEjer,112)   
       , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  -- B.MoCodMon1  
                              ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end        -- B.MoCodMon2  
                         END  
       , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                           ELSE          Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END       
       , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.CaModalidad 
       , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.CaStrike
       , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.CaStrike
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha            
       , 'FecPro'     = @cfecha
       , 'Marca'      = 'M'  
       , 'Plazo'      = Case when (DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer) = DATEDIFF(DD,K.MoFechaInicioOpc, K.MoFechaPagoEjer)) then 0 else DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)end
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')         
       , 'Sector'     = 0 -- D.CLACTIVIDA  
       , 'CODBCCH'    = @ccodbcch   
       , 'cod_instru' = CASE WHEN B.MoCallPut = K.MoCallPut THEN  '00' ELSE   (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END) END
       , 'Prima'      = 0.0 -- CASE WHEN B.MoPrimaInicialDet = K.MoPrimaInicialDet THEN 0.0  ELSE B.MoPrimaInicialDet END  -- ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
       , 'CodPagPrima'= A.MoCodMonPagPrima 
 FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato A      
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
  ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
 WHERE @cfecha = CONVERT(CHAR(8),A.MoFechaCreacionRegistro,112)  
 AND  A.MoTipoTransaccion = 'MODIFICA'  
 AND  J.MoTipoTransaccion <> 'MODIFICA'   
 AND  A.MoNumContrato  = J.MoNumContrato  
 AND  B.MoNumEstructura = K.MoNumEstructura
 AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'MODIFICA'  and  MoNumContrato = A.MoNumContrato)
 AND  A.MoEstado <> 'C'  

-- MODIFICACIONES

-- ANTICIPADAS  


     INSERT INTO  #TEMP_OPC  
	 SELECT  Distinct
             'TipOpe'     = A.MoCVEstructura  
           , 'CaCVOpc'    = B.MoCVOpc   
		   , 'NumOpe'     = RTRIM(CONVERT(CHAR(5),A.MoNumContrato)) + RTRIM(CONVERT(CHAR(5),B.MoNumEstructura)) 
		   , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
		   , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
		   , 'NomCli'     = D.clnombre  
		   , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
		   , 'FecTer'     = CONVERT(CHAR(8), A.MoFechaUnwind,112)   
		   , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end
								  ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
							 END  
		   , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end
							      ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
							 END  
		   , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END  
		   , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                            END  
		   , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
							        THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end

							 END  
		   , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END       
		   , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.MoModalidad 
		   , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'rutprop'    = @nrutprop  
		   , 'digprop'    = @cdigprop  
		   , 'FecInfo'    = @cfecha  
		   , 'FecPro'     = @cfecha  
		   , 'Marca'      = 'M'  
		   , 'Plazo'      = DATEDIFF(DD,B.MoFechaInicioOpc,A.MoFechaUnwind) 
		   , 'Contador'   = 0  
		   , 'CanPag'     = 0  
		   , 'CodPais'    = ISNULL(G.codigo_pais,0)  
		   , 'NomPais'    = ISNULL(G.nombre,'')  		   
		   , 'Sector'     = 0 -- D.CLACTIVIDA  
           , 'CODBCCH'    = @ccodbcch   
		   , 'cod_instru' = '00' --(CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END)  
           , 'Prima'      = 0.0  -- B.MoPrimaInicialDet -- ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
           , 'CodPagPrima'= A.MoCodMonPagPrima 	
	FROM LNKOPC.CbMdbOpc.dbo.MoEncContrato A   
	  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
	  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
	  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
	  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
	  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
	  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
      ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
      INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
	WHERE @cfecha = CONVERT(CHAR(8),A.MoFechaUnwind,112)  
	 AND  A.MoTipoTransaccion = 'ANTICIPA'  	 
     AND  J.MoTipoTransaccion <> 'ANTICIPA'   
     AND  A.MoNumContrato  = J.MoNumContrato  
     AND  B.MoNumEstructura = K.MoNumEstructura
     AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'ANTICIPA'  and  MoNumContrato = A.MoNumContrato )
	 AND  A.MoEstado <> 'C'  
    UNION
	SELECT  Distinct
             'TipOpe'     = A.MoCVEstructura  
           , 'CaCVOpc'    = B.MoCVOpc   
		   , 'NumOpe'     = RTRIM(CONVERT(CHAR(5),A.MoNumContrato)) + RTRIM(CONVERT(CHAR(5),B.MoNumEstructura)) 
		   , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
		   , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
		   , 'NomCli'     = D.clnombre  
		   , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
		   , 'FecTer'     = CONVERT(CHAR(8), A.MoFechaUnwind,112)   
		   , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end
								  ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
							 END  
		   , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end
							      ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
							 END  
		   , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END  
		   , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                            END  
		   , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
							        THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end

							 END  
		   , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END       
		   , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.MoModalidad 
		   , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'rutprop'    = @nrutprop  
		   , 'digprop'    = @cdigprop  
		   , 'FecInfo'    = @cfecha  		   
		   , 'FecPro'     = @cfecha  
		   , 'Marca'      = 'M'  
		   , 'Plazo'      =  DATEDIFF(DD,B.MoFechaInicioOpc,A.MoFechaUnwind) 
		   , 'Contador'   = 0  
		   , 'CanPag'     = 0  
		   , 'CodPais'    = ISNULL(G.codigo_pais,0)  
		   , 'NomPais'    = ISNULL(G.nombre,'')  		   
		   , 'Sector'     = 0 -- D.CLACTIVIDA  
           , 'CODBCCH'    = @ccodbcch   
		   , 'cod_instru' = '00' -- (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END)  
           , 'Prima'      = 0.0  -- B.MoPrimaInicialDet -- ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
           , 'CodPagPrima'= A.MoCodMonPagPrima 
	 FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato A   
	  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
	  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
	  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
	  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
	  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
	  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
      ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
      INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
	 WHERE @cfecha = CONVERT(CHAR(8),A.MoFechaUnwind,112)  
	 AND  A.MoTipoTransaccion = 'ANTICIPA'  
     AND  J.MoTipoTransaccion <> 'ANTICIPA'   
     AND  A.MoNumContrato  = J.MoNumContrato  -- 
     AND  B.MoNumEstructura = K.MoNumEstructura
     AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'ANTICIPA'  and  MoNumContrato = A.MoNumContrato )
     AND  A.MoEstado <> 'C'  

-- ANTICIPADAS

		INSERT INTO #TMP
		SELECT  'CANTOPERA'			= 0   
			  , 'TOTENT'			= 0.0 
			  , 'TOTREC'			= 0.0 
			  , 'FECHAPROC'			= FecPro  
			  , 'RUTPROP'			= rutprop                                 
			  , 'DIGPROP'			= digprop  
			  , 'FECHAINI'			= FecIni  
			  , 'FECHAFIN'			= FecTer
			  , 'catipoper'			= CaCVOpc
			  , 'camtomon1'			= MtoRecibe                              
			  , 'camtomon2'			= MtoEntrega                               
			  , 'RUTCLI'			= RutCli                                   
			  , 'DIGCLI'			= DigCli 
			  , 'NOMCLI'			= NomCli                                                                  
			  , 'NUMOPER'			= NumOpe                                  
			  , 'plazo'				= plazo                                     
			  , 'catipmoda'			= Modal
			  , 'CODMREC'			= CodMdaRec                                 
			  , 'CODMENT'			= CodMdaEnt                                
			  , 'MTOREC'			= MtoRecibe                              
			  , 'MTOENT'			= MtoEntrega                                  
			  , 'CAPREMON1'			= PreSpt              
			  , 'PRECIOFUT'			= PreFut             
			  , 'CODBCCH'			= CODBCCH                                 
			  , 'CodigoIns'			= cod_instru
			  , 'SectorEconomico'   = Sector                       
			  , 'Prima'             = 0.0 -- CASE WHEN CodPagPrima <> 999 THEN Prima ELSE  ROUND((Prima / @DoObs),4) END
			  , 'Flujos_SwapCCS'    = 0
			  , 'Modulo'			= 'OPT'   
			  , 'Marca'				= 'M'
		  FROM  #TEMP_OPC
           ,    #VALOR_MONEDA M 
          WHERE CodPagPrima  = M.vmcodigo  



       SELECT @nTotOpc = COUNT(*)
        FROM #TMP 
        WHERE  Modulo = 'OPT'          
        


         SELECT  @TotOptRecibe = 0.0
         SELECT  @TotOptPaga   = 0.0
         SELECT  @TotOptRecibe = ISNULL ( SUM ( MTOREC ), 0 ),  
                 @TotOptPaga   = ISNULL ( SUM ( MTOENT ), 0 )   
         FROM   #TMP
         WHERE  Modulo = 'OPT'          


	/**************************************************OPCIONES*************************************************************/



          UPDATE #TMP
          SET CANTOPERA = @ncantop + @nTotOpc  ,             -- + @nTotSwap   ,
              TOTENT    = @ntot2e + @ntot4e + @TotOptPaga ,  -- + round( @TotSwapPaga, 4 )  ,
  	          TOTREC    = @ntot1r + @ntot3r + @TotOptRecibe  -- + round( @TotSwapRecibe, 4 )  



-- INI COMDER
IF EXISTS(SELECT 1 FROM BDBOMESA.dbo.COMDER_RelacionMarcaComder a, #TMP b WHERE a.nReNumOper = b.NUMOPER AND a.iReNovacion = 1 AND a.vReEstado = 'V' AND CONVERT(CHAR(8),a.dReFecha,112)= @cfecha )
BEGIN
	UPDATE #TMP
	SET	NOMCLI	= b.Clnombre
		,DIGCLI	= b.Cldv
		,RUTCLI	= b.Clrut
		,SectorEconomico = b.clactivida
   FROM		BDBOMESA.dbo.COMDER_RelacionMarcaComder a, VIEW_CLIENTE b  
   WHERE	a.nReNumOper = #TMP.NUMOPER
   AND		#TMP.RUTCLI = (select acRutComder from MFAC)  
   AND		(a.nReRutCliente = b.clrut and a.nReCodCliente=b.clcodigo )
   AND		a.iReNovacion = 1 
   AND		a.vReEstado = 'V' 
   AND		CONVERT(CHAR(8),a.dReFecha,112)= @cfecha
      
END
-- FIN COMDER

   IF (SELECT COUNT(*) FROM #TMP) > 0
      SELECT * FROM #TMP  ORDER BY   Flujos_SwapCCS, CodigoIns, NUMOPER, FECHAFIN   
   ELSE

      IF (@ncantop + @nTotOpc ) = 0   -- + @ncantopSWAP
		BEGIN   
			SELECT	'VACIO'     ='Vacio'                          ,
					'RUTPROP'   = acrutprop                       ,
					'DIGPROP'   = acdigprop                       ,
					'FECHAPROC' = @cfecproc                       ,
					'CODBCCH'   = @ccodbcch
			FROM   MFAC
		END   

   

/*

 DROP TABLE #VALOR_MONEDA 
 DROP TABLE #TMP
 DROP TABLE #TEMP
 DROP TABLE #TEMP_OPC  




 DROP TABLE #AntParcialSaldo
 DROP TABLE #AntParcialSaldoHis
 DROP TABLE #CARTERA_OPC
 DROP TABLE #TEMP_OPC_ANT 

*/

  

  
 END


GO
