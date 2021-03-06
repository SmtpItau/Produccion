USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_COMUNA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MOSTRAR_COMUNA]	(	@Codigo_CIUDAD	CHAR(05)	= '-999'
					,	@Codigo_Comuna	CHAR(05)	= '-999'
					)
AS
BEGIN 
	IF @Codigo_CIUDAD = '' begin
		SELECT @Codigo_CIUDAD = '-999'
	END
	
	IF @Codigo_CIUDAD = '' AND @Codigo_Comuna = '' BEGIN
		SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA ORDER BY nombre 
        END
	ELSE BEGIN
		SELECT	codigo_comuna
		,	codigo_ciudad
		,	nombre 
		FROM	COMUNA 
		WHERE	(Codigo_CIUDAD = CONVERT(NUMERIC(5),@Codigo_CIUDAD)	OR @Codigo_CIUDAD = '-999')
		AND	(Codigo_Comuna = CONVERT(NUMERIC(5),@Codigo_Comuna)	OR @Codigo_Comuna  = '-999') 
		ORDER BY nombre
	END
END
GO
