USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_GrabaLineaSistema]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_GrabaLineaSistema]
			(
			@rut_cliente		NUMERIC	(09)	,
			@codigo_cliente		NUMERIC	(09)	,
			@Codigo_grupo		CHAR	(10)	,
			@fechaasignacion	DATETIME	,
			@fechavencimiento	DATETIME	,
			@fechafincontrato	DATETIME	,
			@realizatraspaso	CHAR	(01)	,
			@bloqueado		CHAR	(01)	,
			@compartido		CHAR	(01)	,
			@controlaplazo		CHAR	(01)	,
			@totalasignado		NUMERIC	(19,4)	,
			@totalocupado		NUMERIC	(19,4)	,
			@totaldisponible	NUMERIC	(19,4)	,
			@totalexceso		NUMERIC	(19,4)	,
			@totaltraspaso		NUMERIC	(19,4)	,
			@totalrecibido		NUMERIC	(19,4)	,
			@sinriesgoasignado	NUMERIC	(19,4)	,
			@sinriesgoocupado	NUMERIC	(19,4)	,
			@sinriesgodisponible	NUMERIC	(19,4)	,
			@sinriesgoexceso	NUMERIC	(19,4)	,
			@conriesgoasignado	NUMERIC	(19,4)	,
			@conriesgoocupado	NUMERIC	(19,4)	,
			@conriesgodisponible	NUMERIC	(19,4)	,
			@conriesgoexceso    	NUMERIC	(19,4)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	IF EXISTS(SELECT 1 FROM LINEA_SISTEMA WITH (NOLOCK) WHERE @rut_cliente		= rut_cliente	 AND
						    		  @codigo_cliente	= codigo_cliente AND
						    		  @Codigo_grupo		= codigo_grupo) BEGIN
		UPDATE LINEA_SISTEMA SET 
				fechaasignacion		=	@fechaasignacion,
				fechavencimiento	=	@fechavencimiento,
				fechafincontrato	=	@fechafincontrato,
				realizatraspaso		=	@realizatraspaso,
				bloqueado		=	@bloqueado,
				compartido		=	@compartido,
				controlaplazo		=	@controlaplazo,
				totalasignado		=	@totalasignado,
				totalocupado		=	@totalocupado,
				totaldisponible		=	@totaldisponible,
				totalexceso		=	@totalexceso,
				totaltraspaso		=	@totaltraspaso,
				totalrecibido		=	@totalrecibido,
				sinriesgoasignado	=	@sinriesgoasignado,
				sinriesgoocupado	=	@sinriesgoocupado,
				sinriesgodisponible	=	@sinriesgodisponible,
				sinriesgoexceso		=	@sinriesgoexceso,
				conriesgoasignado	=	@conriesgoasignado,
				conriesgoocupado	=	@conriesgoocupado,
				conriesgodisponible	=	@conriesgodisponible,
				conriesgoexceso		=    	@conriesgoexceso
		WHERE 	rut_cliente	= @rut_cliente 		AND
			codigo_cliente	= @codigo_cliente	AND
			Codigo_grupo	= @Codigo_grupo

		IF @@ERROR <> 0 BEGIN
			SELECT 'NO ACTUALIZADO'
		END
		RETURN
	END
		
	INSERT INTO LINEA_SISTEMA
		       (rut_cliente,
			codigo_cliente,
			codigo_grupo,
			fechaasignacion,
			fechavencimiento,
			fechafincontrato,
			realizatraspaso,
			bloqueado,
			compartido,
			controlaplazo,
			totalasignado,
			totalocupado,
			totaldisponible,
			totalexceso,
			totaltraspaso,
			totalrecibido,
			sinriesgoasignado,
			sinriesgoocupado,
			sinriesgodisponible,
			sinriesgoexceso,
			conriesgoasignado,
			conriesgoocupado,
			conriesgodisponible,
			conriesgoexceso    )
		VALUES
		       (@rut_cliente,
			@codigo_cliente,
			@Codigo_grupo,
			@fechaasignacion,
			@fechavencimiento,
			@fechafincontrato,
			@realizatraspaso,
			@bloqueado,
			@compartido,
			@controlaplazo,
			@totalasignado,
			@totalocupado,
			@totaldisponible,
			@totalexceso,
			@totaltraspaso,
			@totalrecibido,
			@sinriesgoasignado,
			@sinriesgoocupado,
			@sinriesgodisponible,
			@sinriesgoexceso,
			@conriesgoasignado,
			@conriesgoocupado,
			@conriesgodisponible,
			@conriesgoexceso)

END





GO
