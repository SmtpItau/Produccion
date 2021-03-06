USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListCP_Holding_PASO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ListCP_Holding_PASO]
               (
                   @entidad        NUMERIC(9)   =0 
    			 , @titulo    	   VARCHAR(200) =''
			     , @Fecha_Desde    CHAR(08)
			    )
AS
BEGIN

DECLARE  @acfecproc		 CHAR (10) 
		, @acfecprox	 CHAR (10) 
		, @uf_hoy		 FLOAT  
		, @uf_man		 FLOAT  
		, @ivp_hoy		 FLOAT  
		, @ivp_man		 FLOAT  
		, @do_hoy		 FLOAT  
		, @do_man		 FLOAT  
		, @da_hoy		 FLOAT  
		, @da_man		 FLOAT  
		, @acnomprop     CHAR (40) 
		, @rut_empresa   CHAR (12) 
		, @hora          CHAR (8)

EXECUTE dbo.sp_Base_Del_Informe
                     @acfecproc   OUTPUT  
                   , @acfecprox   OUTPUT  
                   , @uf_hoy      OUTPUT  
                   , @uf_man      OUTPUT  
                   , @ivp_hoy     OUTPUT  
                   , @ivp_man     OUTPUT  
                   , @do_hoy      OUTPUT  
                   , @do_man      OUTPUT  
                   , @da_hoy      OUTPUT  
                   , @da_man      OUTPUT  
                   , @acnomprop   OUTPUT  
                   , @rut_empresa OUTPUT 
                   , @hora        OUTPUT


 DECLARE   @fPvp  	        FLOAT   
	     , @fMT  	        FLOAT   
	     , @fMTUM    	    FLOAT   
	     , @fMT_cien 	    FLOAT   
	     , @fVan  	        FLOAT   
	     , @fVpar  	        FLOAT   
	     , @nNumucup 	    INTEGER 
	     , @fIntucup 	    FLOAT   
	     , @fAmoucup 	    FLOAT   
	     , @fSalucup 	    FLOAT   
	     , @nNumpcup 	    INTEGER 
	     , @fIntpcup 	    FLOAT   
	     , @fAmopcup 	    FLOAT   
	     , @fSalpcup 	    FLOAT   
	     , @fDurat  	    FLOAT   
	     , @fConvx  	    FLOAT   
	     , @fDurmo  	    FLOAT   
	     , @nError  	    INTEGER 
	     , @cProg   	    CHAR(10)
  	     , @dFecucup 	    DATETIME
         , @fecucup 	    DATETIME
         , @nNominal 	    FLOAT
    	 , @nn	    	    INT
		 , @nCont    	    INT
		 , @xnumdocu 	    NUMERIC(9)
   		 , @xcodigo 	    NUMERIC(5)
   		 , @dFecCierre      DATETIME
		 , @xInstser 	    CHAR(12)
		 , @xmonemi 	    NUMERIC(3)
		 , @xFecVcto 	    DATETIME
		 , @ntasest 	    NUMERIC(9,4)
		 , @nTasaMerc 	    NUMERIC(9,4)
		 , @nTirOrig        NUMERIC(9,4)
		 , @xcorrela 	    NUMERIC(3)
		 , @xFecemi 	    DATETIME
		 , @nTasemi 	    NUMERIC(9,4)
		 , @xNomiTot 	    NUMERIC(19,4)
		 , @xfecven 	    DATETIME
		 , @nPlazo   	    INTEGER
		 , @nbasemi 	    INTEGER
		 , @dFecpcup 	    DATETIME
		 , @cTasEmision 	CHAR(7)
 		 , @dFecProx 		DATETIME
		 , @Fecha_maxima	DATETIME
		 , @dFecpro_aux		DATETIME
		 , @dFecSalida		DATETIME
		 , @dFecesp			DATETIME
		 , @mes_esp			CHAR(1)
		 , @nFinMes			NUMERIC(01)
		 , @fecha_anterior  DATETIME
		 , @Ano			    AS NUMERIC
		 , @Ano1		    AS FLOAT
		 , @Mes			    AS FLOAT
		 , @nRutemp		    NUMERIC (09,0)
  		 , @Tir_valorizacion	   NUMERIC(9,4)
		 , @Fecha_compra_Original  DATETIME
 

 		SELECT @nRutemp        = acrutprop FROM MDAC  WITH (NOLOCK)
        SELECT @dFecpro_aux    = acfecproc From Mdac  WITH (NOLOCK)
        SELECT @fecha_anterior = (SELECT acfecante FROM MDAC WITH (NOLOCK))
        SELECT @Fecha_maxima   = (SELECT MAX(fecha_valorizacion) FROM VALORIZACION_MERCADO WITH (NOLOCK))


     	EXECUTE dbo.sp_TraeNexthabil @dFecpro_aux,6,@dFecSalida OUTPUT

       IF @nFinMes = 1 
	   BEGIN
    	   IF DATEPART(mm,@dFecpro_aux) <> DATEPART(mm,@dFecSalida)
			 BEGIN
			      SELECT @dFecCierre = Dateadd(day, datepart(day,@dFecSalida) * -1 ,@dFecSalida)
			      SELECT @dFecesp    = @dFecpro_aux
			      SELECT @mes_esp    = 'S'
			 END 
		   ELSE 
		     BEGIN
				  SELECT @dFecCierre = @dFecpro_aux
				  SELECT @dFecesp    = @dFecpro_aux
				  SELECT @mes_esp 	 = 'N'
			 END
           END 
		  ELSE 
		   BEGIN
            SELECT @dFecCierre = @dFecpro_aux
			SELECT @mes_esp = 'N'
		   END
		
 SET NOCOUNT ON

 --  ISNULL( CONVERT(CHAR(10),MDMO.Fecha_PagoMañana, 103), '19000101'),

 IF EXISTS(SELECT * FROM MDAC, MDCP,MDDI,VIEW_TABLA_GENERAL_DETALLE  WHERE dinominal>0 AND cpnumdocu=dinumdocu AND cpcorrela=dicorrela AND ditipoper='CP' AND 
		   (tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)= cptipcart AND VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 = 1) AND  cptipcart = 1 )
 BEGIN
  SELECT	'clnombre'  			= CONVERT(CHAR(70),''),
   			'rcnombre'  			= CONVERT(CHAR(70),''),
   			'tbglosa'  				= CONVERT(CHAR(01),'') ,
			'numcorrela'  			= ISNULL(RTRIM(CONVERT(CHAR(7),MDCP.cpnumdocu)),' '), 
   			'instser'  				= ISNULL(MDCP.cpinstser, ''),
   			'emgeneric'  			= ISNULL(digenemi,' '),  
   			'fecemi'  				= (CASE WHEN MDCP.cpseriado = 'S' THEN CONVERT(CHAR(10),MDCP.cpfecemi,112) ELSE '19000101' END)      ,
   			'fecven'  				=  CASE  WHEN MDCP.cpinstser='FMUTUO' OR MDCP.cpfecven='19000101' 
												THEN ' '
       											ELSE ISNULL(CONVERT(CHAR(10),MDCP.cpfecven,112),'') END,
   			'Tasemi'  				= CONVERT(FLOAT,0), 
   			'baseemi'  				= CONVERT(FLOAT,dibase), --CONVERT(FLOAT,0),
   			'mnnemo'  				= (SELECT mnnemo FROM VIEW_MONEDA WHERE mnnemo = dinemmon),
   			'nominal'  				= ISNULL(dinominal,0),
   			'motir'   				= (CASE WHEN ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO (NOLOCK) WHERE (VALORIZACION_MERCADO.rmnumdocu = MDCP.cpnumdocu) ORDER BY fecha_valorizacion DESC),0) = 0 THEN MDCP.TIR_COMPRA_ORIGINAL ELSE ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO (NOLOCK) WHERE (VALORIZACION_MERCADO.rmnumdocu = MDCP.cpnumdocu) ORDER BY fecha_valorizacion DESC),0) END ),
   			'mopvp'   				= ISNULL(MDCP.cppvpcomp,0),
   			'tasest'  				= ISNULL(MDCP.cptasest,0) ,
			'movalcomp'  			= ISNULL(MDCP.cpvalcomp,0),
   			'movalcomu'  			= ISNULL(MDCP.cpvalcomu,0),
   			'glosa'   				= CONVERT(CHAR(01),''), 
   			'motipobono'  			= CONVERT(CHAR(1),''),  
   			'propia'  				= 'propia'          , 
   			'mopagohoy'  			= (CASE WHEN MDCP.Fecha_PagoMañana = MDCP.fecha_compra_original THEN 'PH' ELSE 'PM' END )   ,
   			'monumoper'  			= ISNULL(MDCP.cpnumdocu,0)         ,
   			'mocorrela'  			= ISNULL(MDCP.cpcorrela,0)         ,
   			'acrutpropagdigprop'    = ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,'')    ,
   			'inserie'  				= CONVERT(CHAR(1),''), 
   			'sw'					='0',
   			'titulo'				= @titulo,
   			'CLAVEDCV' 				= MDCP.cpdcv,
   			'Mn_Pago'				= CONVERT(CHAR(01),''), 
   			'numdocu' 				= ISNULL(RTRIM(CONVERT(CHAR(10),MDCP.cpnumdocuo))+'-'+CONVERT(CHAR(3),MDCP.cpcorrelao),''),
   			'MoOperador'			= CONVERT(CHAR(1),''),
			'Modalidad'				= CONVERT(CHAR(1),''),
			'TasaMerc'				= CONVERT(FLOAT,0) ,
			'CProg' 				='sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = MDCP.cpcodigo),
			'Codigo'				= MDCP.cpcodigo,
			'Monemi'				= (SELECT mncodmon FROM VIEW_MONEDA WHERE mnnemo = dinemmon), 
			'correla'				= ISNULL(MDCP.cpcorrela,0),
			'xNumdocu'				= ISNULL(MDCP.cpnumdocu,0),
			'Tir_de_Valorizacion'	= CONVERT(FLOAT,0),
			'valpresen_CLP'			= diinteresc + direajustc + dicapitalc ,
			'Holding_Period'		= DATEDIFF(DAY,MDCP.fecha_compra_original,@dFecpro_aux),
			'Valor_Par'				= ISNULL(MDCP.valor_par_compra_original,0),
			'Plazo'					= datediff(day,@dFecpro_aux,MDCP.cpfecven),
			'Duration'				= ISNULL(MDCP.cpdurat,0), 
			'Convexidad'			= ISNULL(MDCP.cpconvex,0),
			'Valor_Par_100'			= ISNULL(MDCP.porcentaje_valor_par_compra_original,0),
			'var2'       			= CONVERT(FLOAT,(DATEDIFF(DAY,@dFecpro_aux,MDCP.cpfecven))) ,
			'Año'					= FLOOR(CONVERT(FLOAT,(DATEDIFF(DAY,@dFecpro_aux,MDCP.cpfecven))/365)),
			'Mes'					= (CONVERT(FLOAT,(DATEDIFF(DAY,@dFecpro_aux,MDCP.cpfecven)))/365)-FLOOR(CONVERT(FLOAT,(datediff(day,@dFecpro_aux,MDCP.cpfecven))/365)),
			'Plazo2'				= (((CONVERT(FLOAT,(DATEDIFF(DAy,@dFecpro_aux,MDCP.cpfecven)))/365)-FLOOR(CONVERT(FLOAT,(datediff(day,@dFecpro_aux,MDCP.cpfecven))/365)))*365)/30,
			'Plazo_Real'			= CONVERT(VARCHAR,FLOOR(CONVERT(FLOAT,(DATEDIFF(DAY,@dFecpro_aux,MDCP.cpfecven))/365))) + '/' + CONVERT(VARCHAR,ROUND((((CONVERT(FLOAT,(datediff(day,@dFecpro_aux,MDCP.cpfecven)))/365)-FLOOR(CONVERT(FLOAT,(datediff(day,@dFecpro_aux,MDCP.cpfecven))/365)))*365)/30,0)),
			'Tir_valorizacion'		= ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO (NOLOCK) WHERE (VALORIZACION_MERCADO.rmnumdocu = MDCP.cpnumdocu) ORDER BY fecha_valorizacion DESC),0),
			'Fecha_compra_Original' = MDCP.Fecha_PagoMañana,
    		Flag					= IDENTITY(INT)
     INTO #TEMP
     FROM MDAC, MDCP,MDDI,VIEW_TABLA_GENERAL_DETALLE
     WHERE   dinominal > 0 
	     AND cpnumdocu = dinumdocu 
		 AND cpcorrela=dicorrela 
		 AND  ditipoper='CP'
		 AND (tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1) = cptipcart 
		 AND VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 = 1) 
		 AND cptipcart = 1 
    ORDER BY instser,Holding_Period ASC 


  SELECT   inserie
	     , 'nominal'   = SUM(nominal)
	     , 'movalcomu' = SUM(movalcomu)
	     , 'movalcomp' = SUM(movalcomp)  
  INTO #TOTAL  
  FROM #TEMP  
  GROUP BY inserie

  SELECT @nCont = MAX(Flag) FROM #TEMP
  SELECT @nn    = MIN(Flag) FROM #TEMP 


  WHILE @nn <= @nCont
   BEGIN

	 SELECT   @xnumdocu   = ISNULL(xnumdocu,0),
			  @xcorrela   = ISNULL(correla,0),
			  @cProg      = CProg,
			  @xcodigo    = ISNULL(codigo,0),
			  @xinstser   = instser,
			  @xmonemi    = ISNULL(monemi,0),
			  @xfecemi    = fecemi,
			  @xFecVcto   = fecven, 
			  @ntasemi    = ISNULL(Tasemi,0),
			  @nbasemi    = ISNULL(baseemi,0), 
			  @ntasest    = ISNULL(tasest,0),
			  @xNomiTot   = ISNULL(Nominal,0),
			  @nTasaMerc  = ISNULL(TasaMerc,0),
			  @nTirOrig   = ISNULL(motir,0),
			  @Tir_Valorizacion		 = ISNULL(Tir_Valorizacion,0),
			  @Fecha_compra_Original = ISNULL(Fecha_compra_Original,0)
	   FROM #TEMP 
	   WHERE flag = @nn 

   IF @xnumdocu > 0 
   BEGIN
   	  SELECT @fPvp       = 0 
   	  SELECT @fMt        = 0
   	  SELECT @fMtum      = 0
   	  SELECT @fMt_cien   = 0
   	  SELECT @fVan	   = 0
   	  SELECT @fVpar	   = 0
   	  SELECT @nNumucup   = 0
   	  SELECT @dFecucup   = ''
   	  SELECT @fIntucup   = 0
   	  SELECT @fAmoucup   = 0
   	  SELECT @fSalucup   = 0
   	  SELECT @nNumpcup   = 0
   	  SELECT @fIntpcup   = 0
   	  SELECT @fAmopcup   = 0
   	  SELECT @fSalpcup   = 0
   	  SELECT @fDurat     = 0
   	  SELECT @fConvx     = 0
   	  SELECT @fDurmo     = 0

--select  @dFecpro_aux,@Tir_Valorizacion,@nTirOrig
	IF @Tir_Valorizacion <> 0 
        BEGIN
	 	EXECUTE @nError = @cProg 2
				, @dFecpro_aux
				, @xcodigo
				, @xinstser
				, @xmonemi
				, @xfecemi
				, @xFecVcto
				, @ntasemi, @nbasemi
				, @ntasest
				, @xNomiTot    OUTPUT
				, @nTirOrig    OUTPUT
				, @fPvp		   OUTPUT
				, @fMt		   OUTPUT
				, @fMtum	   OUTPUT
				, @fMt_cien    OUTPUT
				, @fVan		   OUTPUT
				, @fVpar	   OUTPUT
				, @nNumucup    OUTPUT
				, @dFecucup    OUTPUT
				, @fIntucup    OUTPUT
				, @fAmoucup    OUTPUT
				, @fSalucup    OUTPUT
				, @nNumpcup    OUTPUT
				, @dFecpcup    OUTPUT
				, @fIntpcup    OUTPUT
				, @fAmopcup    OUTPUT
				, @fSalpcup    OUTPUT
				, @fDurat      OUTPUT
				, @fConvx      OUTPUT
				, @fDurmo      OUTPUT

	    UPDATE #temp SET valpresen_CLP = @fMt WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 
		UPDATE #temp SET Duration = @fDurat WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 
		UPDATE #temp SET Convexidad = @fConvx WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 
		UPDATE #temp SET Valor_Par_100 = @fPvp WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 

		--select @cProg ,2,@fPvp,@fMt,@fMtum ,@fMt_cien , @fVan , @fVpar ,@nNumucup , @dFecucup , @fIntucup , @fAmoucup , @fSalucup , @nNumpcup , @dFecpcup , @fIntpcup , @fAmopcup , @fSalpcup, @fDurat , @fConvx ,@fDurmo 

	     END 
	  ELSE 
		BEGIN
		   --select '2',@fPvp,@fMt,@fMtum ,@fMt_cien , @fVan , @fVpar ,@nNumucup , @dFecucup , @fIntucup , @fAmoucup , @fSalucup , @nNumpcup , @dFecpcup , @fIntpcup , @fAmopcup , @fSalpcup, @fDurat , @fConvx ,@fDurmo 

	 	   EXECUTE @nError = @cProg 2
		   , @Fecha_compra_Original
		   , @xcodigo
		   , @xinstser
		   , @xmonemi
		   , @xfecemi
		   , @xFecVcto
		   , @ntasemi
		   , @nbasemi
		   , @ntasest
		   , @xNomiTot OUTPUT
		   , @nTirOrig OUTPUT
		   , @fPvp     OUTPUT
		   , @fMt      OUTPUT
		   , @fMtum    OUTPUT
		   , @fMt_cien OUTPUT
		   , @fVan     OUTPUT
		   , @fVpar    OUTPUT
		   , @nNumucup OUTPUT
		   , @dFecucup OUTPUT
		   , @fIntucup OUTPUT
		   , @fAmoucup OUTPUT
		   , @fSalucup OUTPUT
		   , @nNumpcup OUTPUT
		   , @dFecpcup OUTPUT
		   , @fIntpcup OUTPUT
		   , @fAmopcup OUTPUT
		   , @fSalpcup OUTPUT
		   , @fDurat   OUTPUT
		   , @fConvx   OUTPUT
		   , @fDurmo   OUTPUT

	
	   	UPDATE #temp SET valpresen_CLP = @fMt --WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 
		UPDATE #temp SET Duration      = @fDurat --WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 
		UPDATE #temp SET Convexidad    = @fConvx --WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 
		UPDATE #temp SET Valor_Par_100 = @fPvp --WHERE @xnumdocu = xnumdocu AND @xcorrela = correla 

    WHERE flag = @nn 
   END
END

   SELECT @nn = @nn + 1
  END

  SELECT   clnombre   
         , rcnombre   
         , tbglosa    
         , numcorrela 
         , instser    
         , emgeneric  
         , fecemi   
         , fecven   
         , Tasemi   
         , baseemi  
         , mnnemo   
         , nominal  
         , motir    
         , mopvp    
         , tasest   
         , movalcomp  
         , movalcomu  
         , glosa     
         , motipobono 
         , propia   
         , mopagohoy  
         , monumoper  
         , mocorrela  
         , acrutpropagdigprop 
         , inserie          
         , 'acfecproc'   = @acfecproc   
         , 'acfecprox'   = @acfecprox   
         , 'uf_hoy'      = @uf_hoy      
         , 'uf_man'      = @uf_man      
         , 'ivp_hoy'     = @ivp_hoy     
         , 'ivp_man'     = @ivp_man     
         , 'do_hoy'      = @do_hoy      
         , 'do_man'      = @do_man      
         , 'da_hoy'      = @da_hoy      
         , 'da_man'      = @da_man      
         , 'acnomprop'   = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales) --@acnomprop   
         , 'rut_empresa' = @rut_empresa
         , 'hora'        = @hora 
         , sw   
         , titulo
         , acrutprop
         , acdigprop
         , CLAVEDCV
         , Mn_Pago
         , numdocu
         , MoOperador
         , Modalidad
         , TasaMerc
         , CProg
         , Codigo
         , Monemi
         , correla
         , xNumdocu
         , Tir_de_Valorizacion
         , valpresen_CLP
         , Holding_Period
         , Valor_Par
         , Plazo
         , Duration
         , Convexidad
         , Valor_Par_100
         , var2
         , Año
         , Mes
         , Plazo2
         , Plazo_Real
         , Tir_valorizacion
         , Fecha_compra_Original
  FROM #TEMP,mdac
  ORDER BY instser,Holding_Period ASC 
 END
 ELSE 
  SELECT clnombre  			= ' ',
         rcnombre  			= ' ',
         tbglosa  			= ' ' ,
         numcorrela			= ' ',
         instser			= ' ' ,
         emgeneric			= ' ' ,
         fecemi				= '  /  /  ' ,
         fecven				= '  /  /  ' ,
         Tasemi				= 0 ,
         baseemi			= 0 ,
         mnnemo				= ' ',
         nominal			= 0,
         motir				= 0,
         mopvp				= 0,
         tasest				= 0 ,
         movalcomp			= 0,
         movalcomu			= 0,
         glosa				=' ',
         motipobono			= ' ' ,
         propia				= ' ' ,
         mopagohoy			= ' ',
         monumoper			= 0,
         mocorrela			= 0,
         acrutpropagdigprop = ' ',
         inserie			= ' '    ,
         'acfecproc'		= @acfecproc   ,
         'acfecprox'		= @acfecprox   ,
         'uf_hoy'			= @uf_hoy      ,
         'uf_man'			= @uf_man      ,
         'ivp_hoy'			= @ivp_hoy     ,
         'ivp_man'			= @ivp_man     ,
         'do_hoy'			= @do_hoy      ,
         'do_man'			= @do_man      ,
         'da_hoy'			= @da_hoy      ,
         'da_man'			= @da_man      ,
         'acnomprop'		= (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --@acnomprop   ,
         'rut_empresa'		= @rut_empresa,
         'hora'				= @hora ,
         sw					='0',
         'titulo'			= @Titulo,
         acrutprop         ,
         acdigprop         ,
         CLAVEDCV 			= ' ',
         Mn_Pago			= ' ',
         numdocu			= ' ',
         MoOperador		    = ' ',
         Modalidad		    = ' ',
         'TasaMerc'         = 0  ,
         'CProg' 		    = ' ',
         'Codigo'			= 0  ,
         'Monemi'			= 0  ,
         'correla'			= 0  ,
         'Numdocu'			= 0  ,
         'Tir_de_Valorizacion'= 0,
         'valpresen_CLP'      = 0,
         'Holding_Period'	= 0,
         'Valor_Par'		= 0,
         'Plazo'			= 0,
         'Duration'			= 0,
         'Convexidad'	    = 0,
         'Valor_Par_100'    = 0,
         'Var2'				= 0,
         'Año'				= 0,
         'Mes'	  			= 0,
         'Plazo2'			= 0,
         'Plazo_Real'		= 0,
         'Tir_valorizacion' = 0,
         'Fecha_compra_Original' = ' '
 FROM MDAC


  SET NOCOUNT OFF 

END

-- Base de Datos --

GO
