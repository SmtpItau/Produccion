USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALMERCADO_ICP]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VALMERCADO_ICP]
		(	@iCodigo	NUMERIC(05,0)
		,	@nNominal	NUMERIC(21,8) 
		,	@fTasaMkt	FLOAT
		,	@FechaVcto	DATETIME
		,	@FechaHoy	DATETIME
		,	@nValMercado	FLOAT OUTPUT
		)			
AS
BEGIN

    -->	Proceimiento de Valorizacion de Papeles en ICPN y ICPR 
    --> Se Cacula ICP Futuro con Tasa SWAP Compuesta y se descuenta con tasa ICP Lineal
    -->

	SET NOCOUNT ON				;

	DECLARE @fValorMoneda 	NUMERIC(21,4)
	,	@fValorFuturo	NUMERIC(21,4) 	
	,	@iMoneda	NUMERIC(03,0)	;	

	
	DECLARE @CurvaUsada	VARCHAR(20)	;

	DECLARE @fTasaSWAP	FLOAT		;

	DECLARE @iPlazo		INTEGER		;


	CREATE TABLE #TasaMoneda
	(
             Tasa               FLOAT NOT NULL DEFAULT(0.0),
             Spreed             FLOAT NOT NULL DEFAULT(0.0),
             SpotCompra         FLOAT NOT NULL DEFAULT(0.0),
             SpotVenta          FLOAT NOT NULL DEFAULT(0.0)
	)

	SET @iMoneda	 = (CASE @iMoneda 	WHEN 800  	THEN 999
						WHEN 801	THEN 998 
						ELSE 999 	END)	;
	

	SET @iPlazo 	 = (SELECT DATEDIFF(DAY,@FechaHoy,@FechaVcto) ) ;

	INSERT INTO #TasaMoneda
	EXECUTE BacFwdSuda.dbo.SP_RetornaTasaMoneda @iMoneda, @iPlazo,   'PCS', 1 , 1, 1, 1, 'C', 0, 'CERO', 'Forward', @CurvaUsada OUTPUT

	SET @fTasaSWAP 		= ( SELECT tasa FROM #TasaMoneda )	;


	SET @fValorMoneda 	= (SELECT vmvalor  
			   	     FROM bacparamsuda.dbo.valor_moneda
		 		    INNER 
		  		     JOIN bacparamsuda.dbo.instrumento
		    		       ON incodigo = @iCodigo
		   		      AND vmcodigo = inmonemi
		 		    WHERE vmfecha = @FechaHoy) ;

	SET @fValorFuturo =  @nNominal * (@fValorMoneda * POWER (1.0 + (@fTasaSWAP/100.0), (DATEDIFF(DAY,@FechaHoy,@FechaVcto)/360.0)))	;

	SET @nValMercado  = ROUND(  @fValorFuturo / ( 1.0 + (@fTasaMkt/100.0)*(DATEDIFF(DAY,@FechaHoy,@FechaVcto)/360.0)) ,0)		;


END
GO
