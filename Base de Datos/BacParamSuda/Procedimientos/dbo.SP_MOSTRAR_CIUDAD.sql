USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_CIUDAD]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MOSTRAR_CIUDAD]	(	@Codigo_Region		CHAR(5)	= '-999'
					,	@Codigo_Ciuidad		CHAR(5) = ''
					)
AS
BEGIN
	IF @Codigo_Region = '' BEGIN
		SELECT	codigo_ciudad
		,	codigo_region
		,	nombre 
		FROM	CIUDAD 
		ORDER
		BY	nombre
        END
	ELSE BEGIN
		SELECT	codigo_ciudad
		,	codigo_region
		,	nombre 
		FROM	CIUDAD 
		WHERE	(codigo_region	= CONVERT(NUMERIC(5),@Codigo_Region)	OR @Codigo_Region	= '-999')
		AND	(Codigo_Ciudad	= CONVERT(NUMERIC(5),@Codigo_Ciuidad)	OR @Codigo_Ciuidad	= '')
		ORDER 
		BY	nombre
        END
END
GO
