USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETINTERPOLCURVAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETINTERPOLCURVAS]
	(	 @codCurva	VARCHAR(20)
		,@dias		NUMERIC(9)
		,@modo		CHAR(3) = 'BID'
		,@valInterpol	NUMERIC(19,4) OUTPUT
	)
AS 
BEGIN

	SET NOCOUNT ON

	DECLARE @Tmenos1	DATETIME,
		@Valor		NUMERIC(19,4),
		@tDias		NUMERIC(9),
		@CotaMax	NUMERIC(9),
		@CotaMin	NUMERIC(9),
		@X1		NUMERIC(19,4),
		@Xn		NUMERIC(19,4),
		@Y1		NUMERIC(19,4),
		@Yn		NUMERIC(19,4)

	SELECT 	@Tmenos1 = acfecante
		FROM BacTraderSuda..MDAC

	SELECT 	@CotaMax = MAX(Dias),
		@CotaMin = MIN(Dias)
	FROM Bacparamsuda..CURVAS
	WHERE CodigoCurva   = @codCurva
	AND FechaGeneracion = @Tmenos1

	IF @CotaMax IS NULL OR @CotaMin IS NULL
	BEGIN
		SELECT @valInterpol = NULL
		RETURN 0
	END
	--- @dias está entre @CotaMin y @CotaMax
	IF @modo = 'BID'
	BEGIN
		SELECT 	@X1 = Dias,
		@Y1 = ValorBid
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias	    = @CotaMin

		SELECT 	@Xn = Dias,
			@Yn = ValorBid
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias	    = @CotaMax
	
		IF @dias >= @CotaMax
		BEGIN
			SELECT @valInterpol = @Yn + (@Yn/@Xn)*( @dias - @Xn)
			RETURN 0
		END
		IF @dias <= @CotaMin
		BEGIN
			SELECT @valInterpol = (@Y1/@X1)*@dias
			RETURN 0
		END

		SELECT TOP 1
		@tDias = Dias,
		@Valor = ValorBid
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias >= @dias
		ORDER BY Dias ASC
		SELECT  @Xn = @tDias,
		@Yn = @Valor

		SELECT TOP 1
		@tDias = Dias,
		@Valor = ValorBid
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias < @dias
		ORDER BY Dias DESC
		SELECT  @X1 = @tDias,
		@Y1 = @Valor

		SELECT @valInterpol = @Yn + ( (@Yn - @Y1)/(@Xn - @X1) ) * ( @dias - @Xn )
		RETURN 0
	END	
	IF @modo = 'ASK'
	BEGIN
		SELECT 	@X1 = Dias,
		@Y1 = ValorAsk
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias	    = @CotaMin

		SELECT 	@Xn = Dias,
			@Yn = ValorAsk
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias	    = @CotaMax
	
		IF @dias >= @CotaMax
		BEGIN
			SELECT @valInterpol = @Yn + (@Yn/@Xn)*( @dias - @Xn)
			RETURN 0
		END
		IF @dias <= @CotaMin
		BEGIN
			SELECT @valInterpol = (@Y1/@X1)*@dias
			RETURN 0
		END

		SELECT TOP 1
		@tDias = Dias,
		@Valor = ValorAsk
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias >= @dias
		ORDER BY Dias ASC
		SELECT  @Xn = @tDias,
		@Yn = @Valor

		SELECT TOP 1
		@tDias = Dias,
		@Valor = ValorAsk
		FROM BacParamsuda..CURVAS
		WHERE CodigoCurva   = @codCurva
		AND FechaGeneracion = @Tmenos1
		AND Dias < @dias
		ORDER BY Dias DESC
		SELECT  @X1 = @tDias,
		@Y1 = @Valor

		SELECT @valInterpol = @Yn + ( (@Yn - @Y1)/(@Xn - @X1) ) * ( @dias - @Xn )
		RETURN 0
	END
END
GO
