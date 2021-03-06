USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACION]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEROPERACION]
   (   @nnumoper   NUMERIC(10)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecproc FROM MFAC with (nolock) )

   DECLARE @dFecha          DATETIME
       SET @dFecha          = (SELECT cafecha   FROM MFCA with (nolock) WHERE canumoper = @nnumoper)

      SELECT mocodcart
      ,      mocodigo
      ,      mocodpos1
      ,      mocodmon1
      ,      mocodmon2
      ,      motipoper
      ,      motipmoda
      ,      mofecha = CONVERT(CHAR(10),mofecha,103)
      ,      motipcam
      ,      momdausd
      ,      momtomon1
      ,      moequusd1
      ,      moequmon1
      ,      moparmon1
      ,      mopremon1 = CASE WHEN cacodpos1 = 12 THEN cacosto_mxclp ELSE mopremon1 END
      ,      momtomon2
      ,      moequusd2
      ,      moequmon2
      ,      moparmon2 = CASE WHEN cacodpos1 = 12 THEN cacosto_mxusd ELSE moparmon2 END
      ,      mopremon2 = CASE WHEN cacodpos1 = 12 THEN cavalpre      ELSE mopremon2 END
      ,      moestado
      ,      moretiro
      ,      mocontraparte
      ,      moobserv
      ,      mospread
      ,      moprecal
      ,      moplazo
      ,      mofecvcto = CONVERT(CHAR(10),mofecvcto,103)
      ,      molock
      ,      mooperador
      ,      motasausd
      ,      motasacon
      ,      mofpagomn
      ,      mofpagomx
      ,      camtocalzado
      ,      momtomon1ini
      ,      momtomon1fin
      ,      momtomon2ini
      ,      momtomon2fin
      ,      mocodsuc1
      ,      mocodcli
      ,      mobroker
      ,      camontopfe
      ,      camontocce
      ,      mopremio
      ,      motipopc
      ,      mopreciopunta
      ,      moremunera_linea
      ,      motasa_efectiva_moneda1
      ,      motasa_efectiva_moneda2  
      ,      catasaEfectMon1
      ,      catasaEfectMon2 
      ,      catipcamSpot
      ,      catipcamFwd
      ,      cafecEfectiva = CONVERT(CHAR(10),cafecEfectiva,103)
      ,      caserie
      ,      caseriado
      ,      moArea_Responsable
      ,      mocartera_normativa 
      ,      mosubcartera_normativa 
      ,      molibro
      -->    Mx-$
      ,      nCostoUSDCLP         = cacosto_usdclp
      ,      nCostoMxUSD          = cacosto_mxusd
      ,      nCostoMxCLP          = cacosto_mxclp
      ,      iRefTc               = cacodpos2
      ,      iRefParidad          = cacolmon1
      ,      dRefTc               = cafijaTCRef
      ,      dRefParidad          = cafijaPRRef
      ,      nTipCamUSDCLP        = cavalpre
      ,      caSpotTipCam         = caSpotTipCam
      ,      caSpotParidad        = caSpotParidad
      ,      canumspot            = MFMO.numerospot
      -->>>> Resultado de Mesa de Distribucion
      ,      Resultado_Mesa       = MFCA.Resultado_Mesa
      ,	     Precio_Spot
      --- PRD-4858, Threshold
      ,	     Threshold		  = MFCA.Threshold
      --- PRD-5522
      ,      MoFechaStarting             
      ,      MoFechaFijacionStarting     
      ,      MoPuntosFwdCierre                                     
      ,      MoPuntosTransfObs                                     
      ,      MoPuntosTransfFwd  
      --- PRD-5539
      ,	     Cadevacum
	  ,		  ISNULL(relacionada,0) -->VB+-12/04/2011
	  ,      'nCacalvtadol'    = mocalvtadol   --> Marca de Forward Asiatico
	  ,      mocalvtaspr 	      --> PRD 21645	
	  --  PRD 12712
	  ,       MFMO.bEarlyTermination 
	  ,		  MFMO.FechaInicio
      ,       MFMO.Periodicidad 
	  
	  			
      FROM   MFMO            with(nolock)
             LEFT JOIN MFCA  with(nolock) ON canumoper = monumoper
			 LEFT JOIN (SELECT var_moneda2		AS operacion 
							,  MAX(canumoper)   AS relacionada
						  FROM MFCA 
						 WHERE var_moneda2 = @nnumoper
					  GROUP BY var_moneda2 ) mxclp 
										  ON mxclp.operacion = monumoper
      WHERE  monumoper  = @nnumoper 

      UNION

      SELECT cacodcart               --> mocodcart
      ,      cacodigo                --> mocodigo
      ,      cacodpos1               --> mocodpos1
      ,      cacodmon1               --> mocodmon1
      ,      cacodmon2               --> mocodmon2
      ,      catipoper               --> motipoper
      ,      catipmoda               --> motipmoda
      ,      cafecha                 = CONVERT(CHAR(10),cafecha,103) --> CONVERT(CHAR(10),mofecha,103)
      ,      catipcam                --> motipcam
      ,      camdausd --> momdausd
      ,      camtomon1               --> momtomon1
      ,      caequusd1               --> moequusd1
      ,      caequmon1               --> moequmon1
      ,      caparmon1               --> moparmon1
      ,      capremon1               = CASE WHEN cacodpos1 = 12 THEN cacosto_mxclp ELSE capremon1 END
      ,      camtomon2               --> momtomon2
      ,      caequusd2               --> moequusd2
      ,      caequmon2               --> moequmon2
      ,      caparmon2               = CASE WHEN cacodpos1 = 12 THEN cacosto_mxusd ELSE caparmon2 END
      ,      capremon2               = CASE WHEN cacodpos1 = 12 THEN cavalpre      ELSE capremon2 END
      ,      caestado                --> moestado
      ,      caretiro                --> moretiro
      ,      cacontraparte           --> mocontraparte
      ,      caobserv                --> moobserv
      ,      caspread                --> mospread
      ,      caprecal                --> moprecal
      ,      caplazo                 --> moplazo
      ,      cafecvcto               = CONVERT(CHAR(10), cafecvcto,103) --> CONVERT(CHAR(10),mofecvcto,103)
      ,      calock                  --> molock
      ,      caoperador              --> mooperador
      ,      catasausd               --> motasausd
      ,      catasacon               --> motasacon
      ,      cafpagomn               --> mofpagomn
      ,      cafpagomx               --> mofpagomx
      ,      camtocalzado            --> camtocalzado
      ,      camtomon1ini            --> momtomon1ini
      ,      camtomon1fin            --> momtomon1fin
      ,      camtomon2ini            --> momtomon2ini
      ,      camtomon2fin            --> momtomon2fin
      ,      cacodsuc1               --> mocodsuc1
      ,      cacodcli                --> mocodcli
      ,      cabroker                --> mobroker
      ,      camontopfe              --> camontopfe
      ,      camontocce              --> camontocce
      ,      capremio                --> mopremio
      ,      catipopc                --> motipopc
      ,      capreciopunta           --> mopreciopunta
      ,      caremunera_linea        --> moremunera_linea
      ,      catasaEfectMon1         --> catasaEfectMon1
      ,      catasaEfectMon2         --> catasaEfectMon2
      ,      catasaEfectMon1         --> catasaEfectMon1
      ,      catasaEfectMon2         --> catasaEfectMon2
      ,      catipcamSpot            --> catipcamSpot
      ,      capreciopunta           --> capreciopunta
      ,      cafecEfectiva           = CONVERT(CHAR(10),cafecEfectiva,103)
      ,      caserie                 --> caserie
      ,      caseriado               --> caseriado
      ,      caArea_Responsable      --> moArea_Responsable
      ,      cacartera_normativa     --> mocartera_normativa 
      ,      casubcartera_normativa  --> mosubcartera_normativa 
      ,      molibro
      -->    Mx-$
      ,      nCostoUSDCLP            = cacosto_usdclp
      ,      nCostoMxUSD             = cacosto_mxusd
      ,      nCostoMxCLP             = cacosto_mxclp
      ,      iRefTc                  = cacodpos2
      ,      iRefParidad             = cacolmon1
      ,      dRefTc                  = cafijaTCRef
      ,      dRefParidad             = cafijaPRRef
      ,      nTipCamUSDCLP           = cavalpre
      ,      caSpotTipCam         = caSpotTipCam
      ,      caSpotParidad        = caSpotParidad
      ,      canumspot               = MFMOH.numerospot
      -->>>> Resultado de Mesa de Distribucion
      ,      Resultado_Mesa          = MFCA.Resultado_Mesa
      ,	  Precio_Spot
      --- PRD-4858, Threshold
      ,	     Threshold		  = MFCA.Threshold
      --- PRD-5522
      ,    CaFechaStarting             
      ,    CaFechaFijacionStarting     
      ,    CaPuntosFwdCierre                                     
      ,    CaPuntosTransfObs                         
      ,    CaPuntosTransfFwd  
      --- PRD-5539
      ,	   Cadevacum
	  ,	   ISNULL(relacionada,0) -->VB+-12/04/2011
	  ,    'nCacalvtadol'    = mocalvtadol --> Marca de Forward Asiatico   --> 83
	  ,     mocalvtaspr		   --> PRD 21645
	    --  PRD 12712
	  ,       MFMOH.bEarlyTermination 
	  ,		  MFMOH.FechaInicio
      ,       MFMOH.Periodicidad 
	  	
    FROM   MFMOH			with (nolock)
             LEFT JOIN MFCA with (nolock) ON canumoper = monumoper
			 LEFT JOIN (SELECT var_moneda2		AS operacion 
						,	   MAX(canumoper)   AS relacionada
						  FROM MFCA 
						 WHERE var_moneda2 = @nnumoper
					  GROUP BY var_moneda2 ) mxclp 
										  ON mxclp.operacion = monumoper
      WHERE  monumoper                      = @nnumoper
      
   SET NOCOUNT OFF

END

GO
