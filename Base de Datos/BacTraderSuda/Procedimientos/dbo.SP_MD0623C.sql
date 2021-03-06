USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0623C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0623C]
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
    @fpvp  float  OUTPUT  ,
    @fmt  float  OUTPUT  ,
    @fmtum  float  OUTPUT  ,
    @fmt_cien float  OUTPUT  ,
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
 if @modcal<>2
  return
 if @dfeccal<@dfecemi
  return
 if @dfeccal>@dfecven
  select @dfeccal = @dfecven
 if @modcal=2
 begin
  select @fpvp = 0.0
  select @fvpar = 0.0
  select @fvan = (((@ftir/@fbasemi)*datediff(day,@dfeccal,@dfecven))/100.0)+1.0
  select @fmt = @fvan*@fnominal
  select @fmtum = round(@fmt,4)
  select @fmt = @fmtum
 end
    
 select @fdurat = round(datediff(day,@dfeccal,@dfecven)/365.0,8)
 select @fconvx = round(power(@fdurat,2) / power(1.0+(@ftir/100.0)*@fdurat,2), 2)
 select @fdurmo = round(@fdurat / (1.0+(@ftir/100.0)),2)
 if @dfeccal<@dfecven
  select @nnumucup = 1  ,
   @dfecucup = @dfecemi ,
   @dfecpcup = @dfecven ,
   @famoucup = 100.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0
 else
  select @nnumucup = 1  ,
   @dfecucup = @dfecemi ,
   @dfecpcup = @dfecven ,
   @famoucup = 100.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0
end

GO
