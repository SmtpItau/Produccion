USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limpia_Ocupado_Lineas]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Limpia_Ocupado_Lineas]
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy
         

	UPDATE	LINEA_AFILIADO
	SET	totaldisponible		= 0,
		totalexceso		= 0,
		ConRiesgodisponible	= 0,
		ConRiesgoexceso		= 0,
		SinRiesgodisponible	= 0,
		SinRiesgoexceso		= 0


	UPDATE	LINEA_AFILIADO
	SET	totaldisponible	= totalasignado - totalocupado
	WHERE	totalasignado > totalocupado

	UPDATE	LINEA_AFILIADO
	SET	ConRiesgodisponible = ConRiesgoasignado - ConRiesgoocupado
	WHERE	ConRiesgoasignado > ConRiesgoocupado

	UPDATE	LINEA_AFILIADO
	SET	SinRiesgodisponible = SinRiesgoasignado - SinRiesgoocupado
	WHERE	SinRiesgoasignado > SinRiesgoocupado

	UPDATE	LINEA_AFILIADO
	SET	totalexceso 	= ( totalasignado - totalocupado ) * -1
	WHERE	totalasignado < totalocupado

	UPDATE	LINEA_AFILIADO
	SET	ConRiesgoexceso = ( ConRiesgoasignado - ConRiesgoocupado ) * -1
	WHERE	ConRiesgoasignado < ConRiesgoocupado

	UPDATE	LINEA_AFILIADO
	SET	SinRiesgoexceso = ( SinRiesgoasignado - SinRiesgoocupado ) * -1
	WHERE	SinRiesgoasignado < SinRiesgoocupado



	UPDATE	LINEA_GENERAL
	SET	totaldisponible	= 0 ,
		totalexceso	= 0

	UPDATE	LINEA_GENERAL
	SET	totaldisponible = totalasignado + totalrecibido - totalocupado
	WHERE	totalasignado + totalrecibido > totalocupado

	UPDATE	LINEA_GENERAL
	SET	totalexceso 	= ( totalasignado + totalrecibido - totalocupado ) * -1
	WHERE	totalasignado + totalrecibido < totalocupado




	UPDATE	LINEA_SISTEMA
	SET	totaldisponible	= 0 ,
		totalexceso	= 0

	UPDATE	LINEA_SISTEMA
	SET	totaldisponible = totalasignado + totalrecibido - totalocupado
	WHERE	totalasignado + totalrecibido > totalocupado

	UPDATE	LINEA_SISTEMA
	SET	totalexceso 	= ( totalasignado + totalrecibido - totalocupado ) * -1
	WHERE	totalasignado + totalrecibido < totalocupado




	UPDATE	LINEA_POR_PLAZO
	SET	totaldisponible	= 0 ,
		totalexceso	= 0

	UPDATE	LINEA_POR_PLAZO
	SET	totaldisponible = totalasignado + totalrecibido - totalocupado
	WHERE	totalasignado + totalrecibido > totalocupado

	UPDATE	LINEA_POR_PLAZO
	SET	totalexceso 	= ( totalasignado + totalrecibido - totalocupado ) * -1
	WHERE	totalasignado + totalrecibido < totalocupado

	SET NOCOUNT OFF

END



GO
