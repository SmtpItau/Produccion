USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Filtrarcart_RP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Filtrarcart_RP]
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

   SELECT  @dFechaPro   = acfecproc,
	   @dFechaProx  = acfecprox
   FROM    MDAC
 
select @x = 0
select @y = 0
select @contador = 0

   create table #TEMP2 
   (            nerror   numeric (09,0)  null,     --(1)
                hwnd2    numeric (09,0)  null,     --(2)
                usuario2 char    (20)  null,       --(3)
                rutcart  numeric (9,0)  null,      --(4)
                tipcart  numeric (9,0)  null,      --(5)
                numdocu  numeric (9,0)  null,      --(6)
                correla  numeric (9,0)  null,      --(7)
                numdocuo numeric (9,0)  null,      --(8)
                correlao numeric (9,0)  null,      --(9)
                tipoper  char    (03)  null,       --(10)
                serie    char    (12)  null,       --(11)
                instser  char    (12)  null,       --(12)
                genemi   char    (05)  null,       --(13)
                nemmon   char    (05)  null,       --(14)
                nominal  numeric (21,4)  null,     --(15)
                tircomp  numeric (21,4)  null,     --(16)
                pvpcomp  numeric (21,4)  null,     --(17)
                vptirc   numeric (21,4)  null,     --(18) valor presente o referencial
                pvpmcd   numeric (21,4)  null,     --(19)
                tirmcd   numeric (21,4)  null,     --(20)
                vpmcd100 numeric (21,4)  null,     --(21)
                vpmcd    numeric (21,4)  null,     --(22)
                vptirci  numeric (21,4)  null,     --(23)
                fecsal   char    (10)  null,       --(24)
                numucup  numeric (9,0)  null,      --(25)
                interesc numeric (21,4)  null,     --(26)
                reajustc numeric (21,4)  null,     --(27)
                intereci numeric (21,4)  null,     --(28)
                reajusci numeric (21,4)  null,     --(29)
                capitalc numeric (21,4)  null,     --(30)
                capitaci numeric (21,4)  null,     --(31)
                codigo   numeric (09,0)  null,     --(32)
                mascara  char    (12)  null,       --(33)
                tasest   numeric (21,4)  null,     --(34)
                rutemi   numeric (9,0)  null,      --(35)
                monemi   numeric (9,0)  null,      --(36)
                tasemi   numeric (09,4)  null,     --(37)
                basemi   numeric (09,0)  null,     --(38)
                fecemi   char    (10)  null,       --(39)
                fecven   DATETIME  null,           --(40)
                fecpcup  char    (10)  null,       --(41)
                bloq     char    (1)   null,       --(42)
                diasdisp numeric (9,0)  null,      --(43) Plazo Residual
                custodia_dcv char(01)  null,       --(44)
                seriados    char (01)  null,       --(45)
                convexidad  float   null,          --(46)
                durationmac float   null,          --(47)
                durationmod float   null,          --(48)
                nombre_carterasuper char(20) null, --(49)
                id_libro    CHAR(06)         null, --(50)
                modPAgo	    CHAR(01)             , --(51)
                Margen      float null,            --(52)
                Val_Inicial float null             --(53)

  )



 insert into #TEMP2 
        select isnull(@nerror,0)     , --(1)
               isnull(@hwnd2,0)      , --(2)
               @usuario2    ,          --(3)
               dirutcart    ,          --(4)
               ditipcart    ,          --(5)
               dinumdocu    ,          --(6)
               dicorrela    ,          --(7)
               dinumdocuo   ,          --(8)
               dicorrelao   ,          --(9)
               ditipoper    ,          --(10)
               diserie      ,          --(11)
               diinstser    ,          --(12)
               digenemi     ,          --(13)
               dinemmon     ,          --(14)
               dinominal    ,          --(15)
               ditircomp    ,          --(16)
               dipvpcomp    ,          --(17)
               divptirc     ,          --(18)
               dipvpmcd     ,          --(19)
               ditirmcd     ,          --(20)
               0     ,  --divpmcd100   , --(21)
               divpmcd      ,          --(22)
               divptirc     ,  --divptirci --(23)
               convert(char(10),difecsal,103),--(24)
               dinumucup    ,            --(25)
               0            ,   --diinteresc   , --(26)
               0,    --direajustc   ,          --(27)
               0,   --diintereci   ,      --(28)
               0,   --direajusci   ,      --(29)
               divptirc     ,  --dicapitalc   ,--(30)
               divptirc     ,  --dicapitaci   ,--(31)
               cpcodigo      ,          --(32)
               cpmascara     ,          --(33)
               cptasest      ,          --(34)
               case when cpseriado = 'S'  then (select serutemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nsrutemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,                     --(35)
               case when cpseriado = 'S'  then (select semonemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nsmonemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,                     --(36)
               case when cpseriado = 'S'  then (select setasemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nstasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,                     --(37)
               case when cpseriado = 'S'  then (select sebasemi from VIEW_SERIE where semascara = cpmascara)
                    else (select nsbasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) 
               end,                     --(38)
               convert(char(10),cpfecemi,103), --(39)
               cpfecven,                --(40)
               convert(char(10),cpfecpcup,103), --(41)
               CASE WHEN EXISTS( SELECT 1 FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd <> 0 ) THEN '*'
                    WHEN EXISTS( SELECT 1 FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario <> @cUsuario) THEN '*'
                    WHEN EXISTS( SELECT 1 FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario = @cUsuario)  THEN 'B'
                   ELSE ' ' 
               END,                      --(42)
               datediff(day,acfecproc,difecsal),--(43)
            b.cpdcv   , --(44)
               b.cpseriado ,--(45)
               b.cpconvex  ,--(46)
               b.cpdurat   ,--(47)
               b.cpdurmod  , --(48)
               b.codigo_carterasuper,   --49
               b.id_libro  ,            --50
	       '', -- pago hoy pago mañana... solo para compras y vtas propias... --(51)
	       (
          case 
            when exists(select A.Margen from BacParamSuda..margen_instrumento_soma A, view_instrumento B
                        where A.Fecha_Margen=acfecproc
                          and B.inserie=diserie
                          and A.Codigo_instrumento=B.incodigo
                          and A.Plazo_desde <= datediff(day,acfecproc,difecsal)
                          and A.Plazo_hasta >= datediff(day,acfecproc,difecsal)
                       )
            then (select A.Margen from BacParamSuda..margen_instrumento_soma A, view_instrumento B
                  where A.Fecha_Margen=acfecproc
                    and B.inserie=diserie
                    and A.Codigo_instrumento=B.incodigo
                    and A.Plazo_desde <= datediff(day,acfecproc,difecsal)
                    and A.Plazo_hasta >= datediff(day,acfecproc,difecsal)
                 )
            else 1
          end
	       ),--(52)
	       0 --(53)
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
        select @nerror      ,         --(1)
               @hwnd2       ,         --(2)
               @usuario2    ,         --(3)
               dirutcart    ,         --(4)
               ditipcart    ,         --(5)
               dinumdocu    ,         --(6)
               dicorrela    ,         --(7)
               dinumdocuo   ,         --(8)
               dicorrelao   ,         --(9)
               ditipoper    ,         --(10)
               diserie      ,         --(11)
               diinstser    ,         --(12)
               digenemi     ,         --(13)
               dinemmon     ,         --(14)
               dinominal    ,         --(15)
               ditircomp    ,         --(16)
               dipvpcomp    ,         --(17)
               divptirc     ,         --(18) valor presente o Referencial
               dipvpmcd     ,         --(19)
               ditirmcd     ,         --(20)
               0     ,  --divpmcd100   ,--(21)
               divpmcd      ,         --(22)
               divptirc     ,  --divptirci   --(23)
               convert(char(10),difecsal,103),--(24)
               dinumucup    ,          --(25)
               0            ,   --diinteresc   , --(26)
               0,    --direajustc   ,--(27)
               0,   --diintereci   ,--(28)
               0,   --direajusci   , --(29)
               divptirc     ,  --dicapitalc   ,--(30)
               divptirc     ,  --dicapitaci   ,--(31)
               cicodigo     ,        --(32)
               cimascara    ,        --(33)
               citasest     ,        --(34)
  case 
     when ciseriado = 'S'  then (select serutemi from VIEW_SERIE where semascara = cimascara)
      else (select nsrutemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,--(35)
  case 
     when ciseriado = 'S'  then (select semonemi from VIEW_SERIE where semascara = cimascara)
      else (select nsmonemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end, --(36)
  case 
     when ciseriado = 'S'  then (select setasemi from VIEW_SERIE where semascara = cimascara)
      else (select nstasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,--(37)
  case 
     when ciseriado = 'S'  then (select sebasemi from VIEW_SERIE where semascara = cimascara)
      else (select nsbasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,  --(38)
  convert(char(10),cifecemi,103),  --(39)
  convert(char(10),cifecvenp,112), --(40)
  convert(char(10),cifecpcup,103), --(41)
  CASE 
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd <> 0 ) THEN '*'
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario <> @cUsuario) THEN '*'
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario = @cUsuario)  THEN 'B'
    ELSE ' ' END,  --(42)
--  case 
--     when exists( select * from MDBL where blrutcart = dirutcart and blnumdocu = dinumdocu and blcorrela = dicorrela ) then '*'
--    else ' ' end,
  datediff(day,acfecproc,difecsal),--(43)
  b.cidcv   , --(44)
  ciseriado,  --(45)
  b.ciconvex   , --(46)
  b.cidurat   ,  --(47)
  b.cidurmod   ,       --48
  b.codigo_carterasuper  ,         --49
  b.id_libro  ,        --50
  '', -- pago hoy pago mañana... solo para compras y vtas propias...  --(51)
	       (
          case 
            when exists(select A.Margen from BacParamSuda..margen_instrumento_soma A, view_instrumento B
                        where A.Fecha_Margen=acfecproc
                          and B.inserie=diserie
                          and A.Codigo_instrumento=B.incodigo
                          and A.Plazo_desde <= datediff(day,acfecproc,difecsal)
                          and A.Plazo_hasta >= datediff(day,acfecproc,difecsal)
                       )
            then (select A.Margen from BacParamSuda..margen_instrumento_soma A, view_instrumento B
                  where A.Fecha_Margen=acfecproc
                    and B.inserie=diserie
                    and A.Codigo_instrumento=B.incodigo
                    and A.Plazo_desde <= datediff(day,acfecproc,difecsal)
                    and A.Plazo_hasta >= datediff(day,acfecproc,difecsal)
                 )
            else 1
          end
	       ),--(52)
	       0 --(53)
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

--Actualizar Valor Inicial
  update #TEMP2
  set Val_Inicial=round(Margen*vptirc,0)
--

 if @sqlseri1 = 'VACIO'
 begin
            SELECT * INTO #tem_seri1 
            FROM  #temp2 
            WHERE codigo IN (6,7,9,11,13,14) ORDER BY fecven

       INSERT INTO #tem_seri1 
       SELECT * FROM #temp2 WHERE codigo NOT IN(6,7,9,11,13,14) order by instser

       SELECT   nerror   ,                      --(1)
                hwnd2    ,                      --(2)
                usuario2 ,                      --(3)
                rutcart  ,                      --(4)
                tipcart  ,                      --(5)
                numdocu  ,                      --(6)
                correla  ,                      --(7)
                numdocuo ,                      --(8)
                correlao ,                      --(9)
                tipoper  ,                      --(10)
                serie    ,                      --(11)
                instser  ,                      --(12)
                genemi   ,                      --(13)
                nemmon   ,                      --(14)
                nominal  ,                      --(15)
                tircomp  ,                      --(16)
                pvpcomp  ,                      --(17)
                vptirc   ,                      --(18)
                pvpmcd   ,                      --(19)
                tirmcd   ,                      --(20)
                vpmcd100 ,                      --(21)
                vpmcd    ,                      --(22)
                vptirci  ,                      --(23)
                fecsal   ,                      --(24)
                numucup  ,                      --(25)
                interesc ,                      --(26)
                reajustc ,                      --(27)
                intereci ,                      --(28)
                reajusci ,                      --(29)
                capitalc ,                      --(30)
                capitaci ,                      --(31)
                codigo   ,                      --(32)
                mascara  ,                      --(33)
                tasest   ,                      --(34)
                rutemi   ,                      --(35)
                monemi   ,                      --(36)
                tasemi   ,                      --(37)
                basemi   ,                      --(38)
                fecemi   ,                      --(39)
                convert(char(10),fecven,103)  , --(40)
                fecpcup  ,                      --(41)
                bloq     ,                      --(42)
                diasdisp ,                      --(43)
                custodia_dcv ,                  --(44)
                seriados ,                      --(45)
                convexidad ,                    --(46)
                durationmac ,                   --(47)
                durationmod ,                   --(48)
                nombre_carterasuper ,           --(49)
                id_libro,                       --(50)
                modPAgo,                        --(51)
                Margen,                         --(52)
                Val_Inicial                     --(53)
                from #Tem_seri1 
                order by instser
 end else 
 begin
    
            declare @sqlaux varchar(255)
            declare @sqlaux2 varchar(255)
            declare @cont INTEGER
            select @sqlaux2 = ''

         WHILE 1 = 1
         begin
            select @cont =  CHARINDEX(';',@sqlseri1)
            if @cont = 0
            begin
               break
            end

            select @sqlaux = SUBSTRING( @sqlseri1, 1, @cont - 1) + ' OR instser = '
            select @sqlaux2 = @sqlaux2 + @sqlaux
            select @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont + 1,LEN(@sqlseri1))) 
            
         end

         SELECT @SQLAUX = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13)) 

         DECLARE @GSBAC_SQL    VARCHAR(1000)
             SET @GSBAC_SQL    = "SELECT * FROM #TEMP2 WHERE instser IN('" + @sqlaux + "') ORDER BY instser "

         EXECUTE(@GSBAC_SQL)

 END


END

GO
