USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRARCART_VI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FILTRARCART_VI]
   (   @rutcart1             NUMERIC(10,0)
   ,   @sqlvari1             NUMERIC(10,0)
   ,   @sqlfami1             VARCHAR(255)
   ,   @sqlemis1             VARCHAR(255)
   ,   @sqlmone1             VARCHAR(255)
   ,   @sqlseri1             VARCHAR(255)
   ,   @codigo_carterasuper  CHAR(1)
   ,   @cUsuario             CHAR(10) 
   ,   @id_libro             CHAR(06)	= ''
   ,   @iDPV                 INTEGER = 0
   )
AS
BEGIN

 SET NOCOUNT ON

 declare @nerror         numeric (02,0)
 declare @usuario        char    (20)
 declare @usuario2       char    (20)
 declare @hwnd2          numeric (09,0)
 declare @rutcart        numeric(09,0)
 declare @tipcart        numeric(05,0)
 declare @numdocu        numeric(10,0)
 declare @correla        numeric(03,0)
 declare @numdocuo       numeric(10,0)   -- 'utilizado para accesar a VIEW_NOSERIE
 declare @correlao       numeric(03,0)   -- 'utilizado para accesar a VIEW_NOSERIE
 declare @tipoper        char(03)
 declare @serie          char(12)
 declare @instser        char(12)
 declare @genemi         char(10)
 declare @nemmon         char(05)
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
 select @xfecpcup = ' '
 declare @sqlfijo1 varchar(255)
 declare @sqlfijo2 varchar(255)
 declare @sqlfijo3 varchar(255)
 declare @dFechaPro DATETIME
 declare @dFechaProx   DATETIME

  /* PRD-5521 */
 DECLARE @nreg NUMERIC(9),
	@treg NUMERIC(9),
	@xnumdocu NUMERIC(9,0),
	@xnominal NUMERIC(19,4),
	@xinstser CHAR(12),
	@factor NUMERIC(19,4)
  /* fin PRD-5521 */

   SELECT  @dFechaPro   = acfecproc,
	   @dFechaProx  = acfecprox
   FROM    MDAC
 
select @x = 0
select @y = 0
select @contador = 0

   create table #TEMP2 
   (            nerror   numeric (09,0)  null,
                hwnd2    numeric (09,0)  null,
                usuario2 char    (20)  null,
                rutcart  numeric (9,0)  null,
                tipcart  numeric (9,0)  null,
                numdocu  numeric (9,0)  null,
                correla  numeric (9,0)  null,
                numdocuo numeric (9,0)  null,
                correlao numeric (9,0)  null,
                tipoper  char    (03)  null,
                serie    char    (12)  null,
                instser  char    (12)  null,
                genemi   char    (05)  null,
                nemmon   char    (05)  null,
                nominal  numeric (21,4)  null,
                tircomp  numeric (21,4)  null,
                pvpcomp  numeric (21,4)  null,
                vptirc   numeric (21,4)  null,
                pvpmcd   numeric (21,4)  null,
                tirmcd   numeric (21,4)  null,
                vpmcd100 numeric (21,4)  null,
                vpmcd    numeric (21,4)  null,
                vptirci  numeric (21,4)  null,
                fecsal   char    (10)  null,
                numucup  numeric (9,0)  null,
                interesc numeric (21,4)  null,
                reajustc numeric (21,4)  null,
                intereci numeric (21,4)  null,
                reajusci numeric (21,4)  null,
                capitalc numeric (21,4)  null,
		capitaci numeric (21,4)  null,
                codigo   numeric (09,0)  null,
                mascara  char    (12)  null,
                tasest   numeric (21,4)  null,
                rutemi   numeric (9,0)  null,
                monemi   numeric (9,0)  null,
                tasemi   numeric (09,4)  null,
                basemi   numeric (09,0)  null,
                fecemi   char    (10)  null,
                fecven   DATETIME  null,
                fecpcup  char    (10)  null,
                bloq     char    (1)   null,
                diasdisp numeric (9,0)  null,
                custodia_dcv char(01)  null,
                seriados    char (01)  null,
                convexidad  float   null,
                durationmac float   null,
                durationmod float   null,
                nombre_carterasuper char(20)   null,
		id_libro    CHAR(06)        null,
		modPAgo	    CHAR(01)

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
               dinominal    ,
               ditircomp    ,
               dipvpcomp    ,
               divptirc     ,
               dipvpmcd     ,
               ditirmcd     ,
               0     ,  --divpmcd100   ,
               divpmcd      ,
               divptirc     ,  --divptirci
               convert(char(10),difecsal,103),
               dinumucup    ,
               0            ,   --diinteresc   ,
               0,    --direajustc   ,
               0,   --diintereci   ,
               0,   --direajusci   ,
               divptirc     ,  --dicapitalc   ,
               divptirc     ,  --dicapitaci   ,
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
	       '' -- pago hoy pago mañana... solo para compras y vtas propias...
           from MDDI a, MDCP b, MDAC
           where dirutcart = @rutcart1 
           and ditipcart = @sqlvari1
           and charindex(rtrim(ltrim(diserie)),@sqlfami1) > 0
           and charindex(rtrim(ltrim(digenemi)),@sqlemis1) > 0
           and charindex(rtrim(ltrim(dinemmon)),@sqlmone1) > 0
           and dinominal > 0
           and ditipoper = 'CP'
           and cprutcart       = dirutcart     
           and cpnumdocu       = dinumdocu     
           and cpcorrela       = dicorrela
           and a.Estado_Operacion_Linea	= ''
	   and a.codigo_carterasuper	= @codigo_carterasuper 
	   and (b.id_libro		= @id_libro or @id_libro = '')
	   and a.Fecha_PagoMañana <= @dFechaPro

           order by dicontador



 insert into #TEMP2 
        select @nerror     ,
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
               dinominal    ,
               ditircomp    ,
               dipvpcomp    ,
               divptirc     ,
               dipvpmcd     ,
               ditirmcd     ,
               0     ,  --divpmcd100   ,
               divpmcd      ,
               divptirc     ,  --divptirci
               convert(char(10),difecsal,103),
               dinumucup    ,
               0            ,   --diinteresc   ,
               0,    --direajustc   ,
               0,   --diintereci   ,
               0,   --direajusci   ,
               divptirc     ,  --dicapitalc   ,
               divptirc     ,  --dicapitaci   ,
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
  '' -- pago hoy pago mañana... solo para compras y vtas propias...  
  from MDDI a, MDCI b,MDAC
  where dirutcart = @rutcart1 
  and ditipcart = @sqlvari1
  and charindex(rtrim(ltrim(diserie)),@sqlfami1) > 0
  and charindex(rtrim(ltrim(digenemi)),@sqlemis1) > 0
  and charindex(rtrim(ltrim(dinemmon)),@sqlmone1) > 0
  and dinominal > 0
  and ditipoper = 'CI'
  and cirutcart       = dirutcart     
  and cinumdocu       = dinumdocu     
  and cicorrela       = dicorrela
  and a.codigo_carterasuper = @codigo_carterasuper 
  AND a.Estado_Operacion_Linea=''
  and (digenemi <> 'BCO' or diserie <> 'LCHR')  --> VGS 07/04/2005	
               and (a.id_libro			= @id_libro or @id_libro = '')
  order by dicontador

   IF @iDPV = 1
   BEGIN
      DELETE #TEMP2
      WHERE  LTRIM(RTRIM(custodia_dcv)) NOT IN('D')
   END

  /* Inicio PRD-5521 */
   CREATE TABLE temp3(
	tnumdocu	NUMERIC(9,0) NULL,
	tcorrela	NUMERIC(3,0) NULL,
	tinstser	CHAR(12) NULL,
	tnominal	NUMERIC(19,4) NULL,
	tfactor		NUMERIC(19,4) NULL,
	tnumreg		NUMERIC(9,0) IDENTITY)

   INSERT INTO #temp3
   SELECT numdocu, correla, instser, nominal, 1 FROM #temp2
   SELECT @nreg = 0
   SELECT @treg = COUNT(*) FROM #temp3	
   WHILE @nreg < @treg
   BEGIN
	SELECT @nreg = @nreg + 1
	SELECT @xnumdocu = tnumdocu,
	       @xinstser = tinstser,
	       @xnominal = nominal	
	FROM #temp3
	WHERE tnumreg = @nreg

	SELECT @factor = 0.0000
	EXECUTE Bacparamsuda..sp_CalculaFactor @xnumdocu, @xinstser, @xnominal, @factor OUTPUT

	UPDATE #temp3
	SET tfactor = @factor
	WHERE tnumreg = @nreg
   END

   UPDATE #temp2
   SET  vptirc   = vptirc * tfactor,
	interesc = interesc * tfactor,
	capitalc = capitalc * tfactor,
	reajustc = reajustc * tfactor
   FROM #temp2, #temp3
   WHERE numdocu = tnumdocu
   AND correla   = tcorrela
   AND instser   = tinstser

  /* Fin PRD-5521 */

 if @sqlseri1 = 'VACIO'
 begin
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
                nominal  ,
                tircomp  ,
                pvpcomp  ,
                vptirc  ,
                pvpmcd  ,
                tirmcd  ,
                vpmcd100 ,
                vpmcd  ,
                vptirci  ,
                fecsal  ,
                numucup  ,
                interesc ,
                reajustc ,
                intereci ,
                reajusci ,
                capitalc ,
                capitaci ,
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
		modPAgo
                from #Tem_seri1 
                order by instser
 end else 
 begin
	/*
	PRD-5521 - Descontar los Nominales de las Garantías Otorgadas
	*/

	UPDATE #temp2
	SET nominal = nominal - ISNULL(nominalesGarantias, 0)
	FROM #temp2 tmp
	JOIN (SELECT	Numdocu,
			Correlativo,
			SUM(Nominal) AS nominalesGarantias
	FROM 	BacParamSuda..tbl_Garantias_Otorgadas_Detalle det,
		BacParamSuda..tbl_Garantias_Otorgadas enc
	WHERE	det.Folio = enc.Folio
	GROUP BY Numdocu,
		Correlativo) AS tbl
	ON tmp.numdocu  = tbl.Numdocu
	AND tmp.correla = tbl.Correlativo
	

	/*
	Fin PRD-5521 (JBH)
	*/
    
            declare @sqlaux varchar(255)
            declare @sqlaux2 varchar(255)
            declare @cont INTEGER
            select @sqlaux2 = ''

         WHILE 1 = 1
        BEGIN
            select @cont =  CHARINDEX(';',@sqlseri1)
            if @cont = 0
            begin
               break
            END
            select @sqlaux = ''' + SUBSTRING( @sqlseri1, 1, @cont - 1) + '' OR instser = '
            select @sqlaux2 = @sqlaux2 + @sqlaux
            select @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont + 1,LEN(@sqlseri1))) 
            
         END
         SELECT @sqlaux = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13)) 
        EXECUTE ('SELECT * FROM #temp2 WHERE instser = ' + @sqlaux + ' ORDER BY instser' )
 END

END

GO
