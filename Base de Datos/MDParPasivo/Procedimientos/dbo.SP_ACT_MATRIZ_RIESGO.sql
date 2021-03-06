USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_MATRIZ_RIESGO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACT_MATRIZ_RIESGO]
					(	@id_sistema		CHAR(3)
					,	@cod_producto		CHAR(5)
					,	@cod_instrumento	NUMERIC(5) = 0
					,	@codigo_moneda		NUMERIC(10)
					,	@codigo_moneda2		NUMERIC(10)
					,	@plazo_grupo_desde	NUMERIC(10)
					,	@plazo_grupo_hasta	NUMERIC(10)
					,	@plazo_desde		NUMERIC(10)
					,	@plazo_hasta		NUMERIC(10)
					,	@porcen			FLOAT
					)
AS
BEGIN
	SET NOCOUNT ON
	SET DATEFORMAT dmy
	
	INSERT INTO MATRIZ_RIESGO
	(	id_sistema
	,	codigo_producto
	,	codigo_instrumento
	,	dias_grupo_desde
	,	dias_grupo_hasta
	,	dias_desde
	,	dias_hasta
	,	porcentaje                                            
	,	codigo_moneda
	,	codigo_moneda2
	)
	VALUES
	(	@id_sistema
	,	@cod_producto
	,	@cod_instrumento
	,	@plazo_grupo_desde
	,	@plazo_grupo_hasta
	,	@plazo_desde
	,	@plazo_hasta
	,	@porcen
	,	@codigo_moneda
	,	@codigo_moneda2
	)	
	
	SET NOCOUNT OFF
END


GO
