USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_TasamConvencional_Buscar]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_TasamConvencional_Buscar]
			(
			@cod_mon	NUMERIC(05)
			)
AS
BEGIN
SET NOCOUNT ON
	SELECT	'codigo_moneda' = codigo_moneda		,
		'diasdesde'	= diasdesde		,
		'diashasta'	= diashasta		,
		'montominimo'	= montominimo		,
		'montomaximo'	= montomaximo		,
		'tasa'		= tasa			,
		'des_moneda'	= (SELECT mnglosa FROM moneda WHERE mncodmon = codigo_moneda),
		'hora'	= CONVERT(CHAR,GETDATE(),108)
	INTO  #Tempo_Tasa_Maxima
	FROM  tasas_maximas_convencional
	WHERE ((codigo_moneda	= @cod_mon)	OR
	       (@cod_mon	= 0	))

	SELECT * FROM #Tempo_Tasa_Maxima
SET NOCOUNT OFF
END
GO
