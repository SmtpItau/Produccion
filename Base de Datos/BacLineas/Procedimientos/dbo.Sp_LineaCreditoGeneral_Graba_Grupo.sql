USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_Graba_Grupo]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_Graba_Grupo]
	@totalasignado		NUMERIC(19,4),
	@totalocupado		NUMERIC(19,4),
	@totaldisponible	NUMERIC(19,4),
	@totalexceso		NUMERIC(19,4),
	@rutcasamatriz		NUMERIC(9),
	@codigocasamatriz	NUMERIC(9),
	@SinRiesgoAsignado	NUMERIC(19,4),
	@ConRiesgoAsignado	NUMERIC(19,4)

AS
BEGIN

SET NOCOUNT ON
	BEGIN
	IF EXISTS(SELECT 1 FROM LINEA_AFILIADO 	
                          WHERE rutcasamatriz 	 = @rutcasamatriz
			    AND codigocasamatriz = @codigocasamatriz)

		BEGIN
			SELECT 'EXISTS'
			UPDATE LINEA_AFILIADO 
                           SET  totalasignado		=	@totalasignado,
				totalocupado		=	@totalocupado,
				totaldisponible		=	@totaldisponible,
				totalexceso		=	@totalexceso,
				rutcasamatriz		=	@rutcasamatriz,
				codigocasamatriz	=	@codigocasamatriz,
				SinRiesgoAsignado	= 	@SinRiesgoAsignado,
				ConRiesgoAsignado	= 	@ConRiesgoAsignado
				WHERE rutcasamatriz 	=	@rutcasamatriz
				AND   codigocasamatriz	=	@codigocasamatriz

				IF @@ERROR<>0 
				   BEGIN
					SELECT 'NO ACTUALIZADO'
			           END	
			END
		ELSE
			BEGIN
				SELECT 'NO EXISTS'
				INSERT INTO LINEA_AFILIADO
				       (
					totalasignado,
					totalocupado,
					totaldisponible,
					totalexceso,
					rutcasamatriz,
					codigocasamatriz,
					SinRiesgoAsignado,
					ConRiesgoAsignado

					)

				VALUES
				       (
					@totalasignado,
					@totalocupado,
					@totaldisponible,
					@totalexceso,
					@rutcasamatriz,
					@codigocasamatriz,
					@SinRiesgoAsignado,
					@ConRiesgoAsignado

					)

				IF @@ERROR<>0 
				   BEGIN
						SELECT 'NO INSERTADO'
		                   END
				ELSE
				   BEGIN
						SELECT 'INSERTADO'
			
		                END

			END

	END

END





GO
