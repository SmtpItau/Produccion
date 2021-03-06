USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0301C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MD0301C]
		(
		@modcal		INTEGER		,
		@dFeccal	DATETIME	,
		@nCodigo	INTEGER		,
		@cMascara	CHAR	(12)	,
		@nMonemi	INTEGER		,
		@dFecemi	DATETIME	,
		@dFecven	DATETIME	,
		@fTasemi	FLOAT		,
		@fBasemi	FLOAT		,
		@fTasest	FLOAT		,
		@fNominal	FLOAT	OUTPUT	,
		@fTir		FLOAT	OUTPUT	,
		@fPvp		FLOAT	OUTPUT	,
		@fMT		FLOAT	OUTPUT	,
		@fMTUM		FLOAT	OUTPUT	,
		@fMT_cien	FLOAT	OUTPUT	,
		@fVan		FLOAT	OUTPUT	,
		@fVpar		FLOAT	OUTPUT ,
		@nNumucup	INTEGER	OUTPUT ,
		@dFecucup	DATETIME OUTPUT ,
		@fIntucup	FLOAT  OUTPUT ,
		@fAmoucup	FLOAT  OUTPUT ,
		@fSalucup	FLOAT  OUTPUT ,
		@nNumpcup	INTEGER  OUTPUT ,
		@dFecpcup	DATETIME OUTPUT ,
		@fIntpcup	FLOAT  OUTPUT ,
		@fAmopcup	FLOAT  OUTPUT ,
		@fSalpcup	INTEGER  OUTPUT ,
		@fDurat		FLOAT  OUTPUT ,
		@fConvx		FLOAT  OUTPUT ,
		@fDurmo		FLOAT  OUTPUT
		)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@nTera		NUMERIC (08,04)  ,
		@nCupones	NUMERIC (03,00)  ,
		@nMonemis NUMERIC (03,00)  ,
		@nSaldo  FLOAT   ,
		@nValmon NUMERIC (18,10)  ,
		@nPervcup NUMERIC (03,00)  ,
		@cFecemi CHAR (10)  ,
		@auxMascara CHAR (12)  ,
		@nRango  NUMERIC (05,02)  ,
		@nDecs  INTEGER   ,
		@nTkl  FLOAT   ,
		@nUt  FLOAT   ,
		@nMa  FLOAT   ,
		@nMe  FLOAT   ,
		@jVan  FLOAT   ,
		@nCount  INTEGER   ,
		@nMes  INTEGER   ,
		@nMes_a  INTEGER   ,
		@nAno  INTEGER   ,
		@cAno  CHAR (04)  ,
		@nAst  INTEGER   ,
		@pervcupano INTEGER   ,
		@dFecaux DATETIME,
                @tirpaso NUMERIC(6,4)

		 --** Cambio para Letras con "*" y "&" **--
		SELECT	@nAst		= 0  ,
			@dFecaux	= @dFeccal

		IF CHARINDEX('*',@cMascara)<>0
		BEGIN
			IF SUBSTRING(@cMascara,7,2)='**'
				SELECT	@nAst	= 2
			ELSE
				SELECT	@nAst	= 1

			SELECT	@cMascara=SUBSTRING(@cMascara,1,6)+'01'+SUBSTRING(@cMascara,9,2)
		END

		IF CHARINDEX('&',@cMascara)<>0
 BEGIN
  IF SUBSTRING(@cMascara,7,2)='&&'
   SELECT @nAst = 2
  ELSE
   SELECT @nAst = 1
  SELECT @nMes =CONVERT(INTEGER,SUBSTRING(@cMascara,9,2))
  SELECT @nMes_a =DATEPART(MONTH,@dFeccal)
  IF @nMes>@nMes_a
   SELECT @nAno = DATEPART(YEAR,@dFeccal) - 1
  ELSE
   SELECT @nAno = DATEPART(YEAR,@dFeccal)
  SELECT @cAno  = CONVERT(CHAR(04),@nAno)
  SELECT @cMascara= SUBSTRING(@cMascara,1,6)+SUBSTRING(@cMascara,9,2)+SUBSTRING(@cAno,3,2)
 END
 SELECT @nTera=-1.0
 SET ROWCOUNT 1
 SELECT @nTera  = setera ,
  @nCupones = secupones ,
  @nMonemis = semonemi ,
  @nPervcup = sepervcup ,
  @pervcupano = (12/sepervcup)
 FROM VIEW_SERIE 
 WHERE semascara=SUBSTRING(@cMascara,1,6)
 SET ROWCOUNT 0
 IF @nTera=-1.0
 BEGIN
  SELECT 1, 'La serie ingresada NO ha sido encontrada en tabla de Series'
  RETURN
 END
 --** Cÿlculo de Fechas Emis. y Vcto. **--
-- SELECT @cFecemi = SUBSTRING(@cMascara,7,2)+'/01/'+SUBSTRING(@cMascara,9,2)
 IF CONVERT(NUMERIC(02),SUBSTRING(@cMascara,9,2))<= 50  
  SELECT @cFecemi = '20'+SUBSTRING(@cMascara,9,2)+SUBSTRING(@cMascara,7,2)+'01'
 ELSE
  SELECT @cFecemi = '19'+SUBSTRING(@cMascara,9,2)+SUBSTRING(@cMascara,7,2)+'01'
 SELECT @dFecemi = CONVERT(DATETIME,@cFecemi)
 SELECT @dFecven = DATEADD(MONTH,(@nCupones*@nPervcup),@dFecemi)
 IF @dFeccal<@dFecemi
 BEGIN
  SELECT 1, 'La serie tiene Fecha de emisi½n posterior a Fecha de Calculo'
  RETURN
 END
 IF @dFeccal>@dFecven
 BEGIN
  SELECT 1, 'La serie tiene Fecha de Vcto. Anterior a Fecha de Cÿlculo'
  RETURN
 END
 SELECT @auxMascara = '*'
 SELECT @auxMascara = tdmascara FROM view_Tabla_Desarrollo WHERE tdmascara=SUBSTRING(@cMascara,1,6)
 IF @auxMascara='*'
 BEGIN
  SELECT 1,'Serie No ha sido encontrada en Tabla de Desarrollo'
  RETURN
 END

 IF @nMonemi = 999
	 SELECT @nValmon=1.0
 ELSE
	 SELECT @nValmon=vmvalor FROM view_valor_moneda WHERE  vmcodigo=@nMonemis AND vmfecha=@dFeccal 
	
 IF @dFeccal>=@dFecven
 BEGIN
  SELECT @dFecucup = DATEADD(MONTH,(@nCupones * @nPervcup),@dFecemi)
  SELECT @fAmoucup = -1.0
  SELECT @nSaldo  = 0.0  ,
   @nNumucup = @nCupones ,
   @fIntucup = tdinteres ,
   @fAmoucup = tdamort ,
   @fSalucup = 0.0  ,
   @fMt  = 0.0  ,
   @fMtum     = 0.0  ,
   @fMt_cien = 0.0
  FROM view_Tabla_Desarrollo 
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon=@nCupones
  SELECT @fPvp  = 0.0  ,
   @fVan  = 0.0  ,
   @fVpar  = 0.0  ,
   @nNumucup = @nCupones ,
   @dFecucup = @dFecven ,
   @nNumpcup = @nCupones ,
   @dFecpcup = @dFecven ,
   @fIntpcup = 0.0  ,
   @fAmopcup = 0.0  ,
   @fSalpcup = 0.0
  RETURN
 END
 SELECT 'tdmascara' = tdmascara       ,
  'tdcupon'   = tdcupon       ,
  'tdfecven'  =DATEADD(MONTH,(tdcupon * @nPervcup),@dFecemi)  ,
  'tdinteres' = tdinteres       ,
  'tdamort'   = tdamort       ,
  'tdflujo'   = tdflujo       ,
  'tdsaldo'   = tdsaldo
 INTO #Temp
 FROM VIEW_TABLA_DESARROLLO
 WHERE tdmascara=SUBSTRING(@cMascara,1,6)
 SELECT @fDurat = 0.0 ,
  @fConvx = 0.0 ,
  @fDurmo = 0.0
 IF @modcal=1 OR @modcal=4
 BEGIN
  SELECT @nSaldo  = 100.0  ,
   @dFecucup = @dFecemi ,
   @nNumucup = 0  ,
   @fAmoucup = 0.0  ,
   @fIntucup = 0.0  ,
   @fSalucup = 0.0
  --** Pr½ximo Cup½n **--
  SET ROWCOUNT 1
  SELECT @auxMascara = tdmascara ,
   @nNumpcup = tdcupon ,
   @dFecpcup = tdfecven ,
   @fIntpcup = tdinteres ,
   @fAmopcup = tdamort ,
   @fSalpcup = tdsaldo
  FROM #Temp
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdfecven>@dFeccal
  SET ROWCOUNT 0
  --** Cup½n Anterior **--
  SELECT @nNumucup = 0   ,
   @dFecucup = @dFecemi  ,
   @fIntucup = 0.0   ,
   @fAmoucup = 0.0   ,
   @nSaldo   = CONVERT(FLOAT,100)
  SET ROWCOUNT 1
  SELECT  @auxMascara = tdmascara ,
   @nNumucup = tdcupon ,
   @dFecucup = tdfecven ,
   @fIntucup = tdinteres ,
   @fAmoucup = tdamort ,
   @nSaldo  = tdsaldo
  FROM #Temp
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdfecven<@dFecpcup
  ORDER BY tdcupon DESC
  SET ROWCOUNT 0
  IF @nAst>0
  BEGIN
   SELECT @nNumucup = @nNumucup + @nAst
   SELECT @auxMascara = tdmascara ,
    @nNumucup = tdcupon ,
    @dFecucup = tdfecven ,
    @fIntucup = tdinteres ,
    @fAmoucup = tdamort ,
    @nSaldo  = tdsaldo
   FROM #Temp
   WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon=@nNumucup
  END
		SELECT @fSalucup=@nSaldo

		--** Valor Par **--
		IF DATEPART(DAY,@dFeccal)=31
			SELECT @dFeccal = DATEADD(DAY,-1,@dFeccal)

		IF @nAst=0
			--SELECT @fVpar = ROUND(@nSaldo * POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((DATEPART(YEAR,@dFecucup)-DATEPART(YEAR,@dFeccal))*CONVERT(FLOAT,360))+((DATEPART(MONTH,@dFeccal)-DATEPART(MONTH,@dfecucup))*CONVERT(FLOAT,30))+(DATEPART(DAY,@dFeccal)-DATEPART(DAY,@dFecucup)))/CONVERT(FLOAT,360)),8)
                        SELECT @fVpar = ROUND(@nSaldo * POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((DATEPART(YEAR,@dFeccal)-DATEPART(YEAR,@dFecucup))*CONVERT(FLOAT,360))+((DATEPART(MONTH,@dFeccal)-DATEPART(MONTH,@dfecucup))*CONVERT(FLOAT,30))+(DATEPART(DAY,@dFeccal)-DATEPART(DAY,@dFecucup)))/CONVERT(FLOAT,360)),8)
		ELSE
			SELECT @fVpar = SUM(tdflujo/POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))
			FROM #Temp
			WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup

		--** Base Cien **--
		SELECT @fMt_cien = ROUND((@fPvp/CONVERT(FLOAT,100))*(@fVpar/CONVERT(FLOAT,100))*CONVERT(FLOAT,100),4)

		--** Tir **--
  SELECT @fTir = 0.0   ,
   @nRango = 50.00   ,
   @nDecs = 4   , 
   @nTkl = @nTera
  SELECT @nUt = @nTkl   ,
   @nMa = @nRango *  1.0  ,
   @nMe = @nRango * -1.0  ,
   @nCount = 1

  WHILE @nCount<=50
  BEGIN
   IF (CONVERT(FLOAT,1)+@nTkl/CONVERT(FLOAT,100))=0.0
    SELECT @jVan = 0.0
   ELSE
    SELECT @jVan = SUM(tdflujo/POWER((CONVERT(FLOAT,1)+@nTkl/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))
    FROM #Temp
    WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon > @nNumucup 
   SELECT @nUt=ROUND(@nTkl, @nDecs)
   IF @jVan<@fMt_cien
    SELECT @nMa = @nTkl
   ELSE
    SELECT @nMe = @nTkl
   SELECT @nTkl=(@nMa - @nMe) / CONVERT(FLOAT,2) + @nMe
   IF @nUt=ROUND(@nTkl,@nDecs)
   BEGIN
    SELECT @nCount = 51
    IF ABS(ROUND(@nUt,0))=@nRango
     SELECT @fTir = 0.0
    ELSE
     SELECT @fTir = ROUND(@nUt,2)
   END
   SELECT @nCount = @nCount + 1
  END
		IF @nCount<>52
			SELECT @fTir = 0

		--** Van **--
		IF (CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100))=0.0
			SELECT	@jVan	= 0.0	,
				@fDurat	= 0.0	,
				@fConvx	= 0.0
			ELSE
				SELECT	@jVan	= SUM(tdflujo/POWER((CONVERT(FLOAT,1)+@nTkl/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))                          ,
					@fDurat	= SUM(tdflujo*((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360))),
					@fConvx = SUM((tdflujo*((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360))*(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)+CONVERT(FLOAT,1))/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)))
				FROM	#Temp
				WHERE	tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup

		SELECT	@fVan = @jVan
		--** Duration y Convexidad **--

		SELECT	@fDurat	= ROUND(@fDurat/@fVan,8)         ,
			@fConvx	= ROUND((@fConvx/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),CONVERT(FLOAT,2)))/@fVan,8)

		SELECT	@fDurmo = ROUND(@fDurat/ ( CONVERT(FLOAT,1) + ((@fTir/CONVERT(FLOAT,100))/@pervcupano)),8)

		IF @modcal=1
			SELECT	@fMt	= ROUND(@fMt_cien /CONVERT(FLOAT,100)*@fNominal,4)
		ELSE
			SELECT	@fNominal = ROUND((CONVERT(FLOAT,10000)*@fMt)/(@fPvp*@fVpar), 4)

		SELECT	@fMtum	= @fMt
		SELECT	@fMt	= ROUND(@fMt * @nValmon, 0)

	END

	IF @modcal=2 OR @modcal=5
	BEGIN
		SELECT	@nSaldo		= 100.0		,
			@dFecucup	= @dFecemi	,
			@nNumucup	= 0		,
			@fAmoucup	= 0.0		,
			@fIntucup	= 0.0		,
			@fSalucup	= 0.0		,
			@fVan		= 0.0

		--** Pr½ximo Cup½n **--
		SET ROWCOUNT 1
  SELECT  @auxMascara = tdmascara ,
   @nNumpcup = tdcupon ,
   @dFecpcup = tdfecven ,
   @fIntpcup = tdinteres ,
   @fAmopcup = tdamort ,
   @fSalpcup = tdsaldo
  FROM #Temp
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdfecven>@dFeccal
  SET ROWCOUNT 0
  --** Cup½n Anterior **--
  SELECT @nNumucup = 0   ,
   @dFecucup = @dFecemi  ,
   @fIntucup = 0.0   ,
   @fAmoucup = 0.0   ,
   @nSaldo   = CONVERT(FLOAT,100)
  SET ROWCOUNT 1
  SELECT @auxMascara = tdmascara ,
   @nNumucup = tdcupon ,
   @dFecucup = tdfecven ,
   @fIntucup = tdinteres ,
   @fAmoucup = tdamort ,
   @nSaldo  = tdsaldo
  FROM #Temp
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdfecven<@dFecpcup
  ORDER BY tdcupon DESC
  SET ROWCOUNT 0
  IF @nAst>0
  BEGIN
   SELECT @nNumucup = @nNumucup + @nAst
   SELECT @auxMascara = tdmascara ,
    @nNumucup = tdcupon ,
    @dFecucup = tdfecven ,
    @fIntucup = tdinteres ,
    @fAmoucup = tdamort ,
    @nSaldo = tdsaldo
     FROM #Temp
     WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon=@nNumucup
  END

		SELECT	@fSalucup = @nSaldo

		--** Van **--  
		IF DATEPART(DAY,@dFeccal)=31
			SELECT @dFeccal = DATEADD(DAY,-1,@dFeccal)
  
		SELECT	@fVan	= SUM(tdflujo/POWER((CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360))),
			@fDurat	= SUM(tdflujo*((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360))),
			@fConvx = SUM((tdflujo*((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360))*(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)+CONVERT(FLOAT,1))/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)))
		FROM	#Temp
		WHERE	tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup

		--** Duration y Convexidad **--
	  	SELECT	@fDurat = ROUND(@fDurat/@fVan,8)         ,
			@fConvx = ROUND((@fConvx/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),CONVERT(FLOAT,2)))/@fVan,8)

		--** SELECT @fDurmo = ROUND(@fDurat/(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100)),8)
		SELECT @fDurmo = ROUND(@fDurat/ ( CONVERT(FLOAT,1) + ((@fTir/CONVERT(FLOAT,100))/@pervcupano)),8)

		--** Valor Par **--
		IF @nAst=0
			--SELECT	@fVpar = ROUND(@nSaldo * POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((DATEPART(YEAR,@dFeccal)-DATEPART(YEAR,@dFecucup))*CONVERT(FLOAT,360))+((DATEPART(MONTH,@dFeccal)-DATEPART(MONTH,@dfecucup))*CONVERT(FLOAT,30))+(DATEPART(DAY,@dFeccal)-DATEPART(DAY,@dFecucup)))/CONVERT(FLOAT,360)),8)
                           SELECT	@fVpar = ROUND(@nSaldo * POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((DATEPART(YEAR,@dFeccal)-DATEPART(YEAR,@dFecucup))*CONVERT(FLOAT,360))+((DATEPART(MONTH,@dFeccal)-DATEPART(MONTH,@dfecucup))*CONVERT(FLOAT,30))+(DATEPART(DAY,@dFeccal)-DATEPART(DAY,@dFecucup)))/CONVERT(FLOAT,360)),8)

		ELSE
			SELECT	@fVpar = SUM( tdflujo/POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))
			FROM	#Temp
			WHERE	tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup 

		  --** % Valor Par **--
		SELECT	@fPvp = ROUND((@fVan / @fVpar) * CONVERT(FLOAT,100), 2)

		IF @modcal=2
			SELECT @fMt = ROUND((@fPvp/CONVERT(FLOAT,100)) * (@fVpar/CONVERT(FLOAT,100)) * @fNominal, 4)
		ELSE
			SELECT @fNominal = ROUND( (CONVERT(FLOAT,10000) * @fMt) / (@fPvp * @fVpar), 4)

		SELECT	@fMt_cien = ROUND((@fPvp / 100.0) * (@fVpar/CONVERT(FLOAT,100)) * CONVERT(FLOAT,100),4)
		SELECT	@fMtum    = @fMt
		SELECT	@fMt      = ROUND(@fMt * @nValmon, 0)
	END

	IF @modcal=3
	BEGIN
		--** Pr½ximo Cup½n **--
		SET ROWCOUNT 1
		SELECT	@auxMascara  = tdmascara ,
                        @nNumpcup    = tdcupon ,
                        @dFecpcup    = tdfecven ,
                        @fIntpcup    = tdinteres ,
                        @fAmopcup    = tdamort ,
                        @fSalpcup    = tdsaldo
                FROM #Temp
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdfecven>@dFeccal
  SET ROWCOUNT 0
  --** Cup½n Anterior **--
  SELECT @nNumucup = 0  ,
   @dFecucup  = @dFecemi ,
   @fIntucup = 0.0  ,
   @fAmoucup = 0.0  ,
   @nSaldo   = CONVERT(FLOAT,100)
  SET ROWCOUNT 1
  SELECT @auxMascara = tdmascara ,
   @nNumucup = tdcupon ,
   @dFecucup = tdfecven ,
   @fIntucup = tdinteres ,
   @fAmoucup = tdamort ,
   @nSaldo  = tdsaldo
  FROM #Temp
  WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdfecven<@dFecpcup
  ORDER BY tdcupon DESC
  SET ROWCOUNT 0
  IF @nAst>0
  BEGIN
   SELECT @nNumucup = @nNumucup + @nAst
   SELECT @auxMascara = tdmascara ,
    @nNumucup = tdcupon ,
    @dFecucup = tdfecven ,
    @fIntucup = tdinteres ,
    @fAmoucup = tdamort ,
    @nSaldo = tdsaldo
   FROM #Temp
   WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon=@nNumucup
  END
  SELECT @fSalucup = @nSaldo
  SELECT @fMtum = ROUND(@fMt / @nValmon, 4) 
  --** Base Cien **--
  SELECT @fMt_cien = ( @fMtum / @fNominal) * CONVERT(FLOAT,100)
  --** Tir **--
  SELECT @fTir = 0.0   ,
   @nRango = 50.00   ,
   @nDecs = 6 ,--4  ,  will
   @nTkl = @nTera
  SELECT @nUt = ROUND(@nTkl,4) ,
   @nMa = @nRango *  1.0  ,
   @nMe = @nRango * -1.0  ,
   @nCount = 1
		IF DATEPART(DAY,@dFeccal)=31
			SELECT @dFeccal = DATEADD(DAY,-1,@dFeccal)

		--** Valor Par **--
		IF @nAst=0
--			SELECT	@fVpar = ROUND(@nSaldo * POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((DATEPART(YEAR,@dFeccal)-DATEPART(YEAR,@dFecucup))*CONVERT(FLOAT,360))+((DATEPART(MONTH,@dFeccal)-DATEPART(MONTH,@dfecucup))*CONVERT(FLOAT,30))+(DATEPART(DAY,@dFeccal)-DATEPART(DAY,@dFecucup)))/CONVERT(FLOAT,360)),8)
                        SELECT	@fVpar = ROUND(@nSaldo * POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((DATEPART(YEAR,@dFeccal)-DATEPART(YEAR,@dFecucup))*CONVERT(FLOAT,360))+((DATEPART(MONTH,@dFeccal)-DATEPART(MONTH,@dfecucup))*CONVERT(FLOAT,30))+(DATEPART(DAY,@dFeccal)-DATEPART(DAY,@dFecucup)))/CONVERT(FLOAT,360)),8)
		ELSE
			SELECT	@fVpar = SUM( tdflujo/POWER((CONVERT(FLOAT,1)+@nTera/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))
			FROM	#Temp
			WHERE	tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup

		--** % Valor Par **--
		SELECT	@fPvp = ROUND(@fMt/((@fVpar/CONVERT(FLOAT,100)*@fNominal)*@nValmon)*CONVERT(FLOAT,100),2)

		WHILE @nCount<=50
		BEGIN
			IF (CONVERT(FLOAT,1)+@nTkl/CONVERT(FLOAT,100))=0.0
				SELECT	@jVan	= 0.0
			ELSE
				SELECT	@jVan	= SUM(tdflujo/POWER((CONVERT(FLOAT,1)+@nTkl/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))
				FROM	#Temp
				WHERE	tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup 

			SELECT	@nUt = ROUND(@nTkl, @nDecs)
			--SELECT	@tirpaso = ROUND(@nTkl, @nDecs)
			IF @jVan < @fMt_cien
				SELECT	@nMa = @nTkl
			ELSE
				SELECT	@nMe = @nTkl

			SELECT	@nTkl	= (@nMa - @nMe) / CONVERT(FLOAT,2) + @nMe

			IF @nUt=ROUND(@nTkl,@nDecs)
			BEGIN
				SELECT	@nCount	= 51
				IF ABS(ROUND(@nUt,0))=@nRango
					SELECT	@fTir	= 0.0
				ELSE
                                    begin 
                                    --   print @nUt    -- will
					SELECT	@fTir	   = ROUND(@nUt,4) -- VB+- 17/05/2000 se ajusto decimales de 2 a 4 MASCAREÑO 29-072002
                                        SELECT	@Tirpaso   = ROUND(@ftir,4)
                                        SELECT	@fTir      = ROUND(@tirpaso,2)

                                    end
			END

			SELECT	@nCount = @nCount + 1
		END

		IF @nCount<>52
			SELECT	@fTir	= 0

		--** Van **--
		IF (CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100))=0.0
			SELECT	@jVan	= 0.0	,
				@fDurat	= 0.0	,
				@fConvx	= 0.0
		ELSE
			SELECT	@jVan	= SUM(tdflujo/POWER((CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100)),(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+CONVERT(FLOAT,1))/CONVERT(FLOAT,360)))                          ,
				@fDurat	= SUM(tdflujo*((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360))),
				@fConvx	= SUM((tdflujo*((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360))*(((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)+CONVERT(FLOAT,1))/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),((CONVERT(FLOAT,30)*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))/CONVERT(FLOAT,360)))
			FROM	#Temp
			WHERE	tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup 

		SELECT	@fVan	= @jVan

		--** Duration y Convexidad **--
		SELECT	@fDurat	= ROUND(@fDurat/@fVan,8),
			@fConvx	= ROUND((@fConvx/POWER(CONVERT(FLOAT,1)+@fTir/CONVERT(FLOAT,100),CONVERT(FLOAT,2)))/@fVan,8)

		SELECT	@fDurmo	= ROUND(@fDurat/( CONVERT(FLOAT,1)+((@fTir/CONVERT(FLOAT,100))/@pervcupano)),8)
	END

	IF @nMonemi = 999
		SELECT @fMtum = ROUND(@fMtum, 0)

	SET NOCOUNT OFF
END

GO
