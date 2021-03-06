USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListCP_IRF_PASO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ListCP_IRF_PASO]
(
   @entidad 	   NUMERIC (9) = 0 , 
   @titulo   	   VARCHAR (200) = '',
   @Fecha_Desde    CHAR(08),
   @Fecha_Hasta    CHAR(08)
)
AS

BEGIN

SET DATEFORMAT dmy

 DECLARE @acfecproc CHAR (10) ,
         @acfecprox CHAR (10) ,
         @uf_hoy  FLOAT  ,
         @uf_man  FLOAT  ,
         @ivp_hoy FLOAT  ,
         @ivp_man FLOAT  ,
         @do_hoy  FLOAT  ,
         @do_man  FLOAT  ,
         @da_hoy  FLOAT  ,
         @da_man  FLOAT  ,
         @acnomprop CHAR (40) ,
         @rut_empresa CHAR (12) ,
         @hora  CHAR (8)
         
 EXECUTE dbo.sp_Base_Del_Informe
         @acfecproc OUTPUT ,
         @acfecprox OUTPUT ,
         @uf_hoy  OUTPUT ,
         @uf_man  OUTPUT ,
         @ivp_hoy OUTPUT ,
         @ivp_man OUTPUT ,
         @do_hoy  OUTPUT ,
         @do_man  OUTPUT ,
         @da_hoy  OUTPUT ,
         @da_man  OUTPUT ,
         @acnomprop OUTPUT ,
         @rut_empresa OUTPUT ,
         @hora  OUTPUT
             

 DECLARE    @fPvp  	FLOAT  ,
			@fMT  	FLOAT  ,
			@fMTUM  	FLOAT  ,
			@fMT_cien 	FLOAT  ,
			@fVan  	FLOAT  ,
			@fVpar  	FLOAT  ,
			@nNumucup 	INTEGER  ,
			@fIntucup 	FLOAT  ,
			@fAmoucup 	FLOAT  ,
			@fSalucup 	FLOAT  ,
			@nNumpcup 	INTEGER  ,
			@fIntpcup 	FLOAT  ,
			@fAmopcup 	FLOAT  ,
			@fSalpcup 	FLOAT  ,
			@fDurat  	FLOAT  ,
			@fConvx  	FLOAT  ,
			@fDurmo  	FLOAT  ,
			@nError  	INTEGER,
			@cProg   	CHAR(10),
  			@dFecucup 	DATETIME,
            @fecucup 	DATETIME,
            @nNominal 	FLOAT,
    	    @nn	    	INT,
			@nCont    	INT,
			@xnumdocu 	NUMERIC(9),
   			@xcodigo 	NUMERIC(5),
   			@dFecCierre  	datetime,
			@xInstser 	char(12),
			@xmonemi 	NUMERIC(3),
			@xFecVcto 	DATETIME,
			@ntasest 	NUMERIC(9,4),
			@nTasaMerc 	NUMERIC(9,4),
			@xcorrela 	NUMERIC(3),
			@xFecemi 	DATETIME,
			@nTasemi 	NUMERIC(9,4),
			@xNomiTot 	NUMERIC(19,4),
			@xfecven 	DATETIME,
			@nPlazo 	INTEGER,
			@nbasemi 	INTEGER,
			@dFecpcup 	DATETIME,
            @cTasEmision 	CHAR(7),
 			@dFecProx 	DATETIME,
			@Fecha_maxima DATETIME,
			@dFecpro_aux Datetime,
			@dFecSalida  Datetime,
			@dFecesp     datetime,	
			@mes_esp     CHAR(1),
			@nFinMes     NUMERIC(01),
           @fecha_anterior DATETIME


  CREATE TABLE #TEMP (  clnombre   		CHAR(80),
						rcnombre    	CHAR(80),
						tbglosa   		CHAR(60),
						numcorrela   	CHAR(15),
						moinstser       CHAR(30),
						emgeneric   	CHAR(30),
						Fecemi    		CHAR(10),
						FecVen    		CHAR(10),
						Tasemi    		NUMERIC(9,4),
						baseemi   		NUMERIC(3),
						mnnemo   		CHAR(3),
						nominal   		NUMERIC(19,4),
						motir     		NUMERIC(9,4),
						mopvp	  		NUMERIC(19,4),
						tasest    		NUMERIC(9,4),
						movalcomp 		FLOAT,
						movalcomu 		FLOAT,
						glosa     		CHAR(25),
						motipobono 		CHAR(20),
						propia	   		CHAR(10),
						mopagohoy  		CHAR(02),
						monumoper  		NUMERIC(15),
						mocorrela  		NUMERIC(3),
						acrutpropagdigprop CHAR(15),		
						inserie	  		CHAR(30),
						sw	  			CHAR(1),
						titulo    		CHAR(100),
						CLAVEDCV  		CHAR(15),
						Mn_Pago   		CHAR(3),
						numdocu   		CHAR(20),
						MoOperador 		CHAR(20),
						Modalidad  		CHAR(1),
						TasaMerc   		NUMERIC(9,4),
						CProg 	   		CHAR(15),
						Codigo     		NUMERIC(5),
						Monemi     		NUMERIC(3),
						correla	   		NUMERIC(3),
						xNumdocu   		NUMERIC(10),
						Tir_de_Mercado	NUMERIC(9,4),
						valpresen  		FLOAT,
						Fecha_Compra  	DATETIME,
						Flag			INT IDENTITY(1,1)
			)


           SELECT @dFecpro_aux = acfecproc From Mdac
           SELECT @fecha_anterior = (SELECT acfecante FROM MDAC)
           SELECT @Fecha_maxima   = (SELECT MAX(fecha_valorizacion) FROM VALORIZACION_MERCADO)


     	EXECUTE dbo.sp_TraeNexthabil @dFecpro_aux,6,@dFecSalida OUTPUT

       If @nFinMes = 1 BEGIN
    	   If Datepart(mm,@dFecpro_aux) <> Datepart(mm,@dFecSalida)BEGIN
	      SELECT @dFecCierre = Dateadd(day, datepart(day,@dFecSalida) * -1 ,@dFecSalida)
	      SELECT @dFecesp    = @dFecpro_aux
	      SELECT @mes_esp    = 'S'
	   END ELSE BEGIN
	      SELECT @dFecCierre = @dFecpro_aux
	      SELECT @dFecesp    = @dFecpro_aux
	      SELECT @mes_esp 	 = 'N'
	   END
       END ELSE BEGIN
           SELECT @dFecCierre = @dFecpro_aux
	   SELECT @mes_esp = 'N'
       End


 SET NOCOUNT ON
  	INSERT #TEMP  	(
				clnombre,
				rcnombre,
				tbglosa,
				numcorrela,
				moinstser,
				emgeneric,
				Fecemi,
				FecVen,
				Tasemi,
				baseemi,
				mnnemo,
				nominal,
				motir,
				mopvp,
				tasest,
				movalcomp,
				movalcomu,
				glosa,
				motipobono,
				propia,
				mopagohoy,
				monumoper,
				mocorrela,
				acrutpropagdigprop,		
				inserie,
				sw,
				titulo,
				CLAVEDCV,
				Mn_Pago,
				numdocu,
				MoOperador,
				Modalidad,
				TasaMerc,
				CProg,
				Codigo,
				Monemi,
				correla,
				xNumdocu,
				Tir_de_Mercado,
				valpresen,
				Fecha_Compra
			)
	SELECT	ISNULL(clnombre,'')         ,
   		ISNULL(rcnombre,'')         ,
   		ISNULL(VIEW_TABLA_GENERAL_DETALLE.tbglosa,''),
		ISNULL(RTRIM(CONVERT(CHAR(7),monumoper)),' '),
   		ISNULL(moinstser,'')         ,
   		ISNULL(emgeneric,'')         ,
   		(case when moseriado = 'S' then CONVERT(CHAR(10),mofecemi,103) else '19000101' end)      ,
   		CASE  WHEN moinstser='FMUTUO' OR mofecven='19000101' THEN '19000101'
       				ELSE ISNULL(CONVERT(CHAR(10),mofecven,103),'') END,
   		ISNULL(motasemi,0)         ,
   		ISNULL(mobasemi,0)         ,
   		ISNULL(mnnemo,'')          ,
   		ISNULL(monominal,0)        ,
   		ISNULL(motir,0)            ,
   		ISNULL(mopvp,0)            ,
   		ISNULL(motasest,0)         ,
		ISNULL(movalcomp,0)        ,
   		ISNULL(movalcomu,0)        ,
   		ISNULL(glosa,'')           ,
   		CASE motipobono WHEN 'S' THEN 'SECUNDARIO' ELSE 'PRIMARIO' END   ,
   		'propia'                   , 
		(CASE WHEN MDMO.Fecha_PagoMañana > MDMO.mofecpro THEN 'PM' ELSE 'PH' END),
   		ISNULL(monumoper,0)        ,
   		ISNULL(mocorrela,0)        ,  
   		ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,'')    ,
   		CASE WHEN mocodigo=20 AND motipoletra='V' THEN 'LCHR VIV'
				  WHEN mocodigo=20 AND motipoletra='F' THEN 'LCHR F.GEN'
       				  WHEN mocodigo=20 AND motipoletra='E' THEN 'LCHR ESTA'
       				  WHEN mocodigo=20 AND motipoletra='O' THEN 'LCHR OTROS'
 			      ELSE inserie   END,
   		'0',
   		@titulo,
   		moclave_dcv,
   		(case when momonemi = 13 and exists(select 1 from view_moneda_forma_de_pago WHERE MFCODMON=13 and mfcodfor=moforpagi) then
		                'USD' else 'CLP' end),
   		ISNULL(RTRIM(CONVERT(CHAR(10),MDMO.monumdocuo))+'-'+convert(CHAR(3),MDMO.mocorrelao),''),
   		mousuario,
		Condicion_Captacion,
		CONVERT(FLOAT,0) ,
		'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = mocodigo),
		mocodigo,
		ISNULL(MDMO.momonemi,0),
		ISNULL(MDMO.mocorrela,0),
		ISNULL(MDMO.monumdocuo,0),
		ISNULL(MDMO.tir_compra_original,0),
                ISNULL(MDMO.movalcomp, 0),--ISNULL(MDMO.movpresen, 0),
		ISNULL(MDMO.mofecpro,'')
   FROM MDAC, MDMO, VIEW_CLIENTE, VIEW_ENTIDAD, VIEW_EMISOR, VIEW_MONEDA, VIEW_TABLA_GENERAL_DETALLE, 
   VIEW_INSTRUMENTO, VIEW_FORMA_DE_PAGO
  WHERE motipoper='CP' AND mostatreg<>'A' AND codigo_carterasuper = 'T' AND (mofecpro >= CONVERT(DATETIME,@Fecha_Desde) and mofecpro <= CONVERT(DATETIME,@Fecha_Hasta)) AND rcrut=morutcart AND (clrut=morutcli AND clcodigo=mocodcli) AND
   emrut=morutemi AND mncodmon=momonemi AND (tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)= motipcart AND VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 = 1) AND
   motipcart = 1 AND
   incodigo=mocodigo AND codigo=moforpagi  AND
   (morutcart=@entidad OR @entidad=0)
  ORDER BY MDMO.mofecpro


------
/* MDMH */
------
  	INSERT #TEMP  	(   clnombre,
						rcnombre,
						tbglosa,
						numcorrela,
						moinstser,
						emgeneric,
						Fecemi,
						FecVen,
						Tasemi,
						baseemi,
						mnnemo,
						nominal,
						motir,
						mopvp,
						tasest,
						movalcomp,
						movalcomu,
						glosa,
						motipobono,
						propia,
						mopagohoy,
						monumoper,
						mocorrela,
						acrutpropagdigprop,		
						inserie,
						sw,
						titulo,
						CLAVEDCV,
						Mn_Pago,
						numdocu,
						MoOperador,
						Modalidad,
						TasaMerc,
						CProg,
						Codigo,
						Monemi,
						correla,
						xNumdocu,
						Tir_de_Mercado,
						valpresen,
						Fecha_Compra
			)
	SELECT	ISNULL(clnombre,'')         			,
   		ISNULL(rcnombre,'')         			,
   		ISNULL(VIEW_TABLA_GENERAL_DETALLE.tbglosa,'')	,
		ISNULL(RTRIM(CONVERT(CHAR(7),MDMH.monumoper)),' '),
   		ISNULL(MDMH.moinstser,'')         		,
   		ISNULL(emgeneric,'')         			,
   		(CASE WHEN moseriado = 'S' then CONVERT(CHAR(10),mofecemi,112) else '19000101' end)      ,
   		CASE  WHEN moinstser='FMUTUO' OR mofecven='19000101' THEN '19000101'
       				ELSE ISNULL(CONVERT(CHAR(10),mofecven,112),'') END,
   		ISNULL(MDMH.motasemi,0)        			,
   		ISNULL(MDMH.mobasemi,0)        			,
   		ISNULL(mnnemo,'')         			,
   		ISNULL(MDMH.monominal,0)       			,
   		ISNULL(MDMH.motir,0)           			,
   		ISNULL(MDMH.mopvp,0)           			,
   		ISNULL(MDMH.motasest,0)        			,
		ISNULL(MDMH.movalcomp,0)       			,
   		ISNULL(MDMH.movalcomu,0)       			,
   		ISNULL(glosa,'')          			,
   		CASE MDMH.motipobono WHEN 'S' THEN 'SECUNDARIO' ELSE 'PRIMARIO' END   ,
   		'propia'					,           
		(CASE WHEN MDMH.Fecha_PagoMañana > MDMH.mofecpro THEN 'PM' ELSE 'PH' END),
   		ISNULL(MDMH.monumoper,0)        		,
   		ISNULL(MDMH.mocorrela,0)        		,
   		ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,'')    ,
   		CASE WHEN MDMH.mocodigo=20 AND MDMH.motipoletra='V' THEN 'LCHR VIV'
				  WHEN MDMH.mocodigo=20 AND MDMH.motipoletra='F' THEN 'LCHR F.GEN'
       				  WHEN MDMH.mocodigo=20 AND MDMH.motipoletra='E' THEN 'LCHR ESTA'
       				  WHEN MDMH.mocodigo=20 AND MDMH.motipoletra='O' THEN 'LCHR OTROS'
 			      ELSE inserie   END		,
   		'0'						,
   		@titulo						,
   		MDMH.moclave_dcv				,
   		(case when MDMH.momonemi = 13 and exists(select 1 from view_moneda_forma_de_pago WHERE MFCODMON=13 and mfcodfor = MDMH.moforpagi) then
		                'USD' else 'CLP' end)		,
   		ISNULL(RTRIM(CONVERT(CHAR(10),MDMH.monumdocuo))+'-'+convert(CHAR(3),MDMH.mocorrelao),''),
   		MDMH.mousuario					,
		MDMH.Condicion_Captacion			,
		CONVERT(FLOAT,0) 		,
		'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = MDMH.mocodigo),
		MDMH.mocodigo					,
		ISNULL(MDMH.momonemi,0)				,
		ISNULL(MDMH.mocorrela,0)			,
		ISNULL(MDMH.monumdocuo,0)			,
		ISNULL(MDMH.tir_compra_original,0)		,
                ISNULL(MDMH.movalcomp, 0),
		ISNULL(MDMH.mofecpro,'')
   FROM MDAC, MDMH, VIEW_CLIENTE, VIEW_ENTIDAD, VIEW_EMISOR, VIEW_MONEDA, VIEW_TABLA_GENERAL_DETALLE, 
   VIEW_INSTRUMENTO, VIEW_FORMA_DE_PAGO
  WHERE MDMH.motipoper='CP' AND MDMH.mostatreg<>'A' AND MDMH.codigo_carterasuper = 'T' AND (MDMH.mofecpro >= CONVERT(DATETIME,@Fecha_Desde) and MDMH.mofecpro <= CONVERT(DATETIME,@Fecha_Hasta)) AND rcrut = MDMH.morutcart AND (clrut = MDMH.morutcli AND clcodigo = MDMH.mocodcli) AND
   emrut = MDMH.morutemi AND mncodmon = MDMH.momonemi AND (tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)= MDMH.motipcart AND VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 = 1) AND
   motipcart = 1 AND
   incodigo = MDMH.mocodigo AND codigo=MDMH.moforpagi  AND
   (MDMH.morutcart=@entidad OR @entidad=0)
  ORDER BY MDMH.mofecpro


  SELECT inserie, 
   nominal   = SUM(nominal),
   movalcomu = SUM(movalcomu),
   movalcomp = SUM(movalcomp)  
  INTO #TOTAL  
  FROM #TEMP  
  GROUP BY inserie


   IF EXISTS (SELECT tasa_mercado FROM VALORIZACION_MERCADO,#temp where #temp.xNumdocu = rmnumdocu and #temp.correla = rmcorrela And fecha_valorizacion = @Fecha_maxima)
     UPDATE #temp SET TasaMerc = ISNULL((SELECT tasa_mercado FROM VALORIZACION_MERCADO where #temp.xNumdocu = rmnumdocu and #temp.correla = rmcorrela and fecha_valorizacion = @Fecha_maxima),0)
   ELSE
      UPDATE #temp SET TasaMerc = ISNULL(#temp.Tir_de_Mercado,0)


  SELECT @nCont = Max(Flag) From #TEMP
  SELECT @nn = Min(Flag) From #TEMP

  WHILE @nn <= @nCont
   BEGIN

  SELECT  @xnumdocu = ISNULL(xnumdocu,0),
          @xcorrela = ISNULL(correla,0),
          @cProg    = CProg,
          @xcodigo  = ISNULL(codigo,0),
	  @xinstser = moinstser,
          @xmonemi  = ISNULL(monemi,0),
	  @xfecemi  = fecemi,
          @xFecVcto = fecven, 
          @ntasemi  = ISNULL(Tasemi,0),
          @nbasemi  = ISNULL(baseemi,0), 
	  @ntasest  = ISNULL(tasest,0),
	  @xNomiTot = ISNULL(Nominal,0),
	  @nTasaMerc = ISNULL(TasaMerc,0)
   FROM #temp WHERE flag = @nn

   If @xnumdocu > 0 Begin
   	Select @fPvp = 0 
   	Select @fMt = 0
   	Select @fMtum = 0
   	Select @fMt_cien = 0
   	Select @fVan = 0
   	Select @fVpar = 0
   	Select @nNumucup = 0
   	Select @dFecucup = ''
   	Select @fIntucup = 0
   	Select @fAmoucup = 0
   	Select @fSalucup = 0
   	Select @nNumpcup = 0
   	Select @fIntpcup = 0
   	Select @fAmopcup = 0
   	Select @fSalpcup = 0
   	Select @fDurat   = 0
   	Select @fConvx   = 0
   	Select @fDurmo   = 0
   End

   SELECT @nn = @nn + 1
  END



  SELECT 
	clnombre  ,
	rcnombre  ,
   	tbglosa   ,
   	numcorrela  ,
   	moinstser  ,
   	emgeneric  ,
   	fecemi  ,
   	fecven  ,
   	Tasemi  ,
  	baseemi  ,
   	mnnemo   ,
   	nominal  ,
   	motir   ,
   	mopvp   ,
   	tasest  ,
   	movalcomp  ,
   	movalcomu  ,
   	glosa   ,
   	motipobono  ,
   	propia   ,
   	mopagohoy  ,--case MDMO.mopagohoy when 'N' then 'PAGO MA¾ANA' else ' ' end
   	monumoper  ,
   	mocorrela  ,
   	acrutpropagdigprop ,
   	inserie          ,
   	'acfecproc' = @acfecproc   ,
   	'acfecprox' = @acfecprox   ,
   	'uf_hoy'    = @uf_hoy      ,
   	'uf_man'    = @uf_man      ,
   	'ivp_hoy'   = @ivp_hoy     ,
   	'ivp_man'   = @ivp_man     ,
   	'do_hoy'    = @do_hoy      ,
   	'do_man'    = @do_man      ,
   	'da_hoy'    = @da_hoy      ,
   	'da_man'    = @da_man      ,
   	'acnomprop' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --@acnomprop   ,
   	'rut_empresa' = @rut_empresa,
   	'hora'      = @hora ,
   	sw   ,
   	titulo,
   	acrutprop,
   	acdigprop,
   	CLAVEDCV,
   	Mn_Pago,
   	numdocu,
   	MoOperador,
   	Modalidad,
   	TasaMerc,
   	CProg,
   	Codigo,
   	Monemi,
   	correla,
   	xNumdocu,
   	Tir_de_Mercado,
   	valpresen,
	Fecha_Compra
  FROM #TEMP,mdac
  ORDER BY Fecha_Compra

IF NOT EXISTS(SELECT * FROM #TEMP) 
BEGIN
  SELECT clnombre  = ' ',
   rcnombre  	   = ' ',
   tbglosa  	   = ' ' ,
   numcorrela  	   = ' ',
   moinstser         = ' ' ,
   emgeneric       = ' ' ,
   fecemi 	   = '  /  /  ' ,
   fecven 	   = '  /  /  ' ,
   Tasemi          = 0 ,
   baseemi         = 0 ,
   mnnemo   	   = ' ',
   nominal         = 0,
   motir           = 0,
   mopvp           = 0,
   tasest          = 0 ,
   movalcomp       = 0,
   movalcomu       = 0,
   glosa   	   =' ',
   motipobono 	   = ' ' ,
   propia  	   = ' ' ,
   mopagohoy  	   = ' ',--case MDMO.mopagohoy when 'N' then 'PAGO MA¾ANA' else ' ' end
   monumoper  	   = 0,
   mocorrela  	   = 0,
   acrutpropagdigprop = ' ',
   inserie         = ' '    ,
   'acfecproc'     = @acfecproc   ,
   'acfecprox'     = @acfecprox   ,
   'uf_hoy'        = @uf_hoy      ,
   'uf_man'        = @uf_man      ,
   'ivp_hoy'       = @ivp_hoy     ,
   'ivp_man'       = @ivp_man     ,
   'do_hoy'        = @do_hoy      ,
   'do_man'        = @do_man      ,
   'da_hoy'        = @da_hoy      ,
   'da_man'        = @da_man      ,
   'acnomprop'     = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --@acnomprop   ,
   'rut_empresa'   = @rut_empresa,
   'hora'          = @hora ,
   sw              = '0',
   'titulo'        = @Titulo,
   acrutprop       = ' '  ,
   acdigprop       = ' '  ,
   CLAVEDCV 	   = ' ',
   Mn_Pago	   = ' ',
   numdocu	   = ' ',
   MoOperador      = ' ',
   Modalidad       = ' ',
  'TasaMerc'       = 0  ,
  'CProg' 	   = ' ',
  'Codigo'         = 0  ,
  'Monemi'         = 0  ,
  'correla'        = 0  ,
  'Numdocu'        = 0  ,
  'Tir_de_Mercado' = 0,
  'valpresen' 	   = 0,
  'Fecha_Compra'   = ' '
 FROM MDAC
END

  SET NOCOUNT OFF 
END

GO
