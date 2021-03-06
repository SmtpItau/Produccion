USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0622C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MD0622C]
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
    @ftir  float  OUTPUT ,
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
    @fsalpcup integer  OUTPUT  ,
    @fdurat  float  OUTPUT ,
    @fconvx  float  OUTPUT ,
    @fdurmo  float  OUTPUT
    )
as
begin
 declare @nvalmon numeric (18,10)
 select @fpvp  = 0.0 ,
  @fmt_cien = 0.0
 if @modcal=1 or @modcal=4
  return
 if @dfeccal<@dfecemi
  return
 if @dfeccal>@dfecven
  select @dfeccal = @dfecven
 select @nvalmon = 0.0
 select @nvalmon = vmvalor from VIEW_VALOR_MONEDA where vmcodigo=@nmonemi and vmfecha=@dfeccal
 
 if @modcal=2
 begin
  select @fpvp = 0.0 ,
   @fvpar = 0.0
  select @fvan = power((1.0+(@ftir/100.0)),(datediff(day,@dfeccal,@dfecven)/@fbasemi))
  select @fmt = @fnominal/@fvan
  select @fmtum = round(@fmt,4)
  select @fmt = round(@fmtum*@nvalmon,0)
 end
 if @modcal=3
 begin
  select @fmt = @fmt/@nvalmon ,
   @fpvp = 0.0  ,
   @fvpar = 0.0
  select @ftir = round((power((@fnominal/@fmt),(@fbasemi/datediff(day,@dfeccal,@dfecven)))-1.0)*100.0,2)
  select @fvan = (@fmt/@fnominal)*100.0
  select @fmtum = @fmt
  select @fmt = round(@fmt*@nvalmon,0)
 end
 select @fdurat = round(datediff(day,@dfeccal,@dfecven)/365.0,8)
 select @fdurmo = round(@fdurat / (1.0+(@ftir/100.0)),2)
 select @fconvx = round(power(@fdurat,2) / power(1.0+(@ftir/100.0)*@fdurat,2), 2)
 if @dfeccal<@dfecven
  select @nnumucup = 0.0  ,
   @dfecucup = @dfecemi ,
   @famoucup = 0.0  ,
   @fintucup = 0.0  ,
   @nnumucup = 1  ,
   @dfecucup = @dfecven ,
   @dfecpcup = @dfecven ,
   @famoucup = 100.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0
 else
  select @nnumucup = 1  ,
   @dfecucup = @dfecven ,
   @dfecpcup = @dfecven ,
   @famoucup = 100.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0
 return
end
/*
-- select convert( char(100), (15000/power((1.0+(6.25/100.0)),(datediff(day,"20000706","20010101")/365))))
-- select * from MDIN
-- sp_valorizar_client 2,'05/11/2000',16,'zero010102', 998,'05/11/2000','01/01/2002', 0.0, 365.0, 0.0, 10000.0, 7.0, 0.0, 0.0
-- sp_valorizar_client 2,'05/11/2000',16,'cero010102', 998,'05/11/2000','01/01/2002', 0.0, 365.0, 0.0, 10000.0, 7.0, 0.0, 0.0
-- sp_valorizar_client 3,'05/11/2000',300,'cero010102', 998,'05/11/2000','01/01/2002', 0.0, 365.0, 0.0, 10000.0, 0.0, 0.0, 137376116.0
-- sp_valorizar_client 2,'07/06/2000',300,'cero010101',998,'07/06/2000','01/01/2001',   0, 360  ,   0,     15000,   7,   0, 0
update MDIN set inbasemi = 365 where incodigo = 301
select * from MD_SETTLEMENT
 
*/


GO
