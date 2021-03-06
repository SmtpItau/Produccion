USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_actualiza_margenes]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_actualiza_margenes]
			(
			@cSistema		CHAR	(03)	,
			@cCodigo_grupo		CHAR	(10)	,
			@nInCodigo		NUMERIC	(05)	,
			@nMoneda_Emision	NUMERIC	(03)	,
			@nRut_emisor		NUMERIC	(10)	,
			@nMonto			FLOAT		,
			@seriado		CHAR	(01)	,
			@plazo			INTEGER
			)

AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

         IF EXISTS(SELECT 1 FROM PRODUCTO_CONTROL WHERE codigo_control  = 'MAINV'	AND
							estado		= 'S'		AND
							Codigo_grupo	= @cCodigo_grupo) BEGIN
		UPDATE	MARGEN_INVERSION_INSTRUMENTO
		SET	TotalOcupado	= TotalOcupado 	  + @nMonto,
			TotalDisponible	= TotalDisponible - @nMonto
		WHERE	id_sistema	= @cSistema
		AND	instrumento	= @nInCodigo
		AND	codigo_moneda	= @nMoneda_Emision
--		AND	rut_emisor	= @nRut_emisor

         END

SET NOCOUNT OFF
END

GO
