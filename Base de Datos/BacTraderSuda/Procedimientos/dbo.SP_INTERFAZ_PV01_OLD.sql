USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_PV01_OLD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_PV01_OLD]( @Fecha_Proc DATETIME )
AS
BEGIN  
	DECLARE @itotreg	INTEGER       	,
	        @icontador	INTEGER       	,
		@nnumucup 	INTEGER		,
		@itotcupon	INTEGER		,
		@icodigo	INTEGER		,
		@ibaseemi	INTEGER 	,
		@ibaseemi2	INTEGER 	,
		@iplazo_cupon	INTEGER		,
		@imonemi	INTEGER		,
		@itotregpr	INTEGER       	,
	        @icontadorpr	INTEGER       	,
		@iper_cupon	INTEGER		,
		@imoneda1	INTEGER		,
		@imoneda2	INTEGER		,
		@nnumdocu	NUMERIC(10,0)	,
		@nnumoper	NUMERIC(10,0)	,
		@ncorrela	NUMERIC(05,0)	,
		@nrutemi	NUMERIC(10,0)	
	 
	DECLARE @cinstser	CHAR(10)	,
		@cmascara	CHAR(10)	,
		@cseriado	CHAR(01)	,
		@ctablades	CHAR(01)	,
		@ctablapre	CHAR(01)	,
		@cfuerte 	CHAR(01)	,
		@cmoneda	CHAR(03)	,
		@cllave1	CHAR(15)	,
		@cpasivo	CHAR(01)	,
		@ctype1		CHAR(02)	,
		@ctype2		CHAR(02)	,
		@ctipoper	CHAR(03)	

	DECLARE @fnominal	FLOAT		,
		@fvalormcdo	FLOAT		,
		@fvan		FLOAT		,
		@ftasacal	FLOAT		,
		@fflujo		FLOAT		,
		@xdur		FLOAT		,
		@xvalue		FLOAT		,
		@ftascal	FLOAT		,
		@ftera		FLOAT 		,
		@ftasemi	FLOAT 		,
		@xpvalue	FLOAT		,
		@fvpresen	FLOAT 		,
		@xporc		FLOAT		,
		@xir		FLOAT		,
		@xdv		FLOAT		,
		@fpremio	FLOAT		,
		@dlibo		FLOAT		,
		@xtasa		FLOAT 		,
		@fvalmon	FLOAT 		,
		@fvalorDOLAR	FLOAT		,
		@fvalorUF	FLOAT		,
		@fvalorUM 	FLOAT		,
		@xpvalueUM	FLOAT		,
		@xtasamtm	NUMERIC(6,2)

	DECLARE @icodmonest 	INTEGER 	,
		@zlibo	 	FLOAT 

	DECLARE @dfecvcto	DATETIME	,
		@dfecucup 	DATETIME 	,
		@dfecemi	DATETIME	,
		@dfeccupon	DATETIME	,
		@dfechoy	DATETIME	,
		@dfecultcupon	DATETIME	,
		@Fecha_Rs	DATETIME

	DECLARE @ntotCRI_CON    INTEGER		,
		@ntotPV01_CON   INTEGER

	DECLARE @ncount 	INTEGER	
	DECLARE @ftasav 	FLOAT 
	DECLARE @cprimera 	CHAR(1)

	DECLARE @iplazo_aux  	INTEGER
	DECLARE @fmontoMEX	FLOAT
	DECLARE @fmontoFIN	FLOAT

	/* VALORIZACION */

	DECLARE    @cProg    CHAR (10)       ,
		   @ctipocar CHAR (01)       ,
        	   @iModcal  INTEGER         ,
	           @dFecven  DATETIME        ,
	           @dFeccal  DATETIME        ,   
	           @fBasemi  FLOAT           ,
	           @fTasest  FLOAT           ,
	           @fTir     FLOAT           ,
	           @fTirBCaps FLOAT          ,
	           @fPvp     FLOAT           ,
	           @fMT      FLOAT           ,
	           @fMTUM    FLOAT           ,
	           @fMT_cien FLOAT           ,
	           @fVpar    FLOAT           ,
	           @fIntucup FLOAT           ,
        	   @fAmoucup FLOAT           ,
	           @fSalucup FLOAT           ,
	           @nNumpcup INTEGER         ,
        	   @dFecpcup DATETIME        ,
	           @fIntpcup FLOAT           ,
	           @fAmopcup FLOAT           ,
	           @fSalpcup FLOAT           ,
	           @fDurat  FLOAT            ,
	           @fConvx  FLOAT            ,
	           @fDurmo  FLOAT            ,
        	   @nError  INTEGER

	SELECT 	@ntotCRI_CON  = 0
	SELECT 	@ntotPV01_CON = 0

	SET NOCOUNT ON

	IF NOT EXISTS( SELECT tasa_mercado
                         FROM VALORIZACION_MERCADO
                        WHERE fecha_valorizacion = @Fecha_Proc )
 	BEGIN
	   SELECT 'NO', 1
           RETURN 0
	END

	SELECT  @dFechoy   = acfecproc FROM mdac 
	SELECT  @dFeccal   = @Fecha_Proc

	SELECT  @fvalorDOLAR = ISNULL(vmvalor,1) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 988 AND vmfecha = @Fecha_Proc 

	IF @fvalorDOLAR IS NULL OR @fvalorDOLAR = 0 SELECT  @fvalorDOLAR = 1

	SELECT  @fvalorUF = ISNULL(vmvalor,1) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 998 AND vmfecha = @Fecha_Proc 

	DELETE CARTERA_PV01

     -- Creo tabla de paso de cartera
     -- ---------------------------------------

        SELECT 'numdocu' = c.cpnumdocu	, 
               'numoper' = c.cpnumdocu	,
               'correla' = c.cpcorrela	, 
               'instser' = c.cpinstser	,
               'mascara' = c.cpmascara	,
               'nominal' = c.cpnominal	,
            'fecvcto' = c.cpfecven  ,
               'numucup' = c.cpnumucup	,
               'fecucup' = c.cpfecucup	,
               'fecemi'  = c.cpfecemi  ,               'tasacal' = c.cptircomp	,
               'codigo'  = c.cpcodigo 	,
               'seriado' = c.cpseriado ,
               'vpresen' = c.cpvptirc  ,
               'valuevan'= ISNULL(c.cpvpcomp,0.0),
               'valorUM' = c.cpvalcomu ,
               'tipocar' = codigo_carterasuper
          INTO #tempdata
          FROM mdcp c
         WHERE 1=2

	IF @Fecha_Proc = @dFechoy
	BEGIN

	   INSERT #tempdata
	   SELECT 'numdocu' = c.cpnumdocu , 
                  'numoper' = c.cpnumdocu ,
                  'correla' = c.cpcorrela , 
                  'instser' = c.cpinstser ,
                  'mascara' = c.cpmascara ,
                  'nominal' = c.cpnominal ,
                  'fecvcto' = c.cpfecven  ,
                  'numucup' = c.cpnumucup ,
                  'fecucup' = c.cpfecucup ,
                  'fecemi'  = c.cpfecemi  ,                  'tasacal' = c.cptircomp ,
                  'codigo'  = c.cpcodigo  ,
                  'seriado' = c.cpseriado ,
                  'vpresen' = c.cpvptirc  ,
                  'valuevan'= ISNULL(c.cpvpcomp,0.0),
                  'valorUM' = c.cpvalcomu ,
                  'tipocar' = codigo_carterasuper
             FROM mdcp	c
            WHERE cpnominal > 0.0

           INSERT #tempdata
	   SELECT 'numdocu' = c.vinumdocu , 
		  'numoper' = c.vinumoper ,
		  'correla' = c.vicorrela , 
		  'instser' = c.viinstser ,
		  'mascara' = c.vimascara ,
		  'nominal' = c.vinominal ,
		  'fecvcto' = c.vifecven  ,
		  'numucup' = 1		  ,
		  'fecucup' = c.vifecucup ,
		  'fecemi'  = c.vifecemi  ,	   	  'tasacal' = c.vitircomp ,
		  'codigo'  = c.vicodigo  ,
		  'seriado' = c.viseriado ,
		  'vpresen' = c.vivptirc  ,
		  'valuevan'= ISNULL(c.vivpcomp,0.0),
	  	  'valorUM' = c.vivalcomu ,
		  'tipocar' = codigo_carterasuper
             FROM mdvi c
	    WHERE vinominal > 0.0
	END
	ELSE
	BEGIN

           SET ROWCOUNT 1
           SELECT @Fecha_Rs = rsfecha FROM MDRS WHERE rsfecha > @Fecha_Proc ORDER BY rsfecha
           SET ROWCOUNT 0

           IF @Fecha_Rs IS NULL
	   BEGIN
	      SELECT 'NO', 2
              RETURN 0
           END

	   INSERT #tempdata
	   SELECT  'numdocu' = c.rsnumdocu	, 
                   'numoper' = c.rsnumoper	,
                   'correla' = c.rscorrela	, 
                   'instser' = c.rsinstser	,
                   'mascara' = c.rsmascara	,
                   'nominal' = c.rsnominal	,
                   'fecvcto' = c.rsfecvcto  	,
                   'numucup' = c.rsnumucup	,
                   'fecucup' = c.rsfecucup	,
                   'fecemi'  = c.rsfecemis  	,                   'tasacal' = c.rstir		,
                   'codigo'  = c.rscodigo 	,
                   'seriado' = ' '  	        ,
                   'vpresen' = c.rsvppresen  	,
                   'valuevan'= ISNULL(c.rsvpcomp,0.0),
                   'valorUM' = c.rsvalcomu 	,
                   'tipocar' = codigo_carterasuper
              FROM mdrs c
             WHERE rsfecha   = @Fecha_Rs
	       AND rscartera IN(111,114)
	       AND rsnominal > 0
	       AND rstipoper = 'DEV'
	END

	SELECT  @itotreg   = COUNT(*) FROM #tempdata 
	SELECT  @icontador = 1

	WHILE @icontador <= @itotreg
	BEGIN

		SET ROWCOUNT @icontador 

		SELECT  
			@nnumdocu = numdocu	, 
			@nnumoper = numoper 	,
			@ncorrela = correla	, 
			@cinstser = instser	,
			@cmascara = mascara 	,
			@fnominal = nominal 	,
			@dfecvcto = fecvcto     ,
			@nnumucup = numucup	,
			@dfecucup = fecucup 	,
			@ftascal  = tasacal	,
			@icodigo  = codigo 	,
			@cseriado = seriado  	,
			@fvpresen = vpresen	,
			@dfecemi  = fecemi	,
			@fvan 	  = valuevan 	,
			@fvalorUM = valorUM     ,
			@ctipocar = tipocar
		FROM 	
			#tempdata

		SET ROWCOUNT 0

		SELECT @ftascal = tasa_mercado,
                       @xpvalue = valor_mercado
		FROM VALORIZACION_MERCADO
		WHERE 	rmnumdocu          = @nnumdocu
	        AND     rmnumoper          = @nnumoper
		AND   	rmcorrela          = @ncorrela 
		AND     fecha_valorizacion = @Fecha_Proc 

		SELECT 	@ctablades = inmdtd		,
			@ctablapre = inmdpr		,
			@ctype1	   = insecuritytype	,
			@ctype2    = insecuritytype2 	,
			@cProg     = 'SP_'+inprog	,
			@iCodigo   = incodigo		,
			@cseriado  = (CASE WHEN @cseriado = ' ' THEN inmdse ELSE @cseriado END)
		FROM	VIEW_INSTRUMENTO
		WHERE   incodigo = @icodigo

		IF @cseriado = 'S'
			SELECT  @itotcupon  = secupones	,
				@iper_cupon = sepervcup ,
				@ibaseemi   = sebasemi	,  
				@imonemi    = semonemi	,
				@nrutemi    = serutemi  ,
				@nrutemi    = serutemi  ,
                                @ftera      = setera
			FROM   VIEW_SERIE
			WHERE semascara = @cmascara
		ELSE
			SELECT 	@imonemi = nsmonemi	,
				@nrutemi = nsrutemi 
			FROM VIEW_NOSERIE
			WHERE nsnumdocu = @nnumdocu 
			AND   nscorrela = @ncorrela 

		/* LETRAS DE EMISION PROPIA */

		IF @icodigo = 20 AND @cinstser IN('COR','BCO')
			SELECT @ftascal = @ftera

       		EXECUTE @nError = @cProg 2, @dFeccal,@iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, 0.0,
                	          @fNominal OUTPUT, @ftascal OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
                         	  @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
                         	  @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

		SELECT	@fvalorUM = @fMtum 

	     /* ______________________________________________________
		Comienzo proceso para papeles con tabla de Desarrollo
		====================================================== */
		IF  @ctablades = 'S'  
		BEGIN

			WHILE 1=1
			BEGIN
				SELECT  @nnumucup = @nnumucup + 1 

				SELECT  @fflujo    = tdflujo FROM VIEW_TABLA_DESARROLLO
 				WHERE tdmascara = @cmascara AND tdcupon = @nnumucup

				IF @@ROWCOUNT = 0 BREAK

				SELECT  @dfeccupon = (DATEADD(MONTH, @iper_cupon * @nnumucup, @dfecemi) ) 		

			     -- Saco diferencial de dias manteniendo condicion de LCHR				
				IF @icodigo = 20 
					EXECUTE sp_difdia30  @Fecha_Proc, @dfeccupon, @iplazo_cupon OUTPUT
				ELSE  
					SELECT  @iplazo_cupon = DATEDIFF( DAY, @Fecha_Proc, @dfeccupon)
	
 				IF @icodigo = 15 SELECT  @ibaseemi  = 365
				IF @iplazo_cupon < 0 CONTINUE 

			     -- Calculo PV01
				SELECT  @xporc     = POWER( (1.0+(@ftascal/100.0)), (CONVERT(FLOAT,@iplazo_cupon)/@ibaseemi)) 
				SELECT  @xpvalue   = ((@fflujo/@xporc)/100)*@fnominal
		                SELECT  @xporc     = (@xpvalue/((@fvan/100.0)*@fnominal))*@fvalorUM
				SELECT  @xpvalueUM = @xporc

                                SELECT @xpvalue = ROUND(@xpvalueUM * vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @imonemi AND vmfecha = @Fecha_Proc 

                                SELECT @xir = @xpvalue

/*
			        SELECT  @xdur    = (CONVERT(FLOAT,@iplazo_cupon)/365.0) 	
--		                SELECT  @xdv     = ((@xdur*(-0.0001))*@xpvalue)
		                SELECT  @xdv     = (@xdur*@xpvalue)
				SELECT  @xir     =  @xdv		
*/
                                INSERT CARTERA_PV01( NUMDOCU,
                                                     NUMOPER,
                                                     CORRELA,
                                                     SERIE,
                                                     FECHA_FLUJO,
                                                     FLUJO,
                                                     TIR_MERCADO,
                                                     TIPO_CARTERA,
 EST_CARTERA,
               MONEDA,
                                                     CODIGO )
                                             VALUES( @nnumdocu,
                                                     @nnumoper,
                                                     @ncorrela,
                                                     @cinstser,
                                                     @dfeccupon,
                                                     @xir,
						     @ftascal,
                                                     @ctipocar,
                                                     (CASE WHEN @nnumdocu <> @nnumoper THEN 'I' ELSE 'D' END),
                                                     @imonemi,
                                                     @icodigo )
			END		   
		END

		IF  @ctablades = 'N' AND  @ctablapre ='N'   -- Papeles no Seriados  - DPF - DPR - BR - BF - BE - FMUTUOS
		BEGIN  
		     -- Condicion de Bonos de Reconocimientos   BE/BR/BD/BF/BA/BC y Otros 		
			IF @icodigo = 888 OR  @icodigo = 889 OR @icodigo = 890 OR  @icodigo = 891
				SELECT  @cmoneda = 'UF'
			ELSE 		
			-- Condicion de Depositos a Plazos US/CL/UF y Fondos Mutuos
			   IF @icodigo = 9 OR  @icodigo = 11 OR @icodigo = 98 OR @icodigo = 13
				SELECT  @cmoneda  = CASE @imonemi WHEN 999 THEN 'KT' ELSE  @cmoneda END
			   ELSE
				SELECT  @cmoneda  = CASE @imonemi WHEN 999 THEN 'VT' ELSE  @cmoneda END

                        INSERT CARTERA_PV01( NUMDOCU,
                                             NUMOPER,
                                             CORRELA,
                                             SERIE,
                                             FECHA_FLUJO,
                                             FLUJO,
                                             TIR_MERCADO,
                                             TIPO_CARTERA,
                                             EST_CARTERA,
                                             MONEDA,
                                             CODIGO )
                                     VALUES( @nnumdocu,
                                             @nnumoper,
                                             @ncorrela,
                                             @cinstser,
                                             @dfecvcto,
                                             @xpvalue,
                                             @ftascal,
                                             @ctipocar,
                                             (CASE WHEN @nnumdocu <> @nnumoper THEN 'I' ELSE 'D' END),
					     @imonemi,
                                             @icodigo )

		END
				
		IF  @ctablades = 'N' AND  @ctablapre ='S' 
		BEGIN  

			SELECT  @itotcupon = secupones ,
				@iper_cupon= sepervcup ,
				@ibaseemi  = sebasemi  , 
				@ftasemi   = setasemi 
			FROM 	VIEW_SERIE
			WHERE 	semascara = @cmascara

			SELECT 	@dlibo	= 0.0, 
				@ncount = 0

			IF @nnumucup = 0  BEGIN
				SELECT  @dfecultcupon 	= @dfecemi	,
					@dlibo 		= @ftasemi	,
					@ftasav		= @ftasemi	
 			END ELSE
			BEGIN
				SELECT  @dfecultcupon = (DATEADD(MONTH, @iper_cupon*@nnumucup, @dfecemi) )	,
					@dlibo        = 0.0
			
				WHILE @dLibo=0.0
				BEGIN	
					SELECT 	@dLibo	= vmvalor FROM VIEW_VALOR_MONEDA WHERE  vmcodigo=222 AND vmfecha=DATEADD(DAY,@nCount*-1,@dfecultcupon) 
					SELECT 	@ncount = @ncount + 1
					IF @nCount>31 BREAK
				END
				SELECT  @ftasav = @dlibo +  prpremio FROM VIEW_PREMIO WHERE prserie=SUBSTRING(@cmascara,4,1) AND prcupon = @nnumucup
			END
		

			SELECT	@icodmonest  = CASE @icodigo  WHEN  1 THEN 301 WHEN 2 THEN 300 ELSE 302 END 
			
			SELECT  @zlibo = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @icodmonest AND vmfecha = @Fecha_Proc 

			WHILE 1=1  
			BEGIN

				SELECT  @nnumucup = @nnumucup + 1 
				SELECT  @dfeccupon = (DATEADD(MONTH, @iper_cupon * @nnumucup, @dfecemi) )
				
				SELECT  @iplazo_cupon = DATEDIFF( DAY, @dfecultcupon, @dfeccupon)
				SELECT  @fpremio = prpremio FROM VIEW_PREMIO WHERE prserie=SUBSTRING(@cmascara,4,1) AND prcupon = @nnumucup

				IF @@ROWCOUNT = 0 BREAK 

				SELECT  @ftascal = (@zlibo + @fpremio)*(@iplazo_cupon/360.0)
				IF @cprimera ='S'
					SELECT  	@ftascal  = @ftascal * (@iplazo_cupon/360.0),
						@cprimera = 'N'

				SELECT  @xvalue = ROUND( 100.0 * @ftascal /100.0,4)

				IF @nnumucup = @itotcupon
					SELECT  @xvalue = ROUND( @xvalue+100.0,4)

				IF @iplazo_cupon < 0 CONTINUE 

				SELECT  @xporc     = POWER( (1.0+(@ftascal/100.0)), (CONVERT(FLOAT,@iplazo_cupon)/@ibaseemi)) 
				SELECT  @xpvalue   = ((@fflujo/@xporc)/100)*@fnominal
		                SELECT  @xporc     = (@xpvalue/((@fvan/100.0)*@fnominal))*@fvalorUM
				SELECT  @xpvalueUM = @xporc

                                SELECT @xpvalue = ROUND(@xpvalueUM * vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @imonemi AND vmfecha = @Fecha_Proc 

                                SELECT @xir = @xpvalue

				SELECT  @dfecultcupon = @dfeccupon   -- Traspaso Fecha ultimo cup+n 

                                INSERT CARTERA_PV01( NUMDOCU,
                                                     NUMOPER,
                                                     CORRELA,
                                                     SERIE,
                                                     FECHA_FLUJO,
                                                     FLUJO,
                                                     TIR_MERCADO,
                                                     TIPO_CARTERA,
                                                     EST_CARTERA,
                                                     MONEDA,
                                                     CODIGO )
                                             VALUES( @nnumdocu,
                                                     @nnumoper,
                                                     @ncorrela,
                                                     @cinstser,
                                                     @dfeccupon,
                                                     @xir,
                                                     @ftascal,
                                                     @ctipocar,
                                                     (CASE WHEN @nnumdocu <> @nnumoper THEN 'I' ELSE 'D' END),
                                                     @imonemi,
                                                     @icodigo )
			END
			
		END

		SELECT  @icontador = @icontador + 1
	END

     /* _________________________________________________________________________________________
     	Realizo proceso para Compras con Pacto
     	========================================================================================== */

	SELECT cinumdocu   , 
	       cicorrela   , 
	       ciinstser   ,
	       cimascara   ,
	       cinominal   ,
	       cifecvenp   ,
	       civptirci   ,
	       cimonpact   ,
	       cicodigo    ,
	       citaspact 
	  INTO #tempdata_ci
	  FROM mdci
         WHERE 1=2

	IF @Fecha_Proc = @dFechoy
	BEGIN
	   INSERT #tempdata_ci
	   SELECT cinumdocu  ,
	          cicorrela  , 
	          ciinstser  ,
	          (CASE WHEN LEFT(ciinstser,4) IN ('ICOL','ICAP') THEN ciinstser ELSE 'PACTO' END),
	          cinominal  ,
	          cifecvenp  ,
	          (CASE WHEN LEFT(ciinstser,4) IN ('ICOL','ICAP') THEN civptirc ELSE civptirci END),
	          cimonpact  ,
	          cicodigo   ,
	          citaspact 
 	     FROM mdci
            WHERE cinominal > 0.0
	END
	BEGIN
	   INSERT #tempdata_ci
	   SELECT rsnumdocu  ,
	          rscorrela  , 
	          rsinstser  ,
	          (CASE WHEN LEFT(rsinstser,4) IN ('ICOL','ICAP') THEN rsinstser ELSE 'PACTO' END),
	          rsnominal  ,
	          rsfecvtop  ,
	          rsvppresen ,
	          rsmonpact  ,
	          rscodigo   ,
	          rstaspact 
 	     FROM mdrs
            WHERE rsfecha   = @Fecha_Proc
	      AND rscartera = 112
	      AND rstipoper = 'DEV'

	END

	SELECT  @itotreg   = COUNT(*) FROM #tempdata_ci 
	SELECT  @icontador = 1

	WHILE @icontador <= @itotreg
	BEGIN

		SET ROWCOUNT @icontador 
		SELECT  
			@nnumdocu = cinumdocu	, 
			@nnumoper = cinumdocu	,
			@ncorrela = cicorrela	, 
			@cinstser = ciinstser	,
			@cmascara = cimascara	,
			@fnominal = cinominal 	,
			@dfecvcto = cifecvenp   ,
			@fvpresen = civptirci   ,
			@imonemi  = cimonpact	,
			@icodigo  = cicodigo    ,
                        @ftascal  = citaspact 
		FROM	#tempdata_ci 

		SET ROWCOUNT 0

		SELECT  @icontador = @icontador + 1
	
                INSERT CARTERA_PV01( NUMDOCU	,
                                     NUMOPER	,
                                     CORRELA	,
                                     SERIE	,
                                     FECHA_FLUJO,
                                     FLUJO	,
                                     TIR_MERCADO,
                                     TIPO_CARTERA,
                                     EST_CARTERA,
                                     MONEDA	,
                                     CODIGO 	)
                             VALUES( @nnumdocu	,
                                     @nnumoper	,
                                     @ncorrela	,
                                     @cmascara	,
                                     @dfecvcto	,
                                     @fvpresen	,
                                     @ftascal	,
                                     @ctipocar	,
                                     'D'	,
                                     @imonemi	,
                                     0 		)

	END
	IF (SELECT COUNT(*) FROM CARTERA_PV01)>=0	
		SELECT 'SI',COUNT(*) FROM CARTERA_PV01	
	ELSE
		SELECT 'NO',0

END   /* FIN PROCEDIMIENTO */

--SP_INTERFAZ_PV01_OLD '20040531'
--SP_ARCHIVOPV01 '20040531'








GO
