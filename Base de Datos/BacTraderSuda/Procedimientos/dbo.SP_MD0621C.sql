USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0621C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0621C]
    (
    @modcal  INTEGER   ,
    @dfeccal DATETIME  ,
    @ncodigo INTEGER   ,
    @cmascara CHAR (12)  ,
    @nmonemi INTEGER   ,
    @dfecemi DATETIME  ,
    @dfecven DATETIME  ,
    @ftasemi FLOAT   ,
    @fbasemi FLOAT   ,
    @ftasest FLOAT   ,
    @fnominal FLOAT  OUTPUT ,
    @ftir  FLOAT  OUTPUT  ,
    @fpvp  FLOAT  OUTPUT  ,
    @fmt  FLOAT  OUTPUT  ,
    @fmtum  FLOAT  OUTPUT  ,
    @fmt_cien FLOAT  OUTPUT  ,
    @fvan  FLOAT  OUTPUT  ,
    @fvpar  FLOAT  OUTPUT  ,
    @nnumucup INTEGER  OUTPUT  ,
    @dfecucup DATETIME OUTPUT  ,
    @fintucup FLOAT  OUTPUT  ,
    @famoucup FLOAT  OUTPUT  ,
    @fsalucup FLOAT  OUTPUT  ,
    @nnumpcup INTEGER  OUTPUT  ,
    @dfecpcup DATETIME OUTPUT  ,
    @fintpcup FLOAT  OUTPUT  ,
    @famopcup FLOAT  OUTPUT  ,
    @fsalpcup INTEGER  OUTPUT ,
    @fdurat  FLOAT  OUTPUT ,
    @fconvx  FLOAT  OUTPUT ,
    @fdurmo  FLOAT  OUTPUT
    )
AS
BEGIN
 SET NOCOUNT on
        DECLARE @nvalmon NUMERIC (18,10)
        DECLARE @nDecs  NUMERIC (01)
 IF @modcal=1 or @modcal=4
  RETURN
 IF @dfeccal<@dfecemi
  RETURN
 IF @dfeccal>@dfecven
  SELECT @dfeccal = @dfecven
 --** busqueda de valor de moneda a fecha de calculo **--
 IF SUBSTRING( @cmascara,1,3 )='DPX'
 BEGIN
  SELECT @nvalmon = 1
  SELECT @nDecs  = 4
 END
 ELSE
  IF @nmonemi=999 OR @nmonemi=13 BEGIN -- vb+- pichicateo para dolar/dolar
  SELECT @nvalmon = 1
  SELECT @nDecs  = 0
 END
 ELSE
 BEGIN
  SELECT @nvalmon= vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfeccal 
  SELECT @nDecs = 0
 END
 IF @modcal=2
 BEGIN 
  SELECT @fpvp = 0.0
  SELECT @fvpar = 0.0
  SELECT @fvan = 100.0/(1.0+(@ftir/@fbasemi)*(DATEDIFF(DAY,@dfeccal,@dfecven))/100.0)
  SELECT @fmt = @fvan /100*@fnominal
  SELECT @fmtum = ROUND(@fmt,4)
  SELECT @fmt = ROUND(@fmt*@nvalmon, @nDecs)
 END
    
 IF @modcal=3
 BEGIN
  SELECT @fmt = @fmt/@nvalmon
  SELECT @fpvp = 0.0
  SELECT @fvpar = 0.0
  SELECT @ftir = ROUND(((((@fnominal/@fmt)-1.0)*100.0)/(DATEDIFF(DAY,@dfeccal,@dfecven)))*@fbasemi,4)
  SELECT @fvan = (@fmt/@fnominal)*100.0
  SELECT @fmtum = ROUND(@fmt,4)
  SELECT @fmt = ROUND(@fmt*@nvalmon, @nDecs)
 END 
 IF @modcal=5
 BEGIN
  SELECT @fmt  = @fmt/@nvalmon
  SELECT @fpvp  = 0.0
  SELECT @fvpar  = 0.0
  SELECT @fnominal = ROUND(@fmt*(1.0+(@ftir/@fbasemi)*DATEDIFF(DAY,@dfeccal,@dfecven)/100.0),4)
  SELECT @fvan  = (@fmt/@fnominal)*100.0
  SELECT @fmtum  = ROUND(@fmt,4)
  SELECT @fmt  = ROUND(@fmt*@nvalmon, @nDecs)
 END
 IF @nmonemi=999 OR @nmonemi=13
  SELECT @fmtum = @fmt
 SELECT @fdurat = ROUND(DATEDIFF(DAY,@dfeccal,@dfecven)/365.0,8)
 SELECT @fconvx = ROUND(POWER(@fdurat,2)/POWER(1.0+(@ftir/100.0)*@fdurat,2),2)
 SELECT @fdurmo = ROUND(@fdurat/(1.0+(@ftir/100.0)),2)
 IF @dfeccal<@dfecven
  SELECT @nnumucup = 1  ,
   @dfecucup = @dfecven ,
   @dfecpcup = @dfecven ,
   @famoucup = 100.0  ,
   @fintucup = 0.0  ,
   @fsalucup = 0.0
 ELSE
  SELECT @nnumucup = 1  ,
   @dfecucup = @dfecven ,
   @dfecpcup = @dfecven ,
   @famoucup = 100.0  ,
   @fintucup = 0.0  ,
                @fsalucup = 0.0
                  
END

GO
