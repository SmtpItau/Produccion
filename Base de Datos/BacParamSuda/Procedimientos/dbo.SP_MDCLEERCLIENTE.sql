USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLEERCLIENTE]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_MDCLEERCLIENTE]
	(	@xMercado     CHAR(4) =  ''
	,   @RutCliente   NUMERIC(9) = 0
	,   @CodCliente   SMALLINT   = 0
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @xMercado = 'PTAS' OR @xMercado ='ARBI'
    BEGIN
		SELECT	clrut
			,	cldv
			,	clcodigo
			,	clnombre	= rtrim(ltrim(clnombre))
		FROM	BacParamSuda.dbo.CLIENTE	with(nolock)
		WHERE	(	clrut      = @RutCliente or @RutCliente = 0	)
		AND		(	clcodigo   = @CodCliente or @CodCliente = 0	)
		AND		(	clvigente  = 'S'	)
		AND		(	cltipcli  <= 4		)
		AND		(	bloqueado <> 'S'	)
		ORDER 
		BY		ltrim(rtrim( clnombre ))
	END

	--***************************************************************************** 
	IF @xMercado = 'EMPR' 
	BEGIN 
		SELECT	clrut
			,	cldv
			,	clcodigo
			,	clnombre = rtrim(ltrim(clnombre))
		FROM	BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE	(	clrut        = @RutCliente or @RutCliente = 0	)
		AND		(	clcodigo     = @CodCliente or @CodCliente = 0	)
		AND		(	clvigente	 = 'S'	) 
		AND		(	Bloqueado	<> 'S'	)
		AND		(	cltipcli	>= 4 
				OR	clgeneric	IN('BCCH', 'CORPB') 
				) 
		ORDER 
		BY		ltrim(rtrim( clnombre ))
	END


	--***************************************************************************** 
/*
	IF @xMercado = ''
	BEGIN
		--		SELECCION DE CLIENTES EN PRODUCCION	--

		SELECT	clrut
			,	cldv
			,	clcodigo
			,	clnombre
			,	clgeneric
			,	cldirecc
			,	clcomuna
			,	clregion
			,	cltipcli
			,	CONVERT( CHAR(10), clfecingr, 103 )
			,	clctacte
			,	clfono
			,	clfax
			,	0
			,	clcalidadjuridica
			,	clciudad
			,	clentidad
			,	clmercado
			,	clgrupo
			,	clapoderado
			,	fecha_escritura
			,	nombre_notaria
			,	clFechaFirma_cond
		FROM	BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE	clvigente	= 'S'
		ORDER
		BY		clnombre
	END
*/

	IF @xMercado = ''
	BEGIN
		--		SELECCION DE CLIENTES PROPUESTO	--
		SELECT	clrut
			,	cldv
			,	clcodigo
			,	clnombre
			,	clgeneric
			,	cldirecc
			,	clcomuna
			,	clregion
			,	cltipcli
			,	CONVERT( CHAR(10), clfecingr, 103 )
			,	clctacte
			,	clfono
			,	clfax
			,	0
			,	clcalidadjuridica
			,	clciudad
			,	clentidad
			,	clmercado
			,	clgrupo
			,	clapoderado
			,	fecha_escritura
			,	nombre_notaria
			,	clFechaFirma_cond
		FROM	BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE	clvigente			= 'S'			--	Filtro Vigente
		AND		Bloqueado			IN('N', '')		--	Filtro Nuevo
		AND		cltipcli			<> 8
			union all
		SELECT	clrut
			,	cldv
			,	clcodigo
			,	clnombre
			,	clgeneric
			,	cldirecc
			,	clcomuna
			,	clregion
			,	cltipcli
			,	CONVERT( CHAR(10), clfecingr, 103 )
			,	clctacte
			,	clfono
			,	clfax
			,	0
			,	clcalidadjuridica
			,	clciudad
			,	clentidad
			,	clmercado
			,	clgrupo
			,	clapoderado
			,	fecha_escritura
			,	nombre_notaria
			,	clFechaFirma_cond
		FROM	BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE	clvigente			= 'S'			--	Filtro Vigente
		AND		Bloqueado			IN('N', '')		--	Filtro Nuevo
		AND		cltipcli			= 8
		AND	(
					( CLCONDICIONESGENERALES	= 'S' or CLFECHAFIRMA_COND		<> '1900-01-01 00:00:00.000' )
				OR	( NUEVO_CCG_FIRMADO			= 'S' or FECHA_FIRMA_NUEVO_CCG	<> '1900-01-01 00:00:00.000' )
				)
		--		SELECCION DE CLIENTES PROPUESTO	--
	END

END


GO
