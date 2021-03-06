USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PUNTOS_FORWARDCOMEX]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_PUNTOS_FORWARDCOMEX] (	@CompVenta	Char(1),
						@Fecha       	CHAR(8),
						@Clase 		CHAR(2),
						@dia			INT	)	
AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @iDiaMenor FLOAT
	DECLARE @iDiaMayor FLOAT
	DECLARE @iValorMenor FLOAT
	DECLARE @iValorMayor FLOAT

	DECLARE @fPuntosFwd    	  FLOAT       	
	DECLARE @fSpreadComercial FLOAT       
	DECLARE @fSpreadTrading	  FLOAT

	CREATE TABLE #TMP_PUNTOS_COMEX
	( Plazo 	Numeric (3,0)
	 ,TCambio 	FLOAT
	 ,SpreadCom 	FLOAT
	 ,SpreadTra	FLOAT
	)

	IF  @CompVenta = 'V' 
	BEGIN
		INSERT #TMP_PUNTOS_COMEX
		SELECT   'Plazo'	= Plazo
			,'TCambio' 	= Bid
			,'SpreadCom' 	= SpreadCom_Venta
			,'SpreadTra'	= SpreadTra_Venta
		FROM TBL_TRXCOMEX_PUNTOS 
		WHERE 	    fecha 	= @fecha
			AND clase 	= @clase
			AND moneda	= 999 

	END

	IF  @CompVenta= 'C' 
	BEGIN
		INSERT #TMP_PUNTOS_COMEX
		SELECT   'Plazo'	= Plazo
			,'TCambio' 	= Ask  
			,'SpreadCom' 	= SpreadCom_Compra
			,'SpreadTra' 	= SpreadTra_Compra
		FROM TBL_TRXCOMEX_PUNTOS 
		WHERE 	    fecha 	= @fecha
			AND clase 	= @clase
			AND moneda	= 999 
	END


	SELECT @idiamenor = ISNULL(CONVERT(FLOAT,MAX(plazo)),0) FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo <= @dia
	
	SELECT @idiamayor = CONVERT(FLOAT,MIN(plazo)) FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo >= @dia

	IF @idiamenor = 0
 		SELECT @idiamenor = @idiamayor
		SELECT @idiamayor = CONVERT(FLOAT,MIN(plazo)) FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo > @iDiaMenor

        IF @idiamayor = 0
	BEGIN
		SELECT @idiamayor = CONVERT(FLOAT,MAX(plazo)) FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) 
		SELECT @idiamenor = CONVERT(FLOAT,MAX(plazo)) FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) 
				WHERE plazo  < @idiamayor   
	END

	SELECT @ivalormenor = TCambio FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo = @idiamenor
	SELECT @ivalormayor = TCambio FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo = @idiamayor

	IF ( @idiamenor <> @idiamayor ) AND (@ivalormenor <> @ivalormayor)
   	BEGIN
      		EXECUTE Sp_Interpolar_TasasComex @idiamenor , @ivalormenor ,  @idiamayor , @ivalormayor, @dia, @fPuntosFwd out
   	END ELSE
   	BEGIN
      		SET @fPuntosFwd = @ivalormenor
   	END

	SELECT @ivalormenor = SpreadCom FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo = @idiamenor
	SELECT @ivalormayor = SpreadCom FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo = @idiamayor

	IF ( @idiamenor <> @idiamayor ) AND (@ivalormenor <> @ivalormayor)
   	BEGIN
      		EXECUTE Sp_Interpolar_TasasComex @idiamenor , @ivalormenor ,  @idiamayor , @ivalormayor, @dia, @fSpreadComercial out
   	END ELSE
   	BEGIN
      		SET @fSpreadComercial = @ivalormenor
   	END

	SELECT @ivalormenor = SpreadTra FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo = @idiamenor
	SELECT @ivalormayor = SpreadTra FROM #TMP_PUNTOS_COMEX WITH(NOLOCK) WHERE plazo = @idiamayor

	IF ( @idiamenor <> @idiamayor ) AND (@ivalormenor <> @ivalormayor)
   	BEGIN
      		EXECUTE Sp_Interpolar_TasasComex @idiamenor , @ivalormenor ,  @idiamayor , @ivalormayor, @dia, @fSpreadTrading out
   	END ELSE
   	BEGIN
      		SET @fSpreadTrading = @ivalormenor
   	END

	SELECT @fPuntosFwd ,@fSpreadComercial ,@fSpreadTrading

	SET NOCOUNT OFF
END

GO
