USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Inicia_Lineas]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Lineas_Inicia_Lineas]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	UPDATE	LINEA_GENERAL
		SET	TotalOcupado		= 0,
			TotalTraspaso		= 0,
			TotalRecibido		= 0

	UPDATE	LINEA_SISTEMA
		SET	TotalOcupado		= 0,
			TotalTraspaso		= 0,
			TotalRecibido		= 0,
			SinRiesgoOcupado	= 0,
			ConRiesgoOcupado	= 0

	UPDATE	LINEA_POR_PLAZO
		SET	TotalOcupado		= 0,
			TotalTraspaso		= 0,
			TotalRecibido		= 0,
			ConRiesgoOcupadO	= 0,
			SinRiesgoOcupado	= 0

	UPDATE	LINEA_AFILIADO
		SET	TotalOcupado		= 0,
			SinRiesgoOcupado	= 0,
			ConRiesgoOcupado	= 0

	UPDATE MARGEN_INVERSION_GLOBAL
		SET   totalocupado		= 0	

	UPDATE MARGEN_INVERSION_INSTRUMENTO
		SET   totalocupado		= 0


	EXECUTE SP_LINEAS_ACTUALIZA

SET NOCOUNT OFF
END



GO
