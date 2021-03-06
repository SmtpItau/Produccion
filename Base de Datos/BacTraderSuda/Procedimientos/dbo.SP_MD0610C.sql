USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0610C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0610C]
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
   @fnominal float  OUTPUT ,
   @ftir  float  OUTPUT  ,
   @fpvp  float  OUTPUT ,
   @fmt  float  OUTPUT ,
   @fmtum  float  OUTPUT ,
   @fmt_cien float  OUTPUT ,
   @fvan  float  OUTPUT ,
   @fvpar  float  OUTPUT ,
   @nnumucup integer  OUTPUT ,
   @dfecucup datetime OUTPUT ,
   @fintucup float  OUTPUT ,
   @famoucup float  OUTPUT ,
   @fsalucup float  OUTPUT ,
   @nnumpcup integer  OUTPUT ,
   @dfecpcup datetime OUTPUT ,
   @fintpcup float  OUTPUT ,
   @famopcup float  OUTPUT ,
   @fsalpcup integer  OUTPUT ,
   @fdurat  float  OUTPUT ,
   @fconvx  float  OUTPUT ,
   @fdurmo  float  OUTPUT
   )
as
begin
 declare @ndecs  integer  ,
  @ntkl  float  ,
  @nut  float  ,
  @nma  float  ,
  @nme  float  ,
  @ntera  numeric (08,04) ,
  @ncupones numeric (03,00) ,
  @nmonemis numeric (03,00) ,
  @nvalmon numeric (18,10) ,
  @npervcup numeric (03,00) ,
  @cfecemi    char (10) ,
  @ftip15  float  ,
  @ftasa  float  ,
  @nsk  integer  ,
  @nam  float  ,
  @fatip15 float  ,
  @fatasa  float  ,
  @fatasest float  ,
  @fpremioacup float  ,
  @nnumacup integer  ,
  @dfecacup datetime ,
  @fintacup float  ,
  @famoacup float  ,
  @fsalacup float  ,
  @fpremioucup float  ,
  @fpremiopcup float  ,
  @ncount         integer
 set rowcount 1
 select @ntera = -1.0
 select @ntera  = setera ,
  @ncupones = secupones ,
  @nmonemis = semonemi ,
  @npervcup = sepervcup ,
  @dfecemi = sefecemi ,
  @dfecven = sefecven ,
  @ftasemi = setasemi
 from VIEW_SERIE 
 where semascara=substring(@cmascara,1,5)
 set rowcount 0
 if @ntera=-1.0
 begin
  select 1,'LA SERIE INGRESADA NO HA SIDO ENCONTRADA EN TABLA DE SERIES'
  return
 end
 select @dfecemi = substring(@cmascara,7,2)+'/'+'01'+'/'+substring(@cmascara,9,2)
 select @dfecven = dateadd(month,(@ncupones * @npervcup),@dfecemi)
 if @dfeccal<@dfecemi
 begin
  select 1,'LA SERIE TIENE FECHA DE EMISI½N POSTERIOR A FECHA DE CYLCULO'
  return
 end
 
 select @nvalmon=vmvalor from VIEW_VALOR_MONEDA where vmcodigo=@nmonemis and vmfecha=@dfeccal 
 if @ftasest = 0.0
  select @ftasest=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=300 and vmfecha=@dfeccal 
 select  'prcupon' = prcupon      ,
  'prfecven' = dateadd(month,(prcupon * @npervcup), @dfecemi) ,
  'prflujo'  = convert(float,0)     ,
  'prdescap' = convert(integer,0)     ,
  'prdias'   = datediff(day,dateadd(month,(prcupon-1) * @npervcup, @dfecemi),dateadd(month,prcupon * @npervcup, @dfecemi))
 into #TMP
 from MDPR
 where prcodigo=@ncodigo and prcupon<=@ncupones
 --** pr½ximo cup½n **--
 set rowcount 1
 select  @nnumpcup = prcupon ,
  @dfecpcup = prfecven
 from #TMP
 where prfecven>@dfeccal
 set rowcount 0
 if @nnumpcup = 1
 begin
  select @dfecucup = @dfecemi ,
   @ftip15  = @ftasemi ,
   @ftasa  = @ftasemi
 end 
 else
 begin
  --** cup½n anterior **--
  set rowcount 1
  select @nnumucup = prcupon ,
   @dfecucup = prfecven
  from #TMP
  where prfecven<@dfecpcup
  order by prcupon desc
  set rowcount 0
  --** tip quincenal o mensual ( cup½n anterior ) **--
  select @ftip15 = 0.0  ,
   @ncount = 1
  if datepart(day,@dfecucup)<16
  begin
   while @ftip15=0.0
   begin
    select @ftip15=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=432 and vmfecha=dateadd(month,@ncount*-1,@dfecucup)
    select @ncount = @ncount + 1
    if @ncount>31
     break
   end
  end
  else
  begin
   while @ftip15=0.0
   begin
    select @ftip15=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=431 and vmfecha=dateadd(month,@ncount*-1,@dfecucup) 
    select @ncount = @ncount + 1
    if @ncount>31
     break
   end
  end
  select @ftasa = @ftip15 * 0.95
  if @dfeccal>=@dfecucup --**  calcula ultimo cupon  **--
  begin
   --** cup½n anterior para pago de cup½n **--
   set rowcount 1
   select  @nnumacup = prcupon ,
    @dfecacup = prfecven
   from #TMP
   where prcupon=@nnumucup-1
   order by prcupon desc
   set rowcount 0
   --** tasa estimada ultimo cupon **--
   select @ncount  = 0 ,
    @fatasest = 0.0
   while @fatasest=0.0
   begin
    select @fatasest=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=300 and vmfecha=dateadd(day,@ncount*-1,@dfecucup)
    select @ncount = @ncount + 1
    if @ncount>31 break
   end
   --** tip quincenal o mensual ( cup½n anterior ) **--
   select @fatip15 = 0.0  ,
    @ncount  = 1
   if datepart(day,@dfecacup)<16
   begin
    while @fatip15=0.0
    begin
     select @fatip15=vmvalor from VIEW_VALOR_MONEDA where vmcodigo=432 and vmfecha=dateadd(month,@ncount*-1,@dfecacup) 
     select @ncount = @ncount + 1
     if @ncount>31
      break
    end
   end
   else
   begin
    while @fatip15=0.0
    begin
     select @fatip15=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=431 and vmfecha=dateadd(month,@ncount*-1,@dfecacup) 
     select @ncount = @ncount + 1
     if @ncount>31
      break
    end
   end
   select @fatasa = @fatip15 * 0.95
   select @nam = convert(float,5)
   if @nnumacup<11
    select @nsk  = 100 ,
     @famoucup = 0.0   
   else
    select @nsk  = 100-(5*(@nnumacup-10)) ,
     @famoucup = 5.0
   update #TMP set prdescap= case
       when prcupon=@nnumucup  then @nsk
       when prcupon>=@nnumacup then @nsk-((prcupon-(@nnumacup+1))*5)
        end
   where prcupon>@nnumacup
   update #TMP set prflujo = case
       when prcupon=@nnumucup and prcupon<=10 then (power(power(@fatasa/convert(float,100)+convert(float,1),convert(float,1)/convert(float,360)),prdias)-convert(float,1))
       when prcupon=@nnumucup and prcupon>10 then (power(power(@fatasa/convert(float,100)+convert(float,1),convert(float,1)/convert(float,360)),prdias)-convert(float,1))*prdescap+@nam
       when prcupon>@nnumacup and prcupon>10 then (power(power(((@fatasest*convert(float,0.95))/convert(float,100)+convert(float,1)),(convert(float,1)/convert(float,360))),prdias)-1)*prdescap+@nam
        end
   where prcupon>@nnumacup
   --** valor cup½n pr½ximo cup½n **--
   select @fintucup = round(prflujo,4) from #TMP where @dfecucup=prfecven
  end
 end
 select @nam = convert(float,5)
 if @nnumucup<11
  select @nsk = 100
 else
  select @nsk = 100-(5*(@nnumucup-10))
 update #TMP set prdescap= case
     when prcupon=@nnumpcup  then @nsk
     when prcupon>=@nnumucup then @nsk-((prcupon-(@nnumucup+1))*5)
      end
 where prcupon>@nnumucup
 update #TMP set prflujo = case
     when prcupon=@nnumpcup and prcupon<=10 then (power(power(@ftasa/convert(float,100)+convert(float,1),convert(float,1)/convert(float,360)),prdias)-convert(float,1))
     when prcupon=@nnumpcup and prcupon>10 then (power(power(@ftasa/convert(float,100)+convert(float,1),convert(float,1)/convert(float,360)),prdias)-convert(float,1))*prdescap+@nam
     when prcupon>@nnumucup and prcupon>10 then (power(power(((@ftasest*convert(float,0.95))/convert(float,100)+convert(float,1)),(convert(float,1)/convert(float,360))),prdias)-1)*prdescap+@nam
      end
 where prcupon>@nnumucup
 --** valor cup½n pr½ximo cup½n **--
 select @famopcup = 0.0
 select @fintpcup = round(prflujo,4) from #TMP where @dfecpcup=prfecven
 if @modcal = 1
 begin
  --** valor par base 100 **--
  select @fvpar = round(@nsk*(power(power((@ftasa/convert(float,100)+convert(float,1)),(convert(float,1)/convert(float,360))),datediff(day,@dfecucup,@dfeccal))),8)
  --** monto um **--
  select @fmtum = (@fpvp/convert(float,100))*@fnominal*(@fvpar/convert(float,100))
  --** base cien **--
  select @fmt_cien = (@fpvp/convert(float,100))*convert(float,100)*(@fvpar/convert(float,100))
  select @ftir = 0.0  ,
   @ndecs = 4  ,
   @ntkl = @ftasa ,
   @nut = @ntkl  ,
   @nma = 50  ,
   @nme = 0  ,
   @ncount = 1
  while @ncount<=50
  begin
   select @fvan = 0.0
   select @fvan = sum(prflujo/power((convert(float,1)+@ntkl/convert(float,100)),(datediff(day,@dfeccal,prfecven)/@fbasemi)))
   from #TMP
   where prcupon>@nnumucup
   select @nut = round(@ntkl, @ndecs)
   if @fvan<@fmt_cien
    select @nma = @ntkl
   else
    select @nme = @ntkl
   select @ntkl = (@nma - @nme) / 2.0 + @nme
 
   if @nut=round(@ntkl,@ndecs)
    select @ncount = 51  ,
     @ftir = round(@nut,2)
 
   select @ncount = @ncount + 1
 
  end
  if @ncount<>52
   select @ftir = 0.0 ,
    @fdurat = 0.0 ,
    @fconvx = 0.0 ,
    @fdurmo = 0.0
  else
  begin
   select @fvan = sum(prflujo/power((convert(float,1)+convert(float,6.9)/convert(float,100)),(datediff(day,@dfeccal,prfecven)/@fbasemi)))               ,
    @fdurat = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365))))          ,
    @fconvx = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365))*((datediff(day,@dfeccal,prfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365)))
   from #TMP
   where prcupon>@nnumucup
   --** duration y convexidad **--
   select @fdurat = round(@fdurat/@fvan,8)         ,
    @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
   select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  end
  if @modcal=1
   select @fmt = round(@fmtum * @nvalmon, 0)
  else
   select @fnominal = round((10000.0 * @fmt) / (@fpvp * @fvpar), 4)
  
 end
 if @modcal=2
 begin
  --** van **--
  select @fvan = sum(prflujo/power((convert(float,1)+@ftir/convert(float,100)),(datediff(day,@dfeccal,prfecven)/@fbasemi)))                 ,
   @fdurat = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365))))          ,
   @fconvx = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365))*((datediff(day,@dfeccal,prfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365)))
  from #TMP
  where prcupon>@nnumucup
  --** duration y convexidad **--
  select @fdurat = round(@fdurat/@fvan,8)         ,
   @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
  select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  --** valor par base 100 **--
  select @fvpar = round(@nsk*(power(power((@ftasa/convert(float,100)+convert(float,1)),(convert(float,1)/convert(float,360))),datediff(day,@dfecucup,@dfeccal))),8)
  --** porcentaje valor par **--
  select @fpvp = round((@fvan/@fvpar)*100,2)
  --** monto um - $$ *--
  select @fmtum = (@fpvp/convert(float,100))*@fnominal*(@fvpar/100)
  select @fmt = round(@fmtum*@nvalmon,0)
 
 end
 if @modcal = 3
 begin
  --** monto um **--
  select @fmtum = round(@fmt / @nvalmon, 4)
  --** valor par base 100 **--
  select @fvpar  = round(@nsk*(power(power((@ftasa/convert(float,100)+convert(float,1)),(convert(float,1)/convert(float,360))),datediff(day,@dfecucup,@dfeccal))),8)
  --** % valor par **--
  select @fpvp =round((@fmt/((@fvpar/convert(float,100)*@fnominal)*@nvalmon))*convert(float,100), 2)
  --** base cien **--
  select @fmt_cien = (@fpvp/convert(float,100))*100.0*(@fvpar/convert(float,100))
  --** tir **--
  select @ftir = 0.0  ,
   @ndecs = 4  ,
   @ntkl = @ftasa ,
   @nut = @ntkl  ,
   @nma = 50  ,
   @nme = 0  ,
   @ncount = 1
  while @ncount<=50
  begin
   select @fvan = 0.0
   select @fvan = sum(prflujo/power((convert(float,1)+@ntkl/convert(float,100)),(datediff(day,@dfeccal,prfecven)/@fbasemi)))
   from #TMP
   where prcupon>@nnumucup
   select @nut = round(@ntkl, @ndecs)
   if @fvan<@fmt_cien
    select @nma = @ntkl
   else
    select @nme = @ntkl
   select @ntkl = (@nma - @nme) / 2.0 + @nme
 
   if @nut=round(@ntkl,@ndecs)
   begin
    select @ncount = 51  ,
     @ftir = round(@nut,2)
   end
 
   select @ncount = @ncount + 1
  end
  if @ncount<>52
   select @ftir = 0.0 ,
    @fdurat = 0.0 ,
    @fconvx = 0.0 ,
    @fdurmo = 0.0
  else
  begin
   --** van **--
   select @fvan = sum(prflujo/power((convert(float,1)+convert(float,6.9)/convert(float,100)),(datediff(day,@dfeccal,prfecven)/@fbasemi)))               ,
    @fdurat = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365))))          ,
    @fconvx = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365))*((datediff(day,@dfeccal,prfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365)))
   from #TMP
   where prcupon>@nnumucup
   --** duration y convexidad **--
   select @fdurat = round(@fdurat/@fvan,8)         ,
    @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
   select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  end
 end
end

GO
