USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0303C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0303C]
    (
    @modcal  integer   ,
    @dfeccal datetime  ,
    @ncodigo integer   ,
                              @cmascara char (12)  ,
                             @nmonemi integer   ,
    @dfecemi datetime  ,
    @dfecven datetime  ,
    @ftasemi float   ,
    @fbasemi float   ,
    @ftasest float   ,
    @fnominal float  OUTPUT  ,
    @ftir  float  OUTPUT  ,
    @fpvp  float  OUTPUT  ,
    @fmt  float  OUTPUT  ,
    @fmtum  float  OUTPUT  ,
    @fmt_cien float   OUTPUT  ,
    @fvan  float  OUTPUT  ,
    @fvpar  float  OUTPUT  ,
    @nnumucup integer  OUTPUT  ,
    @dfecucup datetime OUTPUT  ,
    @fintucup float  OUTPUT  ,
    @famoucup float  OUTPUT  ,
    @fsalucup float  OUTPUT  ,
    @nnumpcup integer  OUTPUT  ,
    @dfecpcup datetime OUTPUT  ,
    @fintpcup float  OUTPUT  ,
    @famopcup float  OUTPUT  ,
    @fsalpcup integer  OUTPUT ,
    @fdurat  float  OUTPUT ,
    @fconvx  float  OUTPUT ,
    @fdurmo  float  OUTPUT
    )
as
begin
 declare @ntera  float  ,
  @ncupones numeric (03,00) ,
  @nmonemis numeric (03,00) ,
  @x1  integer  ,
  @nsaldo  float  ,
  @fvan_1  float  ,
  @fvan_2  float  ,
  @fvpar_1 float  ,
  @fvpar_2 float  ,
  @nvalmon numeric (18,10) ,
  @auxmascara char (12) ,
  @auxcup  numeric (03,00) ,
  @auxfven datetime ,
  @auxint  numeric (19,10) ,
  @auxamort numeric (19,10) ,
  @auxfluj numeric (19,10) ,
  @auxsaldo numeric (19,10) ,
  @rango  numeric (05,02) ,
  @decs  integer  ,
  @tkl  float  ,
  @ut  float  ,
  @ma  float  ,
  @me  float  ,
  @jvan  float  ,
  @ncount  integer
 select @ntera  = -1.0
 set rowcount 1
 select @ntera  = setera ,
  @dfecemi = sefecemi ,
  @dfecven = sefecven ,
  @ncupones = secupones ,
  @nmonemis = semonemi
 from VIEW_SERIE
 where semascara=@cmascara
 set rowcount 0
 if @ntera=-1.0
 begin
  select @famoucup = 0.0 ,
   @dfecucup = '' ,
   @fintucup = 0.0 ,
   @fsalucup = 0.0 ,
   @fpvp   = 0.0 ,
   @fvan  = 0.0 ,
   @fvpar  = 0.0
  return
 end
 if @dfeccal<@dfecemi
 begin
  select 'NO','LA SERIE TIENE FECHA DE EMISI½N POSTERIOR A FECHA DE CYLCULO'
  return
 end
 if @dfeccal>@dfecven
 begin
  select 'NO','LA SERIE TIENE FECHA DE VCTO. ANTERIOR A FECHA DE CYLCULO'
  return
 end
 select @auxmascara = '*'
 select @auxmascara = tdmascara
 from VIEW_TABLA_DESARROLLO
        where tdmascara=@cmascara
 if @auxmascara='*'
 begin
  select 'NO','SERIE NO HA SIDO ENCONTRADA EN TABLA DE DESARROLLO'
  return
 end
 if @dfeccal=@dfecven
 begin
  select @dfecucup = @dfecven
  select @nsaldo  = 0.0  ,
   @nnumucup = @ncupones ,
   @fintucup = tdinteres ,
   @famoucup = tdamort ,
   @fsalucup = 0.0  ,
   @fmt  = 0.0  ,
   @fmtum     = 0.0  ,
   @fmt_cien = 0.0
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdcupon=@ncupones
  select @fpvp  = 0.0  ,
   @fvan  = 0.0  ,
   @fvpar  = 0.0  ,
   @nnumucup = @ncupones ,
   @dfecucup = @dfecven ,
   @nnumpcup = @ncupones ,
   @dfecpcup = @dfecven ,
   @fintpcup = 0.0  ,
   @famopcup = 0.0  ,
   @fsalpcup = 0.0
  return
 end
 select @nvalmon = vmvalor
 from VIEW_VALOR_MONEDA
 where vmfecha=@dfeccal and vmcodigo=@nmonemis
 if @modcal=1 or @modcal=4
 begin
  select @nsaldo  = 100.0  ,
   @dfecucup = @dfecemi ,
   @nnumucup = 0  ,
   @famoucup = 0.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0
  --** pr½ximo cup½n **--
  set rowcount 1
  select @auxmascara = tdmascara ,
   @nnumpcup = tdcupon ,
   @dfecpcup = tdfecven ,
   @fintpcup = tdinteres ,
   @famopcup = tdamort ,
   @auxfluj = tdflujo ,
   @fsalpcup = tdsaldo    
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdfecven>@dfeccal
  set rowcount 0
  select @fsalpcup = @nsaldo
    
  --** cup½n anterior **--
  set rowcount 1
  select @auxmascara = tdmascara ,
   @nnumucup = tdcupon ,
   @dfecucup = tdfecven ,
   @fintucup = tdinteres ,
   @famoucup = tdamort ,
   @auxfluj = tdflujo ,
   @nsaldo  = tdsaldo
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdfecven<@dfecpcup
  order by tdcupon desc
  set rowcount 0
  select @fsalucup = @nsaldo
  --** valor par **-- 
  select @fvpar  = @nsaldo*round(power(convert(float,1)+@ntera/convert(float,100),datediff(day,@dfecucup,@dfeccal)/convert(float,365)),8)
  --** base 100 **--
  select @fmt_cien = round((@fpvp/convert(float,100)) * (@fvpar/convert(float,100)) * convert(float,100),4)
  --** tir **--
  select @ftir  = 0.0  ,
   @rango  = 50.0  ,
   @decs  = 2  ,
   @tkl  = @ntera ,
   @ut  = @ntera ,
   @ncount  = 1
  select @ma  = @rango * 1.0 ,
   @me  = @rango * -1.0
  while @ncount<=50
  begin
      
   if (1.0+@tkl/100.0)=0.0
    select @jvan = 0.0
   else
   begin
    select @jvan = 0.0
    select @jvan = sum(tdflujo/power(convert(float,1)+@tkl/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))
    from VIEW_TABLA_DESARROLLO
    where tdmascara=@cmascara and tdcupon>@nnumucup
   end
   select @ut = round(@tkl,@decs)
   if @jvan<@fmt_cien
    select @ma = @tkl
   else
    select @me = @tkl
   select @tkl = (@ma - @me) / 2.0 + @me
   if @ut=round(@tkl,@decs)
   begin
    select @ncount = 51
    if abs(round(@ut,0))=@rango
     select @ftir = 0.0
    else
     select @ftir = round(@ut,2)
   end
   select @ncount = @ncount + 1
 
  end
  if @ncount<>52
   select @ftir = 0.0
  --** van **--
  if (1.0+@ftir/100.0)=0.0
   select @jvan = 0.0
  else
  begin
   select @jvan = 0.0 ,
    @fdurat = 0.0 ,
    @fconvx = 0.0
   select @jvan = sum(tdflujo/power(convert(float,1)+@tkl/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))                ,
    @fdurat = sum((tdflujo*datediff(day,@dfeccal,tdfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365))))          ,
    @fconvx = sum((tdflujo*datediff(day,@dfeccal,tdfecven)/convert(float,365))*((datediff(day,@dfeccal,tdfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))
   from VIEW_TABLA_DESARROLLO
   where tdmascara=@cmascara and tdcupon>@nnumucup
  end
  select @fvan = @jvan
  --** duration y convexidad **--
  select @fdurat = round(@fdurat/@fvan,8)         ,
   @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
  select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  if @modcal=1
   select @fmt  = (@fvpar/convert(float,100))*@fnominal*(@fpvp/convert(float,100))
  else
   select @fnominal = round((10000.0*@fmt)/(@fpvp*@fvpar),4)
  select @fmtum = @fmt
  select @fmt = round(@fmt*@nvalmon,0)
 end
 if @modcal=2 or @modcal=5
 begin
  select @nsaldo  = 100.0  ,
   @dfecucup = @dfecemi ,
   @nnumucup = 0  ,
   @famoucup = 0.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0  ,
   @fvan  = 0.0  ,
   @fvan_1  = 0.0  ,
   @fvan_2  = 0.0
  --** pr½ximo cup½n **--
  set rowcount 1
  select @auxmascara = tdmascara ,
   @nnumpcup = tdcupon ,
   @dfecpcup = tdfecven ,
   @fintpcup = tdinteres ,
   @famopcup = tdamort ,
   @auxfluj = tdflujo ,
   @fsalpcup = tdsaldo
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdfecven>@dfeccal
  set rowcount 0
  select @fsalucup = @nsaldo
  --** cup½n anterior **--
  set rowcount 1
  select @auxmascara = tdmascara ,
   @nnumucup = tdcupon ,
   @dfecucup = tdfecven ,
   @fintucup = tdinteres ,
   @famoucup = tdamort ,
   @auxfluj = tdflujo ,
   @nsaldo  = tdsaldo
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdfecven<@dfecpcup
  order by tdcupon desc
  set rowcount 0
  select @fsalucup = @nsaldo
  --** van **--
  select @fvan = sum(tdflujo/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))                ,
   @fdurat = sum((tdflujo*datediff(day,@dfeccal,tdfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365))))          ,
   @fconvx = sum((tdflujo*datediff(day,@dfeccal,tdfecven)/convert(float,365))*((datediff(day,@dfeccal,tdfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdcupon>@nnumucup
  --** duration y convexidad **--
  select @fdurat = round(@fdurat/@fvan,8)         ,
   @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
  select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  --** valor par **--
  select @fvpar  = round(convert(float,@nsaldo)*power(convert(float,1)+@ntera/convert(float,100),datediff(day,@dfecucup,@dfeccal)/convert(float,365)),8)
  --** % valor par **--
  select @fpvp  = round((@fvan/@fvpar)*convert(float,100),2)
  if @modcal=2
   select @fmt  = (@fpvp/convert(float,100))*(@fvpar/convert(float,100))*@fnominal
  else
   select @fnominal = round(((10000.0*@fmt)/(@fpvp*@fvpar)),4)
  select @fmt_cien = round((@fpvp/convert(float,100))*(@fvpar/convert(float,100))*convert(float,100),4)
  select @fmtum  = @fmt
  select @fmt  = round(@fmt*@nvalmon,0)
 end
 if @modcal=3
 begin
  select @nsaldo  = convert(float,100) ,
   @dfecucup = @dfecemi  ,
   @nnumucup = 0   ,
   @famoucup = 0.0   ,
   @fintucup = 0.0   ,
   @fsalucup = 0.0
  --** pr½ximo cup½n **--
  set rowcount 1
  select @auxmascara = tdmascara ,
   @nnumpcup = tdcupon ,
   @dfecpcup = tdfecven ,
   @fintpcup = tdinteres ,
   @famopcup = tdamort ,
   @auxfluj = tdflujo ,
   @fsalpcup = tdsaldo
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdfecven>@dfeccal
  set rowcount 0
  select @fsalucup = @nsaldo
  --** cup½n anterior **--
  set rowcount 1
  select @auxmascara = tdmascara ,
   @nnumucup = tdcupon ,
   @dfecucup = tdfecven ,
   @fintucup = tdinteres ,
   @famoucup = tdamort ,
   @auxfluj = tdflujo ,
   @nsaldo  = tdsaldo
  from VIEW_TABLA_DESARROLLO
  where tdmascara=@cmascara and tdfecven<@dfecpcup
  order by tdcupon desc
  set rowcount 0
  select @fsalucup = @nsaldo
  select @fmtum  = round(@fmt/@nvalmon,4)
  --** base cien **--
  select @fmt_cien = round(@fmtum/@fnominal*convert(float,100),4)
  --** tir **--
  select @ftir  = 0.0  ,
   @rango  = 50.0  ,
   @decs  = 2  ,
   @tkl  = @ntera ,
   @ut  = @ntera ,
   @ncount  = 1
  select  @ma  = @rango *  1.0 ,
   @me  = @rango * -1.0 
  while @ncount<=50
  begin
      
   if (convert(float,1)+@tkl/convert(float,100))=0.0
    select @jvan = 0.0
   else
   begin
    select @jvan = 0.0
    select @jvan = sum(tdflujo/power(convert(float,1)+@tkl/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))
    from VIEW_TABLA_DESARROLLO
    where tdmascara=@cmascara and tdcupon>@nnumucup
   end
   select @ut = round(@tkl,@decs)
   if @jvan<@fmt_cien
    select @ma = @tkl
   else
    select @me = @tkl
   select @tkl = (@ma - @me) / convert(float,2) + @me
   if @ut=round(@tkl,@decs)
   begin
    select @ncount = 51
    if abs(round(@ut,0))=@rango
     select @ftir = 0.0
    else
     select @ftir = round(@ut,2)
   end
   select @ncount = @ncount + 1
  end
   
  if @ncount<>52
   select @ftir = 0.0
  --** van **--
  if (1.0+@ftir/100.0)=0.0
   select @jvan = 0.0
  else
  begin
   select @jvan = 0.0 ,
    @fdurat = 0.0 ,
    @fconvx = 0.0
   select @jvan = sum(tdflujo/power(convert(float,1)+@tkl/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))                ,
    @fdurat = sum((tdflujo*datediff(day,@dfeccal,tdfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365))))          ,
    @fconvx = sum((tdflujo*datediff(day,@dfeccal,tdfecven)/convert(float,365))*((datediff(day,@dfeccal,tdfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,tdfecven)/convert(float,365)))
   from VIEW_TABLA_DESARROLLO
   where tdmascara=@cmascara and tdcupon>@nnumucup
  end
  select @fvan = @jvan
  --** duration y convexidad **--
  select @fdurat = round(@fdurat/@fvan,8)         ,
   @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
  select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  --** valor par **--
  select @fvpar = @nsaldo*round(power(convert(float,1)+@ntera/convert(float,100),datediff(day,@dfecucup,@dfeccal)/convert(float,365)),8)
  --** % valor par **--
  select @fpvp = round((@fvan/@fvpar)*convert(float,100),2)
  select @fmt = round(@fmt,0)
 end
end

GO
