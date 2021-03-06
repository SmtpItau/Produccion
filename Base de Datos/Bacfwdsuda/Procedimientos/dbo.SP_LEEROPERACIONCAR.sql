USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACIONCAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROCEDURE [dbo].[SP_LEEROPERACIONCAR]  
   (   @nnumoper   NUMERIC(10)   )   
AS  
BEGIN  
   
 SET NOCOUNT ON  
   /*=======================================================================*/  
   /*=======================================================================*/  
 SELECT  cacodcart                          ,  
                cacodigo             ,  
                cacodpos1                          ,  
                cacodmon1                          ,  
                cacodmon2                          ,  
                catipoper                          ,   
   catipmoda                          ,  
                CONVERT( CHAR(10), cafecha, 103 )  ,  
                catipcam                           ,  
                camdausd                           , --10  
                camtomon1      ,  
                caequusd1                          ,  
                caequmon1                          ,  
                caparmon1                          ,  
                capremon1                          ,  
                camtomon2                          ,  
                caequusd2                          ,  
                caequmon2                          ,  
                caparmon2                          ,  
                capremon2                          , --20  
  caestado                           ,  
                caretiro                           ,  
                cacontraparte                      ,  
                caobserv                           ,  
                caspread                           ,  
                caprecal                           ,  
                caplazo                            ,  
                case when caantici='A' then CONVERT(CHAR(10),cafecvenor,103) else CONVERT( CHAR(10), cafecvcto, 103 )end,  
                caoperador                         ,   
                catasausd                          , --30  
                catasacon                          ,  
                cafpagomn                          ,  
                cafpagomx                          ,  
  camtocalzado      ,   
  camtomon1ini      ,  
  camtomon1fin      ,  
  camtomon2ini      ,  
  camtomon2fin      ,  
  cacodsuc1                          ,  
                cacodcli                           ,  --40  
                cabroker                           ,  
                catasaufclp                        ,  
                capremio                           ,  
                catipopc   ,  
  capreciopunta   ,  
  caremunera_linea  ,  
  catasa_efectiva_moneda1  ,  
  catasa_efectiva_moneda2  ,  
  cafecEfectiva   ,  
  caArea_Responsable  ,  
  cacartera_normativa  ,  
  casubcartera_normativa  ,  
  calibro                         ,  
                caserie                         ,  
                caseriado     
            ,   cacosto_usdclp                  --> 56  
            ,   cacosto_mxusd                   --> 57  
            ,   cacosto_mxclp                   --> 58  
            ,   cacodpos2                       --> 59  
            ,   cacolmon1                       --> 60  
            ,   cafijaTCRef                     --> 61  
            ,   cafijaPRRef                     --> 62  
            ,   cavalpre                        --> 63  
            ,   caSpotTipCam                    --> 64  
            ,   caSpotParidad                   --> 65  
            ,   Resultado_Mesa                  --> 66 -> Resultado Mesa de Distribucion  
            ,   Threshold   -->67 -- Si tiene o no Threshold, PRD-4858   
      --- PRD-5522  
            ,   CaFechaStarting               
            ,   CaFechaFijacionStarting       
            ,   CaPuntosFwdCierre                                       
            ,   CaPuntosTransfObs                                       
            ,   CaPuntosTransfFwd    
			-->	marca fw Asiatico
			,	CaCalvtadol						--> 73	
			,   cacalvtaspr                     --> PRD 21645 

			  --  PRD 12712
	  ,       bEarlyTermination 
	  ,		  FechaInicio
      ,       Periodicidad 
	          
			  -- PRD 21645
	         ,numerospot
          
		  FROM  MFCA  
          WHERE canumoper  = @nnumoper  
   /*=======================================================================*/  
   /*=======================================================================*/  
     
END  

GO
