USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCPCON_LCHR]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- sp_listadoCPCON_lchr 111, 'CP', 0, '20160301', '20160302', 'CAETERA DE INVERSIONES COMPRAS DE LETRAS', '', 'N', '', 1552, ''


CREATE PROCEDURE [dbo].[SP_LISTADOCPCON_LCHR]
   (
            @tipo_cartera  CHAR (03) = ''     ,
            @tipo_opera    CHAR (05) = ''     ,
            @entidad       FLOAT              ,
            @fechaProc     CHAR (08)          ,
            @fechaProx     CHAR (08)          ,
            @titulo        VARCHAR (120)= ''  ,   
            @carterasuper  CHAR (01)    = ''  ,
            @cDolar        CHAR (01)	      ,
	    @Cartera_Inv   Integer   = 0      ,
	    @Cat_Libro	   CHAR(06)  = ''     ,
	    @Id_Libro	   CHAR(06)  = ''
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
         @fec_proc   DATETIME	   ,
	 @rut_bco    NUMERIC(9)    ,
         @dFecFMesAnt     DATETIME ,
	 @fec_prox        DATETIME ,
 	 @dFecFMesProx    DATETIME ,
	 @dfecfmes        DATETIME ,
  	 @Glosa_Cartera Char   (20),
  	 @Glosa_Libro	  Char(50)


	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
	--   ORDER BY rcrut --REQ.7619 CASS 25-01-2011

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'

  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END


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

		-- FUSION ---
		SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
		-------------

   SET @dfecfmes = DATEADD(DAY,DATEPART(DAY,@fec_prox) * -1,@fec_prox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @fec_prox)
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@dFecFMesProx)) * -1, CONVERT(DATETIME,@dFecFMesProx ))
   SET @dFecFMesAnt = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@fec_prox)) * -1, CONVERT(DATETIME,@fec_prox))


 SELECT @nRutemp  = acrutprop ,
        @paso     = 'N',
        @fec_proc = acfecproc
  FROM MDAC

 SELECT @Rut_bco  = rcrut
  FROM VIEW_ENTIDAD

 SELECT  'numdoc'         = (CONVERT(VARCHAR(9),ISNULL(rsnumoper,0))+'-'+CONVERT(VARCHAR(10),ISNULL(rscorrela,0))), -- 1
         'rscorrela'      = ISNULL(rscorrela,0)                                , -- 2
         'rsinstser'      = ISNULL(rsinstser,' ')                              , -- 3
         'emisor'         = CASE WHEN rscodigo = 98 THEN ( SELECT clgeneric FROM view_cliente WHERE clrut=rsrutcli AND clcodigo=rscodcli )
                                 ELSE                    ( SELECT emgeneric FROM view_emisor  WHERE emrut=rsrutemis )
                            END                                                  , --4
         'fechacompra'    = ISNULL(CONVERT(CHAR(10),rsfeccomp,103),' ')        , -- 5
         'fechavcto'      = CASE WHEN rsinstser='FMUTUO' OR rsfecvcto='19000101' THEN ' '
                                 ELSE                                                 ISNULL(CONVERT(CHAR(10),rsfecvcto,103),' ' )
    END   ,
         'dt'             = ISNULL(DATEDIFF(dd,rsfecvtop,rsfeccomp),0)         , -- 7
         'dd'             = ISNULL(DATEDIFF(dd,@fechaProc,rsfeccomp),0)        , -- 8
         'rsvalcomu'      = ISNULL(CONVERT(NUMERIC(19,4),rsvalcomu),0.0)       , -- 9
         'um'             = (SELECT ISNULL(mnnemo,' ') FROM VIEW_MONEDA WHERE mncodmon=rsmonemi)  , -- 10
         'rsnominal'      = ISNULL(rsnominal,0.0)                              , -- 11
         'cupon'          = ISNULL((rsvalvenc),0.0)                            , -- 12
         'rscupint'       = ISNULL(rscupint,0.0)                               , -- 13
         'rstir'          = ISNULL(CONVERT(FLOAT,rstir),0.0)                   , -- 14
         'rsvpcomp'       = ISNULL(rsvpcomp,0.0)                               , -- 15
         'rsvppresen'     = ISNULL(rsvppresen,0.0)                              , -- 16
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
         'titulo'       = 'CARTERA DE INVERSIONES COMPRAS DE LETRAS'                                   , -- 27
         'sw'           = '0'                                                  , -- 28
         'rsfecprox'    = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')          , -- 29
         'rsfecctb'     = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')           ,
         'rsvpproceso'  = ISNULL(rsvppresen,0.0)                               ,
         'rsfeccupon'   = ISNULL(CONVERT(CHAR(10),rsfecpcup,103),' ')          ,
         'fechaaux'     = rsfecvcto,
         'monemi'       = rsmonemi ,
         'TASA_EMISION' = rstasemi ,
         'TASA_MERCADO' = rstir, /*CASE WHEN rsfecha = @fec_proc THEN ISNULL(CONVERT(NUMERIC(8,4),( SELECT MAX(tasa_mercado) FROM tasa_mercado WHERE tminstser = rsinstser  AND  fecha_proceso = @fec_proc) ),rstir)
                           ELSE  CONVERT(NUMERIC(8,4), 0.0 ) END ,*/

         'Fecha_tasmer' = rsfecha,
         'TIR_EMISOR'   = (SELECT inmdse FROM view_instrumento WHERE incodigo=rscodigo),
	 'valor_par'    = valor_par,
         'Prima'        = prima_descuento_dia,
         'tasa_emis'    = valor_tasa_emision,
         'prima_total'  = prima_descuento_total,
   	 'acum'		= CASE  
			   WHEN @fechaProc>cpfeccomp THEN ROUND(ISNULL( prima_descuento_total /DATEDIFF (dd,cpfeccomp,cpfecven),0)* ISNULL(DATEDIFF (dd,cpfeccomp,@fec_proc),0),0)--ISNULL(DATEDIFF (dd,cpfeccomp,@fecpro)* prima_descuento_dia,0)
			   ELSE 0
			 END,
	 'tasemi'	= ISNULL(R.setasemi,0.0), -- ISNULL((SELECT setasemi FROM VIEW_SERIE WHERE rsmascara=semascara),0), --> 22 Enero 2007
	 'descuento'    = case when prima_descuento_total < 0 then  prima_descuento_total else 0 end,
         'primatotal'	= case when prima_descuento_total > 0 then  prima_descuento_total else 0 end,
	 'primaacum_des'    = case when cpprimdescacum < 0 then cpprimdescacum else 0 end,
	 'primaacum_prim'   = case when cpprimdescacum > 0 then cpprimdescacum else 0 end,	
	 'valor_compra' = isnull(cpvalcomp,0),
     	 'Vardiariaprima'= case when PRIMA_DESCUENTO_DIA > 0 then  PRIMA_DESCUENTO_DIA else 0 end,
	 'Vardiariadesc' = case when PRIMA_DESCUENTO_DIA < 0 then  PRIMA_DESCUENTO_DIA else 0 end,
         'CARTERA'      = MDCP.CODIGO_CARTERASUPER,
	 'tir_original' = tir_compra_original	,
	 'Tipo_Cart'	 = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  rstipcart),
   	 'Tipo_InV'	 = @Glosa_Cartera
	,	'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = rsid_libro),'') 
	,	'Glosa_libro'	= @Glosa_Libro
	INTO    #TEMPORAL
	FROM	MDRS
	,	MDCP
                LEFT JOIN BacParamSuda..SERIE R ON R.semascara = cpmascara
	WHERE	rstipopero	= @tipo_opera 
	AND	rsfecha		= @fechaProx 
	AND	rsnominal	> 0 
	AND	rstipoper	= 'DEV' 
	AND	rscartera	= '111' 
	AND	rsrutemis	= @Rut_bco 
	and	rscodigo	= 20 
	AND	rsnumdocu	= cpnumdocu 
	AND	rscorrela	= cpcorrela
	AND	(rstipcart	= @Cartera_INV OR @Cartera_INV = 0 ) 
	AND	(id_libro	= @id_libro    OR @id_libro    = '')


        --> 22 Enero 2007
        SELECT FechaProc = MAX(fecha_proceso) 
        ,      Serie     = tminstser
        INTO   #TmpSeries
        FROM   TASA_MERCADO
        GROUP BY tminstser

        UPDATE #TEMPORAL
           SET Fecha_tasmer = FechaProc
          FROM #TmpSeries
         WHERE rsinstser    = Serie


/*
 UPDATE #TEMPORAL set Fecha_tasmer = isnull((select max(fecha_proceso) from tasa_mercado
                                       where tminstser = rsinstser ),0)
*/



 IF @cDolar='N' BEGIN
     DELETE #TEMPORAL WHERE monemi <> 997 AND monemi <> 998 AND monemi <> 999
 END else begin
     DELETE #TEMPORAL WHERE monemi = 997 OR monemi = 998 or monemi = 999
 END

 IF (SELECT COUNT(1) FROM #TEMPORAL)> 0
 BEGIN
 SELECT  inserie                             ,
          rsfecprox           ,
          rsfecctb                            ,
          um                                  ,
         'rsnominal'      = SUM(rsnominal)    ,
         'rsvalcomu'      = SUM(rsvalcomu)    ,
         'rsvppresen'     = SUM(rsvppresen)   ,
         'rsvpproceso'    = SUM(rsvpproceso)  ,
         'rsinteres'      = SUM(rsinteres)    , 
         'rsreajuste'     = SUM(rsreajuste)   ,
         'rsintermes'     = SUM(rsintermes)   ,
	 'rsreajumes'      = SUM(rsreajumes)  ,
         'rsvppresenx'     = SUM(rsvppresenx) ,
         'rsinteres_acum'  = SUM(rsinteres_acum) ,
         'rsreajuste_acum' = SUM(rsreajuste_acum) ,
         'rstir'   = SUM(rstir*rsvppresen)/SUM((CASE WHEN rsvppresen = 0 THEN 1 ELSE rsvppresen END)),
         'Prima'   = sum(Prima),
	 'descuento'    = sum(descuento) ,
         'primatotal'	= sum(primatotal),
     	 'Vardiariaprima'= sum(Vardiariaprima),
	 'Vardiariadesc' = sum(Vardiariadesc),
         'primaacum_prim'= sum(primaacum_prim),
         'primaacum_des' = sum(primaacum_des)
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
         ''              ,
         ''		 ,
         0		 ,
	 0		 ,
         0		 ,
         0		 ,
	 0		 ,
	 0               ,
   	 descuento	 ,
         primatotal      ,
	 primaacum_des	 ,
	 primaacum_prim	 ,
	 0               ,
     	 Vardiariaprima  ,
	 Vardiariadesc   ,
         ''		 ,
	 0		 ,
	 ''		 ,
	 @Glosa_Cartera	,
	 ''		 ,
	 @Glosa_Libro

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
         0         , -- 9
         ''        , -- 10
         0         , -- 11
         0         , -- 12
         0         , -- 13
         0         , -- 14
         0         , -- 15
         0   , -- 16
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
         0	   ,
	 0	   ,
	 0         ,
	 0	   ,
	 0         ,
	 0	   ,
         0	   ,
	 0	   ,
         0	   ,
	 0	   ,
	 0	   ,
	 0	   ,
	 0         ,
         ''	   ,
	 0	   ,
	 ''	   ,
	 @Glosa_Cartera	,
 	 ''		,
	 @Glosa_Libro

  END


 UPDATE #TEMPORAL SET TASA_MERCADO = ISNULL(TASA_MERCADO.tasa_mercado,0) FROM TASA_MERCADO
                                         WHERE  fecha_proceso = @dFecFMesAnt
                                          AND  id_sistema     = 'BTR' 
                                          AND  tminstser      = rsinstser 
                                          AND  tmnominal      = rsnominal 
					  AND  fechacompra    <=@dFecFMesAnt 


/*----------------------------------------------------------------------------------------*/
/*           CUANDO NO ES FIN DE MES, SI LA TASA ES CERO SE COLOCA LA TIR DE COMPRA       */
  UPDATE #TEMPORAL SET TASA_MERCADO = TASA_MERCADO where  TASA_MERCADO = 0
/*-----------------------------------------------------------------------------------------*/


 SELECT  numdoc        , -- 1
         rscorrela     , -- 2
        rsinstser    , -- 3
         emisor        , -- 4
         fechacompra   , -- 5
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
                      WHEN 'LCHRO'    THEN 'LCHR OTROS'
                                       ELSE (inserie + um)
         END                  , -- 26
         CASE
WHEN sw='1' THEN 'RESUMEN '+ @titulo+SPACE(3)+'DEL'+SPACE(3)+ rsfecctb+SPACE(3)+'AL'+SPACE(3)+rsfecprox
                ELSE titulo+SPACE(3)+'DEL'+SPACE(3)+rsfecctb+SPACE(3)+'AL'+SPACE(3)+rsfecprox
         END
         AS 'titulo'       , -- 27
         'fecproc'   = @acfecproc  , -- 28
         'fecprox'   = @acfecprox  , -- 29
         'uf_hoy'    = @uf_hoy  , -- 30
         'uf_man'    = @uf_man  , -- 31
         'ivp_hoy'   = @ivp_hoy  , -- 32
         'ivp_man'   = @ivp_man  , -- 33
         'do_hoy'    = @do_hoy  , -- 34
         'do_man'    = @do_man  , -- 35
         'da_hoy'    = @da_hoy  , -- 36
         'da_man'    = @da_man  , -- 37
         'acnomprop' = (SELECT ISNULL(@acnomprop,'NO DEFINIDO') FROM MDAC )    , -- 38
         'rut_empresa'   = @rut_empresa                     , -- 39
         'nombreentidad' = (SELECT ISNULL(acnomprop,'NO DEFINIDO') FROM MDAC ) , -- 40
         'hora'      = @hora  , -- 41
         sw                                                                    , -- 42
       'tirXnominal' = rstir*rsnominal                      , -- 43
         'Fecha1'      = SUBSTRING(@fechaProc,7,2)+'/'+SUBSTRING(@fechaProc,5,2)+'/'+SUBSTRING(@fechaProc,1,4) , 
         'Fecha2'      = SUBSTRING(@fechaProx,7,2)+'/'+SUBSTRING(@fechaProx,5,2)+'/'+SUBSTRING(@fechaProx,1,4) ,
         'rsfecprox'   = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')  ,
         'rsfecctb'    = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')   ,
         rsvpproceso                                                  ,
         rsfeccupon                                                   ,
         fechaaux   ,
         TASA_EMISION,
         TASA_MERCADO,
         Fecha_tasmer,
         TIR_EMISOR ,
	 valor_par  ,
         Prima      ,
         tasa_emis  ,
         prima_total,
   	 acum	    ,
	 tasemi	    ,
	 descuento,
         primatotal,
	 primaacum_des,
	 primaacum_prim,	
	 valor_compra,
     	 Vardiariaprima,
	 Vardiariadesc,
         CARTERA,
 	 tir_original	,
	 Tipo_Cart	,
	 Tipo_InV	,
	 Libro		,
	 Glosa_Libro
    FROM #TEMPORAL
    ORDER BY sw,rsinstser 
 
END
GO
