USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Filtrarcart_Vi]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Filtrarcart_Vi]
                         
                          (@rutcart1 NUMERIC(09,0),
                           @sqlvari1 NUMERIC(04,0),
                           @sqlfami1 VARCHAR(255),
                           @sqlemis1 VARCHAR(255),
                           @sqlmone1 VARCHAR(255),
                           @sqlseri1 VARCHAR(255),
                           @codigo_carterasuper CHAR(1) )
as
begin
       
 declare @nerror    numeric (02,0)
 declare @usuario   char    (20)
 declare @usuario2  char    (20)
 declare @hwnd2     numeric (09,0)
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
 
 set nocount on
select @x = 0
select @y = 0
select @contador = 0
   create table #TEMP2 (
  nerror  numeric (02,0)  null,
                hwnd2  numeric (09,0)  null,
                usuario2 char    (20)  null,
                rutcart  numeric(9,0)  null,
                tipcart  numeric(1,0)  null,
                numdocu  numeric(5,0)  null,
                correla  numeric(3,0)  null,
                numdocuo numeric(5,0)  null,
                correlao numeric(3,0)  null,
                tipoper  char    (03)  null,
                serie  char(12)  null,
                instser  char(12)  null,
                genemi  char(05)  null,
  nemmon  char(05)  null,
                nominal  numeric(19,4)  null,
                tircomp  numeric(19,4)  null,
                pvpcomp  numeric(19,4)  null,
                vptirc  numeric(19,4)  null,
                pvpmcd  numeric(19,4)  null,
                tirmcd  numeric(19,4)  null,
                vpmcd100 numeric(19,4)  null,
                vpmcd  numeric(19,4)  null,
                vptirci  numeric(19,4)  null,
                fecsal  char(10)  null,
                numucup  numeric( 5,0)  null,
                interesc numeric(19,4)  null,
                reajustc numeric(19,4)  null,
                intereci numeric(19,4)  null,
                reajusci numeric(19,4)  null,
                capitalc numeric(19,4)  null,
                capitaci numeric(19,4)  null,
                codigo  numeric(03,0)  null,
                mascara  char(12)  null,
   tasest  numeric(19,4)  null,
                rutemi  numeric( 9,0)  null,
                monemi  numeric(03,0)  null,
         tasemi  numeric(09,4)  null,
   basemi  numeric(03,0)  null,
                fecemi  char(10)  null,
                fecven  DATETIME  null,
  fecpcup  char(10)  null,
  bloq  char(1)   null,
  diasdisp numeric( 5,0)  null,
  custodia_dcv char(01)  null,
  seriados char(01)  null,
  convexidad float   null,
  durationmac float   null,
  durationmod float   null,
  nombre_carterasuper char(20)   null
  )
 insert into #TEMP2 
        select @nerror     ,
               @hwnd2       ,       
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
  case 
     when cpseriado = 'S'  then (select serutemi from VIEW_SERIE where semascara = cpmascara)
      else (select nsrutemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  case 
     when cpseriado = 'S'  then (select semonemi from VIEW_SERIE where semascara = cpmascara)
      else (select nsmonemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  case 
     when cpseriado = 'S'  then (select setasemi from VIEW_SERIE where semascara = cpmascara)
      else (select nstasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  case 
     when cpseriado = 'S'  then (select sebasemi from VIEW_SERIE where semascara = cpmascara)
      else (select nsbasemi from VIEW_NOSERIE where nsrutcart = dirutcart and nsnumdocu = dinumdocu and nscorrela = dicorrela) end,
  convert(char(10),cpfecemi,103),
  cpfecven,
  convert(char(10),cpfecpcup,103),
  case 
     when exists( select * from MDBL where blrutcart = dirutcart and blnumdocu = dinumdocu and blcorrela = dicorrela ) then '*'
    else ' ' end,
  datediff(day,acfecproc,difecsal),
                b.cpdcv   ,
  b.cpseriado   ,
  b.cpconvex   ,
  b.cpdurat   ,
  b.cpdurmod   , 
         --nombre_carterasuper = (select nombre_carterasuper from bacparametros..categoria_carterasuper where codigo_carterasuper = a.codigo_carterasuper)
  b.codigo_carterasuper
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
  and a.codigo_carterasuper = @codigo_carterasuper AND a.Estado_Operacion_Linea=''
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
  case 
     when exists( select * from MDBL where blrutcart = dirutcart and blnumdocu = dinumdocu and blcorrela = dicorrela ) then '*'
    else ' ' end,
  datediff(day,acfecproc,difecsal),
                b.cidcv   ,
  ciseriado,
  b.ciconvex   ,
  b.cidurat   ,
  b.cidurmod   
         --nombre_carterasuper = (select nombre_carterasuper from bacparametros..categoria_carterasuper where codigo_carterasuper = a.codigo_carterasuper)--insertado
  
 
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
  and a.codigo_carterasuper = @codigo_carterasuper AND a.Estado_Operacion_Linea=''
  order by dicontador
 if @sqlseri1 = 'VACIO'
 begin
         SELECT * into #tem_seri1 from #temp2 where codigo in (6,7,9,11,13,14) order by  fecven
            INSERT #tem_seri1 select * from #temp2 where codigo not in (6,7,9,11,13,14) order by instser
     select   nerror  ,
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
  nombre_carterasuper 
  from #Tem_seri1 order by codigo
  
 end else begin
     
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
            select @sqlaux = "'" + SUBSTRING( @sqlseri1, 1, @cont - 1) + "' OR instser = "
            select @sqlaux2 = @sqlaux2 + @sqlaux
            select @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont + 1,LEN(@sqlseri1))) 
            
         end
         SELECT @sqlaux = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13)) 
        EXECUTE ("SELECT * FROM #temp2 WHERE instser = " + @sqlaux )
   END
   SET NOCOUNT OFF
end
--select convert(char(10),cifecven,103),* from mdci
GO
