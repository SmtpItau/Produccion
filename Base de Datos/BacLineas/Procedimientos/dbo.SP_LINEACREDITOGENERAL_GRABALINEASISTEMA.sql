USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABALINEASISTEMA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABALINEASISTEMA]
		( 	@rut_cliente   		NUMERIC(9)	,
			@codigo_cliente  	NUMERIC(9)	,
			@id_sistema   		CHAR(3)		,
			@fechaasignacion 	DATETIME	,
			@fechavencimiento 	DATETIME	,
			@fechafincontrato 	DATETIME	,
			@bloqueado  		CHAR(1)		,
			@totalasignado  	NUMERIC(19,4)	,
			@totalocupado  		NUMERIC(19,4)	,
			@totaldisponible 	NUMERIC(19,4)	,
			@totalexceso  		NUMERIC(19,4)	,
			@moneda			VARCHAR(3)
		)
AS
BEGIN
	SET NOCOUNT ON
        SELECT @moneda = Ltrim(Rtrim(@moneda))
	IF EXISTS(SELECT rut_cliente,
			 id_sistema
		  FROM 	 LINEA_SISTEMA
		  WHERE  @rut_cliente		= rut_cliente		AND 
			 @codigo_cliente	= codigo_cliente	AND
			 @id_sistema		= id_sistema
		)
		BEGIN
			SELECT 'EXISTS'
			UPDATE 	LINEA_SISTEMA 
			SET	fechaasignacion  	= @fechaasignacion	,
				fechavencimiento 	= @fechavencimiento	,
				fechafincontrato 	= @fechafincontrato	,
				bloqueado  		= @bloqueado		,
				totalasignado  		= @totalasignado	,
				totalocupado  		= @totalocupado		,
				totaldisponible  	= @totaldisponible	,
				totalexceso  		= @totalexceso		,
				moneda			= @moneda
			WHERE  	rut_cliente	        = @rut_cliente 
			AND     codigo_cliente 	        = @codigo_cliente
			AND     id_sistema 	        = @id_sistema

			IF @@ERROR<>0 
				SELECT 'NO ACTUALIZADO'
			ELSE
				SELECT 'ACTUALIZADO'

			RETURN

		END
  
	SELECT 'NO EXISTS'
	INSERT INTO LINEA_SISTEMA
	(	rut_cliente,
		codigo_cliente,
		id_sistema,
		fechaasignacion,
		fechavencimiento,
		fechafincontrato,
		bloqueado,
		totalasignado,
		totalocupado,
		totaldisponible,
		totalexceso,
		moneda
	)
	VALUES	(	
		@rut_cliente		,
		@codigo_cliente		,
		@id_sistema		,
		@fechaasignacion	,
		@fechavencimiento	,
		@fechafincontrato	,
		@bloqueado		,
		@totalasignado		,
		@totalocupado		,
		@totaldisponible	,
		@totalexceso		,
		@moneda
                )
		
	IF @@ERROR <> 0 
		SELECT 'NO INSERTADO'
	ELSE
		SELECT 'INSERTADO'

	SET NOCOUNT OFF 

END
GO
