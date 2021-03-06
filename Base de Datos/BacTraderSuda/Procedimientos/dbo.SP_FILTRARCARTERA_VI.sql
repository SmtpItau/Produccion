USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRARCARTERA_VI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FILTRARCARTERA_VI]
  (       @rutcart1          NUMERIC(10,0)
      ,   @sqlCarte          VARCHAR(255)
      ,   @sqlfami1          VARCHAR(255)
      ,   @sqlemis1          VARCHAR(255)
      ,   @sqlmone1          VARCHAR(255)
      ,   @sqlseri1          VARCHAR(255)
      ,   @sqlCateg          VARCHAR(255)
      ,   @cUsuario          CHAR(10) 
      ,   @sqlLibro          VARCHAR(255)
      ,   @iDPV              INTEGER = 0
   )
AS
BEGIN

 SET NOCOUNT ON

 DECLARE @nerror         NUMERIC (02,0)
 DECLARE @usuario        CHAR    (20)
 DECLARE @usuario2       CHAR    (20)
 DECLARE @hwnd2          NUMERIC (09,0)
 DECLARE @rutcart        NUMERIC(09,0)
 DECLARE @tipcart        NUMERIC(05,0)
 DECLARE @numdocu        NUMERIC(10,0)
 DECLARE @correla        NUMERIC(03,0)
 DECLARE @numdocuo       NUMERIC(10,0)   -- 'UTILIZADO PARA ACCESAR A VIEW_NOSERIE
 DECLARE @correlao       NUMERIC(03,0)   -- 'UTILIZADO PARA ACCESAR A VIEW_NOSERIE
 DECLARE @tipoper        CHAR(03)
 DECLARE @serie          CHAR(12)
 DECLARE @instser        CHAR(12)
 declare @genemi         CHAR(10)
 declare @nemmon         CHAR(05)
 declare @nominal        numeric(19,4)
 declare @tircomp        numeric(19,4)
 declare @pvpcomp        numeric(19,2)
 declare @vptirc         numeric(19,4)
 declare @pvpmcd         numeric(19,2)
 declare @tirmcd         numeric(19,4)
 declare @vpmcd100       real
 declare @vpmcd          numeric(19,4)
 declare @vptirci        numeric(19,4)
 declare @fecsal         char(10)
 declare @numucup        numeric(03,0)
 declare @interesc       numeric(19,4)
 declare @reajustc       numeric(19,4)
 declare @intereci       numeric(19,4)
 declare @reajusci       numeric(19,4)
 declare @capitalc       numeric(19,4)
 declare @capitaci       numeric(19,4)
 declare @codigo         numeric(03,0)
 declare @mascara        char(12)
 declare @tasest         numeric(09,4)
 declare @rutemi         numeric(09,0)
 declare @monemi         numeric(03,0)
 declare @tasemi         numeric(09,4)
 declare @basemi         numeric(03,0)
 declare @fecemi         char(10)
 declare @fecven         char(10)
 declare @cseriado       char(01)
 declare @fecpcup        char(10)
 declare @xfecpcup       datetime
 declare @contador numeric(19,4)
 declare @x  integer
 declare @y  integer
 select  @xfecpcup = ' '
 declare @sqlfijo1 varchar(255)
 declare @sqlfijo2 varchar(255)
 declare @sqlfijo3 varchar(255)
 declare @dFechaPro DATETIME
 declare @dFechaProx   DATETIME

   SELECT  @dFechaPro   = acfecproc,   @dFechaProx  = acfecprox FROM    MDAC
 
   select @x = 0
   select @y = 0
   select @contador = 0

   create table #TEMP2 
   (            nerror      NUMERIC (09,0)  NULL,
                hwnd2       NUMERIC (09,0)  NULL,
                usuario2    CHAR    (20)  NULL,
                rutcart     NUMERIC (9,0)  NULL,
                tipcart     NUMERIC (9,0)  NULL,
                numdocu     NUMERIC (9,0)  NULL,
                correla     numeric (9,0)  null,
                numdocuo    numeric (9,0)  null,
                correlao    numeric (9,0)  null,
                tipoper     char    (03)  null,
                serie       char    (12)  null,
                instser     char    (12)  null,
                genemi      char    (05)  null,
                nemmon      char    (05)  null,
                nominal     numeric (21,4)  null,
                tircomp     numeric (21,4)  null,
                pvpcomp     numeric (21,4)  null,
                vptirc      numeric (21,4)  null,
                pvpmcd      numeric (21,4)  null,
                tirmcd      numeric (21,4)  null,
                vpmcd100    numeric (21,4)  null,
                vpmcd       numeric (21,4)  null,
                vptirci     numeric (21,4)  null,
                fecsal      char    (10)  null,
                numucup     numeric (9,0)  null,
                interesc    numeric (21,4)  null,
                reajustc    numeric (21,4)  null,
                intereci    numeric (21,4)  null,
                reajusci    numeric (21,4)  null,
                capitalc    numeric (21,4)  null,
		capitaci    numeric (21,4)  null,
                codigo      numeric (09,0)  null,
                mascara     char    (12)  null,
                tasest      numeric (21,4)  null,
                rutemi      numeric (9,0)  null,
                monemi      numeric (9,0)  null,
                tasemi      numeric (09,4)  null,
                basemi      numeric (09,0)  null,
                fecemi      char    (10)  null,
                fecven      DATETIME  null,
                fecpcup     char    (10)  null,
                bloq        char    (1)   null,
                diasdisp    numeric (9,0)  null,
                custodia_dcv char(01)  null,
                seriados    char (01)  null,
                convexidad  float   null,
                durationmac float   null,
                durationmod float   null,
                nombre_carterasuper char(20)   null,
		id_libro    CHAR(06)        null,
		modPAgo	    CHAR(01)        null, -- MAP PROD-6005
                NocBloqueado numeric (21,4)  null 
  )

 insert into #TEMP2 
        select isnull(@nerror,0)     ,
               isnull(@hwnd2,0)       ,       
               @usuario2    ,       
               dirutcart    ,
               ditipcart    ,
               dinumdocu    ,
               dicorrela    ,
               dinumdocuo   ,
               dicorrelao   ,
               ditipoper    ,
               diserie      ,
               diinstser    ,
               digenemi     ,
               dinemmon     ,

               -- PROD-6005
               dinominal - isnull( bpNominal , 0.0 ),     
               ditircomp    ,
               dipvpcomp    ,

               -- PROD-6005
               divptirc  * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) ,  

               dipvpmcd     ,
               ditirmcd     ,
               0     ,  --divpmcd100   ,
               divpmcd      ,

               -- PROD-6005
               divptirc  * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  )   ,  --divptirci     
               convert(char(10),difecsal,103),
               dinumucup    ,
               0            ,   --diinteresc   ,
               0,    --direajustc   ,
               0,   --diintereci   ,
               0,   --direajusci   ,
               
               -- PROD-6005 Inicio Bloque
               divptirc * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  )    ,  --dicapitalc   , 
               divptirc * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  )    ,  --dicapitaci   , 
               -- PROD-6005 Inicio Bloque
 
               cpcodigo      ,
               cpmascara     ,
               cptasest      ,
               case when cpseriado = 'S'  then (select serutemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nsrutemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,
               case when cpseriado = 'S'  then (select semonemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nsmonemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,
               case when cpseriado = 'S'  then (select setasemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nstasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,
               case when cpseriado = 'S'  then (select sebasemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nsbasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,
               convert(char(10),cpfecemi,103),
               cpfecven,
               convert(char(10),cpfecpcup,103),
               CASE WHEN EXISTS( SELECT 1 FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd <> 0 ) THEN '*'
                    WHEN EXISTS( SELECT 1 FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario <> @cUsuario) THEN '*'
                    WHEN EXISTS( SELECT 1 FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario = @cUsuario)  THEN 'B'
                   ELSE ' ' 
               END,
               datediff(day,acfecproc,difecsal),
               b.cpdcv   ,
               b.cpseriado ,
               b.cpconvex  ,
               b.cpdurat   ,
               b.cpdurmod  , 
               b.codigo_carterasuper,   --49
               b.id_libro  ,            --50
	       '' , -- pago hoy pago mañana... solo para compras y vtas propias...
               isnull( bpNominal, 0.0 ) * 1.0  -- MAP PROD-6005
           from MDDI a 
                -- PROD-6005
                LEFT JOIN dbo.BloqueadoPacto BlPact ON     BlPact.bpnumdocu = a.dinumdocu  
                                                  AND BlPact.bpcorrela = a.dicorrela
                , MDCP b, MDAC
 
           where dirutcart = @rutcart1 
           and charindex(rtrim(ltrim(convert(varchar(255),ditipcart))),@sqlCarte) > 0  ---ditipcart = @sqlCarte ---@sqlvari1
           and charindex(rtrim(ltrim(diserie)),@sqlfami1) > 0
           and charindex(rtrim(ltrim(digenemi)),@sqlemis1) > 0
           and charindex(rtrim(ltrim(dinemmon)),@sqlmone1) > 0
           and (charindex(rtrim(ltrim(a.codigo_carterasuper)), @sqlCateg ) > 0   or @sqlCateg = '' )--cass
           and (charindex(rtrim(ltrim(b.id_libro)), @sqlLibro ) > 0  or @sqlLibro = '')--cass
           and dinominal > 0
           and ditipoper = 'CP'
           and cprutcart       = dirutcart     
           and cpnumdocu       = dinumdocu     
           and cpcorrela       = dicorrela
           and a.Estado_Operacion_Linea	= ''
	   --and a.codigo_carterasuper	= @sqlCarte ---@codigo_carterasuper cass
	--   and (b.id_libro		= @id_libro or @id_libro = '')
	   and a.Fecha_PagoMañana       <= @dFechaPro

           ORDER BY dicontador



 INSERT INTO #TEMP2 
        SELECT @nerror     ,
               @hwnd2       ,       
               @usuario2    ,       
               dirutcart   ,
               ditipcart    ,
               dinumdocu    ,
               dicorrela    ,
               dinumdocuo   ,
               dicorrelao   ,
               ditipoper    ,
               diserie      ,
               diinstser    ,
               digenemi     ,
               dinemmon     ,
               -- PROD-6005
               case when (dinominal - isnull( bpNominal , 0.0 ))< 0 then 0 else  dinominal - isnull( bpNominal , 0.0 ) end ,     
               ditircomp    ,
               dipvpcomp    ,
               -- PROD-6005
               divptirc  * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) ,  
               dipvpmcd     ,
               ditirmcd     ,
               0            ,  --divpmcd100   ,
               divpmcd      ,
               divptirc     ,  --divptirci
               convert(char(10),difecsal,103),
               dinumucup    ,
               0            ,   --diinteresc   ,
               0,    --direajustc   ,
               0,   --diintereci   ,
               0,   --direajusci   ,

               -- PROD-6005 Inicio Bloque
               divptirc * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  )    ,  --dicapitalc   , 
               divptirc * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  )    ,  --dicapitaci   , 
               -- PROD-6005 Inicio Bloque
            cicodigo      ,
  cimascara     ,
  citasest      ,
  case 
     when ciseriado = 'S'  then (select serutemi from VIEW_SERIE where semascara = cimascara)
      else (select nsrutemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  case 
     when ciseriado = 'S'  then (select semonemi from VIEW_SERIE where semascara = cimascara)
      else (select nsmonemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  case 
     when ciseriado = 'S'  then (select setasemi from VIEW_SERIE where semascara = cimascara)
      else (select nstasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  case 
     when ciseriado = 'S'  then (select sebasemi from VIEW_SERIE where semascara = cimascara)
      else (select nsbasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  convert(char(10),cifecemi,103),
  convert(char(10),cifecvenp,112),
  convert(char(10),cifecpcup,103),
  CASE 
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd <> 0 ) THEN '*'
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario <> @cUsuario) THEN '*'
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario = @cUsuario)  THEN 'B'
    ELSE ' ' END,
--  case 
--     when exists( select * from MDBL where blrutcart = dirutcart and blnumdocu = dinumdocu and blcorrela = dicorrela ) then '*'
--    else ' ' end,
  datediff(day,acfecproc,difecsal),
  b.cidcv   ,
  ciseriado,
  b.ciconvex   ,
  b.cidurat   ,
  b.cidurmod   ,       --48
  b.codigo_carterasuper  ,         --49
  b.id_libro  ,        --50
  '' , -- pago hoy pago mañana... solo para compras y vtas propias... 
  isnull( bpNominal, 0.0 ) * 1.0   -- MAP PROD-6005
  from MDDI a
       -- PROD-6005
      LEFT JOIN dbo.BloqueadoPacto BlPact ON     BlPact.bpnumdocu = a.dinumdocu  
                                                 AND BlPact.bpcorrela = a.dicorrela
  , MDCI b,MDAC

  where dirutcart = @rutcart1 
  and charindex(rtrim(ltrim(convert(varchar(255),ditipcart))), @sqlCarte ) > 0
  and charindex(rtrim(ltrim(diserie)),@sqlfami1) > 0
  and charindex(rtrim(ltrim(digenemi)),@sqlemis1) > 0
  and charindex(rtrim(ltrim(dinemmon)), @sqlmone1 ) > 0
  and (charindex(rtrim(ltrim(a.codigo_carterasuper)), @sqlCateg ) > 0 or @sqlCateg = '')
  and (charindex(rtrim(ltrim(a.id_libro)) , @sqlLibro ) > 0  or @sqlLibro = '' )--cass
  and dinominal       > 0
  and ditipoper       = 'CI'
  and cirutcart       = dirutcart     
  and cinumdocu       = dinumdocu     
  and cicorrela       = dicorrela
  AND a.Estado_Operacion_Linea=''
  and (digenemi <> 'BCO' or diserie <> 'LCHR')  
  order by dicontador

  /* 
  IF @iDPV = 1
   BEGIN
      DELETE #TEMP2
      WHERE  LTRIM(RTRIM(custodia_dcv)) NOT IN('D')
   END
  */

 IF @SQLSERI1 = 'VACIO'
 BEGIN

     SELECT * INTO #tem_seri1 
     FROM  #temp2 
    WHERE codigo IN (6,7,9,11,13,14) ORDER BY fecven

       INSERT INTO #tem_seri1 
       SELECT * FROM #temp2 WHERE codigo NOT IN(6,7,9,11,13,14) order by instser

       SELECT   nerror  ,
                hwnd2  ,
                usuario2 ,
                rutcart  ,
                tipcart  ,
                numdocu  ,
                correla  ,
                numdocuo ,
                correlao ,
                tipoper  ,
                serie  ,
                instser  ,
                genemi  ,
                nemmon  ,
                Case when nominal < 0 then 0 else nominal end ,
                tircomp  ,
                pvpcomp  ,
                Case when nominal < 0 then 0 else vptirc end ,
                pvpmcd  ,
                tirmcd  ,
                vpmcd100 ,
                vpmcd  ,
                Case when nominal < 0 then 0 else vptirci end ,
                fecsal  ,
                numucup  ,
                interesc ,
                reajustc ,
                intereci ,
                reajusci ,
                Case when nominal < 0 then 0 else capitalc end ,
                Case when nominal < 0 then 0 else capitaci end ,
                codigo  ,
                mascara  ,
                tasest  ,
                rutemi  ,
                monemi  ,
                tasemi  ,
                basemi  ,
                fecemi  ,
                convert(char(10),fecven,103)  ,
                fecpcup  ,
                bloq  ,
                diasdisp ,
                custodia_dcv ,
                seriados ,
                convexidad ,
                durationmac ,
                durationmod ,
                nombre_carterasuper ,
                id_libro,
		modPAgo,
                NocBloqueado -- MAP PROD-6005
                from #Tem_seri1 
                order by instser
 END 

ELSE 

 BEGIN
    
            DECLARE @sqlaux VARCHAR(255)
            DECLARE @sqlaux2 VARCHAR(255)
            DECLARE @cont INTEGER
            SELECT @sqlaux2 = ''

         WHILE 1 = 1
         BEGIN

            SELECT @cont =  CHARINDEX(';',@sqlseri1)
  
      IF @cont = 0
               BEGIN
                  BREAK
               END
    
     --  REQ. 7619   
            SELECT @sqlaux = ''' + SUBSTRING( @sqlseri1, 1, @cont - 1) + '' OR instser = '
            SELECT @sqlaux2 = @sqlaux2 + @sqlaux
            SELECT @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont + 1,LEN(@sqlseri1))) 
            
         END

            SELECT @sqlaux = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13)) 
     --  REQ. 7619   
            EXECUTE ('SELECT * FROM #temp2 WHERE instser = ' + @sqlaux + ' ORDER BY instser' )
 END


END
GO
