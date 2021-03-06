USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAPRC]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CREAPRC] (@cinstser char(10))
as
begin
      set nocount on
  declare @ntasemi   float
  declare @ncupones  integer
  declare @ncortes   integer
  declare @ntasper   float
  declare @nflujo    float
  declare @nsalaux   float
  declare @dfecemi   datetime
  declare @sa_aux    float
  declare @ncontador integer
  declare @dfecaux1  datetime  
  declare @dfecaux2  datetime
  declare @ndias     integer
  declare @ft        datetime
  declare @fl        float
  declare @am        float
  declare @it        float
  declare @sa        float
  declare @dfecven   datetime
  declare @decs      integer
  declare @jvan      float
  declare @tkl       float
  declare @me        float
  declare @ma        float
  declare @cmascara  char(10)
  declare @ut        float
  declare @ntera     float
  declare @de        float
  declare @x1        float
  declare @x2        float
  if substring(@cinstser,5,1) = '1' begin
    select @ntasemi = 6.5
    select @ncupones= 20
  end
  if substring(@cinstser,5,1) = '2' begin
    select @ntasemi = 5.0
    select @ncupones= 8
  end
  if substring(@cinstser,5,1) = '3' begin
    select @ntasemi = 5.0
    select @ncupones= 12
  end
  if substring(@cinstser,5,1) = '4' begin
    select @ntasemi = 6.5
    select @ncupones= 16
  end
  if substring(@cinstser,5,1) = '5' begin
    select @ntasemi = 6.5
    select @ncupones= 24
  end
  if substring(@cinstser,5,1) = '6' begin
    select @ntasemi = 6.5
    select @ncupones= 28
  end
  if substring(@cinstser,5,1) = '7' begin
    select @ntasemi = 6.5
    select @ncupones= 40
  end
  if substring(@cinstser,6,1)='A' select @ncortes=500.0
  if substring(@cinstser,6,1)='B' select @ncortes=1000.0
  if substring(@cinstser,6,1)='C' select @ncortes=5000.0
  if substring(@cinstser,6,1)='D' select @ncortes=10000.0
  if isdate(substring(@cinstser,7,2)+'/01/'+substring(@cinstser,9,2)) = 1 begin
      select @dfecemi  = substring(@cinstser,7,2)+'/01/'+substring(@cinstser,9,2)
  end
   else begin
      set nocount off
      select 'OK'
       return 15
  end    
  select @ntasper  = power( 1.0 + @ntasemi/100.0, 0.5 ) -1.0
  select @nflujo   = round(@ncortes*@ntasper*power((1+@ntasper),@ncupones)/( power(1+@ntasper,@ncupones)-1),2)
  select @nsalaux  = @ncortes
  select @dfecaux1 = @dfecemi
  select @sa_aux   = 100.0
  delete VIEW_TABLA_DESARROLLO where tdmascara=@cinstser
  select @ncontador = 1
  while @ncontador <= @ncupones begin
    select @dfecaux2 = dateadd (day, 190, @dfecaux1)
    select @ft       = dateadd(day, (datepart(day, @dfecaux2) - 1 ) * -1, @dfecaux2)
    select @ndias    = datediff(day, @dfecaux1, @ft)
    select @dfecaux1 = @ft
    select @de       = datediff(day, @dfecemi, @ft) / 365.0
    select @fl       = @nflujo
    select @it       = round( (power( 1+@ntasemi/100.0, @ndias/360.0) -1) * @nsalaux, 2)
    select @am       = @fl - @it
    select @sa       = @nsalaux - @am
    select @nsalaux  = @sa
    select @it       = @it / @ncortes * 100.0
    if @ncontador = @ncupones begin
      select @am = @sa_aux
      select @fl = @am + @it
      select @sa = 0.0
    end
    else begin
      select @am = @am / @ncortes * 100.0
      select @fl = @fl / @ncortes * 100.0
      select @sa = @sa / @ncortes * 100.0
    end
    insert into VIEW_TABLA_DESARROLLO values (@cinstser, @ncontador, @ft, @it, @am, @fl, @sa)
    select @sa_aux = @sa
    select @ncontador = @ncontador + 1
  end
  select @dfecven = @ft
  -- cÿlculo de la tera
  ---------------------
  select @decs = 8
  select @tkl  = 6.5
  select @ut   = @tkl
  select @me   = 0.0
  select @ma   = 15
  select @ntera= 0.0
  select @ncontador = 1
  while @ncontador <= 80 begin
     -- van prc --------
     select @jvan=0.0
     select @jvan=sum( tdflujo / power( 1.0 + @tkl / 100.0 , datediff(day,@dfecemi,tdfecven) / 365.0) )
            from VIEW_TABLA_DESARROLLO
            where tdmascara=@cinstser
     ------------------
    select @ut = round( @tkl, @decs )
     if @jvan < 100.0 select @ma = @tkl
     else select @me = @tkl
     select @tkl  = ( @ma - @me ) / 2.0 + @me
     if @ut = round( @tkl, @decs ) begin
       select @ntera=round(@ut,4)
       break
     end
  end
  delete VIEW_SERIE where semascara=@cinstser
  insert into VIEW_SERIE (secodigo, semascara, serutemi, setasemi, sebasemi, semonemi, setera,
                   setipamort, seplazo, sepervcup, secupones, sefecven, sefecemi,seserie,
                   sediavcup, senumamort, sedecs, secorte,setotalemitido)
            values(4,@cinstser, 97029000, @ntasemi, 365, 998, @ntera, 1, @ncupones / 2, 6,
                   @ncupones, @dfecven, @dfecemi, @cinstser, 1, @ncupones, 3, @ncortes,0)
      set nocount off
      select 'OK'
end
-- sp_creaprc 'prc-4b0896'
-- select * from MDTD where tdmascara='prc-4d0896'
-- delete from MDBL
-- select * from mdse where semascara='prc-7d0397'
-- execute sp_generauf 05, 1997,0.3
-- update MDAC set acfecproc='07/10/1997'


GO
