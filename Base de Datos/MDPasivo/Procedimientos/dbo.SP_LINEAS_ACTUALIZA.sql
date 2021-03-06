USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ACTUALIZA]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_ACTUALIZA] ( @rut_cliente NUMERIC(10) = 0)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
        SET DATEFORMAT dmy

/*   NO SE UTILIZAN
	UPDATE	INVERSION_EXTERIOR
	SET	ArbSpo_Disponible	= 0,
		ArbSpo_Exceso		= 0,
		ArbFwd_Disponible	= 0,
		ArbFwd_Exceso		= 0,
		InvExt_Disponible	= 0,
		ArbExt_Exceso		= 0

	UPDATE	RIESGO_PAIS
	SET	totaldisponible = 0,
		totalexceso	= 0

	UPDATE	RIESGO_PAIS
	SET	totaldisponible	= totalasignado - totalocupado

-- select * from MARGEN_INVERSION_GLOBAL

	UPDATE	MARGEN_INVERSION_GLOBAL
	SET	totaldisponible = 0,
		totalexceso	= 0

	UPDATE	MARGEN_INVERSION_GLOBAL
	SET	totaldisponible	= totalasignado - totalocupado


-- select * from MARGEN_INVERSION_INSTRUMENTO
	UPDATE	MARGEN_INVERSION_INSTRUMENTO
	SET	totaldisponible = 0,
		totalexceso	= 0

	UPDATE	MARGEN_INVERSION_INSTRUMENTO
	SET	totaldisponible	= totalasignado - totalocupado



-- select * from LINEA_AFILIADO
	UPDATE	LINEA_AFILIADO
	SET	totaldisponible		= 0,
		totalexceso		= 0,
		ConRiesgodisponible	= 0,
		ConRiesgoexceso		= 0,
		SinRiesgodisponible	= 0,
		SinRiesgoexceso		= 0

-- select * from LINEA_AFILIADO
	UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
	SET	totaldisponible	= totalasignado - totalocupado
	WHERE	( RutCasaMatriz = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado > totalocupado


	UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
	SET	ConRiesgodisponible = ConRiesgoasignado - ConRiesgoocupado
	WHERE	( RutCasaMatriz = @rut_cliente OR @rut_cliente = 0)
	AND	ConRiesgoasignado > ConRiesgoocupado

	UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
	SET	SinRiesgodisponible = SinRiesgoasignado - SinRiesgoocupado
	WHERE	( RutCasaMatriz = @rut_cliente OR @rut_cliente = 0)
	AND	SinRiesgoasignado > SinRiesgoocupado

	UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
	SET	totalexceso 	= ( totalasignado - totalocupado ) * -1
	WHERE	( RutCasaMatriz = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado < totalocupado

	UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
	SET	ConRiesgoexceso = ( ConRiesgoasignado - ConRiesgoocupado ) * -1
	WHERE	( RutCasaMatriz = @rut_cliente OR @rut_cliente = 0)
	AND	ConRiesgoasignado < ConRiesgoocupado

	UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
	SET	SinRiesgoexceso = ( SinRiesgoasignado - SinRiesgoocupado ) * -1
	WHERE	( RutCasaMatriz = @rut_cliente OR @rut_cliente = 0)
	AND	SinRiesgoasignado < SinRiesgoocupado

*/

-- select * from LINEA_GENERAL
	UPDATE	LINEA_GENERAL WITH (ROWLOCK)
	SET	totaldisponible	= 0 ,
		totalexceso	= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)

	UPDATE	LINEA_GENERAL WITH (ROWLOCK)
        SET	totaldisponible = totalasignado - totalocupado 
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado > totalocupado 
	

	UPDATE	LINEA_GENERAL WITH (ROWLOCK)
	SET	totalexceso 	= ABS( totalasignado - totalocupado )
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado  < totalocupado 



	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	totaldisponible	= 0 ,
		totalexceso	= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)

	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	totaldisponible = totalasignado - totalocupado 
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado > totalocupado 


	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	totalexceso 	= ABS( totalasignado - totalocupado  )
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado < totalocupado 



	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	SinRiesgodisponible	= 0 ,
		SinRiesgoexceso		= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)



--	UPDATE	LINEA_SISTEMA
--	SET	SinRiesgodisponible = CASE WHEN SinRiesgoasignado - SinRiesgoOcupado < 0 THEN 0 ELSE SinRiesgoasignado - SinRiesgoOcupado END
--	,       SinRiesgoExceso     = CASE WHEN SinRiesgoasignado - SinRiesgoOcupado > 0 THEN 0 ELSE ABS(SinRiesgoasignado - SinRiesgoOcupado) END
--	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


	--************************

	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	SinRiesgodisponible = SinRiesgoasignado - SinRiesgoOcupado
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(SinRiesgoasignado - SinRiesgoOcupado) > 0


	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	SinRiesgoExceso     = ABS(SinRiesgoasignado - SinRiesgoOcupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(SinRiesgoasignado - SinRiesgoOcupado) < 0

	--************************


	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	ConRiesgodisponible	= 0 ,
		ConRiesgoexceso		= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


--	UPDATE	LINEA_SISTEMA
--	SET	ConRiesgodisponible = CASE WHEN ConRiesgoasignado - ConRiesgoocupado < 0 THEN 0 ELSE ConRiesgoasignado - ConRiesgoocupado END
--	,	ConRiesgoexceso     = CASE WHEN ConRiesgoasignado - ConRiesgoocupado > 0 THEN 0 ELSE ABS(ConRiesgoasignado - ConRiesgoocupado) END
--	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


	--************************
	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	ConRiesgodisponible = ABS(ConRiesgoasignado - ConRiesgoocupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(ConRiesgoasignado - ConRiesgoocupado) > 0


	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	ConRiesgoexceso = ABS(ConRiesgoasignado - ConRiesgoocupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(ConRiesgoasignado - ConRiesgoocupado) < 0
	--************************




	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	totaldisponible	= 0 ,
		totalexceso	= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	totaldisponible = totalasignado - totalocupado
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado  > totalocupado 





	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	totalexceso 	= ( totalasignado - totalocupado  ) * -1
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	totalasignado < totalocupado 



	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	SinRiesgodisponible	= 0 ,
		SinRiesgoexceso		= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


--	UPDATE	LINEA_POR_PLAZO
--	SET	SinRiesgodisponible = CASE WHEN SinRiesgoasignado - SinRiesgoOcupado < 0 THEN 0 ELSE SinRiesgoasignado - SinRiesgoOcupado END
--	,       SinRiesgoExceso     = CASE WHEN SinRiesgoasignado - SinRiesgoOcupado > 0 THEN 0 ELSE ABS(SinRiesgoasignado - SinRiesgoOcupado) END
--	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


	--************************

	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	SinRiesgodisponible = ABS(SinRiesgoasignado - SinRiesgoOcupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(SinRiesgoasignado - SinRiesgoOcupado) > 0

	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	SinRiesgoExceso     = ABS(SinRiesgoasignado - SinRiesgoOcupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(SinRiesgoasignado - SinRiesgoOcupado) < 0

	--************************



	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	ConRiesgodisponible	= 0 ,
		ConRiesgoexceso		= 0
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


--	UPDATE	LINEA_POR_PLAZO
--	SET	ConRiesgodisponible = CASE WHEN ConRiesgoasignado - ConRiesgoocupado < 0 THEN 0 ELSE ConRiesgoasignado - ConRiesgoocupado END
--	,	ConRiesgoexceso     = CASE WHEN ConRiesgoasignado - ConRiesgoocupado > 0 THEN 0 ELSE ABS(ConRiesgoasignado - ConRiesgoocupado) END
--	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)


	--************************

	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	ConRiesgodisponible = ABS(ConRiesgoasignado - ConRiesgoocupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(ConRiesgoasignado - ConRiesgoocupado) >  0

	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	ConRiesgoexceso     = ABS(ConRiesgoasignado - ConRiesgoocupado)
	WHERE	( rut_cliente = @rut_cliente OR @rut_cliente = 0)
	AND	(ConRiesgoasignado - ConRiesgoocupado) <  0

	--************************


END

GO
