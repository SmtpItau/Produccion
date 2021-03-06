USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_INIDIA_RECALCULA_LIMITE_SECURITIE_TRADING]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_INIDIA_RECALCULA_LIMITE_SECURITIE_TRADING]

AS BEGIN


/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

	DECLARE @DO_HOY FLOAT
	DECLARE @FECPROC DATETIME
	SELECT @FECPROC = ACFECPROC FROM MDAC

SET NOCOUNT ON

	SET @DO_HOY = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE VMFECHA = (SELECT ACFECPROC FROM MDAC) AND VMCODIGO = 994 )

	SELECT 	PLAZO	= DATEDIFF(DAY,@FECPROC,CAFECVCTO) ,
		MONTO	= CAVPRESEN / @DO_HOY 		  ,
		GRUPO	= ( select Codigo_Grupo from view_GRUPO_TRADING_SWAP WHERE Codigo_Limite = 3 and DATEDIFF(DAY,@FECPROC,CAFECVCTO) BETWEEN Tramo_Desde AND Tramo_Hasta )
	INTO #PASO
	FROM IBL_MDCA
	WHERE CACARTERA IN(111,114) AND CATIPOPER IN('CP','VI') AND CAINDPAC <> 'S'
	ORDER BY PLAZO

	INSERT INTO #PASO
	SELECT 	PLAZO	= DATEDIFF(DAY,@FECPROC,CAFECVCTO) ,
		MONTO	= CAVPRESEN / @DO_HOY 		    ,
		GRUPO	= ( select Codigo_Grupo from view_GRUPO_TRADING_SWAP WHERE Codigo_Limite = 3 and DATEDIFF(DAY,@FECPROC,CAFECVCTO) BETWEEN Tramo_Desde AND Tramo_Hasta )
	FROM BISA_MDCA
	WHERE CACARTERA IN(111,114) AND CATIPOPER IN('CP','VI') AND CAINDPAC <> 'S'
	ORDER BY PLAZO

	INSERT INTO #PASO
	SELECT 	PLAZO	= DATEDIFF(DAY,@FECPROC,cpfecven),
		
		MONTO	=   CASE WHEN cpcodigo=35 or cpcodigo=36 or  cpcodigo=37  THEN -- CBG 09/09/2004
			       CASE WHEN cpvcum100 = 0 OR cpfeccomp = @FECPROC THEN (cpvptirc+isnull((select Sum(vivptirc) From Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0))
ELSE (cpvcum100 + isnull((select Sum(vivvum100) From Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0))
END
			    ELSE
			       CASE WHEN cpvcum100 = 0 OR cpfeccomp = @FECPROC THEN (cpvptirc+isnull((select Sum(vivptirc) From Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0)) / @DO_HOY
ELSE (cpvcum100 + isnull((select Sum(vivvum100) From Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0)) / @DO_HOY
END
		            END,
		GRUPO	= ( select Codigo_Grupo from view_GRUPO_TRADING_SWAP WHERE Codigo_Limite = 3 and DATEDIFF(DAY,@FECPROC,cpfecven) BETWEEN Tramo_Desde AND Tramo_Hasta )
	FROM MDCP
	WHERE cptipcart = 1 and (Exists(Select * from mdvi where vinumdocu = cpnumdocu and vicorrela = cpcorrela) or cpnominal > 0)
	ORDER BY PLAZO

	SELECT 	T_Codigo_Grupo  = Codigo_Grupo,
		T_Tramo_Desde   = Tramo_Desde,
		T_Tramo_Hasta   = Tramo_Hasta,
		T_MONTO		= ( SELECT SUM(MONTO) FROM #PASO WHERE GRUPO = view_GRUPO_TRADING_SWAP.Codigo_Grupo )
	INTO #MONTOS
	FROM view_GRUPO_TRADING_SWAP
	WHERE Codigo_Limite = 3

	UPDATE view_LIMITE_TRADING_SWAP
	SET Outstanding = Isnull(T_MONTO,0)
	FROM #MONTOS
	WHERE Codigo_Limite = 3 and T_Codigo_Grupo = Codigo_Grupo

	UPDATE view_LIMITE_TRADING_SWAP
	SET Disponible = Monto_Limite - Outstanding
	WHERE Codigo_Limite = 3


SET NOCOUNT OFF

	SELECT  Codigo_Limite        ,
		Codigo_Grupo         ,
		Outstanding          ,
		Monto_Limite         ,
		Disponible
FROM view_LIMITE_TRADING_SWAP
	WHERE Codigo_Limite = 3

END

GO
