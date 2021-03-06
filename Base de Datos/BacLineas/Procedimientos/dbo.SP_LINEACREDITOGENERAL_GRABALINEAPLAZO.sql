USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABALINEAPLAZO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABALINEAPLAZO]
		(	@rut_cliente 		NUMERIC(9)	,
			@codigo_cliente  	NUMERIC(9)	,			
			@id_sistema 	 	CHAR(3)		,
			@codigo_producto	CHAR(5)		,
			@plazodesde	 	NUMERIC(5)	,
			@plazohasta	 	NUMERIC(5)	,
			@porcentaje	 	NUMERIC(8,4)	,
			@totalasignado	 	NUMERIC(19,4)	,
			@totalocupado	 	NUMERIC(19,4)	,
			@totaldisponible	NUMERIC(19,4)	,
			@totalexceso		NUMERIC(19,4)	,
			@totaltraspaso		NUMERIC(19,4)	,
			@totalrecibido		NUMERIC(19,4)
		)
AS 
BEGIN

	SET NOCOUNT ON
	
	SELECT 'NO EXISTS'
	IF EXISTS(SELECT rut_cliente,
			 id_sistema
		  FROM 	 LINEA_PRODUCTO_POR_PLAZO
		  WHERE  @rut_cliente		= rut_cliente		AND 
			 @codigo_cliente	= codigo_cliente	AND
			 @id_sistema		= id_sistema		AND 
			 @codigo_producto	= codigo_producto	AND
			 @plazodesde		= plazodesde
		)
		BEGIN
			SELECT 'EXISTS'
			UPDATE 	LINEA_PRODUCTO_POR_PLAZO
			SET	plazohasta	= @plazohasta		,
				porcentaje	= @porcentaje		,
				totalasignado	= @totalasignado	,
				totalocupado	= @totalocupado		,
				totaldisponible	= @totaldisponible	,
				totalexceso	= @totalexceso		,
				totaltraspaso	= @totaltraspaso	,
				totalrecibido	= @totalrecibido
			WHERE  	@rut_cliente		= rut_cliente		AND 
			 	@codigo_cliente		= codigo_cliente	AND
			 	@id_sistema		= id_sistema		AND 
			 	@codigo_producto	= codigo_producto	AND
			 	@plazodesde		= plazodesde

			IF @@ERROR<>0 
				SELECT 'NO INSERTADO'
			ELSE
				SELECT 'INSERTADO'

			RETURN

		END

	INSERT INTO LINEA_PRODUCTO_POR_PLAZO
	(	rut_cliente	,
		codigo_cliente	,
		id_sistema	,
		codigo_producto	,
		plazodesde	,
		plazohasta	,
		porcentaje	,
		totalasignado	,
		totalocupado	,
		totaldisponible	,
		totalexceso	,
		totaltraspaso	,
		totalrecibido
	)
	VALUES(	@rut_cliente		,
		@codigo_cliente		,
		@id_sistema		,
		@codigo_producto	,
		@plazodesde		,
		@plazohasta		,
		@porcentaje		,
		@totalasignado		,
		@totalocupado		,
		@totaldisponible	,
		@totalexceso		,
		@totaltraspaso		,
		@totalrecibido
		)	

	IF @@ERROR<>0 
		SELECT 'NO INSERTADO'
	ELSE
		SELECT 'INSERTADO'


	SET NOCOUNT OFF

END
GO
