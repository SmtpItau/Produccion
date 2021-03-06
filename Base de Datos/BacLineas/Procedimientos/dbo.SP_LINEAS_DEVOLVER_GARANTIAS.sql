USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_DEVOLVER_GARANTIAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_DEVOLVER_GARANTIAS]
   (   @dFecPro  	 DATETIME
   ,   @nRutEmi 	 NUMERIC(09,0)
   ,   @dFeciniop 	 DATETIME
   ,   @nMonto   	 NUMERIC(19,4)
   ,   @dFecvctop 	 DATETIME
   ,   @incodigo	 NUMERIC(5)
   ,   @salida VARCHAR(100) OUTPUT
   )
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @dFechaDOContable     DATETIME
	DECLARE @rut_banco		NUMERIC(9)
	SELECT @dFechaDOContable = acfecante FROM BacTraderSuda.dbo.MDAC with(nolock)
	SELECT @rut_banco = rcrut FROM BacParamSuda.dbo.ENTIDAD with(nolock)

	DECLARE @cNombre            	CHAR(60)
	DECLARE @nCorrDet		INTEGER
	DECLARE @cMensaje		VARCHAR(255)
	DECLARE @cError		   	VARCHAR(1)
	DECLARE @iFound		   	INTEGER
	DECLARE @cCtrlplazo		CHAR(01)
	DECLARE @nMontolin		NUMERIC(19,4)
	DECLARE @nmontolin_pesos	NUMERIC(19,0)
	DECLARE @nPlazoDesde		NUMERIC(10,0)
	DECLARE @nPlazoHasta		NUMERIC(10,0)
	DECLARE @nMontoLinGen	   	NUMERIC(19,4)
	DECLARE @nMontoLinSis	   	NUMERIC(19,4)
	DECLARE @nMontoLinPro	   	NUMERIC(19,4)
	DECLARE @nParidadMon		NUMERIC(10,4)
	DECLARE @nMoneda		NUMERIC(05,0)
	DECLARE @iMonedaPorPlazo    	INTEGER
	DECLARE	@SaltarEmisor		CHAR(1)
	DECLARE @nCodigo 	 	NUMERIC(9)
	DECLARE	@fTipcambio 	 	NUMERIC(08,4)

	SET @nCodigo 		= 0
	SET @cMensaje           = ''
	SET @fTipcambio 	= 0
	
	IF @nRutEmi = 97029000 OR @nRutEmi = @rut_banco
		SET @SaltarEmisor = 'S'
	ELSE
		SET @SaltarEmisor = 'N'

	IF @nCodigo = 0
		SELECT 	@cNombre = clnombre
		,     	@nCodigo = clcodigo
		FROM   BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE  clrut    = @nRutEmi
	ELSE
		SELECT @cNombre = clnombre
		FROM   BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE  clrut    = @nRutEmi
		AND    clcodigo = @nCodigo

	IF @SaltarEmisor = 'S'
	BEGIN
		SELECT @salida = 'NO, Emisor ' + @cNombre + ' no tiene línea.'
		RETURN 
	END

	SET @nCorrDet  = 0  

	IF @fTipcambio = 0 
		SET @fTipcambio = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = 994), 1)
		
	SET @fTipcambio = (SELECT ISNULL(Tipo_Cambio, 1) FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) WHERE Fecha = @dFechaDOContable AND Codigo_Moneda = 994)

	SET @nmontolin_pesos = @nMonto
	SET @nMontolin       = @nMonto
	---------------------------------- Conversion A Monedas -------------------------------------
	UPDATE LINEA_GENERAL SET moneda = '999' WHERE moneda = ''
	UPDATE LINEA_SISTEMA SET moneda = '999' WHERE moneda = ''

    ----- Monto en Moneda para Linea General -----
	SELECT @nMoneda       = CONVERT(NUMERIC(3),RTRIM(LTRIM(moneda)))
	FROM   LINEA_GENERAL with(nolock)
	WHERE  rut_cliente    	= @nRutEmi 	
	AND    codigo_cliente 	= @nCodigo
	SET @nParidadMon      	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)
	SET @nMontoLinGen 		= @nmontolin_pesos / @nParidadMon

   ----- Monto en Moneda para Linea Sistema -----

	SELECT @nMoneda        = CONVERT(NUMERIC(05),RTRIM(LTRIM(moneda)))
	FROM   LINEA_SISTEMA with(nolock)
	WHERE  rut_cliente     = @nRutEmi	
	AND    codigo_cliente  = @nCodigo	
	AND    id_sistema      = 'BTR'

	SET @iMonedaPorPlazo   	= @nMoneda
	SET @nParidadMon       	= ISNULL(( SELECT vmvalor FROM VIEW_VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda),1)
	SET @nMontoLinSis 	= @nmontolin_pesos / @nParidadMon

	----- Monto en Moneda para Linea Producto ----- 
	DECLARE @nPlazoProdPla   NUMERIC(9)
	SET @nPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)

	EXECUTE dbo.SP_VALIDA_LINPRODUCTO_PLAZO @nRutEmi, @nCodigo, 'BTR', 'CP', @incodigo, @nPlazoProdPla

	SELECT	@nMoneda        = mncodmon
	FROM   	LINEA_PRODUCTO_POR_PLAZO with(nolock)
	WHERE  	rut_cliente	= @nRutEmi				
	AND    	codigo_cliente  = @nCodigo				
	AND    	id_sistema	= 'BTR'				
	AND    	codigo_producto	= 'CP'
	AND   	incodigo	= @incodigo
	AND    	plazodesde 	<= @nPlazoProdPla
	AND    	plazohasta  	>= @nPlazoProdPla
               
	SET @nMoneda        = @iMonedaPorPlazo
	SET @nParidadMon    = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WITH(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda),1)

	SET @nMontoLinPro = @nmontolin_pesos / @nParidadMon

	IF @nMoneda = 13
		SET @nMontoLinGen = @nmontolin_pesos / @fTipcambio
  
	----- Monto en Moneda para Linea Producto ----- 
	SET @iFound  = 0
	SELECT @iFound		= 1   
	FROM   	LINEA_GENERAL WITH(nolock)
	WHERE  	rut_cliente   = @nRutEmi	
	AND	codigo_cliente= @nCodigo
    
	IF @iFound = 1 
	BEGIN
		  --*************** DEVOLVER EN LINEA GENERAL
	
		UPDATE LINEA_GENERAL
		SET    	totalocupado    = totalocupado    - @nMontoLinGen,
			totaldisponible = totaldisponible + @nMontoLinGen
		WHERE  rut_cliente     = @nRutEmi
		AND    codigo_cliente  = @nCodigo

		SET @nCorrDet = @nCorrDet + 1

			  --***************DEVOLVER EN LINEA SISTEMA

		UPDATE LINEA_SISTEMA
		SET    totalocupado    = totalocupado    - @nMontoLinSis
		,      totaldisponible = totaldisponible + @nMontoLinSis  
		WHERE  rut_cliente     = @nRutEmi	
		AND    codigo_cliente  = @nCodigo	
		AND    id_sistema      = 'BTR'

		SET @nCorrDet = @nCorrDet + 1

		--***************DEVOLVER EN LINEA POR PRODUCTO PLAZO

		SET @incodigo 	= @incodigo

		DECLARE @nnPlazoProdPla   NUMERIC(9)
		SET @nnPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)

		EXECUTE dbo.SP_VALIDA_LINPRODUCTO_PLAZO @nRutEmi, @nCodigo, 'BTR', 'CP', @incodigo, @nnPlazoProdPla

		SET ROWCOUNT 1
		SELECT @nPlazoDesde    = ISNULL(PlazoDesde,0)		,      @nPlazoHasta    = ISNULL(PlazoHasta,0)

		FROM   LINEA_PRODUCTO_POR_PLAZO WITH(nolock)
		WHERE  rut_cliente	= @nRutEmi
		AND    codigo_cliente	= @nCodigo
		AND    id_sistema	= 'BTR'
		AND    codigo_producto 	= 'CP'
		AND    incodigo		= @incodigo
		AND    plazodesde     	<= @nnPlazoProdPla
		AND    plazohasta     	>= @nnPlazoProdPla

		SET ROWCOUNT 0

		IF @nplazodesde = NULL
		BEGIN
			EXECUTE Sp_Lineas_Actualiza
			SELECT @salida = 'OK'
			RETURN
		END

		IF @nplazohasta = NULL
		BEGIN
			EXECUTE Sp_Lineas_Actualiza
			SELECT @salida = 'OK'
			RETURN
		END

		UPDATE  LINEA_PRODUCTO_POR_PLAZO
		SET	totalocupado 	 = totalocupado    - @nMontoLinSis
			,totaldisponible = totaldisponible + @nMontoLinSis
		WHERE   rut_cliente 	= @nRutEmi				
		AND     codigo_cliente	= @nCodigo				
		AND     id_sistema	= 'BTR'				
		AND     codigo_producto = 'CP'				
		AND     incodigo	= @incodigo
		AND     plazodesde 	= @nPlazoDesde
		AND     plazohasta      = @nPlazoHasta

		SET @nCorrDet  = @nCorrDet + 1
		EXECUTE Sp_Lineas_Actualiza
		SELECT @salida = 'OK'
	END 
	ELSE
	BEGIN
		SELECT @salida = 'NO, EMISOR SIN LINEA GENERAL' + CONVERT(VARCHAR(10), @nRutEmi) +'  '+@cNombre
		RETURN
   	END
	SET NOCOUNT OFF
END

GO
