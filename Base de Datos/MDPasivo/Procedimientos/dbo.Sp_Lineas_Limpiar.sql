USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Limpiar]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Lineas_Limpiar]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	UPDATE	INVERSION_EXTERIOR
	SET	ArbSpo_Disponible	= ArbSpo_Total	,
		ArbSpo_Ocupado		= 0		,
		ArbSpo_Exceso		= 0		,
		ArbFwd_Disponible	= ArbFwd_Total	,
		ArbFwd_Ocupado		= 0		,
		ArbFwd_Exceso		= 0		,
		InvExt_Disponible	= InvExt_Total	,
		InvExt_Ocupado		= 0		,
		ArbExt_Exceso		= 0


	UPDATE	RIESGO_PAIS
	SET	totaldisponible = totalasignado	,
		totalocupado	= 0		,
		totalexceso	= 0

	UPDATE	MARGEN_INVERSION_GLOBAL
	SET	totaldisponible = totalasignado	,
		totalocupado	= 0		,
		totalexceso	= 0

	UPDATE	MARGEN_INVERSION_INSTRUMENTO
	SET	totaldisponible = totalasignado	,
		totalocupado	= 0		,
		totalexceso	= 0

	UPDATE	LINEA_GENERAL
	SET	totaldisponible = totalasignado	,
		totalocupado	= 0		,
		totalexceso	= 0		,
		totaltraspaso	= 0		,
		totalrecibido	= 0		

	UPDATE	LINEA_SISTEMA
	SET	totaldisponible = totalasignado	,
		totalocupado	= 0		,
		totalexceso	= 0		,
		totaltraspaso	= 0		,
		totalrecibido	= 0		

	UPDATE 	LINEA_POR_PLAZO
	SET	totaldisponible = totalasignado	,
		totalocupado	= 0		,
		totalexceso	= 0		,
		totaltraspaso	= 0		,
		totalrecibido	= 0		


	UPDATE 	LINEA_AFILIADO
	SET	TotalDisponible 	= TotalAsignado		,
		TotalOcupado		= 0			,
		TotalExceso		= 0			,
		SinRiesgoDisponible 	= SinRiesgoAsignado	,
		SinRiesgoOcupado	= 0			,
		SinRiesgoExceso		= 0			,
		ConRiesgoDisponible 	= ConRiesgoAsignado	,
		ConRiesgoOcupado	= 0			,
		ConRiesgoExceso       	= 0


	DELETE 	LINEA_TRANSACCION_DETALLE
	DELETE 	LINEA_TRASPASO
	DELETE	LINEA_TRANSACCION

	DELETE	LIMITE_TRANSACCION
	DELETE	LIMITE_TRANSACCION_ERROR



	SET NOCOUNT OFF

END






GO
