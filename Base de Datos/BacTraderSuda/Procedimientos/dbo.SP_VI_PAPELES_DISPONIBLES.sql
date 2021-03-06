USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VI_PAPELES_DISPONIBLES]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_VI_PAPELES_DISPONIBLES]	(	@TipoOper		CHAR(10)
						,	@Cadena_Familia		VARCHAR(500)
						,	@Cadena_Emisor		VARCHAR(500)
						,	@Cadena_Moneda		VARCHAR(500)
						,	@Cadena_Libro		VARCHAR(500)
						,	@Cadena_Cartera   	VARCHAR(500)
						,	@Cadena_CatSuper	VARCHAR(500)
						)
AS
BEGIN
	SET NOCOUNT ON
        DECLARE @dFechaPro   DATETIME

	SELECT  @dFechaPro   = acfecproc
	FROM    MDAC

	/*IF LTRIM(RTRIM(@TIPOOPER)) = "VP" BEGIN

		SELECT	DISTINCT A.diinstser
		,	B.cpcodigo
		FROM	MDDI	A
		,	MDCP	B
		WHERE	A.dinominal			> 0 
		AND	A.Estado_Operacion_Linea	= ''
		AND	 CHARINDEX(RTRIM(LTRIM(A.diserie))  , @Cadena_Familia) > 0  
		AND	(CHARINDEX(RTRIM(LTRIM(A.digenemi)) , @Cadena_Emisor ) > 0 OR @Cadena_Emisor = '' )
		AND	(CHARINDEX(RTRIM(LTRIM(A.dinemmon)) , @Cadena_Moneda ) > 0 OR @Cadena_Moneda = '' )
		AND	(CHARINDEX(RTRIM(LTRIM(A.id_libro)) , @Cadena_Libro ) > 0 OR @Cadena_Libro = '' ) --cass
		AND	(CHARINDEX(RTRIM(LTRIM(A.codigo_carterasuper)) , @Cod_CarteraSuper ) > 0 OR @Cod_CarteraSuper = '' ) --cass
		AND	(CHARINDEX(RTRIM(LTRIM(A.ditipcart)) , @Cod_CarteraFin ) > 0 OR @Cod_CarteraFin = '' ) --cass
		--AND	A.id_libro			= @Cod_Libro --cass
		--AND	A.codigo_carterasuper		= @Cod_CarteraSuper --cass
		--AND	A.ditipcart			= @Cod_CarteraFin --cass
		AND	cprutcart 			= dirutcart
		AND	cpnumdocu 			= dinumdocu
		AND	cpcorrela			= dicorrela
	END
	ELSE */
        
        IF LTRIM(RTRIM(@TIPOOPER)) = 'VI' BEGIN

		SELECT	DISTINCT A.diinstser	AS 'PAPEL'
		,	B.cpcodigo		AS 'CODIGO'
		INTO	#TEMPORAL
		FROM	MDDI	A
		,	MDCP	B
		WHERE	A.dinominal			> 0 
		AND	A.Estado_Operacion_Linea	= ''
		AND	(A.digenemi			<> 'BCO' OR A.diserie <> 'LCHR')
		AND	CHARINDEX(RTRIM(LTRIM(A.diserie))  ,@Cadena_Familia) > 0  
		AND	(CHARINDEX(RTRIM(LTRIM(A.digenemi)) ,@Cadena_Emisor ) > 0 OR @Cadena_Emisor = '' )
		AND	(CHARINDEX(RTRIM(LTRIM(A.dinemmon)) ,@Cadena_Moneda ) > 0 OR @Cadena_Moneda = '' )
		AND	(CHARINDEX(RTRIM(LTRIM(A.id_libro)) , @Cadena_Libro ) > 0 OR @Cadena_Libro = '' ) --cass
		AND	(CHARINDEX(RTRIM(LTRIM(A.codigo_carterasuper)) , @Cadena_CatSuper ) > 0 OR @Cadena_CatSuper = '' ) --cass
		AND	(CHARINDEX(RTRIM(LTRIM(A.ditipcart)) , @Cadena_Cartera ) > 0 OR @Cadena_Cartera = '' ) --cass
		AND	cprutcart 			= A.dirutcart
		AND	cpnumdocu 			= A.dinumdocu
		AND	cpcorrela			= A.dicorrela
		and     A.Fecha_PagoMañana 		<= @dFechaPro	

	
		INSERT INTO #TEMPORAL
		SELECT	A.diinstser
		,	B.cicodigo
		FROM	MDDI	A
		,	MDCI	B
		WHERE	charindex(rtrim(ltrim(a.diserie)),@Cadena_Familia) > 0
		AND	A.dinominal			> 0 
		AND	A.Estado_Operacion_Linea	= '' 
		AND	(A.digenemi			<> 'BCO' OR A.diserie <> 'LCHR')
		AND	CHARINDEX(RTRIM(LTRIM(A.diserie))  ,@Cadena_Familia) > 0  
		AND	(CHARINDEX(RTRIM(LTRIM(A.digenemi)) ,@Cadena_Emisor ) > 0 OR @Cadena_Emisor = '' )
		AND	(CHARINDEX(RTRIM(LTRIM(A.dinemmon)) ,@Cadena_Moneda ) > 0 OR @Cadena_Moneda = '' )
		AND	(CHARINDEX(RTRIM(LTRIM(A.id_libro)) , @Cadena_Libro ) > 0 OR @Cadena_Libro = '' ) --cass
		AND	(CHARINDEX(RTRIM(LTRIM(A.codigo_carterasuper)) , @Cadena_CatSuper ) > 0 OR @Cadena_CatSuper = '' ) --cass
		AND	(CHARINDEX(RTRIM(LTRIM(A.ditipcart)) , @Cadena_Cartera ) > 0 OR @Cadena_Cartera = '' ) --cass
		AND	B.cirutcart 			= A.dirutcart
		AND	B.cinumdocu 			= A.dinumdocu
		AND	B.cicorrela			= A.dicorrela
		AND	NOT EXISTS(SELECT 1 FROM #TEMPORAL C WHERE C.PAPEL = A.diinstser AND C.CODIGO = B.cicodigo)
				
		SELECT * FROM #TEMPORAL

	END

	SET NOCOUNT OFF

END


GO
