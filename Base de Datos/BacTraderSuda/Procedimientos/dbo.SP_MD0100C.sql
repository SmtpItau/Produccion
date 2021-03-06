USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0100C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0100C]
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
    @fmt_cien float  OUTPUT  ,
    @fvan   float  OUTPUT  ,
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
    @fsalpcup integer  OUTPUT  ,
    @fdurat  float  OUTPUT ,
    @fconvx  float  OUTPUT ,
    @fdurmo  float  OUTPUT
    )
as
begin
 declare @ntera  numeric (08,04) ,
  @ftera  float  ,
  @ncupones numeric (03,00) ,
  @nmonemis numeric (03,00) ,
  @nsaldo  float  ,
  @nvalmon numeric (18,10) ,
  @npervcup numeric (03,00) ,
  @ndecs  integer  ,
  @nintpcup float  ,
  @namopcup float  ,
  @nsalpcup float  ,
    @auxmascara char (12) ,
  @fpremiopcup float  ,
  @fpremioucup float  ,
  @ntkl  float  ,
  @nut  float  ,
  @nma  float  ,
  @nme  float  ,
  @ncount  integer  ,
  @flibo  float  ,
  @ftasa  float  ,
  @flog  float  ,
  @falibo  float  ,
  @fatasa  float  ,
  @fatasest float  ,
  @fpremioacup float  ,
  @nnumacup integer  ,
  @dfecacup datetime ,
  @fintacup float  ,
  @famoacup float  ,
  @fsalacup float  ,
  @pervcupano    float   ,
  @xcien  float  
 select @ntera  = -1.0  ,
  @nvalmon = 0.0
 set rowcount 1
 select @ntera  = setera ,
  @ncupones = secupones ,
  @nmonemis = semonemi ,
  @npervcup = sepervcup ,
  @dfecemi = sefecemi ,
  @dfecven = sefecven ,
  @ftasemi = setasemi ,
  @pervcupano = (12/sepervcup)
 from VIEW_SERIE 
 where semascara=@cmascara
 set rowcount 0
 if @ntera=-1.0
 begin
  select 1,'LA SERIE INGRESADA NO HA SIDO ENCONTRADA EN TABLA DE SERIES'
  return
 end
 if @dfeccal<@dfecemi
 begin
  select 1,'LA SERIE TIENE FECHA DE EMISION POSTERIOR A FECHA DE CYLCULO'
  return
 end
 if @dfeccal>@dfecven
 begin
select @dfeccal = @dfecven
--  select 1,'la serie tiene fecha de vcto. anterior a fecha de cÿlculo'
--  return
 end
 select @auxmascara = '*'  ,
  @auxmascara = prserie
 from MDPR
 where prcodigo=1 and prserie=substring(@cmascara,7,1)
 if @auxmascara='*'
 begin
  select 1,'TABLA DE PREMIOS NO HA SIDO ENCONTRADA'
  return 
 end
 select @nvalmon=vmvalor from VIEW_VALOR_MONEDA   where  vmcodigo=@nmonemis and vmfecha=@dfeccal 
 
 if @ftasest=0.0
  select @ftasest=vmvalor from VIEW_VALOR_MONEDA   where  vmcodigo=302 and vmfecha=@dfeccal 
 --** llenado de tabla temporal **--
 select prcodigo       ,
  prserie        ,
  prcupon        ,
        'prfecven' = dateadd(month,(prcupon*@npervcup),@dfecemi) ,
  prpremio       ,
        'prflujo' = convert(numeric(19,4),0)   ,
        'prdias'  = datediff(day,dateadd(month,(prcupon-1)*@npervcup,@dfecemi),dateadd(month,prcupon*@npervcup,@dfecemi))
 into #TMP
 from MDPR
 where  prserie=substring(@cmascara,7,1) 
 and  prcodigo=1
 select @nnumpcup = @ncupones ,
  @dfecpcup = @dfecven ,
  @fpremiopcup = 100.0
 --** pr½ximo cup½n **--
 set rowcount 1
 select @nnumpcup = isnull(prcupon,@ncupones) ,
  @dfecpcup = isnull(prfecven,@dfecven) ,
  @fpremiopcup = isnull(prpremio,0)
 from #TMP
 where prserie=substring(@cmascara,7,1) 
 and  prcodigo=1 
 and  prfecven>@dfeccal
 set rowcount 0
 if @nnumpcup=1
  select @dfecucup = @dfecemi ,
   @flibo    = @ftasemi ,
   @ftasa    = @ftasemi
 else
 begin
  --** cup½n anterior **--
  set rowcount 1
  select @nnumucup = prcupon ,
   @dfecucup = prfecven ,
   @fpremioucup = prpremio
  from #TMP
  where prserie=substring(@cmascara,7,1) 
  and  prcodigo=1 
  and  prfecven<@dfecpcup
  order by prcupon desc
  set rowcount 0
  --** libo 180 d-as ( cup½n anterior ) **--
  select @flibo = 0.0 ,
   @ncount = 0
  while @flibo=0.0
  begin
   select @flibo = vmvalor from VIEW_VALOR_MONEDA  where  vmcodigo=222 and vmfecha=dateadd(day,@ncount*-1,@dfecucup) 
   select @ncount = @ncount + 1
   if @ncount>31
    break
  end
  select @fsalucup = @flibo 
  select @ftasa  = @flibo + @fpremiopcup
             -- **  calcula ultimo cup½n  **--
  if @dfeccal>=@dfecucup and @fpremiopcup<>100 
  begin
   --** cup½n anterior para pago de cup½n **--
   set rowcount 1
   select @nnumacup = prcupon ,
    @dfecacup = prfecven ,
    @fpremioacup = prpremio
   from #TMP
   where prserie=substring(@cmascara,7,1) and prcodigo=1 and prfecven<@dfecucup
   order by prcupon desc
   set rowcount 0
   --** tasa estimada ultimo cupon **--
   select @fatasest=vmvalor from VIEW_VALOR_MONEDA  where  vmcodigo=302 and vmfecha=@dfecacup 
   --** tip promedio mensual ( cup½n anterior ) **--
   select @falibo = 0.0 ,
    @ncount = 0
   while @falibo=0.0
   begin
    select @falibo=vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=222 and  vmfecha=dateadd(day,@ncount*-1,@dfecacup)
    select @ncount = @ncount + 1
    if @ncount>31
     break
   end
   if @falibo=0
   begin
    select @ncount = 0
    while @falibo=0.0
    begin
     select @falibo=vmvalor from VIEW_VALOR_MONEDA  where  vmcodigo=222 and vmfecha=dateadd(day,@ncount*-1,@dfecacup) 
     select @ncount = @ncount + 1
     if @ncount>5
      break
    end
   end
   select @fatasa = @falibo + @fpremioacup ,
    @xcien = 100.0
   update #TMP
   set prflujo = round(@xcien*(@fatasa*(prdias/360.0))/100.0, 4)
   where prcupon=@nnumucup
   update #TMP
   set prflujo = round(@xcien*(((@fatasest+prpremio)*(prdias/360.0)))/100.0, 4)
   where prcupon>@nnumucup
   update #TMP
   set prflujo = round(prflujo + @xcien, 4)
   where prcupon=@ncupones
   select @fintucup = prflujo from #TMP where prcupon=@nnumucup
   select @dfecucup = @dfecucup ,
    @famoucup = 0.0
  end
  else
  begin
   select @fpremiopcup = @fpremioucup
   --** libo 180 d-as ( cup½n anterior ) **--
   select @flibo = 0.0 ,
    @ncount = 0 ,
    @xcien = 100.0
   while @flibo=0.0
   begin
    select @flibo = vmvalor from VIEW_VALOR_MONEDA where  vmcodigo=222 and vmfecha=dateadd(day,@ncount*-1,@dfecucup) 
    select @ncount = @ncount + 1
    if @ncount>31
     break
   end
   select @fsalucup = @flibo --** para cambio de tir **--
   select @ftasa  = @flibo + @fpremiopcup
   update #TMP
   set prflujo = round(@xcien*(@ftasa*(prdias/360.0))/100.0, 4)
   where prcupon=@ncupones
   select @fintucup = prflujo from #TMP where prcupon=@ncupones
   select @famoucup = 100.0  ,
    @fsalucup = 0.0  ,
    @famopcup = 0.0  ,
    @fsalpcup = 0.0  ,
    @nnumucup = @ncupones ,
    @dfecucup = @dfecven ,
    @nnumpcup = 0.0  ,
    @fintpcup = 0.0  ,
    @fvpar  = 0.0  ,
    @fpvp  = 0.0  ,
    @fvan  = 0.0  ,
    @fmt  = 0.0  ,
    @fmt_cien  = 0.0  ,
    @fmtum     = 0.0
   return
  end
 end
 select @ncount = @nnumpcup
 if @modcal=1 or @modcal=3
  select @xcien  = @fnominal
 else
  select @xcien  = 100.0
 update #TMP
 set prflujo = round(@xcien*(@ftasa*(prdias/360.0))/100.0, 4)
 where prcupon=@nnumpcup
 update #TMP
 set prflujo = round(@xcien*(((@ftasest+prpremio)*(prdias/360.0)))/100.0, 4)
 where prcupon>@nnumpcup
 update #TMP
 set prflujo = round(prflujo + @xcien, 4)
 where prcupon=@ncupones
 --** valores de interes, amortizaci½n y saldo **--
 select @fintpcup=prflujo-@xcien from #TMP where prcupon=@nnumpcup
 if @nnumpcup=@ncupones
  select @famopcup = 100.0
 else
  select @famopcup = 0.0
 if @nnumpcup = @ncupones
  select @fsalpcup = 0.0
 else
  select @fsalpcup = 100.0
 if @modcal = 1
 begin
  select @fmtum = round(@fmt / @nvalmon, 4)
  --** tera **--
  select @ntera = 0.0 ,
   @ftera = 0.0
  select @flog = log10(convert(float,1)+@ftasa*datediff(day,@dfecucup,@dfecpcup)/convert(float,36000))
  select @ftera = ((power(convert(float,10),(@flog*convert(float,365)/datediff(day,@dfecucup,@dfecpcup))))-1.0)*100.0
      -- ** valor par ***--
  select @fvpar = round(convert(float,100)*power((convert(float,1)+@ftera/convert(float,100)),datediff(day,@dfecucup,@dfeccal)/convert(float,365)),8)
      -- ** base 100 **--
  select @fmt_cien= (@fpvp/convert(float,100))*@fnominal*(@fvpar/convert(float,100))
  select @ftir = 0.0  ,
   @ndecs = 4  ,
   @ntkl = @ntera ,
   @nut = @ntkl  ,
   @nma = 50  ,
   @nme = 0  ,
   @ncount = 1
  while @ncount<=50
  begin
         select @fvan = 0.0 ,
    @fdurat = 0.0 ,
    @fconvx = 0.0
   select @fvan = sum(prflujo/power(convert(float,1)+@ntkl/convert(float,100.0),(datediff(day,@dfeccal,prfecven)/convert(float,365.0))))                ,
    @fdurat = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365.0)/power(convert(float,1)+@ftir/convert(float,100.0),datediff(day,@dfeccal,prfecven)/convert(float,365.0))))          ,
    @fconvx = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365.0))*((datediff(day,@dfeccal,prfecven)/convert(float,365.0))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365.0)
))
   from #TMP
   where prcupon>@nnumucup
   select @fvan = round(@fvan,4)
   select @nut = round(@ntkl,@ndecs)
   if @fvan<@fmt_cien
    select @nma = @ntkl
   else
    select @nme = @ntkl
   select @ntkl = (@nma - @nme) / 2.0 + @nme
   if @nut=round(@ntkl,@ndecs)
   begin
    select @ncount = 51
    select @ftir = round(@nut,2)
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
   --** duration y convexidad **--
   select @fdurat = round(@fdurat/@fvan,8)         ,
    @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
   select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  end
  if @modcal=1
   select @fmt = round(@fmt_cien * @nvalmon, 0)
  else
  begin
   select @fmt  = round(@fmt / @nvalmon, 4)
   select @fnominal  = round((10000.0 * @fmt) / (@fpvp * @fvpar), 4)
  end
  select @fmt = round(@fmt, 0)
 end
 if @modcal = 2
 begin
  --** van **--
  select @fvan = 0.0
  select @fvan = sum(prflujo/power(1.0+@ftir/convert(float,100.0),(datediff(day,@dfeccal,prfecven)/convert(float,365))))                 ,
   @fdurat = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365))))          ,
   @fconvx = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365))*((datediff(day,@dfeccal,prfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365)))
  from #TMP
  where prcupon > @nnumucup
  --** duration y convexidad **--
  select @fdurat = round(@fdurat/@fvan,8)         ,
   @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
  select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  --** tera **--
  select @ntera = 0.0 ,
   @ftera = 0.0
  select @flog = log10(convert(float,1)+@ftasa*datediff(day,@dfecucup,@dfecpcup)/convert(float,36000))
  select @ftera  = ((power(convert(float,10),(@flog*convert(float,365)/datediff(day,@dfecucup,@dfecpcup))))-1.0)*100.0
  --** valor par **--
  select @fvpar = round(convert(float,100)*power((convert(float,1)+@ftera/convert(float,100)),datediff(day,@dfecucup,@dfeccal)/convert(float,365)),8)
  --** % valor par **--
  select @fpvp = round((@fvan/@fvpar)*100.0,2)
  if @modcal=2
   select @fmt = round((@fpvp/convert(float,100))*(@fvpar/convert(float,100))*@fnominal, 4)
  else
  begin
   select @fmt  = round(@fmt/@nvalmon, 4)
   select @fnominal = round(((convert(float,10000)*@fmt)/(@fpvp*@fvpar)), 4)
  end
  select @fmt_cien = round((@fpvp/convert(float,100))*(@fvpar/convert(float,100))*convert(float,100), 4)
  select @fmtum    = @fmt
  select @fmt      = round(@fmt * @nvalmon, 0)
 end
 if @modcal = 3
 begin
  select @fmtum  = round(@fmt / @nvalmon, 4)
  --** tera **--
  select @ntera = 0.0 ,
   @ftera = 0.0
  select @flog = log10(convert(float,1)+@ftasa*datediff(day,@dfecucup,@dfecpcup)/convert(float,36000))
  select @ftera = ((power(convert(float,10),(@flog*convert(float,365)/datediff(day,@dfecucup,@dfecpcup))))-1.0)*100.0
  --** valor par **--
  select @fvpar = round(convert(float,100)*power((convert(float,1)+@ftera/convert(float,100)),datediff(day,@dfecucup,@dfeccal)/convert(float,365)),8)
  --** % valor par **--
  select @fpvp = round((@fmt/((@fvpar/convert(float,100)*@fnominal)*@nvalmon))*convert(float,100), 2)
  --** base cien **--
  select @fmt_cien = (@fpvp/convert(float,100))*@fnominal*(@fvpar/convert(float,100))
  --** tir **--
  select @ftir = 0.0  ,
   @ndecs = 4  ,
   @ntkl = @ntera ,
   @nut = @ntkl  ,
   @nma = 50  ,
   @nme = 0  ,
   @ncount = 1
  while @ncount<=50
  begin
   select @fvan = 0.0 ,
    @fdurat = 0.0 ,
    @fconvx = 0.0
   select @fvan = sum(prflujo/power(convert(float,1)+@ntkl/convert(float,100),(datediff(day,@dfeccal,prfecven)/convert(float,365))))                ,
    @fdurat = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365)/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365))))          ,
    @fconvx = sum((prflujo*datediff(day,@dfeccal,prfecven)/convert(float,365))*((datediff(day,@dfeccal,prfecven)/convert(float,365))+convert(float,1))/power(convert(float,1)+@ftir/convert(float,100),datediff(day,@dfeccal,prfecven)/convert(float,365)))
   from #TMP
   where prcupon>@nnumucup
   select @fvan = round(@fvan,2)
   select @nut = round(@ntkl,@ndecs)
   if @fvan<@fmt_cien
    select @nma = @ntkl
   else
    select @nme = @ntkl
   select @ntkl = (@nma - @nme) / 2.0 + @nme
   if @nut=round(@ntkl,@ndecs)
   begin
    select @ncount = 51
    select @ftir = round(@nut,2)
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
   --** duration y convexidad **--
   select @fdurat = round(@fdurat/@fvan,8)         ,
    @fconvx = round((@fconvx/power(convert(float,1)+@ftir/convert(float,100),convert(float,2)))/@fvan,8)
   select @fdurmo = round(@fdurat/(convert(float,1)+@ftir/convert(float,100)),8)
  end
  select @fmt = round(@fmt,0)
 end
end

GO
