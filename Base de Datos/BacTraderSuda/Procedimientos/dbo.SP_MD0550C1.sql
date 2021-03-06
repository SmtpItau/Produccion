USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0550C1]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MD0550C1]
   (@modcal     INTEGER          ,
    @dfeccal    DATETIME         ,
    @ncodigo    INTEGER          ,
    @cmascara   CHAR(12)         ,     
    @nmonemi    INTEGER          ,
    @dfecemi    DATETIME         ,
    @dfecven    DATETIME         ,
    @ftasemi    FLOAT            ,
    @fbasemi    FLOAT            ,
    @ftasest    FLOAT            ,
    @fnominal   FLOAT    OUTPUT  ,
    @ftir       FLOAT    OUTPUT  ,
    @fpvp       FLOAT    OUTPUT  ,
    @fmt        FLOAT    OUTPUT  ,
    @fmtum      FLOAT    OUTPUT  ,
    @fmt_cien   FLOAT    OUTPUT  ,
    @fvan       FLOAT    OUTPUT  ,
    @fvpar      FLOAT    OUTPUT  ,
    @nnumucup   INTEGER  OUTPUT  ,
    @dfecucup   DATETIME OUTPUT  ,
    @fintucup   FLOAT    OUTPUT  ,
    @famoucup   FLOAT    OUTPUT  ,
    @fsalucup   FLOAT    OUTPUT  ,
    @nnumpcup   INTEGER  OUTPUT  ,
    @dfecpcup   DATETIME OUTPUT  ,
    @fintpcup   FLOAT    OUTPUT  ,
    @famopcup   FLOAT    OUTPUT  ,
    @fsalpcup   INTEGER  OUTPUT  ,
    @fdurat     FLOAT    OUTPUT  ,
    @fconvx     FLOAT    OUTPUT  ,
    @fdurmo     FLOAT    OUTPUT  )
AS
BEGIN


 DECLARE @imesemi INTEGER  ,
         @ianoemi INTEGER  ,
         @idiaman INTEGER  ,
         @ianovto INTEGER  ,
         @imesman INTEGER  ,
         @cmesvto CHAR (02),
         @iextrae INTEGER  ,
         @cfecemi CHAR (10),
         @cfecven CHAR (10),
         @cfecman CHAR (10),
         @fipcemi FLOAT    ,
         @fipccal FLOAT    ,
         @dfecman DATETIME ,
         @nm1     INTEGER  ,
         @nm2     INTEGER  ,
         @nfactor INTEGER  ,
         @ndifmes INTEGER  ,
         @fvpar2  FLOAT    ,
         @fvan2   FLOAT    ,
         @fpvp2   FLOAT    ,
         @ni      INTEGER  ,
         @nut     FLOAT    ,
         @nma     FLOAT    ,
         @nme     FLOAT    ,
         @ntkl    FLOAT    ,
         @fdias   FLOAT    ,
         @cMesemi CHAR (02)

 SELECT @imesemi = 0   ,
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
        @nm1     = 0   ,
        @nm2     = 0   ,
        @nfactor = 0   ,
        @ndifmes = 0   ,
        @fvpar2  = 0.0   ,
        @fvan2   = 0.0   ,
        @fpvp2   = 0.0   ,
        @ni      = 1   ,
        @nut     = CONVERT(FLOAT,6.5) ,
        @nma     = CONVERT(FLOAT,50) ,
        @nme     = 0.0   ,
        @ntkl    = CONVERT(FLOAT,6.5)

        SELECT @fdurat = 0.0 ,
               @fconvx = 0.0 ,
               @fdurmo = 0.0    

-- select ASCII('9')
 SELECT @iextrae = ASCII(SUBSTRING(@cmascara,3,1))
 SELECT @imesemi = CASE WHEN @iExtrae = 48                   THEN CONVERT(INT,CHAR(@iExtrae))+10
                        WHEN @iextrae > 48 AND @iextrae < 58 THEN CONVERT(INT,CHAR(@iextrae))
                        ELSE                                      CONVERT(INT,@iextrae)-54
                  END

 IF @imesemi > 12
 BEGIN
   SELECT 1, 'SERIE MAL INGRESADA'
   return
 END

 SELECT @iextrae = ASCII(SUBSTRING(@cmascara,4,1))
 SELECT @ianoemi = 1980 + CASE  WHEN @iExtrae = 48                   THEN CONVERT(INT,CHAR(@iExtrae))+10
                                WHEN @iextrae > 48 AND @iextrae < 58 THEN CONVERT(int,CHAR(@iextrae))
                                ELSE                                      CONVERT(int,@iextrae)-54
                          END


 SELECT @ianovto = CONVERT(int,SUBSTRING(@cmascara,9,2))

   IF @ianovto>=0 AND @ianovto<95
      SELECT @ianovto = 2000 + @ianovto
   ELSE
      SELECT @ianovto = 1900 + @ianovto
      SELECT @imesman = DATEPART(DAY,@dfeccal)*-1

   IF @imesemi<10
      SELECT @cMesemi = '0'+CONVERT(CHAR(02),@imesemi)
   ELSE
      SELECT @cMesemi = CONVERT(CHAR(02),@imesemi)

 SELECT @cfecven = CONVERT(CHAR(04),@ianovto)+SUBSTRING(@cmascara,7,2)+SUBSTRING(@cmascara,5,2)
 SELECT @cfecemi = CONVERT(CHAR(04),@ianoemi)+@cMesemi+'01'

 SELECT @cfecman = CONVERT(CHAR(08),DATEADD(DAY,@imesman,@dfeccal),112)
 SELECT @dfecman = CONVERT(DATETIME,SUBSTRING(@cfecman,1,4)+SUBSTRING(@cfecman,5,2)+'01')

 SELECT @dfecemi = CONVERT(DATETIME,@cfecemi)
 SELECT @dfecven = CONVERT(DATETIME,@cfecven)

 SELECT @fipcemi = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dfecemi
 SELECT @fipccal = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dfecman

 SELECT @fipcemi 
 SELECT @fipccal 
--    SELECT @fipccal = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha= '200912
 IF @fipccal=0
    SELECT @fipccal = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha= dateadd(month ,-1,@dfecman)

 IF @fipccal = 0.0
   SELECT @fipccal = vmvalor FROM VIEW_VALOR_MONEDA , bactradersuda..MDAC WHERE vmcodigo=502 AND vmfecha = dateadd(month ,-1,convert(char(6),(year(acfecproc) *100) + month(acfecproc)) + '01')

 SELECT @nm1 = DATEPART(MONTH,@dfecemi)+1
 SELECT @nm2 = DATEPART(MONTH,@dfeccal)

 IF @nm1>12
    SELECT @nfactor = -1   ,
           @nm1  = @nm1 - 12

 IF @nm2>@nm1
    SELECT @ndifmes = @nm2 - @nm1
 ELSE
    SELECT @ndifmes = (@nm2 + 12) - @nm1,
           @nfactor = -1




 SELECT @fvpar = ROUND(100.0*(@fipccal/@fipcemi)*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfeccal)+@nfactor)*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)
-- SELECT @fvpar = ROUND(100.0*(@fipccal/@fipcemi)*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfeccal))*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)
--      ValorPar = Round(100 * (IPC_tf / IPC_ti) * Round((1 + (4 / 100)) ^ (Años_a_Fecha), 8) * Round((1 + (4 / 100) * (Meses_a_Fecha / 12)), 8), 8)
   SELECT @fvpar2 = ROUND(100.0*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfeccal)+@nfactor)*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)
  
-- SELECT @fvpar2 = ROUND(100.0*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfeccal))*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)


 SELECT '@fipccal'= @fipccal,
	'@fipcemi'= @fipcemi,
	'fecemi'=@dfecemi,
	'DATEDIFF(YEAR,@dfecemi,@dfeccal)'=DATEDIFF(YEAR,@dfecemi,@dfeccal),
	'POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfeccal)'=POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfeccal)),
	'@nfactor'=@nfactor,
	'@ndifmes'=@ndifmes,
	(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),
	DATEDIFF(YEAR,@dfecemi,@dfeccal),
	'fvpar '=@fvpar,
	'fvpar2'=@fvpar2

 SELECT @nm1  = DATEPART(MONTH,@dfecemi)+1 ,
        @nm2  = DATEPART(MONTH,@dfecven) ,
        @nfactor = 0

 IF @nm1 > 12
 BEGIN
      SELECT @nfactor = -1   ,
             @nm1     = @nm1 - 12
 END

 IF @nm2>=@nm1 --or (@nm2>=@nm1 and DATEPART(MONTH,@dfecemi) = 12)
    SELECT @ndifmes = @nm2 - @nm1
 ELSE
 BEGIN
    SELECT @ndifmes = (@nm2 + 12) - @nm1 ,
           @nfactor = -1
 END


select 'DIFMES' = @ndifmes
 IF @modcal=1 or @modcal=4
 BEGIN
   SELECT @fmt = ROUND((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
   WHILE @ni<=50
   BEGIN
      SELECT @fvan   = 100.0*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfecven)+@nfactor)*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes)
      SELECT @fvan2  = @fvan
      SELECT @fvan   = @fvan/(POWER(CONVERT(FLOAT,1)+@ntkl/CONVERT(FLOAT,100),DATEDIFF(DAY,@dfeccal,@dfecven)/CONVERT(FLOAT,365)))
      SELECT @fpvp   = ROUND((@fvan/@fvpar2)*100.0,2)
      SELECT @fvan   = ROUND((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
      SELECT @nut    = ROUND(@ntkl,4)

      IF @fvan<@fmt
      BEGIN
         SELECT @nma = @ntkl
         SELECT @ntkl = ( @nma - @nme )/ 2.0 + @nme
      END ELSE
      BEGIN
         SELECT @nme = @ntkl
         SELECT @ntkl = ( @nma - @nme)/ 2.0 + @nme
      END
      IF @nut=ROUND(@ntkl,4)
      BEGIN
         SELECT @ftir = ROUND(@nut,2)
         BREAK
      END
      SELECT @ni = @ni + 1
   END
 END

 IF @modcal=2 or @modcal=5
 BEGIN
  
  SELECT @fvan2   = ROUND(100.0*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfecven)+@nfactor)*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)
  SELECT @fvan    = @fvan2/(POWER(CONVERT(FLOAT,1)+@ftir/CONVERT(FLOAT,100),(DATEDIFF(DAY,@dfeccal,@dfecven)/CONVERT(FLOAT,365.0))))
  SELECT @fpvp    = ROUND((@fvan/@fvpar2)*100.0,2)
  SELECT @fpvp2   = ROUND((@fvan2/@fvpar)*100.0,2)
  SELECT @fmt     = ROUND((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
  SELECT @nm2     = DATEPART(MONTH,@dfecven)
  SELECT @nfactor = 0
select 'fvpar'=@fvpar, 'fvpar2'=@fvpar2, 'fvan2'=@fvan2,'FVAN'=@fvan,'FMT'= @fmt, (POWER(CONVERT(FLOAT,1)+@ftir/CONVERT(FLOAT,100),(DATEDIFF(DAY,@dfeccal,@dfecven)/CONVERT(FLOAT,365.0))))
  IF @nm1>12
  BEGIN
     SELECT @nfactor = -1   ,
            @nm1  = @nm1 - 12
  END

  IF @nm2>@nm1
     SELECT @ndifmes = @nm2 - @nm1
  ELSE BEGIN
     SELECT @ndifmes = (@nm2 + 12) - @nm1 ,
            @nfactor  = -1
  END

--  SELECT @fvpar    = ROUND(100.0*(@fipccal/@fipcemi)*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfecven)+@nfactor)*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)
  SELECT @fvpar    = ROUND(100.0*(@fipccal/@fipcemi)*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfecven))*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes),8)
  SELECT @famopcup = ROUND((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
 END
 
 IF @modcal=3
 BEGIN
    SELECT @fpvp = (@fmt/(@fvpar/100.0*@fnominal))*100.0
    WHILE @ni<=50
    BEGIN
       SELECT @fvan   = 100.0*POWER(CONVERT(FLOAT,1.04),DATEDIFF(YEAR,@dfecemi,@dfecven)+@nfactor)*(1.0+(CONVERT(FLOAT,0.04)/12.0)*@ndifmes)
       SELECT  @fvan2 = @fvan
       SELECT @fvan   = @fvan/(POWER(CONVERT(FLOAT,1)+@ntkl/CONVERT(FLOAT,100),DATEDIFF(DAY,@dfeccal,@dfecven)/CONVERT(FLOAT,365)))
       SELECT @fpvp   = ROUND((@fvan/@fvpar2)*100.0,2)
       SELECT @fvan   = ROUND((@fpvp/100.0)*@fnominal*(@fvpar/100.0),0)
       SELECT @nut    = ROUND(@ntkl,4)

       IF @fvan<@fmt
       BEGIN
          SELECT @nma = @ntkl
          SELECT @ntkl = ( @nma - @nme )/ 2.0 + @nme
       END ELSE
       BEGIN
          SELECT @nme = @ntkl
          SELECT @ntkl = ( @nma - @nme)/ 2.0 + @nme
      END

      IF @nut=ROUND(@ntkl,4)
      BEGIN
         SELECT @ftir = ROUND(@nut,2)
         BREAK
      END
      SELECT @ni = @ni + 1
    END
 END

select  @fvpar
 SELECT @dfecpcup = @dfecven 
   ,    @fmtum    = @fmt  
   ,    @fintpcup = 0
 
 SELECT @fdias    = CONVERT(FLOAT, DATEDIFF(DAY,@dfeccal,@dfecven))
 SELECT @fdurat   = @fdias / 365.0

 SELECT @fconvx   = @fvan2 * (@fdias / 365.0) * ((@fdias / 365.0) + 1.0) 
 SELECT @fconvx   = POWER( @fconvx / (1.0 + @ftir / 100.0) , (@fdias / 365.0) )
 SELECT @fconvx   = POWER( @fconvx / (1.0 + @ftir / 100.0) , 2.0 )
 SELECT @fconvx   = ROUND(@fconvx / @fvan, 2) 

 SELECT @fdurmo   = @fdurat / (1.0 + @ftir / 100.0)

 SELECT @fconvx   = (@fdias / 365.0) 
                  * ( (@fdias / 365.0) + 1.0 ) 
                  / POWER( (1.0 + @ftir/100.0) , 2 )

 SELECT @fmt_cien = ( @fmtum / @fnominal)*100.0



END


GO
