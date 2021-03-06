USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCPCON_REPROCESO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE prOCEDURE [dbo].[SP_LISTADOCPCON_REPROCESO]
	(	@tipo_cartera	CHAR(03)
	,	@tipo_opera	CHAR(05)
	,	@entidad	FLOAT
	,	@fechaProc	CHAR(08)
	,	@fechaProx	CHAR(08)
	,	@titulo		VARCHAR(80)
	,	@carterasuper	CHAR(01)
	,	@cDolar		CHAR(01)
	,	@Cartera_Inv	Integer	
	,	@Cat_Libro	CHAR(06)
	,	@Id_Libro	CHAR(06) = ''
	)
AS 
BEGIN 
	
 SET NOCOUNT ON

 DECLARE @acfecproc  CHAR (10)     ,
         @acfecprox  CHAR (10)     ,
         @uf_hoy     FLOAT         ,
         @uf_man     FLOAT         ,
         @ivp_hoy    FLOAT         ,
         @ivp_man    FLOAT         ,
         @do_hoy     FLOAT         ,
         @do_man     FLOAT         ,
         @da_hoy     FLOAT         ,
         @da_man     FLOAT         ,
         @acnomprop  CHAR (40)     ,
         @rut_empresa CHAR (12)    ,
         @nRutemp    NUMERIC (09,0),
         @hora       CHAR (08)     ,
         @paso       CHAR (01)     ,
	 @fec_ante	DATETIME	,	
         @fec_proc   DATETIME	   ,
         @x               INTEGER  ,
         @max             INTEGER  ,
         @TASA            NUMERIC(19,4)  ,
         @numero          INTEGER  ,
         @correla         INTEGER  ,
	 @fec_prox        DATETIME ,
 	 @dFecFMesProx    DATETIME ,
	 @dfecfmes        DATETIME ,
	 @fecha_compra	  DATETIME ,
         @FechaTMAyer     DATETIME ,
         @Glosa_Cartera	  CHAR(20)	,
         @Glosa_Libro	  CHAR(50)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
--	   ORDER BY rcrut --REQ.7619 CASS 25-01-2011

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'

 EXECUTE Sp_Base_Del_Informe
           @acfecproc OUTPUT       ,
           @acfecprox OUTPUT       ,
           @uf_hoy  OUTPUT         ,
           @uf_man  OUTPUT         ,
           @ivp_hoy OUTPUT         ,
           @ivp_man OUTPUT         ,
           @do_hoy  OUTPUT         ,
           @do_man  OUTPUT         ,
           @da_hoy  OUTPUT         ,
           @da_man  OUTPUT         ,
           @acnomprop OUTPUT       ,      
           @rut_empresa OUTPUT     ,
           @hora  OUTPUT

	SELECT	@nRutemp	= acrutprop 
	,	@paso		= 'N'
	,	@fec_ante	= acfecante
	,	@fec_proc	= acfecproc
	,	@fec_prox	= acfecprox
	FROM 	MDAC0430

	SET @dfecfmes		= DATEADD(DAY,DATEPART(DAY,@fec_prox) * -1,@fec_prox)
	SET @dFecFMesProx	= DATEADD( MONTH, 1, @fec_prox)
	SET @dFecFMesProx	= DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@dFecFMesProx)) * -1, CONVERT(DATETIME,@dFecFMesProx ))
-- GLCF	SET @dFecFMesAnt	= DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@fec_prox)) * -1, CONVERT(DATETIME,@fec_prox))

	IF DATEPART(MONTH, @fec_proc) <> DATEPART(MONTH, @fec_ante) BEGIN
		SELECT	@FechaTMAyer	= DATEADD(DAY, -1, SUBSTRING(CONVERT(CHAR(8), @fec_proc, 112), 1, 6) + '01')
	END
	ELSE BEGIN
		SELECT	@FechaTMAyer	= @fec_ante
	END


  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END

 SELECT  'numdoc'         = (CONVERT(VARCHAR(9),ISNULL(rsnumoper,0))+'-'+CONVERT(VARCHAR(10),ISNULL(rscorrela,0))), -- 1
         'rscorrela'      = ISNULL(rscorrela,0)                                , -- 2
         'rsinstser'      = ISNULL(rsinstser,' ')                              , -- 3
         'emisor'         = CASE WHEN rscodigo = 98 THEN ( SELECT clgeneric FROM view_cliente WHERE clrut=rsrutcli AND clcodigo=rscodcli )
                                 ELSE ( SELECT emgeneric FROM view_emisor WHERE emrut=rsrutemis )
                            END                                                  , --4
         'fechacompra'    = ISNULL(CONVERT(CHAR(10),rsfeccomp,103),' ' )        , -- 5
       'fechavcto'      = CASE
                                 WHEN rsinstser='FMUTUO' OR rsfecvcto='19000101' THEN ' '
                                 ELSE ISNULL(CONVERT(CHAR(10),rsfecvcto,103),' ' )
                             END                                               ,
         'dt'             = ISNULL(DATEDIFF(dd, rsfecvtop, rsfeccomp),0)         , -- 7

         'dd'             = ISNULL(DATEDIFF(dd, acfecproc, rsfeccomp),0)        , -- 8

         'rsvalcomu'      = ISNULL(CONVERT(NUMERIC(19,4),rsvalcomu),0.0)       , -- 9
         'um'             = (SELECT ISNULL(mnnemo,' ') FROM VIEW_MONEDA WHERE mncodmon=rsmonemi)   , -- 10
         'rsnominal'      = ISNULL(rsnominal,0.0)                              , -- 11
         'cupon'          = ISNULL((rsvalvenc),0.0)                            , -- 12
         'rscupint'       = ISNULL(rscupint,0.0)                               , -- 13
         'rstir'          = ISNULL(CONVERT(FLOAT,rstir),0.0)                   , -- 14
         'rsvpcomp'       = ISNULL(rsvpcomp,0.0)                               , -- 15
         'rsvppresen'     = ISNULL(rsvalcomp,0.0)                              , -- 16
         'rsinteres'      = ISNULL(rsinteres,0.0)                              , -- 17
         'rsreajuste'     = ISNULL(rsreajuste,0.0)                             , -- 18
         'rsintermes'     = ISNULL(rsintermes,0.0)                             , -- 19
         'rsreajumes'     = ISNULL(rsreajumes,0.0)                             , -- 20
	 'rsvppresenx'    = ISNULL(rsvppresenx,0.0)                            , -- 21
         'rsinteres_acum' = ISNULL(rsinteres_acum-rsinteres,0.0)               , -- 22
         'rsreajuste_acum'= ISNULL(rsreajuste_acum-rsreajuste,0.0)             , -- 23
         'rscodigo'       = ISNULL(rscodigo,0)                                 , -- 24
         'instrumento'    = (SELECT ISNULL(inglosa,'*') FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo)  , -- 25
         'inserie'        = (CASE WHEN rscodigo = 20 AND rsrutemis = 97030000 AND rsmonemi = 997 THEN 'LCHRBEIVP'
                                  WHEN rscodigo = 20 AND rsrutemis = 97030000 AND rsmonemi = 998 THEN 'LCHRBEUF'
                                  WHEN rscodigo = 20 AND rsrutemis = 97023000                    THEN 'LCHRP'
                                  WHEN rscodigo = 20                                             THEN 'LCHRO'
                                  ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo) 
                            END), -- 26
         'titulo'       = @titulo                                              , -- 27
         'sw'           = '0'                                                  , -- 28
         'rsfecprox'    = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')          , -- 29
         'rsfecctb'     = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')           ,
         'rsvpproceso'  = ISNULL(rsvppresen,0.0)                               ,
         'rsfeccupon'   = ISNULL(CONVERT(CHAR(10),rsfecpcup,103),' ')          ,
         'fechaaux'     = rsfecvcto,
         'monemi'       = rsmonemi ,
         'TASA_EMISION' = rstasemi ,
         'TASA_MERCADO' = rstir,
         'Fecha_tasmer' = rsfecha,
         'TIR_EMISOR'   = (SELECT inmdse FROM view_instrumento WHERE incodigo=rscodigo),
         'Prima'        =  prima_descuento_dia,
	 'numoper'      = rsnumoper		,
         'Tipo_Cart'	= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  rstipcart),
         'Tipo_InV'	= @Glosa_Cartera	,
	 'Clasificacion1'=CASE WHEN rtrim(LTRIM(CONVERT( CHAR(40),clasificacion1))) = '' THEN '---' else rtrim(LTRIM(CONVERT( CHAR(40),clasificacion1))) END,
	 'Clasificacion2'=CASE WHEN rtrim(LTRIM(CONVERT( CHAR(40),clasificacion2))) = '' THEN '---' else rtrim(LTRIM(CONVERT( CHAR(40),clasificacion2))) END,
	 'Tipo_corto1'	= CASE WHEN rtrim(LTRIM(CONVERT( CHAR(40),tipo_corto1))) = '' THEN '---' else rtrim(LTRIM(CONVERT( CHAR(40),tipo_corto1))) END,
	 'Tipo_largo1'	= CASE WHEN rtrim(LTRIM(CONVERT( CHAR(40),tipo_largo1))) = '' THEN '---' else rtrim(LTRIM(CONVERT( CHAR(40),tipo_largo1))) END,
	 'Tipo_corto2'	= CASE WHEN rtrim(LTRIM(CONVERT( CHAR(40),tipo_corto2))) = '' THEN '---' else rtrim(LTRIM(CONVERT( CHAR(40),tipo_corto2))) END,
	 'Tipo_largo2'	= CASE WHEN rtrim(LTRIM(CONVERT( CHAR(40),tipo_largo2))) = '' THEN '---' else rtrim(LTRIM(CONVERT( CHAR(40),tipo_largo2)))END,
	'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND	tbcodigo1 = rsid_libro),'No Definido') ,
	'Cartera_Super'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1111' AND	tbcodigo1 = MDRS0430.codigo_carterasuper),'No Definido') ,
	'Glosa_libro'	= @Glosa_Libro,
	'OPERADOR'	= mousuario
	INTO #TEMPORAL
        FROM MDRS0430 
             INNER JOIN BacParamSuda.dbo.EMISOR ON emrut   = rsrutemis
             INNER JOIN BacTraderSuda.dbo.MDMH  ON motipoper = 'CP' and monumdocu = rsnumdocu and mocorrela = rscorrela
           , MDAC0430
        WHERE rsfecha   = acfecprox
          AND rstipoper = 'DEV'
          AND rscartera = '111'
          AND rsrutemis <> 97023000
	  AND MDRS0430.codigo_carterasuper = @carterasuper 
	  AND (rstipcart                   = @Cartera_INV OR @Cartera_INV = 0) 
	  AND (rsid_libro                  = @id_libro    OR @id_libro	  = '')

   IF @cDolar='N' 
   BEGIN
      DELETE #TEMPORAL WHERE monemi <> 997 AND monemi <> 998 AND monemi <> 999
   END ELSE 
   BEGIN
      DELETE #TEMPORAL WHERE monemi = 997 OR monemi = 998 or monemi = 999
   END

 IF (SELECT COUNT(1) FROM #TEMPORAL)> 0
 BEGIN
  SELECT  inserie                             ,
          rsfecprox                           ,
          rsfecctb                            ,
          um                                  ,
         'rsnominal'      = SUM(rsnominal)    ,
         'rsvalcomu'      = SUM(rsvalcomu)    ,
         'rsvppresen'     = SUM(rsvppresen)   ,
         'rsvpproceso'    = SUM(rsvpproceso)  ,
         'rsinteres'      = SUM(rsinteres)    , 
         'rsreajuste'     = SUM(rsreajuste)   ,
         'rsintermes'     = SUM(rsintermes)   ,
	 'rsreajumes'   = SUM(rsreajumes)  ,
         'rsvppresenx'     = SUM(rsvppresenx) ,
         'rsinteres_acum'  = SUM(rsinteres_acum) ,
         'rsreajuste_acum' = SUM(rsreajuste_acum) ,
         'rstir'   = SUM(rstir*rsvppresen)/SUM((CASE WHEN rsvppresen = 0 THEN 1 ELSE rsvppresen END)),
         'Prima'   = sum(Prima)
  INTO #TOTAL
  FROM #TEMPORAL
  GROUP BY inserie,rsfecprox,rsfecctb, um

  INSERT INTO #TEMPORAL
  SELECT ''              , -- 1
         0               , -- 2
         case when left( inserie, 4 ) = 'LCHR' THEN 'LCHR      ' ELSE inserie END        , -- 3
         um              ,
         ''              , -- 5
         ''              , -- 6
         0               , -- 7
         0               , -- 8
         rsvalcomu       , -- 9
         ''              , -- 10
         rsnominal       , -- 11
         0               , -- 12
         0               , -- 13
         rstir           , -- 14
         0               , -- 15
         rsvppresen      , -- 16
         rsinteres       , -- 17
         rsreajuste      , -- 18
         rsintermes      , -- 19
         rsreajumes      , -- 20
         rsvppresenx     , -- 21
         rsinteres_acum  , -- 22
         rsreajuste_acum , -- 23
         0      , -- 24
         'TOTAL'         , -- 25
         INSERIE         , -- 26   --inseri
         ''              , -- 27
         'sw' = '1'      , -- 28
         rsfecprox       , -- 29
         rsfecctb        , -- 30
         rsvpproceso     ,
         ''              ,
         ''              ,
         0               ,
0               ,
         0               ,
         ''   ,
         ''		 ,
         0		 ,
	 0		 ,
	 ''		 ,
	@Glosa_Cartera   ,
        ''		 ,
	''		 ,
	''		 ,
	''		 ,
	''		 ,
	''		 ,
	''		 ,
	''		 ,
	@Glosa_Libro	,
	' '
        FROM #TOTAL
 END
 ELSE
 BEGIN
  INSERT INTO #TEMPORAL
  SELECT ''        , -- 1
         0         , -- 2
         ''        , -- 3
         ''        , -- 4
         ''        , -- 5
         ''        , -- 6
         0         , -- 7
         0         , -- 8
        0     , -- 9
         ''      , -- 10
         0         , -- 11
         0         , -- 12
         0         , -- 13
         0         , -- 14
         0         , -- 15
         0         , -- 16
         0         , -- 17
         0         , -- 18
         0         , -- 19
         0         , -- 20
         0         , -- 21
         0         , -- 22
         0         , -- 23
         0         , -- 24
         ''        , -- 25
         ''        , -- 26
         @titulo   , -- 27
         '0'       , -- 28
         CONVERT(CHAR(10),CONVERT(DATETIME,@fechaProx),103), --29
         CONVERT(CHAR(10),CONVERT(DATETIME,@fechaProc),103),
         0         ,
         ''        ,
         ''        ,
         0         ,
         0         ,
         0         ,
         ''        ,
         ''        ,
         0         ,
	 0	   ,
	''	   ,
	@Glosa_Cartera,
        ''	   ,
	''	   ,
	''	   ,
	''	   ,
	''	   ,
	''	   ,
	''	   ,
	''	    ,
	@Glosa_Libro,
	' '
  END

   IF EXISTS(SELECT 1 FROM TASA_MERCADO, MDAC0430 WHERE fecha_proceso = acfecproc)
   BEGIN
	UPDATE	#TEMPORAL 
	SET	Tasa_Mercado	= ISNULL(TASA_MERCADO.tasa_mercado,0) 
	,	Fecha_tasmer	= acfecproc
	FROM	TASA_MERCADO
         ,      MDAC0430
	WHERE	fecha_proceso	=  acfecproc
	AND	id_sistema	=  'BTR' 
	AND	tminstser	=  rsinstser 
	--> AND	fechacompra	<= acfecproc
   END ELSE
   BEGIN
      UPDATE #TEMPORAL 
      SET    Tasa_Mercado   = ISNULL(TASA_MERCADO.tasa_mercado,0) 
      ,      Fecha_tasmer   = @FechaTMAyer
      FROM   TASA_MERCADO
      WHERE  fecha_proceso  =  @FechaTMAyer -- GLCF @dFecFMesAnt
      AND    id_sistema	    =  'BTR' 
      AND    tminstser	    =  rsinstser 
      AND    fechacompra   <= @FechaTMAyer -- GLCF @dFecFMesAnt 
   END
	/*----------------------------------------------------------------------------------------*/
	/*           CUANDO NO ES FIN DE MES, SI LA TASA ES CERO SE COLOCA LA TIR DE COMPRA       */
	UPDATE	#TEMPORAL 
	SET	TASA_MERCADO	= TASA_MERCADO 
	WHERE	TASA_MERCADO	= 0
	/*-----------------------------------------------------------------------------------------*/




SELECT  numdoc        , -- 1
         rscorrela     , -- 2
         rsinstser     , -- 3
         emisor        , -- 4
         fechacompra  /* CONVERT(CHAR(10),fechacompra,103)   */, -- 5
         fechavcto     , -- 6
         dt            , -- 7
         dd            , -- 8
         rsvalcomu     , -- 9
         um            , -- 10
         rsnominal     , -- 11
         cupon AS 'cupon'   , -- 12
         rscupint      , -- 13
         rstir         , -- 14
         rsvpcomp      , -- 15
         rsvppresen    , -- 16
         rsinteres     , -- 17
         rsreajuste    , -- 18
         rsintermes    , -- 19
         rsreajumes    , -- 20
         rsvppresenx       , -- 21
         rsinteres_acum    , -- 22
         rsreajuste_acum   , -- 23
         rscodigo          , -- 24
         instrumento       , -- 25
         'inserie' = CASE inserie WHEN 'LCHRBEIVP' THEN 'LCHR B.ESTADO IVP'
                      WHEN 'LCHRBEUF'  THEN 'LCHR B.ESTADO UF'
                      WHEN 'LCHRP'     THEN 'LCHR PROPIA'
 	 WHEN 'LCHRO'     THEN 'LCHR OTROS'
                                       ELSE (inserie + um)
         END                  , -- 26
         CASE
                WHEN sw='1' THEN 'RESUMEN '+ @titulo+SPACE(3)+'DEL'+SPACE(3)+ rsfecctb+SPACE(3)+'AL'+SPACE(3)+rsfecprox
                ELSE titulo+SPACE(3)+'DEL'+SPACE(3)+rsfecctb+SPACE(3)+'AL'+SPACE(3)+rsfecprox
         END
       AS 'titulo' , -- 27
--       'fecproc'   = @acfecproc  , -- 28
--       'fecprox'   = @acfecprox  , -- 29
--       'uf_hoy'    = @uf_hoy  , -- 30
--       'uf_man'    = @uf_man  , -- 31
--       'ivp_hoy'   = @ivp_hoy  , -- 32
--       'ivp_man'   = @ivp_man  , -- 33
--       'do_hoy'    = @do_hoy  , -- 34
--       'do_man'    = @do_man  , -- 35
--       'da_hoy'    = @da_hoy  , -- 36
--       'da_man'    = @da_man  , -- 37
--       'acnomprop' = (SELECT ISNULL(@acnomprop,'NO DEFINIDO') FROM MDAC0430 )    , -- 38
--       'rut_empresa'   = @rut_empresa                     , -- 39
--       'nombreentidad' = (SELECT ISNULL(acnomprop,'NO DEFINIDO') FROM MDAC0430 ) , -- 40
--       'hora'      = @hora                                                   , -- 41
--       sw                                                                    , -- 42
         'tirXnominal' = rstir*rsnominal                                       , -- 43
         'Fecha1'      = SUBSTRING(@fechaProc,7,2)+'/'+SUBSTRING(@fechaProc,5,2)+'/'+SUBSTRING(@fechaProc,1,4) , 
         'Fecha2'      = SUBSTRING(@fechaProx,7,2)+'/'+SUBSTRING(@fechaProx,5,2)+'/'+SUBSTRING(@fechaProx,1,4) ,
         'rsfecprox'   = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')  ,
         'rsfecctb'    = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')   ,
         rsvpproceso                                                  ,
--       rsfeccupon                                                   ,
--       fechaaux   ,
         TASA_EMISION,
         TASA_MERCADO,
         Fecha_tasmer,
         TIR_EMISOR ,
--       Prima	    ,
	 numoper    ,
	Tipo_Cart	,	
	Tipo_inv	,
--	Clasificacion1	,
-- 	Casificacion2	,
--	Tipo_corto1	,
--	Tipo_largo1	,
--	Tipo_corto2	,
--	Tipo_largo2	,
	Libro		,
	Cartera_Super	,
	Glosa_Libro	,
	OPERADOR
    FROM #TEMPORAL
    ORDER BY sw,rsinstser 

	SET NOCOUNT OFF
 
END

GO
