USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FIT_CTR_LQZ]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SVC_FIT_CTR_LQZ]
   (   @rutcart1 NUMERIC(09,0)
   ,   @Tipo     NUMERIC(1)
   ,   @T_Serie  CHAR(20)     = ''
   ,   @hwnd     INTEGER
   )
   -- Autor                  : Miriam moreno
   -- Objetivo               : Filtro
   -- Fecha de Creacion      : 12-12-2002
   -- Modificaciones         : se excluye Bonos - 20 y letras - 15
   -- Primera Modificacion   : 12-12-2002
   -- Segunda Modificacion   : 12-12-2002
   -- Antecedentes Generales : Generar Informe
AS BEGIN
   DECLARE @nrutprop  numeric(09,0)      
      ,    @usuario   char   (20)
      ,    @tipcart   numeric(05,0)      
      ,    @numdocu   numeric(10,0)
      ,    @correla   numeric(03,0)      
      ,    @numdocuo  numeric(10,0)
      ,    @correlao  numeric(03,0)     
      ,    @tipoper   char(03)
      ,    @serie     char(12)          
      ,    @instser   char(12)
      ,    @genemi    char(10)         
      ,    @nemmon    char(05)
      ,    @nominal   numeric(19,4)    
      ,    @tircomp   numeric(19,4)
      ,    @pvpcomp   numeric(19,2)     
      ,    @vptirc    numeric(19,4)
      ,    @pvpmcd    numeric(19,2)     
      ,    @tirmcd    numeric(19,4)
      ,    @vpmcd100  real              
      ,    @vpmcd     numeric(19,4)
      ,    @vptirci   numeric(19,4)     
      ,    @fecsal    char(10)
      ,    @numucup   numeric(03,0)    
      ,    @interesc  numeric(19,4)
      ,    @reajustc  numeric(19,4)    
      ,    @intereci  numeric(19,4)
      ,    @reajusci  numeric(19,4)    
      ,    @capitalc  numeric(19,4)
      ,    @capitaci  numeric(19,4)     
      ,    @codigo    numeric(05,0)
      ,    @mascara   char(12)          
      ,    @tasest    numeric(09,4)
      ,    @rutemi    numeric(09,0)     
      ,    @monemi    numeric(03,0)
      ,    @tasemi    numeric(09,4)     
      ,    @basemi    numeric(03,0)
      ,    @fecemi    char(10)           
      ,    @fecven    char(10)
      ,    @cseriado  char(01)          
      ,    @fecpcup   char(10)
      ,    @xfecpcup  datetime         
      ,    @contador  numeric(19,4)
      ,    @x         integer           
      ,    @y         integer
      ,    @sqlfijo1  varchar(255)     
      ,    @sqlfijo2  varchar(255)
      ,    @sqlfijo3  varchar(255)     
      ,    @fecha_proceso  datetime

   SET NOCOUNT ON


   SELECT @fecha_proceso = ACFECPROC , @nrutprop = acrutprop FROM MDAC
   SELECT @xfecpcup = ' '
   SELECT @x = 0, @y = 0, @contador = 0


   SELECT rutcart  = A.dirutcart    ,
          tipcart  = A.ditipcart    ,
          numdocu  = A.dinumdocu    ,
          correla  = A.dicorrela    , 
          numdocuo = 0            ,
          correlao = 0            , 
          tipoper  = A.ditipoper    ,
          serie    = A.diserie      ,
          instser  = A.diinstser    ,
          genemi   = A.digenemi     ,
          nemmon   = A.dinemmon     ,
          nominal  = A.dinominal    , 
          tircomp  = A.ditircomp    ,
          pvpcomp  = A.dipvpcomp    , 
          vptirc   = A.divptirc     ,
          pvpmcd   = A.dipvpmcd     , 
          tirmcd   = A.ditirmcd     ,
          vpmcd100 = 0            , 
          vpmcd    = A.divpmcd      ,
          vptirci  = A.divptirc     , 
          fecsal   = convert(char(10),A.difecsal,103),
          numucup  = A.dinumucup    , 
          interesc = 0            ,
          reajustc = 0            , 
          intereci = 0            ,
          reajusci = 0            , 
          capitalc = A.divptirc     ,
          capitaci = A.divptirc     , 
          codigo   = B.cpcodigo     ,
          mascara  = B.cpmascara    , 
          tasest   = B.cptasest     ,
          rutemi   = 0,
          monemi   = 0,
          tasemi   = 0,
          basemi   = 0,
          fecemi   = convert(char(10),B.cpfecemi,103),
          fecven   = convert(char(10),B.cpfecven,103),
          fecpcup  = convert(char(10),B.cpfecpcup,103),
          bloq = ISNULL((SELECT 'S' FROM MDBL WHERE blrutcart = A.dirutcart  and blnumdocu = A.dinumdocu and blcorrela = A.dicorrela and blhwnd <> @hwnd), 'N'),
          diasdisp = datediff(day,@fecha_proceso,A.difecsal),
          custodia_dcv = B.cpdcv         ,
          seriados = B.cpseriado         , 
          convexidad  = B.cpconvex       ,
          durationmac = B.cpdurat        , 
          durationmod = B.cpdurmod       ,   
          nombre_carterasuper = B.codigo_carterasuper,
	  clave_dcv	= convert(char(15),'')
   INTO  #TEMP2 
           FROM    mddi A
           ,       mdcp B
           ,       mdac
           ,       VIEW_MONEDA
           WHERE   A.dinemmon       =  mnnemo
           AND     A.dinemmon       <> 'USD'
           AND     A.dirutcart      =  @rutcart1  
           AND     A.dinominal      >  0  
           AND     A.ditipoper      =  'CP' 
           AND     A.digenemi       =  'BCCH'
           AND     B.cprutcart      =  A.dirutcart     
           AND     B.cpnumdocu      =  A.dinumdocu    
           AND     B.cpcorrela      =  A.dicorrela
--         AND     DATEDIFF(DAY, @FECHA_PROCESO, CPFECVEN) > 2  AND DATEDIFF(DAY, @FECHA_PROCESO, CPFECPCUP) > 2 --> Con Fecha 28/02/2007
           AND     B.cpdcv          =  'D'
           AND     @Tipo            =  1
           AND     B.Estado_Operacion_Linea = ''
   ORDER BY dicontador

--SELECT * FROM #TEMP2
--RETURN
-------------------------
/* TIPO 2*/
---------------------------
   INSERT INTO #TEMP2 
        SELECT A.dirutcart    ,
               A.ditipcart    , 
               A.dinumdocu    ,
               A.dicorrela    , 
               0              ,
               0              , 
               A.ditipoper    ,
               A.diserie      ,
               A.diinstser    ,
               A.digenemi     , 
               A.dinemmon     ,
               A.dinominal    , 
               A.ditircomp    ,
               A.dipvpcomp    , 
               A.divptirc     ,
               A.dipvpmcd     , 
               A.ditirmcd     ,
               0              , 
               A.divpmcd      ,
               A.divptirc     , 
               convert(char(10),A.difecsal,103),
               A.dinumucup    , 
               0              ,
               0              , 
               0              ,
               0              , 
               A.divptirc     ,
               A.divptirc     , 
               B.cpcodigo     ,
               B.cpmascara    , 
               B.cptasest     ,
               0              ,
               0              ,
               0              ,
               0              ,
               convert(char(10),B.cpfecemi,103),   
               convert(char(10),B.cpfecven,103),
               convert(char(10),B.cpfecpcup,103),
               ISNULL((SELECT 'S' FROM MDBL WHERE blrutcart = A.dirutcart  and blnumdocu = A.dinumdocu and blcorrela = A.dicorrela and blhwnd <> @hwnd), 'N'),
               datediff(day,@fecha_proceso,A.difecsal),
               B.cpdcv         ,
               B.cpseriado     ,
               B.cpconvex      ,
               B.cpdurat       ,
               B.cpdurmod      ,   
	       B.codigo_carterasuper,
	       ''
           FROM    mddi A
           ,       mdcp B
           ,       mdac
           ,       VIEW_MONEDA
           WHERE   A.dinemmon       =  	mnnemo
           AND     A.dinemmon       <> 	'USD'
           AND     A.dirutcart      =  	@rutcart1  
           AND     A.dinominal      >  	0  
           AND     A.ditipoper      =  	'CP' 
           AND     A.digenemi       =  	'BCCH'
           AND     B.cprutcart      =  	A.dirutcart     
           AND     B.cpnumdocu      =  	A.dinumdocu    
           AND     B.cpcorrela      =  	A.dicorrela
           AND     B.cpdcv          = 	'D'
--         AND     DATEDIFF(DAY, @FECHA_PROCESO, CPFECVEN) > 2  AND DATEDIFF(DAY, @FECHA_PROCESO, CPFECPCUP) > 2 --> Con Fecha 28/02/2007
           AND     B.cpinstser      =   @T_Serie        
           AND     @Tipo            =   2
           AND     B.Estado_Operacion_Linea = ''
   ORDER BY dicontador


-------------------
/*Tipo 3*/
------------------
   INSERT INTO #TEMP2 
        SELECT A.dirutcart    ,
               A.ditipcart    , 
               A.dinumdocu    ,
               A.dicorrela    , 
               0            ,
               0            , 
               A.ditipoper    ,
               A.diserie      , 
               A.diinstser    ,
               A.digenemi     , 
               A.dinemmon     ,
               A.dinominal    , 
               A.ditircomp    ,
               A.dipvpcomp    , 
               A.divptirc     ,
               A.dipvpmcd     , 
               A.ditirmcd     ,
               0            , 
               A.divpmcd      ,
               A.divptirc     , 
               convert(char(10),A.difecsal,103),
               A.dinumucup    ,
               0            ,
               0            , 
               0            ,
               0            ,
               A.divptirc     ,
               A.divptirc     , 
               B.cpcodigo     ,
               B.cpmascara    , 
               B.cptasest     ,
               0            ,
               0            ,
               0            ,
               0            ,
               convert(char(10),B.cpfecemi,103),   convert(char(10),B.cpfecven,103),
               convert(char(10),B.cpfecpcup,103),
               ISNULL((SELECT 'S' FROM MDBL WHERE blrutcart = A.dirutcart and blnumdocu = A.dinumdocu and blcorrela = A.dicorrela and blhwnd <> @hwnd), 'N'),
               datediff(day,@fecha_proceso,A.difecsal),
               B.cpdcv        ,
               B.cpseriado    ,
               B.cpconvex     ,
               B.cpdurat      ,
               B.cpdurmod     ,   
	       B.codigo_carterasuper,
	       ''
           FROM    mddi A
           ,       mdcp B
           ,       mdac
           ,       VIEW_MONEDA
           WHERE   A.dinemmon       =  	mnnemo
           AND     A.dinemmon       <> 	'USD'
           AND     A.dirutcart      =  	@rutcart1  
           AND     A.dinominal      >  	0  
           AND     A.ditipoper      =  	'CP' 
           AND     A.digenemi       =  	'BCCH'
           AND     B.cprutcart      =  	A.dirutcart     
           AND     B.cpnumdocu      =  	A.dinumdocu    
           AND     B.cpcorrela      =  	A.dicorrela
           AND     B.cpdcv          = 	'D'
--         AND     DATEDIFF(DAY, @FECHA_PROCESO, CPFECVEN) > 2  AND DATEDIFF(DAY, @FECHA_PROCESO, CPFECPCUP) > 2 --> Con Fecha 28/02/2007
           AND     @Tipo            = 	3
           AND     B.Estado_Operacion_Linea = ''
   ORDER BY dicontador


---- Completa Información ----

UPDATE #temp2
SET    rutemi  = serutemi,
       monemi  = semonemi,
       tasemi  = setasemi,
       basemi  = sebasemi
FROM   VIEW_SERIE
WHERE  seriados = 'S'           
AND    mascara  = seserie

UPDATE #temp2
SET    rutemi  = nsrutemi,
       monemi  = nsmonemi,
       tasemi  = nstasemi,
       basemi  = nsbasemi
FROM   VIEW_NOSERIE
WHERE  seriados      = 'N'           
AND    rutcart       = nsrutcart     
AND    numdocu       = nsnumdocu     
AND    correla       = nscorrela


   DELETE #TEMP2 WHERE rutemi = @nrutprop


   IF @Tipo = 1
   BEGIN  
       SELECT '', '', '', rutcart, 0   ,MIN(numdocu), MIN(correla), MIN(numdocuo),
              MIN(correlao), tipoper, serie, instser, genemi, nemmon, SUM(nominal),
              AVG(tircomp), AVG(pvpcomp), SUM(vptirc), AVG(pvpmcd), AVG(tirmcd),
              SUM(vpmcd100), SUM(vpmcd), SUM(vptirci), fecsal, 0,  SUM(interesc),
              SUM(reajustc), SUM(intereci), SUM(reajusci), SUM(capitalc), SUM(capitaci),
              codigo, mascara, AVG(tasest), rutemi, monemi, AVG(tasemi), basemi, '', 
            fecven, fecpcup, bloq, diasdisp, custodia_dcv, seriados, 0, 0, 0, '', 0   from #TEMP2 
       WHERE bloq = 'N'
       GROUP BY rutcart,tipoper,serie,instser,genemi,nemmon,fecsal,codigo,mascara,rutemi,monemi,basemi,fecven,fecpcup,bloq,diasdisp,custodia_dcv,seriados  order by instser
   END ELSE BEGIN
       SELECT '', '', '', rutcart, tipcart, numdocu, correla, numdocuo, correlao, tipoper, serie, instser,
              genemi, nemmon, nominal      ,tircomp,    pvpcomp,     vptirc,     pvpmcd,     tirmcd,  
              vpmcd100,       vpmcd,     vptirci, fecsal, numucup, interesc, reajustc, intereci,    reajusci, 
              capitalc,     capitaci, codigo, mascara, tasest , rutemi, monemi, tasemi, basemi, fecemi, fecven, fecpcup, bloq, diasdisp, custodia_dcv, seriados, convexidad, durationmac, durationmod, nombre_carterasuper, clave_dcv
      from #TEMP2 
      WHERE bloq = 'N'
      ORDER BY nominal DESC
   END

END

GO
