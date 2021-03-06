USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Listvp_irf_PASO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Listvp_irf_PASO]
               (
                 @entidad     	NUMERIC(9)   = 0 ,
				 @titulo  	    VARCHAR(200) = ' ',
				 @Fecha_Desde    CHAR(08),
				 @Fecha_Hasta    CHAR(08)
               )
AS

BEGIN
   SET NOCOUNT ON

   DECLARE @ncartini  NUMERIC(10,0)
   DECLARE @ncartfin  NUMERIC(10,0) 
   DECLARE @numero    INTEGER
   SELECT  @ncartini  = @entidad 
   SELECT  @ncartfin  = case @entidad WHEN 0 THEN 999999999 ELSE @entidad END

   DECLARE @acfecproc   CHAR(10),
           @acfecprox   CHAR(10),
           @uf_hoy      FLOAT,
           @uf_man      FLOAT,
           @ivp_hoy     FLOAT,
           @ivp_man     FLOAT,
           @do_hoy      FLOAT,
           @do_man      FLOAT,
           @da_hoy      FLOAT,
           @da_man      FLOAT,
           @acnomprop   CHAR(40),
           @rut_empresa CHAR(12),
           @hora        CHAR(8)


   EXECUTE dbo.sp_Base_Del_Informe @acfecproc   OUTPUT
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


 DECLARE   @fPvp  					FLOAT   
	     , @fMT  					FLOAT   
	     , @fMTUM  					FLOAT   
	     , @fMT_cien 				FLOAT   
	     , @fVan  					FLOAT   
	     , @fVpar  					FLOAT   
	     , @nNumucup 				INTEGER 
	     , @fIntucup 				FLOAT   
	     , @fAmoucup 				FLOAT   
	     , @fSalucup 				FLOAT   
	     , @nNumpcup 				INTEGER 
	     , @fIntpcup 				FLOAT   
	     , @fAmopcup 				FLOAT   
	     , @fSalpcup 				FLOAT   
	     , @fDurat  				FLOAT   
	     , @fConvx  				FLOAT   
	     , @fDurmo  				FLOAT   
	     , @nError  				INTEGER
	     , @cProg   				CHAR(10)
  	     , @dFecucup 				DATETIME
         , @fecucup					DATETIME
         , @nNominal				FLOAT
         , @nn	    				INT
	     , @nCont    				INT
	     , @xnumdocu 				NUMERIC(9)
   	     , @xcodigo					NUMERIC(5)
   	     , @dFecCierre  			DATETIME
	     , @xInstser 				CHAR(12)
	     , @xmonemi					NUMERIC(3)
	     , @xFecVcto				DATETIME
	     , @ntasest					NUMERIC(9,4)
	     , @nTasaMerc 				NUMERIC(9,4)
	     , @xcorrela				NUMERIC(3)
	     , @xFecemi 				DATETIME
	     , @nTasemi 				NUMERIC(9,4)
	     , @xNomiTot 				NUMERIC(19,4)
	     , @xfecven 				DATETIME
	     , @nPlazo 					INTEGER
	     , @nbasemi 				INTEGER
	     , @dFecpcup 				DATETIME
         , @cTasEmision 			CHAR(7)
 	     , @dFecProx 				DATETIME
	     , @Fecha_maxima			DATETIME
	     , @dFecpro_aux				DATETIME
	     , @dFecSalida				DATETIME
	     , @dFecesp					DATETIME	
	     , @mes_esp					CHAR(1)
	     , @nFinMes					NUMERIC(01)
         , @fecha_anterior			DATETIME
	     , @Pago					CHAR(2)
	     , @Fecha_Pago				DATETIME
	     , @nNumoper				NUMERIC(9)
	     , @Tir_Valorizacion		NUMERIC(9,4)
	     , @Fecha_compra_Original   DATETIME
	     , @Fecha_Compra			DATETIME

  CREATE TABLE #TEMP (  nomcli					CHAR(70),
						noment					CHAR(70),
						tipcart					CHAR(50),
						numdocu					CHAR(15),
						instser					CHAR(12),
						emisor					CHAR(20),
						Fecemi					DATETIME, --CHAR(10),
						FecVen					DATETIME, --CHAR(10),
						Tasemi					NUMERIC(9,4),
						baseemi					NUMERIC(3),
						moneda					CHAR(3),
						Nominal					NUMERIC(19,4),
						tirvta					NUMERIC(9,4),
						valpar					NUMERIC(19,4),
						tasest					NUMERIC(9,4),
						valpresen				FLOAT,
						valventa				FLOAT,
						utilidad				FLOAT,
						forpago					CHAR(30),
						tipcust					CHAR(30),
						paghoy					CHAR(02),
						serie  					CHAR(30),
						numoper					NUMERIC(10),
						sw						CHAR(1),
						titulo					CHAR(90),
						tircomp					NUMERIC(9,4),
						acrutprop				NUMERIC(10),
						acdigprop				CHAR(1),
						CLAVEDCV				CHAR(15),
						Mn_Pago					CHAR(3),
						MoOperador				CHAR(15),
						Modalidad				CHAR(2),
						TasaMerc				NUMERIC(9,4),
						CProg 					CHAR(10),
						Codigo					NUMERIC(5),
						Monemi					NUMERIC(3),
						correla					NUMERIC(3),
						xNumdocu				NUMERIC(10),
						Tir_de_Mercado			NUMERIC(9,4),
						Fecha_Com_Orig			DATETIME,
						Fecha_Compra  			DATETIME,
						Pago_manana   			DATETIME,
						Tir_valorizacion		NUMERIC(9,4),
						Fecha_compra_Original   DATETIME,
						Flag				    INT IDENTITY(1,1)
			)


           SELECT @dFecpro_aux    = acfecproc From Mdac
           SELECT @fecha_anterior = (SELECT acfecante 
									 FROM MDAC)

           SELECT @Fecha_maxima   = (SELECT MAX(fecha_valorizacion) 
									 FROM VALORIZACION_MERCADO)


           EXECUTE dbo.sp_TraeNexthabil @dFecpro_aux
									  , 6
									  , @dFecSalida OUTPUT

       IF @nFinMes = 1 
	   BEGIN
    	   IF DATEPART(mm,@acfecproc) <> DATEPART(mm,@dFecSalida)
		   BEGIN
			  SELECT @dFecCierre = DATEADD(DAY, DATEPART(DAY,@dFecSalida) * -1 ,@dFecSalida)
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


INSERT #TEMP  (	  nomcli  
				, noment  
				, tipcart 
				, numdocu
				, instser
				, emisor 
				, Fecemi 
				, FecVen 
				, Tasemi 
				, baseemi 
				, moneda 
				, Nominal
				, tirvta 
				, valpar 
				, tasest
				, valpresen
				, valventa
				, utilidad
				, forpago
				, tipcust
				, paghoy
				, serie
				, numoper
				, sw
				, titulo
				, tircomp
				, acrutprop
				, acdigprop
				, CLAVEDCV
				, Mn_Pago
				, MoOperador
				, Modalidad
				, TasaMerc
				, CProg
				, Codigo
				, Monemi
				, correla
				, xNumdocu
				, Tir_de_Mercado
				, Fecha_Com_Orig
				, Fecha_Compra
				, Pago_manana
				, Tir_valorizacion
				, Fecha_compra_Original
                )
         SELECT 
				ISNULL(VIEW_CLIENTE.clnombre , ''),--1
				ISNULL( MDRC.rcnombre, ''),--2
				ISNULL( VIEW_TABLA_GENERAL_DETALLE.tbglosa, ''),--3
				ISNULL(RTRIM(CONVERT(CHAR(10),MDMO.monumdocuo))+'-'+convert(CHAR(3),MDMO.mocorrelao),''),--4
				ISNULL( MDMO.moinstser,''), --5
				ISNULL( VIEW_EMISOR.emgeneric,''),--6
				(CASE WHEN mdmo.moseriado = 'S' then CONVERT(CHAR(08),mdmo.mofecemi,112) else '19000101' end)  ,  --7
				ISNULL( CONVERT(CHAR(08), MDMO.mofecven, 112), '19000101'),--8
				ISNULL( MDMO.motasemi, 0),--9
				ISNULL( MDMO.mobasemi, 0),--10
				ISNULL( VIEW_MONEDA.mnnemo,''),--11
				ISNULL( MDMO.monominal,0),--12
				ISNULL( MDMO.motir,  0),--13
				ISNULL( MDMO.mopvp, 0),--14
				ISNULL( MDMO.motasest, 0),--15
				ISNULL( MDMO.movpresen, 0),--16
				ISNULL( MDMO.movalven, 0),--17
				ISNULL(convert( FLOAT, case MDMO.moutilidad WHEN 0 THEN (MDMO.moperdida*-1) ELSE MDMO.moutilidad END),0),--18
				ISNULL( VIEW_FORMA_DE_PAGO.glosa, ''),--19
				ISNULL( MDMO.mocondpacto, ''),--20
				CASE WHEN MDMO.Fecha_PagoMañana > MDMO.mofecpro THEN 'PM' ELSE 'PH' END,
				ISNULL( VIEW_INSTRUMENTO.inserie, ''),--22
				ISNULL( MDMO.monumoper,0),
				'0',
				@titulo ,--23,
				MDMO.tir_compra_original,
				acrutprop   ,
				acdigprop   ,	
				MDMO.moclave_dcv,
				(CASE WHEN MDMO.momonemi = 13 and exists(select 1 from view_moneda_forma_de_pago WHERE MFCODMON=13 and mfcodfor=MDMO.moforpagi) then 'USD' ELSE 'CLP' END),
		        MDMO.mousuario,
		        (CASE mopagohoy WHEN 'M' THEN 'PM' ELSE ' ' END),   
		        (CASE WHEN MDMO.mofecpro = MDMO.fecha_compra_original THEN MDMO.tir_compra_original ELSE ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO WHERE (rmnumdocu = MDMO.monumdocuo) ORDER BY fecha_valorizacion DESC),0) END ) ,
		        'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = MDMO.mocodigo),
		        MDMO.mocodigo,
		        ISNULL(MDMO.momonemi,0),
		        ISNULL(MDMO.mocorrela,0),
		        ISNULL(MDMO.monumdocuo,0),
		        ISNULL(MDMO.tir_compra_original,0),
		        ISNULL(MDMO.fecha_compra_original,''),
		        ISNULL(MDMO.mofecpro,''),
		        ISNULL( CONVERT(CHAR(08),MDMO.Fecha_PagoMañana, 112), '19000101'),
		        ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO WHERE (rmnumdocu = MDMO.monumdocuo) ORDER BY fecha_valorizacion DESC),0),
		        ISNULL((SELECT MDCP.Fecha_PagoMañana FROM MDCP WHERE MDCP.cpnumdocu = MDMO.monumdocu and MDCP.cpcorrela = MDMO.mocorrela),'01/01/1900')
	 	FROM    MDMO  LEFT JOIN VIEW_EMISOR ON  MDMO.morutemi = VIEW_EMISOR.emrut
  		        LEFT JOIN VIEW_MONEDA ON  MDMO.momonemi = VIEW_MONEDA.mncodmon ,
  				MDAC  WITH (NOLOCK),  		
  				VIEW_INSTRUMENTO  WITH (NOLOCK),
  				VIEW_ENTIDAD MDRC  WITH (NOLOCK),
				VIEW_CLIENTE           WITH (NOLOCK) ,
  				VIEW_FORMA_DE_PAGO  WITH (NOLOCK),
  				VIEW_TABLA_GENERAL_DETALLE
        WHERE   
  			MDMO.motipoper = 'VP' 
 			AND MDMO.mostatreg <> 'A' 
			AND (MDMO.mofecpro >= CONVERT(DATETIME,@Fecha_Desde) and MDMO.mofecpro <= CONVERT(DATETIME,@Fecha_Hasta))
 			AND MDRC.rcrut     = MDMO.morutcart
 			AND (VIEW_CLIENTE.clrut     = MDMO.morutcli
 			AND VIEW_CLIENTE.clcodigo  = MDMO.mocodcli)
			AND VIEW_INSTRUMENTO.incodigo  = MDMO.mocodigo
        	AND VIEW_FORMA_DE_PAGO.codigo    = MDMO.moforpagi
 			AND VIEW_TABLA_GENERAL_DETALLE.tbcateg  = 204 and VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 = 1
 			AND MDMO.motipcart = 1
 			AND (MDMO.morutcart >= @ncartini
 			AND MDMO.morutcart <= @ncartfin)
	ORDER BY MDMO.mofecpro


INSERT #TEMP  (  nomcli  			-- 1
			   , noment  			-- 2
			   , tipcart 			-- 3
			   , numdocu			-- 4
			   , instser			-- 5
			   , emisor 			-- 6
			   , Fecemi 			-- 7
			   , FecVen 			-- 8
			   , Tasemi 			-- 9
			   , baseemi			-- 10
			   , moneda 			-- 11
			   , Nominal			-- 12
			   , tirvta 			-- 13
			   , valpar 			-- 14
			   , tasest				-- 15
			   , valpresen			-- 16 
			   , valventa			-- 17 
			   , utilidad			-- 18
			   , forpago			-- 19
			   , tipcust			-- 20 
			   , paghoy				-- 21
			   , serie				-- 22
			   , numoper			-- 23 
			   , sw					-- 24
			   , titulo				-- 25
			   , tircomp			-- 26
			   , acrutprop			-- 27
			   , acdigprop			-- 28
			   , CLAVEDCV			-- 29
			   , Mn_Pago			-- 30
			   , MoOperador			-- 31
			   , Modalidad			-- 32
			   , TasaMerc			-- 33
			   , CProg				-- 34
			   , Codigo				-- 35
			   , Monemi				-- 36
			   , correla			-- 37 
			   , xNumdocu			-- 38
			   , Tir_de_Mercado		-- 39
			   , Fecha_Com_Orig		-- 40
			   , Fecha_Compra		-- 41
			   , Pago_manana		-- 42
			   , Tir_valorizacion	-- 43
			   , Fecha_compra_Original
              )
         SELECT   ISNULL(VIEW_CLIENTE.clnombre , '')	--1
				, ISNULL( MDRC.rcnombre, '')			--2
				, ISNULL( VIEW_TABLA_GENERAL_DETALLE.tbglosa, '')	--3
				, ISNULL(RTRIM(CONVERT(CHAR(10),MDMH.monumdocuo))+'-'+convert(CHAR(3),MDMH.mocorrelao),'')	--4
				, ISNULL( MDMH.moinstser,'')			--5
				, ISNULL( VIEW_EMISOR.emgeneric,'')		--6
				, (CASE WHEN MDMH.moseriado = 'S' then CONVERT(CHAR(8),MDMH.mofecemi,112) ELSE '19000101' END)    --7
				, ISNULL( CONVERT(CHAR(8), MDMH.mofecven, 112), '19000101')		--8
				, ISNULL( MDMH.motasemi, 0)			--9
				, ISNULL( MDMH.mobasemi, 0)			--10
				, ISNULL( VIEW_MONEDA.mnnemo,'')	--11
				, ISNULL( MDMH.monominal,0)			--12
				, ISNULL( MDMH.motir,  0)			--13
				, ISNULL( MDMH.mopvp, 0)			--14
				, ISNULL( MDMH.motasest, 0)			--15
				, ISNULL( MDMH.movpresen, 0)	    --16
				, ISNULL( MDMH.movalven, 0)			--17
				, ISNULL(convert( FLOAT, case MDMH.moutilidad WHEN 0 THEN (MDMH.moperdida*-1) ELSE MDMH.moutilidad END),0)--18
				, ISNULL( VIEW_FORMA_DE_PAGO.glosa, '') --19
				, ISNULL( MDMH.mocondpacto, '')			--20
				, CASE WHEN MDMH.Fecha_PagoMañana > MDMH.mofecpro THEN 'PM' ELSE 'PH' END
				, ISNULL( VIEW_INSTRUMENTO.inserie, '')	--22
				, ISNULL( MDMH.monumoper,0)
				, '0'
				, @titulo --23,
				, MDMH.tir_compra_original  --24
				, acrutprop    --25
				, acdigprop    --26	 
				, MDMH.moclave_dcv --27
				, (case when MDMH.momonemi = 13 and exists(select 1 from view_moneda_forma_de_pago WHERE MFCODMON=13 and mfcodfor=MDMH.moforpagi) then 'USD' ELSE 'CLP' END)  --28
				, MDMH.mousuario --29
				, (CASE MDMH.mopagohoy WHEN 'M' THEN 'PM' ELSE ' ' END) 
				, (CASE WHEN MDMH.mofecpro = MDMH.fecha_compra_original THEN MDMH.tir_compra_original ELSE ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO WHERE (rmnumdocu = MDMH.monumdocuo) ORDER BY fecha_valorizacion DESC),0) END ) 
				, 'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = MDMH.mocodigo) --32
				, MDMH.mocodigo  --33
				, ISNULL(MDMH.momonemi,0)   -- 34
				, ISNULL(MDMH.mocorrela,0)  -- 35
				, ISNULL(MDMH.monumdocuo,0) -- 36
				, ISNULL(MDMH.tir_compra_original,0)
				, ISNULL(MDMH.fecha_compra_original,'')
				, ISNULL(MDMH.mofecpro,'')
				, ISNULL(MDMH.Fecha_PagoMañana,'')
				, ISNULL((SELECT TOP 1 tasa_mercado FROM VALORIZACION_MERCADO WHERE (rmnumdocu = MDMH.monumdocuo) ORDER BY fecha_valorizacion DESC),0)
				, ISNULL((SELECT MDCP.Fecha_PagoMañana FROM MDCP WHERE MDCP.cpnumdocu = MDMH.monumdocu and MDCP.cpcorrela = MDMH.mocorrela),'01/01/1900')
	     FROM    MDMH LEFT JOIN VIEW_EMISOR ON  MDMH.morutemi = VIEW_EMISOR.emrut
  		         LEFT JOIN VIEW_MONEDA ON  MDMH.momonemi = VIEW_MONEDA.mncodmon,
  				 MDAC , 
  				 VIEW_INSTRUMENTO ,
  				 VIEW_ENTIDAD MDRC ,
				 VIEW_CLIENTE           ,
  				 VIEW_FORMA_DE_PAGO ,
  				 VIEW_TABLA_GENERAL_DETALLE
        WHERE   MDMH.motipoper = 'VP' 
 			AND MDMH.mostatreg <> 'A' 
			AND (MDMH.mofecpro >= CONVERT(DATETIME,@Fecha_Desde) and MDMH.mofecpro <= CONVERT(DATETIME,@Fecha_Hasta))
 			AND MDRC.rcrut     = MDMH.morutcart
 			AND (VIEW_CLIENTE.clrut     = MDMH.morutcli
 			AND VIEW_CLIENTE.clcodigo  = MDMH.mocodcli)
 			AND VIEW_INSTRUMENTO.incodigo  = MDMH.mocodigo
            AND VIEW_FORMA_DE_PAGO.codigo    = MDMH.moforpagi
 			AND VIEW_TABLA_GENERAL_DETALLE.tbcateg  = 204 and VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 = 1
 			AND MDMH.motipcart = 1 
 			AND (MDMH.morutcart >= @ncartini
 			AND MDMH.morutcart <= @ncartfin)
	 ORDER BY MDMH.mofecpro


  SELECT @nCont = Max(Flag) From #TEMP
  SELECT @nn = Min(Flag) From #TEMP

WHILE @nn <= @nCont
BEGIN

  SELECT  @xnumdocu = ISNULL(xnumdocu,0)
		, @xcorrela = ISNULL(correla,0)
		, @cProg    = CProg
		, @xcodigo  = ISNULL(codigo,0)
		, @xinstser = instser
		, @xmonemi  = ISNULL(monemi,0)
		, @xfecemi  = fecemi 
		, @xFecVcto = fecven 
		, @ntasemi  = ISNULL(Tasemi,0)
		, @nbasemi  = ISNULL(baseemi,0)
		, @ntasest  = ISNULL(tasest,0)
		, @xNomiTot = ISNULL(Nominal,0)
		, @nTasaMerc = ISNULL(TasaMerc,0)
		, @Pago      = ISNULL(paghoy,'')
		, @Fecha_Pago = ISNULL(Pago_manana,'')
		, @nNumoper   = ISNULL(numoper,0)
		, @Tir_Valorizacion = ISNULL(Tir_Valorizacion,0)
		, @Fecha_compra_Original = ISNULL(Fecha_compra_Original,'')
		, @Fecha_Compra  = ISNULL(Fecha_Compra,'')
   FROM #temp 
   WHERE flag = @nn


   IF @xnumdocu > 0 
   BEGIN
   	SELECT @fPvp     = 0 
   	SELECT @fMt      = 0
   	SELECT @fMtum    = 0
   	SELECT @fMt_cien = 0
   	SELECT @fVan	 = 0
   	SELECT @fVpar	 = 0
   	SELECT @nNumucup = 0
   	SELECT @dFecucup = ''
   	SELECT @fIntucup = 0
   	SELECT @fAmoucup = 0
   	SELECT @fSalucup = 0
   	SELECT @nNumpcup = 0
   	SELECT @fIntpcup = 0
   	SELECT @fAmopcup = 0
   	SELECT @fSalpcup = 0
   	SELECT @fDurat   = 0
   	SELECT @fConvx   = 0
   	SELECT @fDurmo   = 0
 
	IF @Tir_Valorizacion <> 0 				
    BEGIN
	---	select @Fecha_Pago,@Fecha_compra_Original,@Fecha_Compra,@xnumdocu,@nTasaMerc,@Pago
		IF @Pago <> 'PM'
		 BEGIN
		 	EXECUTE   @nError = @cProg 2
					, @Fecha_Compra
					, @xcodigo
					, @xinstser
					, @xmonemi
					, @xfecemi
					, @xFecVcto
					, @ntasemi
					, @nbasemi
					, @ntasest
					, @xNomiTot  OUTPUT
					, @nTasaMerc OUTPUT
					, @fPvp      OUTPUT
					, @fMt       OUTPUT
					, @fMtum     OUTPUT
					, @fMt_cien  OUTPUT
					, @fVan      OUTPUT
					, @fVpar     OUTPUT
					, @nNumucup  OUTPUT
					, @dFecucup  OUTPUT
					, @fIntucup  OUTPUT
					, @fAmoucup  OUTPUT
					, @fSalucup  OUTPUT
					, @nNumpcup  OUTPUT
					, @dFecpcup  OUTPUT
					, @fIntpcup  OUTPUT
					, @fAmopcup  OUTPUT
					, @fSalpcup  OUTPUT
					, @fDurat    OUTPUT
					, @fConvx    OUTPUT
					, @fDurmo    OUTPUT
		   	UPDATE #temp 
			SET valpresen = @fMt
		    WHERE  @xnumdocu = xnumdocu 
			    AND @xcorrela = correla
			    AND @nNumoper   = numoper

		 END    
		ELSE 
		 BEGIN
		 	EXECUTE   @nError = @cProg 2
					, @Fecha_Pago
					, @xcodigo
					, @xinstser
					, @xmonemi
					, @xfecemi
					, @xFecVcto
					, @ntasemi
					, @nbasemi
					, @ntasest
					, @xNomiTot  OUTPUT
					, @nTasaMerc OUTPUT
					, @fPvp		 OUTPUT
					, @fMt		 OUTPUT
					, @fMtum	 OUTPUT
					, @fMt_cien  OUTPUT
					, @fVan		 OUTPUT
					, @fVpar	 OUTPUT
					, @nNumucup  OUTPUT
					, @dFecucup  OUTPUT
					, @fIntucup  OUTPUT
					, @fAmoucup  OUTPUT
					, @fSalucup  OUTPUT
					, @nNumpcup  OUTPUT
					, @dFecpcup  OUTPUT
					, @fIntpcup  OUTPUT
					, @fAmopcup  OUTPUT
					, @fSalpcup  OUTPUT
					, @fDurat	 OUTPUT	
					, @fConvx	 OUTPUT
					,@fDurmo	 OUTPUT
		   	UPDATE #temp 
			SET valpresen = @fMt 
			WHERE @xnumdocu = xnumdocu 
			  AND @xcorrela = correla 
			  AND @nNumoper   = numoper
		 END
	END 
	ELSE
	 BEGIN 
	 	   EXECUTE  @nError = @cProg 2
				  , @Fecha_Pago
				  , @xcodigo
				  , @xinstser
				  , @xmonemi
				  , @xfecemi
				  , @xFecVcto
				  , @ntasemi
				  , @nbasemi
				  , @ntasest
				  , @xNomiTot  OUTPUT
				  , @nTasaMerc OUTPUT
				  , @fPvp      OUTPUT
				  , @fMt       OUTPUT
				  , @fMtum	   OUTPUT
				  , @fMt_cien  OUTPUT
				  , @fVan	   OUTPUT
				  , @fVpar	   OUTPUT
				  , @nNumucup  OUTPUT
				  , @dFecucup  OUTPUT
				  , @fIntucup  OUTPUT
				  , @fAmoucup  OUTPUT
				  , @fSalucup  OUTPUT
				  , @nNumpcup  OUTPUT
				  , @dFecpcup  OUTPUT
				  , @fIntpcup  OUTPUT
				  , @fAmopcup  OUTPUT
				  , @fSalpcup  OUTPUT
				  , @fDurat    OUTPUT
				  , @fConvx    OUTPUT
				  , @fDurmo    OUTPUT
	   	   UPDATE #temp 
		   SET valpresen = @fMt  
		   WHERE flag = @nn 
     END
	   
   END

   SELECT @nn = @nn + 1
  END
  
  ----<< agrupando por instrumento
        SELECT serie
			 , valpresen = SUM(valpresen)
			 , valventa  = SUM(valventa)
			 , utilidad  = SUM(utilidad)  
        INTO #total  
        FROM #temp  
        GROUP BY serie


        ----<< Control de datos
     SELECT     nomcli  --1
              , noment  --2
              , tipcart --3
              , numdocu --4
              , instser --5
              , emisor   --6
              , fecemi   --7
              , fecven   --8
              , tasemi   --9
              , baseemi --10
              , moneda  --11
              , nominal --12
              , tirvta  --13
              , valpar  --14
              , tasest  --15
              , valpresen --16
              , valventa --17
              , utilidad--18
              , forpago --19
              , tipcust --20
              , paghoy --21
              , serie --22
              , numoper
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
			  , 'acnomprop'   = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
			  , 'rut_empresa' = @rut_empresa
			  , 'hora'        = @hora 
              , sw           
              , titulo       
              , tircomp
              , acrutprop
              , acdigprop
			  , CLAVEDCV
			  , Mn_Pago
			  , MoOperador
			  , Modalidad
			  , TasaMerc
			  , CProg
			  , Codigo
			  , Monemi
			  , correla
			  , xNumdocu
			  , Tir_de_Mercado
			  , Fecha_Com_Orig
			  , Fecha_Compra
			  , Pago_manana
			  , Tir_valorizacion
			  , Fecha_compra_Original
        FROM #temp
        ORDER BY Fecha_Compra


	IF (SELECT MAX(FLAG) FROM #temp) < 0
      	BEGIN
           SELECT 'nomcli'                   = SPACE(70) --1
                  , 'noment'                 = ' '--2
                  , 'tipcart'                = ' '--3
                  , 'numdocu'                = ''--4
                  , 'instser'                = SPACE(20)    --5
                  , 'emisor'                 = '    '       --6
                  , 'fecemi'                 = '         '  -- 7
                  , 'fecven'                 = '         '  --8
                  , 'tasemi'                 = 0.0 --9
                  , 'baseemi'                = 0.0 --10
                  , 'moneda'                 = ' ' --11
                  , 'nominal'                = 0.0 --12
                  , 'tirvta'                 = 0.0 --13
                  , 'valpar'                 = 0.0 --14
                  , 'tasest'                 = 0.0 --15
                  , 'valpresen'              = 0.0 --16
                  , 'valventa'               = 0.0 --17
                  , 'utilidad'               = 0.0 --18
                  , 'forpago'                = ' ' --19
                  , 'tipcust'                = ' ' --20
                  , 'paghoy'                 = ' ' --21
                  , 'serie'                  = ' ' --22
                  , 'numoper'                = 0 
                  , 'acfecproc'              = @acfecproc    
                  , 'acfecprox'              = @acfecprox    
                  , 'uf_hoy'                 = @uf_hoy       
                  , 'uf_man'                 = @uf_man       
                  , 'ivp_hoy'                = @ivp_hoy      
                  , 'ivp_man'                = @ivp_man      
                  , 'do_hoy'                 = @do_hoy       
                  , 'do_man'                 = @do_man       
                  , 'da_hoy'                 = @da_hoy       
                  , 'da_man'                 = @da_man       
                  , 'acnomprop'              = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales) --@acnomprop    
                  , 'rut_empresa'            = @rut_empresa  
                  , 'hora'                   = @hora	      
                  , 'sw'  	                 = '0'           
                  , 'titulo'                 = @titulo       
                  , 'tircomp'                = 0.0           
                  , acrutprop	                          
                  , acdigprop                              
	              , CLAVEDCV                 = ' '           
	              , Mn_Pago                  = ' '           
                  , 'MoOperador'             = ' '           
	              , 'Modalidad'              = ' '           
   	              , 'TasaMerc'               = 0	         
	              , 'CProg' 	                = ' ' 	     
	              , 'Codigo'                 = 0	    	 
                  , 'Monemi'                 = 0		     
	              , 'correla'                = 0		     
	              , 'Numdocu'                = 0		     
	              , 'Tir_de_Mercado'         = 0	         
	              , 'Fecha_Com_Orig'         = ' ' 	     
	              , 'Fecha_Compra'           =  ' ' 	     
	              , 'Pago_manana'            = ' '	     
	              , 'Tir_valorizacion'       = 0	     
	              , 'Fecha_compra_Original'  = ' '
 		FROM MDAC 


     END
	 	 
 SET NOCOUNT OFF



END


-- Base de Datos --
GO
