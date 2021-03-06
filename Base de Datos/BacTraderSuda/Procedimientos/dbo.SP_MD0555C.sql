USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0555C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0555C]
    ( 
    @modcal     integer          ,
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
    @fsalpcup   integer  OUTPUT  ,
    @fdurat     float    OUTPUT  ,
    @fconvx     float    OUTPUT  ,
    @fdurmo     float    OUTPUT 
    )
as
begin
 declare @imesemi integer  ,
  @ianoemi integer  ,
  @idiaman integer  ,
  @ianovto integer  ,
  @imesman integer  ,
  @cmesvto char (02) ,
  @iextrae integer  ,
  @cfecemi char (10) ,
  @cfecemi_ipc char (10) ,
  @dfecemi_ipc datetime ,
  @cfecven char (10) ,
  @cfecman char (10) ,
  @fipcemi float  ,
  @fipccal float  ,
  @dfecman datetime ,
  @nm1  integer  ,
  @nm2  integer  ,
  @nfactor integer  ,
  @ndifmes integer  ,
  @fvpar2  float  ,
  @fvan2  float  ,
  @fpvp2  float  ,
  @ni  integer  ,
  @nut  float  ,
  @nma  float  ,
  @nme  float  ,
  @ntkl  float  ,
  @mensaje        char(100)
 select @imesemi = 0   ,
  @ianoemi = 0   ,
  @idiaman = 0   ,
  @ianovto = 0   ,
  @imesman = 0   ,
  @cmesvto = ''   ,
  @iextrae = 0   ,
  @cfecemi = ''   ,
  @cfecven = ''   ,
  @cfecman = ''   ,
  @fipcemi = 0.0   ,
  @fipccal = 0.0   ,
  @dfecman = ''   ,
  @nm1  = 0   ,
  @nm2  = 0   ,
  @nfactor = 0   ,
  @ndifmes = 0   ,
  @fvpar2  = 0.0   ,
  @fvan2  = 0.0   ,
  @fpvp2  = 0.0   ,
  @ni  = 1   ,
  @nut  = convert(float,6.5) ,
  @nma  = convert(float,50) ,
  @nme  = 0.0   ,
  @ntkl  = convert(float,6.5) ,
  @fdurat      = 0.0   ,
  @fconvx      = 0.0   ,
  @fdurmo      = 0.0
 select  @fvpar2  = 0.0   ,
  @nnumucup = 0   ,
  @fintucup = 0.0   ,
  @famoucup = 0.0   ,
  @fsalucup = 0.0   ,
  @nnumpcup = 0   ,
  @fintpcup = 0.0   ,
  @famopcup = 0.0   ,
  @fsalpcup = 0.0
 select @ianovto = convert(int,substring(@cmascara,9,2))
 if @ianovto>=0 and @ianovto<95
  select @ianovto = 2000 + @ianovto
 else
  select @ianovto = 1900 + @ianovto
 select @imesman  = datepart(day,@dfeccal)*-1
 select @cfecven  = substring(@cmascara,7,2)+'/'+substring(@cmascara,5,2)+'/'+convert(char(04),@ianovto)
 select @cfecemi  = '06/30/1979'
 select @cfecemi_ipc = '06/01/1979'
 select @cfecman  = convert(char(8),dateadd(day,@imesman,@dfeccal),112)
 select @dfecman  = convert(datetime,substring(@cfecman,5,2)+'/01/'+substring(@cfecman,1,4))
 select @dfecemi  = convert(datetime,@cfecemi)
 select @dfecven  = convert(datetime,@cfecven)
 select @dfecemi_ipc = convert(datetime,@cfecemi_ipc)
        print @cfecemi
 select @fipcemi = vmvalor from VIEW_VALOR_MONEDA where vmcodigo=502 and vmfecha=@dfecemi_ipc
 select @fipccal = vmvalor from VIEW_VALOR_MONEDA where vmcodigo=502 and vmfecha=@dfecman
 select @nm1 = datepart(month,@dfecemi)+1
 select @nm2 = datepart(month,@dfeccal)
 if @nm1>12
  select @nm1  = @nm1 - 12
 if @nm2>@nm1
  select @ndifmes = @nm2 - @nm1
 else
  select @ndifmes = (@nm2 + 12) - @nm1 
  
 --select @fvpar = round(100.0*(@fipccal/@fipcemi)*power(convert(float,1.04),datediff(year,@dfecemi,@dfeccal)+@nfactor)*(1.0+(convert(float,0.04)/12.0)*@ndifmes),8)
 select @fvpar = round(100.0*(@fipccal/@fipcemi),8)
 --select @fvpar2= round(100.0*power(convert(float,1.04),datediff(year,@dfecemi,@dfeccal)+@nfactor)*(1.0+(convert(float,0.04)/12.0)*@ndifmes),8)
 select @fvpar2= round( power((1+@ftir/100.0),(datediff(day,@dfeccal,@dfecven)/365.0)),8)
 select @nm1  = datepart(month,@dfecemi)+1 ,
  @nm2  = datepart(month,@dfecven) ,
  @nfactor = 0
 if @nm1=13
  select @nm1  = 1,
         @nfactor         = -1
 if @nm2>@nm1
  select @ndifmes = @nm2 - @nm1
 else
  select @ndifmes = (@nm2 + 12) - @nm1 ,
             @nfactor         = -1
  
 if @modcal=1 or @modcal=4
 begin
--  select @fmt = round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
  select @fmt = (@fpvp/100.0)*@fnominal*(@fvpar/100.0)
  while @ni<=50
  begin
   select @fvan = 100.0*power(convert(float,1.04),datediff(year,@dfecemi,@dfecven)+@nfactor)*(1.0+(convert(float,0.04)/12.0)*@ndifmes)
   select @fvan = @fvan/(power(convert(float,1)+@ntkl/convert(float,100),datediff(day,@dfeccal,@dfecven)/convert(float,365)))
   select @fpvp = round((@fvan/@fvpar2)*100.0,2)
   select @fvan = round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
   select @nut = round(@ntkl,4)
   if @fvan<@fmt
   begin
    select @nma = @ntkl
    select @ntkl = ( @nma - @nme )/ 2.0 + @nme
   end
   else
   begin
    select @nme = @ntkl
    select @ntkl = ( @nma - @nme)/ 2.0 + @nme
   end
   if @nut=round(@ntkl,4)
   begin
    select @ftir = round(@nut,2)
    break
   end
   select @ni = @ni + 1
   
  end
 end
 if @modcal=2 or @modcal=5
 begin
--  select @fvan2 = round( power((1+@ftir/100.0),(datediff(day,@dfeccal,@dfecven)/365.0)),8)
  select @fvan2 = power((1+(@ftir/100.0)),(datediff(day,@dfeccal,@dfecven)/365.0))
  select @fvan = round((1/@fvan2)*100.0,2)
  select @mensaje = convert(char(25),@fvpar) + '...'+
      convert(char(25),@fvan2) + '...'+
      convert(char(25),@fvan)
print @mensaje
  select @fpvp = round((@fvan/@fvpar2)*100.0,2)
  select @fpvp2 = round((@fvan2/@fvpar)*100.0,2)
  select @fmt = (@fvan/100.0)*@fnominal*(@fvpar/100.0)
--  select @fmt = round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
--  select @fmt = (@fpvp/100.0)*@fnominal*(@fvpar/100.0)
  select @nm2 = datepart(month,@dfecven)
  select @nfactor = 0
  if @nm1>12
  begin
   select @nfactor = -1   ,
    @nm1  = @nm1 - 12
  end
  if @nm2>@nm1
   select @ndifmes = @nm2 - @nm1
  else
  begin
   select @ndifmes = (@nm2 + 12) - @nm1 ,
    @nfactor  = -1
  end
  select @fvpar = round(100.0*(@fipccal/@fipcemi)*power(convert(float,1.04),datediff(year,@dfecemi,@dfecven)+@nfactor)*(1.0+(convert(float,0.04)/12.0)*@ndifmes),8)
  select @famopcup = round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
--select @famopcup,round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0),@fpvp,@fnominal,@fvpar
 
 end
 
 if @modcal=3
 begin
  select @fpvp = (@fmt/(@fvpar/100.0*@fnominal))*100.0
--  select @fmt = round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
  select @fmt = (@fpvp/100.0)*@fnominal*(@fvpar/100.0)
  while @ni<=50
  begin
   select @fvan = 100.0*power(convert(float,1.04),datediff(year,@dfecemi,@dfecven)+@nfactor)*(1.0+(convert(float,0.04)/12.0)*@ndifmes)
   select @fvan = @fvan/(power(convert(float,1)+@ntkl/convert(float,100),datediff(day,@dfeccal,@dfecven)/convert(float,365)))
   select @fpvp = round((@fvan/@fvpar2)*100.0,2)
   select @fvan = round((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
   select @nut = round(@ntkl,4)
   if @fvan<@fmt
   begin
    select @nma = @ntkl
    select @ntkl = ( @nma - @nme )/ 2.0 + @nme
   end
   else
   begin
    select @nme = @ntkl
    select @ntkl = ( @nma - @nme)/ 2.0 + @nme
   end
   if @nut=round(@ntkl,4)
   begin
    select @ftir = round(@nut,2)
    break
   end
   select @ni = @ni + 1
   
  end
 end
 select @dfecpcup = @dfecven ,
  @fmtum  = @fmt  ,
  @fintpcup = 0
--  select @famopcup 
end

GO
