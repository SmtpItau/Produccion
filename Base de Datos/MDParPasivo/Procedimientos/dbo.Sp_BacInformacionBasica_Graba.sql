USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacInformacionBasica_Graba]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BacInformacionBasica_Graba]
	
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
        @limite_cartera_asigNado   FLOAT,
	@limite_cartera_ocupado   FLOAT,
	@FFMMDiasMaximo	NUMERIC(19,0)
)
AS BEGIN


	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        SET DATEFORMAT dmy
	SET NOCOUNT ON

        SET ROWCOUNT 0

	IF EXISTS(SELECT 1 FROM DATOS_GENERALES WITH (NOLOCK))

	BEGIN


		UPDATE DATOS_GENERALES WITH (ROWLOCK) SET
			capital_reserva		= @capitalyreserva,
			capital_basico		= @capitalbasico,
			moneda_control		= @monedacontrol,
			valor_moneda		= @valormoneda,
			porcen_con_riesgo	= @porcenconriesgo,
			porcen_sin_riesgo	= @porcensinriesgo,
			porcen_invext		= @porceninvext,
			monto_con_riesgo	= @montoconriesgo,
			monto_sin_riesgo	= @montosinriesgo,
			invext_total		= @invexttotal,
			primer_tramo		= @primertramo,
			segundo_tramo		= @segundotramo,
			tercer_tramo		= @tercertramo,
			margen_institucion	= @margeninstitucion,
			total_cartera_lchr	= @totalcarteralchr,
			Total_Por_Folio		= @totalporfolio,
			caja_pesos		= @cajapesos,
			caja_bcch		= @cajabcch,
			total_inversiones	= @totalinversiones,
	                Limite_Inversion_Cartera_Asignado = @limite_cartera_asigNado,
             		Limite_Inversion_Cartera_Ocupado  = @limite_cartera_ocupado,
			FFMMDiasMaximo=@FFMMDiasMaximo

         END ELSE BEGIN
	

		INSERT INTO DATOS_GENERALES WITH (ROWLOCK)

		       (
			capital_reserva,
			capital_basico,
			moneda_control,
			valor_moneda,
			numero_traspaso,
			porcen_con_riesgo,
			porcen_sin_riesgo,
			porcen_invext,
			monto_con_riesgo,
			monto_sin_riesgo,
			invext_total,
			invext_ocupado,
			invext_disponible,
			invext_exceso,
			primer_tramo,
			segundo_tramo,
			tercer_tramo,
			margen_institucion,
			total_cartera_lchr,
			Total_Por_Folio,
			caja_pesos,
			caja_bcch,
			total_inversiones,
                       		Limite_Inversion_Cartera_Asignado,
                        		Limite_Inversion_Cartera_Ocupado,
			FFMMDiasMaximo
			)
		
			VALUES

		       (
			@capitalyreserva,
			@capitalbasico,
			@monedacontrol,
			@valormoneda,
			0,--@numerotraspaso,
			@porcenconriesgo,
			@porcensinriesgo,
			@porceninvext,
			@montoconriesgo,
			@montosinriesgo,
			@invexttotal,
			0,--@invextocupado,
			0,--@invextdisponible,
			0,--@invextexceso,
			@primertramo,
			@segundotramo,
			@tercertramo,
			@margeninstitucion,
			@totalcarteralchr,
			@totalporfolio,
			@cajapesos,
			@cajabcch,
			@totalinversiones,
                        		@limite_cartera_asigNado,
                        		@limite_cartera_ocupado , 
			@FFMMDiasMaximo
			)

        END





	IF EXISTS(SELECT 1 FROM DATOS_LIMITES WITH (NOLOCK))
	BEGIN


		UPDATE DATOS_LIMITES WITH (ROWLOCK) SET
			total_cartera_lchr	= @totalcarteralchr,
                        Limite_Inversion_Cartera_Asignado = @limite_cartera_asigNado

         END ELSE BEGIN
	

		INSERT INTO DATOS_LIMITES WITH (ROWLOCK)

		       (total_cartera_lchr,
			Limite_Inversion_Cartera_Asignado
                        )
		
			VALUES

		       (@totalcarteralchr,
			@limite_cartera_asigNado
			)

        END

END

GO
