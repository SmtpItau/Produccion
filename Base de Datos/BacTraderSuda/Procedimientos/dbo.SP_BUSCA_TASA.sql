USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_TASA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_TASA]
				(	@dFecprox  DATETIME, 
		 			@dFecpcup  DATETIME,
		 			@dFechoy   DATETIME 
				)AS
BEGIN
SET NOCOUNT ON

/*             CREATE TABLE #TEMP_1
                      (
                        rsinstser CHAR(25),
                        rsinstcam CHAR(25)
                      )*/



	DECLARE @CONTADOR 		INTEGER
	DECLARE @TOTAL			INTEGER
	DECLARE @INSTRAN		CHAR(10)
	DECLARE	@INSTRCAM		CHAR(10)
	DECLARE	@fecha	 		DATETIME
	DECLARE	@id_sistema		CHAR(3)
	DECLARE	@tmrutcart  		NUMERIC(9)
	DECLARE	@tmrutemis 		NUMERIC(9)
	DECLARE	@tmcodigo  		NUMERIC(3)
	DECLARE	@tminstser 		CHAR(10)
	DECLARE	@tmmonemis 		NUMERIC(3)
	DECLARE	@tmgenemis 		CHAR(6)
	DECLARE	@tmnominal 		NUMERIC(19,4)
	DECLARE	@tmfecvcto 		DATETIME
	DECLARE	@tasa_mercado		NUMERIC(8,4)
	DECLARE	@tasa_market 		NUMERIC(8,4)
	DECLARE	@tasa_market1		NUMERIC(8,4)
	DECLARE	@tasa_market2		NUMERIC(8,4)
	DECLARE	@tasa_mercado_cierre	NUMERIC(8,4)
	DECLARE	@tasa_market_cierre 	NUMERIC(8,4)
        DECLARE @fecha_cierre   	DATETIME

       SELECT  @fecha_cierre = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@dFecprox )) * -1, CONVERT(DATETIME,@dFecprox ))

SELECT @CONTADOR  = 1
SELECT @TOTAL     = 0
IF (@dFecprox >= @dFecpcup AND @dFecpcup > @dFechoy)
BEGIN
	SELECT 	 rsinstser,
		 rsinstcam
	INTO #TEMP_1
	FROM MDRS
	WHERE   (rscartera = 114 OR rscartera  = 111) 
		AND  rscodigo   = 20	
		AND  rsfecha    = @dFecprox 
		AND ( rsinstser  <> rsinstcam AND rsinstcam <> '')	

        SELECT @TOTAL = COUNT(*) FROM #TEMP_1
END
--SELECT * FROM #TEMP

WHILE @CONTADOR < =  @TOTAL
BEGIN

   SET ROWCOUNT @CONTADOR
   SELECT 	@INSTRAN  = rsinstser ,  
		@INSTRCAM = rsinstcam 
  FROM #TEMP_1


   SELECT
	@fecha 			= fecha_proceso, 	
	@id_sistema		= id_sistema,
	@tmrutcart 		= tmrutcart ,
	@tmrutemis 		= tmrutemis,
	@tmcodigo  		= tmcodigo,
	@tminstser 		= tminstser,
	@tmmonemis 		= tmmonemis,
	@tmgenemis 		= tmgenemis,
	@tmnominal 		= tmnominal,
	@tmfecvcto 		= tmfecvcto,
	@tasa_mercado		= tasa_mercado,
	@tasa_market    	= tasa_market,
	@tasa_market1   	= tasa_market1,
	@tasa_market2 		= tasa_market2,
	@tasa_mercado_cierre 	= tasa_mercado_cierre,
	@tasa_market_cierre 	= tasa_market_cierre
	  
   FROM TASA_MERCADO   WHERE TMINSTSER = @INSTRAN 
	 AND FECHA_PROCESO  =  @fecha_cierre  --- buscar fecha del cierre mes anterior 


SELECT	@fecha 		, 	
	@id_sistema	,
	@tmrutcart 	,
	@tmrutemis 	,
	@tmcodigo  	,
	@tminstser 	,
	@tmmonemis 	,
	@tmgenemis 	,
	@tmnominal 	,
	@tmfecvcto 	,
	@tasa_mercado	,
	@tasa_market    ,
	@tasa_market1   ,
	@tasa_market2 	,
	@tasa_mercado_cierre,
	@tasa_market_cierre, 
	@fecha_cierre,
	@instrcam

	IF NOT EXISTS( SELECT * FROM TASA_MERCADO WHERE fecha_proceso = @fecha_cierre AND id_sistema = @id_sistema AND tminstser = @instrcam )
        BEGIN
	   INSERT INTO TASA_MERCADO 	(	
			fecha_proceso		,
			id_sistema		,
			tmrutcart 		,
			tmrutemis 		,
			tmcodigo  		,
			tminstser 		,
			tmmonemis 		,
			tmgenemis 		,
			tmnominal 		,
			tmfecvcto 		,
			tasa_mercado		,
			tasa_market    		,
			tasa_market1   		,
			tasa_market2 		,
			tasa_mercado_cierre	,
			tasa_market_cierre 
				)
	   VALUES	( 	
			@fecha_cierre		, -- buscar fecha del cierre mes anterior
			@id_sistema		,
			@tmrutcart		,
			@tmrutemis		,
			@tmcodigo		,
			@instrcam		,
			@tmmonemis 		,
			@tmgenemis 		,
			@tmnominal 		,
			@tmfecvcto 		,
			@tasa_mercado		,
			@tasa_market    	,
			@tasa_market1   	,
			@tasa_market2 		,
			@tasa_mercado_cierre 	,
			@tasa_market_cierre 	
			)
	END

   SELECT @CONTADOR = @CONTADOR + 1

END
SET NOCOUNT OFF
END   

--SELECT * FROM TASA_MERCADO WHERE FECHA_PROCESO = '20020930'


GO
