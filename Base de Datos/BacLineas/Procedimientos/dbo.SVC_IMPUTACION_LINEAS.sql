USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SVC_IMPUTACION_LINEAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                     
CREATE PROCEDURE [dbo].[SVC_IMPUTACION_LINEAS]
	(   @dFecPro			DATETIME    
	,   @cSistema			CHAR(03)    
	,   @cProducto			CHAR(05)    
	,   @nRutcli			NUMERIC(09,0)    
	,   @nCodigo			NUMERIC(09,0)    
	,   @nNumoper			NUMERIC(10,0)    
	,   @nNumdocu			NUMERIC(10,0)    
	,   @nCorrela			NUMERIC(10,0)    
	,   @dFeciniop			DATETIME    
	,   @nMonto				NUMERIC(19,4)    
	,   @fTipcambio			NUMERIC(08,4)    
	,   @dFecvctop			DATETIME    
	,   @cUsuario			CHAR(10)    
	,   @cMonedaOp			NUMERIC(05,00)    
	,   @cTipo_Riesgo		CHAR(1)    
	,   @incodigo			NUMERIC(5)    
	,   @formapago			NUMERIC(3)    
	,   @nContraMoneda		NUMERIC(03)		= 0
	,   @nMonedaOpera		NUMERIC(03)		= 0
--	,   @SwithEjecucion		INTEGER
	,   @SW					INT
	,   @Resultado			FLOAT			= 0		-- PRD8800
	,   @MetodoLCR			NUMERIC(5)		= 1		-- PRD8800
	,   @Garantia			FLOAT			= 0		-- PRD8800
	,	@Avr				FLOAT			= 0.0	--> Desde Vb viene en Cero
	)
AS    
BEGIN    
    
	SET NOCOUNT ON

	DECLARE @RUTPADRE		AS NUMERIC(10)    
	DECLARE @MONTOPADRE		AS NUMERIC(10)    
	DECLARE @SOBREMONTO		AS INT;		SET @SOBREMONTO = 0    
    
    -->+++CONTROL IDD, jcamposd solo debe grabar no existe logica por cliente

	SET @SW = 1 
	   
	    
    EXECUTE SP_LINEAS_GRABAR	@dFecPro
							,	@cSistema
							,	@cProducto
							,	@nRutcli
							,	@nCodigo
							,	@nNumoper
							,	@nNumdocu
							,	@nCorrela
							,	@dFeciniop
							,	@nMonto
							,	@fTipcambio
							,	@dFecvctop
							,	@cUsuario
							,	@cMonedaOp
							,	@cTipo_Riesgo
							,	@incodigo
							,	@formapago
							,	@nContraMoneda
							,	@nMonedaOpera
							,	@SW
							,	@SOBREMONTO
							,	@Resultado      -- PRD8800
							,	@MetodoLCR      -- PRD8800
							,	@Garantia		-- PRD8800
							,	@Avr			--> 
    
    -->---CONTROL IDD, jcamposd solo debe grabar no existe logica por cliente
	--jcamposd INICIO logica del procedimiento se comenta desde esta linea hasta el final
    
    
	------>     Setea variable para determinar si es hijo
	----DECLARE @ImputaHijo		INT	;		SET @ImputaHijo	= -1
	------>     Variable para determinar existencia
	----DECLARE @ifound			INT	;		SET @ifound		= -1
	------>     Variable contador de registros    
	----DECLARE @iContador		INT	;		SET @iContador	= 1
	------>     Variable para detrminar cantidad de execute el sp lineas Grabar    
	----DECLARE @iVueltas		INT	;		SET @iVueltas	= 1    

	------>     Determina la existencia en relaciones
 ----   SELECT	@ifound			= 1
	----	,	@ImputaHijo		= Afecta_Lineas_Hijo
	------>     Determina que recorrera 1 o 2 veces    
	----	,	@iVueltas		= CASE WHEN Afecta_Lineas_Hijo = 1 THEN 2 ELSE 1 END
	------>		Determina si NO esta marcado impute al padre.    
	----	,	@nRutcli		= CASE WHEN Afecta_Lineas_Hijo = 0 THEN clrut_padre		ELSE @nRutcli	END
	----	,	@nCodigo		= CASE WHEN Afecta_Lineas_Hijo = 0 THEN clcodigo_padre	ELSE @nCodigo	END
	----FROM	CLIENTE_RELACIONADO    
	----WHERE	clrut_hijo		= @nRutcli    
	----AND		clcodigo_hijo	= @nCodigo    

	----/*
	------>     Determina que recorrera 1 o 2 veces    
	----IF @ImputaHijo = 1     
 ----     SET @iVueltas = 2    
	----*/
	----/*
	------>  Determina si NO esta marcado impute al padre.    
	----IF @ImputaHijo = 0    
	----BEGIN    
	----	SELECT @nRutcli      = clrut_padre    
 ----       ,      @nCodigo      = clcodigo_padre    
 ----       FROM   CLIENTE_RELACIONADO    
 ----       WHERE  clrut_hijo    = @nRutcli    
	----	AND    clcodigo_hijo = @nCodigo    
	----END
	----*/
    
	------>     Grabara registro en Linea transaccion    
	----SET @SW = 1    
	--------------------->    
    
	------>     lee el monto asignado al Padre del Grupo.    
	----DECLARE @iMontoGeneralPadre   FLOAT    
	----	SET @iMontoGeneralPadre   = isnull((	SELECT TOP 1 TotalAsignado     
	----											FROM	BacLineas.dbo.LINEA_GENERAL lg /*with(nolock)*/
	----													inner join (SELECT TOP 1 clrut_padre as nRutPadre, clcodigo_padre as nCodPadre    
	----																FROM	BacLineas.dbo.CLIENTE_RELACIONADO /*with(nolock)*/
	----																WHERE	clrut_hijo = @nRutcli 
	----															   ) grp ON grp.nRutPadre = lg.rut_cliente 
	----																    and grp.nCodPadre = lg.Codigo_Cliente 
	----									   ), 0.0)

 ----  -->     lee la sumatoria de los montos ocupados por cada uno de sus hijos.
	----DECLARE @iSumMontosHijo       FLOAT    
	----	SET @iSumMontosHijo       = isnull((	SELECT	SUM( TotalOcupado )    
	----											FROM	BacLineas.dbo.CLIENTE_RELACIONADO      rc /*with(nolock)*/
	----													inner join BacLineas.dbo.LINEA_GENERAL lg /*with(nolock)*/	ON	rc.clrut_hijo		= lg.rut_cliente
	----																											and rc.clcodigo_hijo	= lg.codigo_cliente
	----											WHERE	clrut_hijo = @nRutcli 
	----									   ), 0.0)

	----SET @SOBREMONTO = 0    
	------>    comparacion de ocupado vs el asignado    

	----IF NOT @iMontoGeneralPadre > @iSumMontosHijo    
	----BEGIN
	----	SET @SOBREMONTO = 1    
	----END

	------>	Ciclo de ejecucion
	----WHILE ( @iContador <= @iVueltas )
	----BEGIN    
   
	----	/* Se chequea antes igual 13676 */  
	----	EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES	@cSistema
	----											,	@dFecPro
	----											,	@nRutcli
	----											,	@nCodigo
	----											,	@dFecvctop
	----											,	@nMonto
	----											,	@cTipo_Riesgo
	----											,	@cProducto
	----											,	@incodigo
	----											,	@cMonedaOp
	----											,	@formapago
	----											,	@MetodoLCR   -- PRD8800

	----	/* Se chequea antes reposicionamiento 13676 */
 ---- 		EXECUTE SP_LINEAS_GRABAR					@dFecPro
	----											,	@cSistema
	----											,	@cProducto
	----											,	@nRutcli
	----											,	@nCodigo
	----											,	@nNumoper
	----											,	@nNumdocu
	----											,	@nCorrela
	----											,	@dFeciniop
	----											,	@nMonto
	----											,	@fTipcambio
	----											,	@dFecvctop
	----											,	@cUsuario
	----											,	@cMonedaOp
	----											,	@cTipo_Riesgo
	----											,	@incodigo
	----											,	@formapago
	----											,	@nContraMoneda
	----											,	@nMonedaOpera
	----											,	@SW
	----											,	@SOBREMONTO
	----											,	@Resultado      -- PRD8800
	----											,	@MetodoLCR      -- PRD8800
	----											,	@Garantia		-- PRD8800
	----											,	@Avr			--> 

	----	SET @iContador = @iContador + 1

	----	IF @ifound = 1 AND @iContador = 2    
	----	BEGIN
	----		SELECT @nRutcli      = clrut_padre    
	----		,      @nCodigo      = clcodigo_padre    
	----		FROM   CLIENTE_RELACIONADO    
	----		WHERE  clrut_hijo    = @nRutcli    
	----		AND    clcodigo_hijo = @nCodigo    

	----		EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES	@cSistema
	----												,	@dFecPro
	----												,	@nRutcli
	----												,	@nCodigo
	----												,	@dFecvctop
	----												,	@nMonto
	----												,	@cTipo_Riesgo
	----												,	@cProducto
	----												,	@incodigo
	----												,	@cMonedaOp
	----												,	@formapago
	----												,	@MetodoLCR   -- PRD8800  
	----		SET	@SW = 0
	----	END
	----END		-->	Ciclo de ejecucion

	-----jcamposd FIN logica del procedimiento se comenta 

--	-->		Producto Habilitado para Comder
--	DECLARE @iFoundComder		INT
--		SET @iFoundComder		= 0
--		SET @SOBREMONTO			= 0

--	SELECT	@iFoundComder		= 1
--	FROM	BDBOMESA.dbo.Comder_ProductosComder with(nolock)
--	WHERE	cVehiculo			= 1				--> Banco
--	and		cSistema			= @cSistema		--> Modulo
--	and		cProducto			= @cProducto	--> Producto
--	and		nEstado				= 1				--> Estado Habilitado
		
--	--and		cProducto			= case	when cSistema = 'PCS' and @cProducto = '1' then 'st'
--	--									when cSistema = 'PCS' and @cProducto = '2' then 'sm'
--	--									when cSistema = 'PCS' and @cProducto = '3' then 'fr'
--	--									when cSistema = 'PCS' and @cProducto = '4' then 'sp'
--	--									else @cProducto
--	--								end
----	and		nMoneda				= @nMonedaOpera --> --@cMonedaOp	--> Moneda

		
	-->		Si el Producto esta Habilitado para Comder
	--IF @iFoundComder = 1
	--BEGIN

	--	SET		@nRutcli	= 0
	--	SET		@nCodigo	= 0

	--	-->		( COMDER, Contraparte Central S.A.)
	--	SELECT	@nRutcli	= (select acRutComder from BacFwdSuda.dbo.MFAC with(nolock) )	--> Asignar Rut de Comder
	--		,   @nCodigo	= 1																--> Asignar Codigo de Comder, debe debe agregar el codigo de Comder
	--	FROM	BDBOMESA.dbo.COMDER_RelacionMarcaComder with(nolock)
	--	WHERE	nReNumOper	= @nNumoper
	--	AND     cReSistema =  @cSistema --prd19111
	--	AND     vReEstado = 'V'  -- prd19111
	--	AND		iReNovacion	= 1																--> Si esta Novado el contrato imputara comder, de lo contrario no.


	
		

	--	--IF @nRutcli > 0 and @nCodigo > 0
	--	--BEGIN
		
	--	--	EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES	@cSistema
	--	--											,	@dFecPro
	--	--											,	@nRutcli
	--	--											,	@nCodigo
	--	--											,	@dFecvctop
	--	--											,	@nMonto
	--	--											,	@cTipo_Riesgo
	--	--											,	@cProducto
	--	--											,	@incodigo
	--	--											,	@cMonedaOp
	--	--											,	@formapago
	--	--											,	@MetodoLCR   -- PRD8800 

	--	--	EXECUTE SP_LINEAS_GRABAR					@dFecPro
	--	--											,	@cSistema
	--	--											,	@cProducto
	--	--											,	@nRutcli
	--	--											,	@nCodigo
	--	--											,	@nNumoper
	--	--											,	@nNumdocu
	--	--											,	@nCorrela
	--	--											,	@dFeciniop
	--	--											,	@nMonto
	--	--											,	@fTipcambio
	--	--											,	@dFecvctop
	--	--											,	@cUsuario
	--	--											,	@cMonedaOp
	--	--											,	@cTipo_Riesgo
	--	--											,	@incodigo
	--	--											,	@formapago
	--	--											,	@nContraMoneda
	--	--											,	@nMonedaOpera
	--	--											,	@SW
	--	--											,	@SOBREMONTO
	--	--											,	@Resultado      -- PRD8800
	--	--											,	@MetodoLCR      -- PRD8800
	--	--											,	@Garantia		-- PRD8800
	--	--											,	@Avr			--> 
	--	--END

	--END

	

END
GO
