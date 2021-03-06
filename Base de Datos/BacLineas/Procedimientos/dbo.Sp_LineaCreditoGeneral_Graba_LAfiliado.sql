USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_Graba_LAfiliado]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_Graba_LAfiliado]
		(	@totalasignado		NUMERIC(19,4)	,
			@totalocupado		NUMERIC(19,4)	,
			@totaldisponible	NUMERIC(19,4)	,
			@totalexceso  		NUMERIC(19,4)	,
			@rutcasamatriz  	NUMERIC(9)	,
			@codigocasamatriz 	NUMERIC(9)
		)
AS
BEGIN

	SET NOCOUNT ON
	IF EXISTS(	SELECT 	1 
			FROM 	linea_afiliado
			WHERE 	rutcasamatriz    = @rutcasamatriz AND
				codigocasamatriz = @codigocasamatriz
		)
		BEGIN
			SELECT "EXISTS"

			UPDATE	LINEA_AFILIADO 
			SET	totalasignado  	 = @totalasignado	,
				totalocupado  	 = @totalocupado	,
				totaldisponible  = @totaldisponible	,
				totalexceso  	 = @totalexceso		,
				rutcasamatriz    = @rutcasamatriz	,
				codigocasamatriz = @codigocasamatriz
			WHERE 	rutcasamatriz    = @rutcasamatriz 	AND
				codigocasamatriz = @codigocasamatriz

			IF @@ERROR<>0 
				SELECT "NO ACTUALIZADO"
		END
			
	ELSE
		BEGIN
			SELECT "NO EXISTS"
										
			INSERT INTO linea_afiliado
			(	totalasignado	,
				totalocupado	,
				totaldisponible	,
				totalexceso	,
				rutcasamatriz	,
				codigocasamatriz
			)
			VALUES(	@totalasignado		,
				@totalocupado		,
				@totaldisponible	,
				@totalexceso		,
				@rutcasamatriz		,
				@codigocasamatriz
				)

			IF @@ERROR<>0 
				SELECT "NO INSERTADO"
			ELSE
				SELECT "INSERTADO"
   
		END

END

-- sp_autoriza_ejecutar 'bacuser'





GO
