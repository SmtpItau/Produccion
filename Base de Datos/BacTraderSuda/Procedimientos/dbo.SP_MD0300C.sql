USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0300C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_MD0300C]
                           ( @modcal     integer          ,
                             @dfeccal    datetime         ,
                             @ncodigo    integer          ,
                             @cmascara   char(12)         ,
                             @nmonemi    integer          ,
                             @dfecemi    datetime         ,
                             @dfecven    datetime         ,
                             @ftasemi    float            ,
                             @fbasemi    float            ,
                             @ftasest    float            ,
                             @fnominal   float    OUTPUT  ,
                             @ftir       float    OUTPUT  ,
                             @fpvp       float    OUTPUT  ,
                             @fmt        float    OUTPUT  ,
                             @fmtum      float    OUTPUT  ,
                             @fmt_cien   float    OUTPUT  ,
                             @fvan       float    OUTPUT  ,
                             @fvpar      float    OUTPUT  ,
                             @nnumucup   integer  OUTPUT  ,
                             @dfecucup   datetime OUTPUT  ,
                             @fintucup   float    OUTPUT  ,
                             @famoucup   float    OUTPUT  ,
                             @fsalucup   float    OUTPUT  ,
                             @nnumpcup   integer  OUTPUT  ,
                             @dfecpcup   datetime OUTPUT  ,
                             @fintpcup   float    OUTPUT  ,
                             @famopcup   float    OUTPUT  ,
                             @fsalpcup   integer  OUTPUT  )
as
begin
  declare @ntera     numeric(08,04)
  declare @ncupones  numeric(03,00)
  declare @nmonemis  numeric(03,00)
  declare @x1        integer
  declare @nsaldo    float
  declare @fvan_1    float
  declare @fvan_2    float
  declare @fvpar_1   float
  declare @fvpar_2   float
  declare @nvalmon   numeric(18,10)
  declare @npervcup  numeric(03,00)
  declare @cultdia   char(26)
  declare @nanoemi   integer
  declare @nmesemi   integer
  declare @ndiaemi   integer
  declare @cfecemi   char(10)
  declare @auxmascara char (12)
  declare @auxcup     numeric(03,00)
  declare @auxfven    datetime
  declare @dfeccal0   datetime
  declare @auxint     numeric(19,10)
  declare @auxamort   numeric(19,10)
  declare @auxfluj    numeric(19,10)
  declare @auxsaldo   numeric(19,10)
  declare @rango      numeric(05,02)
  declare @decs       integer
  declare @tkl        float
  declare @ut         float
  declare @ma         float
  declare @me         float
  declare @jvan       float
  declare @vmin1      integer
  declare @vmin2      integer
  declare @fd30       float
  declare @ncount     integer
  declare @ncount_2   integer
  declare @fl         numeric(19,10)
  declare @fac        float
-- busqueda en de serie en MDSE
--/////////////////////////////
  set rowcount 1
  select @ntera=-1.0
  select @ntera=setera, @ncupones=secupones, @nmonemis=semonemi, @npervcup=sepervcup
         from VIEW_SERIE
         where semascara=substring(@cmascara,1,6)
  set rowcount 0
  if @ntera=-1.0 begin
    select 'NO','LA SERIE INGRESADA NO HA SIDO ENCONTRADA EN TABLA DE SERIES'
    return
  end
-- c lculo de fechas inicio y vcto. seg£n serie
-- ////////////////////////////////
  select @cultdia = '312831303130313130313031'
  select @nanoemi = convert(integer,'19' + substring(@cmascara,9,2))
  select @nmesemi = convert(integer,substring(@cmascara,7,2))
  if @nmesemi = 2 and (@nanoemi % 4) = 0 select @ndiaemi = 29
  else select @ndiaemi = convert(integer,substring(@cultdia,@nmesemi * 2 - 1, 2))
  select @cfecemi = convert(varchar(2),@nmesemi) + '/' + convert(varchar(2),@ndiaemi) + '/' + convert(char(4),@nanoemi)
  select @dfecemi = convert(datetime,@cfecemi)
  select @dfecven = dateadd(month, (@ncupones * @npervcup),dateadd(day, datepart(day,@dfecemi)*-1, @dfecemi))
-- chequeos grales.
--/////////////////
  if @dfeccal < @dfecemi begin
    select 'NO','LA SERIE TIENE FECHA DE EMISI=N POSTERIOR A FECHA DE C LCULO'
    return
  end
  if @dfeccal > @dfecven begin
    select 'NO','LA SERIE TIENE FECHA DE VCTO. ANTERIOR A FECHA DE C LCULO'
    return
  end
-- chequeo en tabla de desarrollo
--////////////////////////////////
  select @auxmascara='*'
  select @auxmascara=tdmascara
         from VIEW_TABLA_DESARROLLO
         where tdmascara=substring(@cmascara,1,6)
  if @auxmascara='*' begin
    SELECT 'NO','SERIE NO HA SIDO ENCONTRADA EN TABLA DE DESARROLLO'
    return
  end
  if @dfeccal > @dfecven begin
    select @famoucup=-1.0
    select @nsaldo=0.0, @nnumucup=@ncupones, @fintucup=tdinteres, @famoucup=tdamort, @fsalucup=0.0, @fmt=0.0
           from VIEW_TABLA_DESARROLLO 
           where tdmascara=substring(@cmascara,1,6) and tdcupon=@ncupones
    select @dfecucup=@dfecven
    if @famoucup=-1.0 select 'no','datos del ultimo cup=n no han sido encontrados'
    return
  end
-- busqueda de valor de moneda a fecha de c lculo
-------------------------------------------------
  select @nvalmon=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=@nmonemis and vmfecha=@dfeccal 
-- calculos --------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////
  if @modcal=1 or @modcal=4 begin
    create table #TMP_1 ( ind numeric(03,00) null, flujo numeric(19,10), factor float)
    select @nsaldo   = 100.0
    select @dfecucup = @dfecemi
    select @nnumucup = 0
    select @famoucup = 0.0
    select @fintucup = 0.0
    select @fsalucup = 0.0
    select @auxcup=0
    select @x1=1
    while @x1=1 begin
      set rowcount 1
      select @auxmascara='*'
      select @auxmascara=tdmascara, @auxcup=tdcupon, @auxint=tdinteres, @auxamort=tdamort, @auxfluj=tdflujo, @auxsaldo=tdsaldo
             from VIEW_TABLA_DESARROLLO 
             where tdmascara=substring(@cmascara,1,6) and tdcupon>@auxcup
             order by tdcupon
      set rowcount 0
      if @auxmascara='*' break
      select @auxfven = dateadd(month, (@auxcup * @npervcup),dateadd(day, datepart(day,@dfecemi)*-1, @dfecemi))
      
      if @dfeccal >= @auxfven begin
        select @nsaldo   = @auxsaldo
        select @dfecucup = @auxfven
        select @nnumucup = @auxcup
        select @famoucup = @auxamort
        select @fintucup = @auxint
        select @fsalucup = @auxsaldo
      end
      else begin
        if @auxcup = (@nnumucup + 1) begin
          select @dfecpcup = @auxfven
          select @nnumpcup = @auxcup
          select @famopcup = @auxamort
          select @fintpcup = @auxint
          select @fsalpcup = @auxsaldo
        end
        -- inserci=n de datos en tabla temporal ---------------
        if 30>datepart(day,@auxfven) select @vmin1=datepart(day,@auxfven)
        else select @vmin1 = 30
        if 30>datepart(day,@dfeccal) select @vmin2=datepart(day,@dfeccal)
        else select @vmin2 = 30
        select @fd30 = (datepart(year,@auxfven)-datepart(year,@dfeccal)) * 360.0 + (datepart(month,@auxfven)-datepart(month,@dfeccal)) * 30.0 + @vmin2 - @vmin1
        insert into #TMP_1 (ind    , flujo   , factor)
                    values (@auxcup, @auxfluj, @fd30 / 360.0 )
      end
    end
    -- valor par -------------------------------------------------
    if 30>datepart(day,@dfeccal) select @vmin1=datepart(day,@dfeccal)
    else select @vmin1 = 30
    if 30>datepart(day,@dfecucup) select @vmin2=datepart(day,@dfecucup)
    else select @vmin2 = 30        
    select @fd30 = (datepart(year,@dfeccal0)-datepart(year,@dfecucup)) * 360.0 + (datepart(month,@dfeccal)-datepart(month,@dfecucup)) * 30.0 + @vmin2 - @vmin1
    select @fvpar=round(@nsaldo * power((1.0+@ntera/100.0),(@fd30/360.0)), 8)
    --------------------------------------------------------------
    -- base 100 --------------------------------------------------
    select @fmt_cien = round(( @fpvp / 100.0 ) * ( @fvpar / 100.0 ) * 100.0, 4)
    --------------------------------------------------------------
    -- tir ------------------------------------------------------
    select @ftir  = 0.0
    select @rango = 50.00
    select @decs  = 4
    select @tkl   = @ntera
    select @ut    = @tkl
    select @ma    = @rango *  1.0
    select @me    = @rango * -1.0
    select @ncount = 1
    while @ncount <= 50 begin
      
      if ( 1.0 + @tkl/100.0 ) = 0.0 select @jvan = 0.0
      else begin
        select @jvan=0.0
        select @ncount_2=@nnumucup + 1
        while @ncount_2 <= @ncupones begin
          select @fl=flujo,@fac=factor from #TMP_1
                                       where ind=@ncount_2
          select @jvan = @jvan + @fl / power(1.0+@tkl/100.0,@fac)
          select @ncount_2 = @ncount_2 + 1
        end
      end
      select @ut=round(@tkl, @decs)
      if @jvan < @fmt_cien select @ma=@tkl
      else select @me=@tkl
      select @tkl=(@ma - @me) / 2.0 + @me
      if @ut=round(@tkl,@decs) begin
        select @ncount = 51
        if abs(round(@ut,0))=@rango select @ftir = 0.0
        else select @ftir=round(@ut,4)  -- vb+- 17/05/2000  se ajusta tasa a 4
      end
      select @ncount = @ncount + 1
    end
    if @ncount<>52 select @ftir=0    
    ---------------------------------------------------------------
    -- van --------------------------------------------------------
    if (1.0+@ftir/100.0) = 0.0 select @jvan = 0.0
    else begin
      select @jvan=0.0
      select @ncount_2=@nnumucup + 1
      while @ncount_2 <= @ncupones begin
        select @fl=flujo,@fac=factor from #TMP_1 
                                     where ind=@ncount_2
        select @jvan = @jvan + @fl / power(1.0+@ftir/100.0,@fac)
        select @ncount_2 = @ncount_2 + 1
      end
    end
    select @fvan=@jvan
    ---------------------------------------------------------------
    if @modcal=1 select @fmt = round(@fmt_cien / 100.0 * @fnominal,4)
    else select @fnominal = round((10000.0 * @fmt) / (@fpvp * @fvpar), 4)
    select @fmtum = @fmt
    select @fmt   = round(@fmt * @nvalmon, 0)
    drop table #TMP_1
  end
  if @modcal=2 or @modcal=5 begin
    select @nsaldo   = 100.0
    select @dfecucup = @dfecemi
    select @nnumucup = 0
    select @famoucup = 0.0
    select @fintucup = 0.0
    select @fsalucup = 0.0
    select @fvan     = 0.0
    select @fvan_1   = 0.0
    select @fvan_2   = 0.0
    select @auxcup=0
    select @x1=1
    while @x1=1 begin
      set rowcount 1
      select @auxmascara='*'
      select @auxmascara=tdmascara, @auxcup=tdcupon, @auxint=tdinteres, @auxamort=tdamort, @auxfluj=tdflujo, @auxsaldo=tdsaldo
             from VIEW_TABLA_DESARROLLO 
             where tdmascara=substring(@cmascara,1,6) and tdcupon>@auxcup
             order by tdcupon
      set rowcount 0
      if @auxmascara='*' break
      select @auxfven = dateadd(month, (@auxcup * @npervcup),dateadd(day, datepart(day,@dfecemi)*-1, @dfecemi))
      
      if @dfeccal >= @auxfven begin
        select @nsaldo   = @auxsaldo
        select @dfecucup = @auxfven
        select @nnumucup = @auxcup
        select @famoucup = @auxamort
        select @fintucup = @auxint
        select @fsalucup = @auxsaldo
      end
      else begin
        if @auxcup = (@nnumucup + 1) begin
          select @dfecpcup = @auxfven
          select @nnumpcup = @auxcup
          select @famopcup = @auxamort
          select @fintpcup = @auxint
          select @fsalpcup = @auxsaldo
        end
        -- valor del van -------------------------------------------
        if 30>datepart(day,@auxfven) select @vmin1=datepart(day,@auxfven)
        else select @vmin1 = 30
        if 30>datepart(day,@dfeccal) select @vmin2=datepart(day,@dfeccal)
        else select @vmin2 = 30
        select @fd30 = (datepart(year,@auxfven)-datepart(year,@dfeccal)) * 360.0 + (datepart(month,@auxfven)-datepart(month,@dfeccal)) * 30.0 + @vmin2 - @vmin1
        select @fvan = @fvan + (@auxfluj / (power((1.0+@ftir/100.0),@fd30/360.0)))
        ------------------------------------------------------------
      end
    end
    -- valor par ---------------------------------------------------
    if 30>datepart(day,@dfeccal) select @vmin1=datepart(day,@dfeccal)
    else select @vmin1 = 30
    if 30>datepart(day,@dfecucup) select @vmin2=datepart(day,@dfecucup)
    else select @vmin2 = 30
    select @fd30 = (datepart(year,@dfeccal)-datepart(year,@dfecucup)) * 360.0 + (datepart(month,@dfeccal)-datepart(month,@dfecucup)) * 30.0 + @vmin2 - @vmin1
    select @fvpar = round(@nsaldo * (power((1.0 + @ntera / 100.0),(@fd30 / 360.0))), 8)
    ----------------------------------------------------------------
    -- % v.par -----------------------------------------------------
    select @fpvp = round((@fvan / @fvpar) * 100.0, 4)  -- vb+-17/05/2000 se ajusta vpar a 4 
    ----------------------------------------------------------------
    if @modcal=2 select @fmt = round((@fpvp/100.0) * (@fvpar/100.0) * @fnominal, 4)
    else select @fnominal = round( (10000.0 * @fmt) / (@fpvp * @fvpar), 4)
    select @fmt_cien = round((@fpvp / 100.0) * (@fvpar/100.0) * 100.0,4)
    select @fmtum    = @fmt
    select @fmt      = round(@fmt * @nvalmon, 0)
  end
  if @modcal=3 begin
    create table #TMP_2 ( ind numeric(03,00) null, flujo numeric(19,10), factor float)
    select @nsaldo   = 100.0
    select @dfecucup = @dfecemi
    select @nnumucup = 0
    select @famoucup = 0.0
    select @fintucup = 0.0
    select @fsalucup = 0.0
    select @auxcup=0
    select @x1=1
    while @x1=1 begin
      set rowcount 1
      select @auxmascara='*'
      select @auxmascara=tdmascara, @auxcup=tdcupon, @auxint=tdinteres, @auxamort=tdamort, @auxfluj=tdflujo, @auxsaldo=tdsaldo
             from VIEW_TABLA_DESARROLLO 
             where tdmascara=substring(@cmascara,1,6) and tdcupon>@auxcup
             order by tdcupon
      set rowcount 0
      if @auxmascara='*' break
      select @auxfven = dateadd(month, (@auxcup * @npervcup),dateadd(day, datepart(day,@dfecemi)*-1, @dfecemi))
      
      if @dfeccal >= @auxfven begin
        select @nsaldo   = @auxsaldo
        select @dfecucup = @auxfven
        select @nnumucup = @auxcup
        select @famoucup = @auxamort
        select @fintucup = @auxint
        select @fsalucup = @auxsaldo
      end
      else begin
        if @auxcup = (@nnumucup + 1) begin
          select @dfecpcup = @auxfven
          select @nnumpcup = @auxcup
          select @famopcup = @auxamort
          select @fintpcup = @auxint
          select @fsalpcup = @auxsaldo
        end
        -- inserci=n de datos en tabla temporal ---------------
        if 30>datepart(day,@auxfven) select @vmin1=datepart(day,@auxfven)
        else select @vmin1 = 30
        if 30>datepart(day,@dfeccal) select @vmin2=datepart(day,@dfeccal)
        else select @vmin2 = 30
        select @fd30 = (datepart(year,@auxfven)-datepart(year,@dfeccal)) * 360.0 + (datepart(month,@auxfven)-datepart(month,@dfeccal)) * 30.0 + @vmin2 - @vmin1
        insert into #TMP_2 (ind    , flujo   , factor)
                    values (@auxcup, @auxfluj, @fd30 / 360.0 )
      end
    end
    select @fmtum = round(@fmt / @nvalmon, 4)
    -- base cien --------------------------------------------------------
    select @fmt_cien = ( @fmtum / @fnominal) * 100.0
    ---------------------------------------------------------------------
    -- tir --------------------------------------------------------------
    select @ftir  = 0.0
    select @rango = 50.00
    select @decs  = 4
    select @tkl   = @ntera
    select @ut    = @tkl
    select @ma    = @rango *  1.0
    select @me    = @rango * -1.0
    select @ncount = 1
    while @ncount <= 50 begin
      
      if ( 1.0 + @tkl/100.0 ) = 0.0 select @jvan = 0.0
      else begin
        select @jvan=0.0
        select @ncount_2=@nnumucup + 1
        while @ncount_2 <= @ncupones begin
          select @fl=flujo,@fac=factor from #TMP_2
                                       where ind=@ncount_2
          select @jvan = @jvan + @fl / power(1.0+@tkl/100.0,@fac)
          select @ncount_2 = @ncount_2 + 1
        end
      end
      select @ut=round(@tkl, @decs)
      if @jvan < @fmt_cien select @ma=@tkl
      else select @me=@tkl
      select @tkl=(@ma - @me) / 2.0 + @me
      if @ut=round(@tkl,@decs) begin
        select @ncount = 51
        if abs(round(@ut,0))=@rango select @ftir = 0.0
        else select @ftir=round(@ut,4) -- vb+-17/05/2000 se ajusta vpar a 4 
       end
      select @ncount = @ncount + 1
    end
    if @ncount<>52 select @ftir=0    
    ---------------------------------------------------------------------
    -- van --------------------------------------------------------------
    if (1.0+@ftir/100.0) = 0.0 select @jvan = 0.0
    else begin
      select @jvan=0.0
      select @ncount_2=@nnumucup + 1
      while @ncount_2 <= @ncupones begin
        select @fl=flujo,@fac=factor from #TMP_2
                                     where ind=@ncount_2
        select @jvan = @jvan + @fl / power(1.0+@ftir/100.0,@fac)
        select @ncount_2 = @ncount_2 + 1
      end
    end
    select @fvan=@jvan
    ---------------------------------------------------------------------
    -- mt ---------------------------------------------------------------
    select @fmt = round(@fmt_cien / 100.0 * @fnominal, 4)
    ---------------------------------------------------------------------
    -- valor par --------------------------------------------------------
    if 30>datepart(day,@dfeccal) select @vmin1=datepart(day,@dfeccal)
    else select @vmin1 = 30
    if 30>datepart(day,@dfecucup) select @vmin2=datepart(day,@dfecucup)
    else select @vmin2 = 30        
    select @fd30 = (datepart(year,@dfeccal)-datepart(year,@dfecucup)) * 360.0 + (datepart(month,@dfeccal)-datepart(month,@dfecucup)) * 30.0 + @vmin2 - @vmin1
    select @fvpar=round(@nsaldo * power((1.0+@ntera/100.0),(@fd30/360.0)), 8)
    ---------------------------------------------------------------------
    -- % valor par ------------------------------------------------------
    select @fpvp = round( (@fvan / @fvpar) * 100.0, 4) -- vb+-17/05/2000 se ajusta vpar a 4 
    ---------------------------------------------------------------------
    select @fmt   = round(@fmt * @nvalmon, 0)
  end
end


GO
