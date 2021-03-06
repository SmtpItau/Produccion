USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACINFORMACIONBASICA_GRABA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACINFORMACIONBASICA_GRABA]
	
       (
	@capitalyreserva	NUMERIC(19,4),
        @capitalbasico		NUMERIC(19,4),
	@monedacontrol		NUMERIC(5,0),
	@valormoneda		NUMERIC(10,4),
	@porcenconriesgo	NUMERIC(10,4),
	@porcensinriesgo	NUMERIC(10,4),
	@porceninvext		NUMERIC(10,4),
	@montoconriesgo		NUMERIC(19,4),
	@montosinriesgo		NUMERIC(19,4),
	@invexttotal		NUMERIC(19,4),
	@primertramo		NUMERIC(19,4),
	@segundotramo		NUMERIC(19,4),
	@tercertramo		NUMERIC(19,4),
	@margeninstitucion	NUMERIC(19,4),
	@totalcarteralchr	NUMERIC(19,4),
	@totalporfolio		NUMERIC(19,4),
	@cajapesos		NUMERIC(19,4),
	@cajabcch		NUMERIC(19,4),
	@totalinversiones	NUMERIC(19,4),
	@totalporcentajeletras	NUMERIC(19,4) = 0) 

AS BEGIN

	SET NOCOUNT OFF

        SET ROWCOUNT 0

	IF EXISTS(SELECT 1 FROM POSICION_GRUPO 
			  WHERE codigo_grupo = '08')
	  BEGIN
		UPDATE POSICION_GRUPO 
		   SET totalposicion   = ROUND((@totalporcentajeletras/100) * @capitalyreserva,4)
		   ,   totaldisponible = CASE 
					   WHEN (totalocupado - @totalporcentajeletras) < 0 THEN 0
					   ELSE (totalocupado - @totalporcentajeletras)
					 END
		 WHERE codigo_grupo = '08'
	  END
	ELSE
	  BEGIN
		INSERT INTO POSICION_GRUPO
			(
				codigo_grupo 
			,	porcentaje
			,	totalposicion
			,	totalocupado
			,	totalcompra
			,	totalventa
			,	totaldisponible
			,	totalexcedido
			)
		   VALUES
			(
				'08'
			,	0.0
			,	ROUND((@totalporcentajeletras/100) * @capitalyreserva,4)
			,	0.0
			,	0.0
			,	0.0
			,	0.0
			,	0.0
			)
	  END

	IF EXISTS(SELECT 1 FROM VIEW_CONTROL_FINANCIERO)

	BEGIN

		UPDATE VIEW_CONTROL_FINANCIERO SET
		
			capitalyreserva		= @capitalyreserva			,
			capitalbasico		= @capitalbasico			,
			monedacontrol		= @monedacontrol			,
			valormoneda		= @valormoneda				,
			porcenconriesgo		= @porcenconriesgo			,
			porcensinriesgo		= @porcensinriesgo			,
			porceninvext		= @porceninvext				,
			montoconriesgo		= @montoconriesgo			,
			montosinriesgo		= @montosinriesgo			,
			invexttotal		= @invexttotal				,
			primertramo		= @primertramo				,
			segundotramo		= @segundotramo				,
			tercertramo		= @tercertramo				,
			margeninstitucion	= @margeninstitucion			,
			totalcarteralchr	= @totalcarteralchr			,
			totalporfolio		= @totalporfolio			,
			cajapesos		= @cajapesos				,
			cajabcch		= @cajabcch				,
			totalinversiones	= @totalinversiones			,
			invextexceso		= @totalporcentajeletras

         END ELSE BEGIN
	
		INSERT INTO VIEW_CONTROL_FINANCIERO

		       (
			capitalyreserva				,
			capitalbasico				,
			monedacontrol				,
			valormoneda				,
			numerotraspaso				,
			porcenconriesgo				,
			porcensinriesgo				,
			porceninvext				,
			montoconriesgo				,
			montosinriesgo				,
			invexttotal				,
			invextocupado				,
			invextdisponible			,
			invextexceso				,
			primertramo				,
			segundotramo				,
			tercertramo				,
			margeninstitucion			,
			totalcarteralchr			,
			totalporfolio				,
			cajapesos				,
			cajabcch				,
			totalinversiones
			)
		
			VALUES

		       (
			@capitalyreserva			,
			@capitalbasico				,
			@monedacontrol				,
			@valormoneda				,
			0					,
			@porcenconriesgo			,
			@porcensinriesgo			,
			@porceninvext				,
			@montoconriesgo				,
			@montosinriesgo				,
			@invexttotal				,
			0           				,
			0           				,
			@totalporcentajeletras			,
			@primertramo				,
			@segundotramo				,
			@tercertramo				,
			@margeninstitucion			,
			@totalcarteralchr			,
			@totalporfolio				,
			@cajapesos				,
			@cajabcch				,
			@totalinversiones
			)

       END

END
GO
