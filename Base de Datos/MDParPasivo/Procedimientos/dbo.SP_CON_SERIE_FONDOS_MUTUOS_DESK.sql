USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SERIE_FONDOS_MUTUOS_DESK]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_SERIE_FONDOS_MUTUOS_DESK]
	(
		@Serie CHAR(12),
		@Fecha CHAR(8)
	)
AS
BEGIN
        SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        SET DATEFORMAT dmy

	DECLARE @iCodigo_Error	VARCHAR(06)
	,	@cDescripcion	VARCHAR(255)

	SET @iCodigo_Error = ''

	SELECT  C.NumPro_PU 					AS Numero_Cliente
	,	M.mncodmon					AS Codigo_Moneda
	,	M.mnnemo					AS Nemotecnico_Moneda
	,	M.mnglosa					AS Descripcion_Moneda
	,	M.mnbase					AS Base
	,	F.Descripcion					AS Descripcion_Fondo_Mutuo
	,	ROUND(isnull(MV.valor,0),4) 			AS Valor_Cuota_Fondo_Mutuo
	,	M.mnextranj					AS Extranjera
	,	M.mnredondeo					AS Decimales
	,	CONVERT(NUMERIC(19,4),0)			AS patrimonio
	INTO	#TMP1
	FROM 	FMUTUO_SERIE F WITH (NOLOCK INDEX = PK_FMUTUO_SERIE),
		FMUTUO_VALOR MV WITH (NOLOCK INDEX = PK_FMUTUO_VALOR),
		CLIENTE	     C WITH (NOLOCK INDEX = PK_CLIENTE),
		MONEDA	     M WITH (NOLOCK INDEX = PK_MONEDA)
	WHERE
		F.Serie		=     @Serie    	AND
		MV.serie	=*    F.Serie		AND
		MV.Fecha	=     @fecha		AND
		C.clrut		=     F.rut_cliente	AND
		C.clcodigo	=     F.codigo_cliente	AND
		M.mncodmon	=     F.codigo_moneda	


	UPDATE #TMP1
	SET	patrimonio	= p.patrimonio
	FROM	FMUTUO_PATRIMONIO 	P,
		FMUTUO_SERIE		S
	WHERE	P.rut_cliente		=     s.rut_cliente
	AND	P.codigo_cliente	=     s.codigo_cliente
	AND	s.Serie			=     @Serie

	IF NOT EXISTS(SELECT * FROM #TMP1)
		SELECT @iCodigo_Error = '0000-1',
		       @cDescripcion  = 'No se pudo encontrar la serie.'
	ELSE IF (SELECT Valor_Cuota_Fondo_Mutuo FROM #TMP1) = 0
		SELECT @iCodigo_Error = '0000-2',
		       @cDescripcion  = 'No existe valor cuota para la serie ingresada.'

	IF @iCodigo_Error = ''
		SELECT  codigo = '000000'
		,	Numero_Cliente
		,	Codigo_Moneda
		,	Nemotecnico_Moneda
		,	Descripcion_Moneda
		,	Base
		,	Descripcion_Fondo_Mutuo
		,	Valor_Cuota_Fondo_Mutuo
		,	Extranjera
		,	Decimales
		,	patrimonio
		FROM #TMP1
	ELSE
		SELECT codigo 	   = @iCodigo_Error
		,      descripcion = @cDescripcion


END


-- select * from CLIENTE
-- select * from FMUTUO_PATRIMONIO
-- @Serie
-- SP_CON_SERIE_FONDOS_MUTUOS_DESK 'fmchilecorp','20041230'

GO
