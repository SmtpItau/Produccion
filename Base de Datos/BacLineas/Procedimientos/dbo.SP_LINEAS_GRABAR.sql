USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_GRABAR]  --sp_Helptext SVC_IMPUTACION_LINEAS
	(   @dFecPro			DATETIME            
	,   @cSistema			CHAR(03)   -- bacparamsuda.dbo.Fn_Mesa_Cerrada( @cSistema )         
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
	,   @nContraMoneda		NUMERIC(03) = 0            
	,   @nMonedaOpera		NUMERIC(03) = 0            
--	,   @SwithEjecucion		INT			= 0
	,   @SW					INT			= 1     -- viene en 1 siempre     
	,   @SOBREMONTO			INT			= 0          
	,   @Resultado			FLOAT		= 0		-- PRD8800    
	,   @MetodoLCR			NUMERIC(5)	= 1		-- PRD8800    
	,   @Garantia			FLOAT		= 0		-- PRD8800       
	,	@Avr				FLOAT		= 0.0	--> 
	)            
AS
BEGIN

	SET NOCOUNT ON            

	DECLARE @dFechaDOContable		DATETIME
		SET @dFechaDOContable		= CASE	WHEN @cSistema = 'BCC' THEN (SELECT acfecant  FROM BacCamSuda.dbo.MEAC                  with(nolock))
											WHEN @cSistema = 'BFW' THEN (SELECT acfecante FROM BacFwdSuda.dbo.MFAC                  with(nolock))
											WHEN @cSistema = 'PCS' THEN (SELECT fechaant  FROM BacSwapSuda.dbo.SWAPGENERAL          with(nolock))
											WHEN @cSistema = 'BTR' THEN (SELECT acfecante FROM BacTraderSuda.dbo.MDAC               with(nolock))
											WHEN @cSistema = 'BEX' THEN (SELECT acfecante FROM BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI with(nolock))
											WHEN @cSistema = 'OPT' THEN (SELECT acfecante FROM BacFwdSuda.dbo.MFAC                  with(nolock))
											--  (SELECT fechaant  FROM lnkopc.CbMdbOpc.dbo.OpcionesGeneral  with(nolock))
										END

	DECLARE @cNombre                CHAR(60)
	DECLARE @cNombreCMatriz         CHAR(60)
	DECLARE @nCorrDet				INT
	DECLARE @cMensaje				VARCHAR(255)
	DECLARE @cTipoMov				VARCHAR(1)
	DECLARE @cTipoLinea				VARCHAR(1)
	DECLARE @cTipoControl			VARCHAR(1)
	DECLARE @cError					VARCHAR(1)
	DECLARE @iFound					INT
	DECLARE @cCtrlplazo				CHAR(01)
	DECLARE @cCompartido			CHAR(01)
	DECLARE @nRutcasamatriz			NUMERIC(09,0)
	DECLARE @nCodigocasamatriz		NUMERIC(09,0)
	DECLARE @nMatrizriesgo			NUMERIC(08,4)
	DECLARE @nTotalasignado			NUMERIC(19,4)
	DECLARE @nTotalocupado			NUMERIC(19,4)
	DECLARE @nTotaldisponible		NUMERIC(19,4)
	DECLARE @nTotalexceso			NUMERIC(19,4)
	DECLARE @nTotaltraspaso			NUMERIC(19,4)
	DECLARE @nTotalrecibido			NUMERIC(19,4)
	DECLARE @nSinriesgoasignado		NUMERIC(19,4)
	DECLARE @nSinriesgoocupado		NUMERIC(19,4)
	DECLARE @nSinriesgodisponible   NUMERIC(19,4)
	DECLARE @nSinriesgoexceso		NUMERIC(19,4)
	DECLARE @nConriesgoasignado		NUMERIC(19,4)
	DECLARE @nConriesgoocupado		NUMERIC(19,4)
	DECLARE @nConriesgodisponible   NUMERIC(19,4)
	DECLARE @nConriesgoexceso		NUMERIC(19,4)
	DECLARE @nMonedalin				NUMERIC(05,0)
	DECLARE @nValmonlin				NUMERIC(10,4)
	DECLARE @nMontolin				NUMERIC(19,4)
	DECLARE @nmontolin_pesos		NUMERIC(19,4)	-->	NUMERIC(19,0)
	DECLARE @nPlazoDesde			NUMERIC(10,0)
	DECLARE @nPlazoHasta			NUMERIC(10,0)
	DECLARE @nExceso				NUMERIC(19,4)
	DECLARE @nDisponible			NUMERIC(19,4)
	DECLARE @dFecvctolinea			DATETIME
	DECLARE @cBloqueado				CHAR(01)
	DECLARE @nMontLimIni			NUMERIC(19,4)
	DECLARE @nMontLimVen			NUMERIC(19,4)
	DECLARE @nMontoLinGen			NUMERIC(19,4)
	DECLARE @nMontoLinSis			NUMERIC(19,4)
	DECLARE @nMontoLinPro			NUMERIC(19,4)
	DECLARE @nParidadMon			NUMERIC(10,4)
	DECLARE @nMoneda				NUMERIC(05,0)
	DECLARE @cFuerte				CHAR(01)
	DECLARE @dFecvctoCompensa       DATETIME
	DECLARE @SubTotal				FLOAT
	DECLARE @TotalGeneral			FLOAT
	DECLARE @SoloCnvLinPro			NUMERIC(10,4)
	DECLARE @Tipo_Oper              CHAR(1)
	DECLARE @Capital_A              FLOAT
	DECLARE @Capital_P              FLOAT
	DECLARE @Plazo_A                NUMERIC(18,6)
	DECLARE @Plazo_P                NUMERIC(18,6)
	DECLARE @Moneda_A               NUMERIC(5)
	DECLARE @Moneda_P               NUMERIC(5)
	DECLARE @Duration_A             FLOAT
	DECLARE @Duration_P             FLOAT
	DECLARE @M_Durat                FLOAT
	DECLARE @Serie_Valor            CHAR(12)
	DECLARE @Tipo_Producto          INT
	DECLARE @Numero_Flujo_Vig_A     INT
	DECLARE @Numero_Flujo_Vig_P     INT
	DECLARE @Prc                    FLOAT
	DECLARE @OperacionEsta          CHAR(15)
	DECLARE @Utilidadlin_pesos      FLOAT
	DECLARE @Utilidadlin            FLOAT
	DECLARE @UtilidadLinPro         FLOAT
	DECLARE @UtilidadLinSis         FLOAT
	DECLARE @UtilidadLinGen         FLOAT
	DECLARE @dFechaHoy              DATETIME
	DECLARE @iMonedaPorPlazo        INT
	DECLARE @nRutCliOper            NUMERIC(09,0)
	DECLARE @nCodigoOper            NUMERIC(09,0)
	DECLARE @FecVctoAux             DATETIME
	DECLARE @RutComder				NUMERIC(9)	-- COMDER


	-- PRD8800    
	DECLARE @Id_SistemaNetting      CHAR(03);	SET @Id_SistemaNetting = ''

	SELECT	@Id_SistemaNetting		= CASE WHEN @MetodoLCR NOT IN (1,4) THEN Id_Grupo ELSE Id_Sistema END
	FROM	TBL_AGRPROD				with(nolock)
	WHERE	Id_Sistema				= @cSistema
   -- PRD8800    
            
	SET @cMensaje					= ''
    SET @OperacionEsta				= 'Operacion no'

	SELECT  @OperacionEsta          = 'Esta operacion'             
	FROM    BacSwapSuda..CARTERA	with(nolock)
	WHERE   numero_operacion        = @nNumoper            
            
	IF @SW = 1          
	BEGIN          
		IF @cSistema <> 'BTR' 
		BEGIN
			-- INI PRD19111-COMDER
			DECLARE @iFoundComder		INT
			SET @iFoundComder		= 0

			SELECT	@iFoundComder		= 1
			FROM	BDBOMESA.dbo.COMDER_RelacionMarcaComder with(nolock)
			WHERE	nReNumOper	= @nNumoper
			AND     cReSistema =  @cSistema
			AND     vReEstado = 'V'
			AND		iReNovacion	= 1		

			IF @iFoundComder = 0
			BEGIN

				DELETE	FROM	LINEA_TRANSACCION
						WHERE	numerooperacion     = @nNumoper
						AND		id_sistema          = @cSistema
            
				DELETE	FROM	LINEA_TRANSACCION_DETALLE				
						WHERE	numerooperacion     = @nNumoper
						AND		id_sistema          = @cSistema
			END
			-- FIN PRD19111-COMDER
		END
	END
	
	--===========================================================================--
	--> Para determinar si la operación fue generada en Chile o en NY --
	DECLARE @EsOperacionNY as varchar(2)
		SET @EsOperacionNY = 'No'

	IF EXISTS (SELECT 1 FROM BACSWAPNY..CARTERA WITH(NOLOCK) WHERE NUMERO_OPERACION = @NNUMOPER)
		SET @EsOperacionNY = 'Si'

	IF EXISTS (SELECT * FROM BACFWDNY..CARTERA	WITH(NOLOCK) WHERE CANUMOPER = @NNUMOPER)
		SET @EsOperacionNY = 'Si'
	--===========================================================================--

	IF @cSistema = 'PCS' and @MetodoLCR in (1,4)
	BEGIN
		IF @EsOperacionNY = 'No'
		BEGIN
			SET @dFechaHoy = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )

			EXECUTE BacSwapSuda..SP_CALCULA_DUR_CNVX_SWAP @dFecPro, @nNumOper

			SET @Utilidadlin_pesos  = 0.0
			SET @Utilidadlin        = 0.0
			SET @UtilidadLinPro     = 0.0
			SET @UtilidadLinSis     = 0.0
			SET @UtilidadLinGen		= 0.0

			IF @Avr = 0
			BEGIN
				SELECT	TOP 1 
						@Utilidadlin_pesos		=	Valor_RazonableCLP
				FROM	BacSwapSuda.dbo.Cartera with(nolock)
				WHERE	numero_operacion		=	@nNumoper
				AND	(	(	fecha_cierre		<=	@dFechaHoy AND numero_flujo  = 1 AND @dFechaHoy <= fecha_vence_flujo	)
					OR	(	fecha_inicio_flujo	<	@dFechaHoy AND numero_flujo <> 1 AND @dFechaHoy <= Fecha_Vence_flujo	)
					)
			END ELSE
			BEGIN
				SET @Utilidadlin_pesos = @Avr
			END

			IF	@Utilidadlin_pesos <= 0.0
				SET @Utilidadlin_pesos = 0.0

			SET @Utilidadlin        = @Utilidadlin_pesos
			SET @UtilidadLinPro     = @Utilidadlin_pesos
			SET @UtilidadLinSis     = @Utilidadlin_pesos
			SET @UtilidadLinGen		= @Utilidadlin_pesos

		END ELSE
		BEGIN					

			SET @dFechaHoy = (SELECT fechaproc FROM BacSwapNY.dbo.SWAPGENERAL with(nolock) )

			EXECUTE BacSwapNY..SP_CALCULA_DUR_CNVX_SWAP @dFecPro, @nNumOper             

			SET @Utilidadlin_pesos  = 0.0
			SET @Utilidadlin        = 0.0
			SET @UtilidadLinPro     = 0.0
			SET @UtilidadLinSis     = 0.0
			SET @UtilidadLinGen		= 0.0

			IF @Avr = 0
			BEGIN
				SELECT	TOP 1 
						@Utilidadlin_pesos		=	Valor_RazonableCLP
				FROM	BacSwapNY.dbo.Cartera with(nolock)
				WHERE	numero_operacion		=	@nNumoper
				AND	(	(	fecha_cierre		<=	@dFechaHoy AND numero_flujo  = 1 AND @dFechaHoy <= fecha_vence_flujo	)
					OR	(	fecha_inicio_flujo	<	@dFechaHoy AND numero_flujo <> 1 AND @dFechaHoy <= Fecha_Vence_flujo	)
					)
			END ELSE
			BEGIN
				SET @Utilidadlin_pesos = @Avr
			END

			IF	@Utilidadlin_pesos <= 0.0
				SET @Utilidadlin_pesos = 0.0
				
			SET @Utilidadlin        = @Utilidadlin_pesos
			SET @UtilidadLinPro     = @Utilidadlin_pesos
			SET @UtilidadLinSis     = @Utilidadlin_pesos
			SET @UtilidadLinGen		= @Utilidadlin_pesos
		END
	END

	IF @cSistema = 'BFW' and  @MetodoLCR in (1,4)  -- PRD8800    
	BEGIN    
		IF @EsOperacionNY = 'No'
		BEGIN

			SET @dFechaHoy = (SELECT acfecproc FROM BacFwdSuda..MFAC with(nolock) )

			IF @cProducto <> '10'             
				SET @cMonedaOp = @nMonedaOpera            

			SET @Utilidadlin_pesos = 0.0
			SET @Utilidadlin       = 0.0
			SET @UtilidadLinPro    = 0.0
			SET @UtilidadLinSis    = 0.0
			SET @UtilidadLinGen    = 0.0

			IF @Avr = 0
			BEGIN
				SELECT	@Utilidadlin_pesos = fRes_Obtenido
				FROM	BacFwdSuda.dbo.MFCA with(nolock)
				WHERE	canumoper          = @nNumoper
				AND		fRes_Obtenido      > 0
				AND		cafecha            < @dFecPro
			END ELSE
			BEGIN
				SET @Utilidadlin_pesos = @Avr
			END

			IF	@Utilidadlin_pesos <= 0.0
				SET @Utilidadlin_pesos = 0.0

			SET @Utilidadlin        = @Utilidadlin_pesos
			SET @UtilidadLinPro     = @Utilidadlin_pesos
			SET @UtilidadLinSis     = @Utilidadlin_pesos
			SET @UtilidadLinGen		= @Utilidadlin_pesos
		END

		IF @EsOperacionNY = 'Si'
		BEGIN
			SET @dFechaHoy = (SELECT acfecproc FROM BacFWDNY..MFAC with(nolock) )

			IF @cProducto <> '10'             
				SET @cMonedaOp = @nMonedaOpera            

			SET @Utilidadlin_pesos = 0.0
			SET @Utilidadlin       = 0.0
			SET @UtilidadLinPro    = 0.0
			SET @UtilidadLinSis    = 0.0
			SET @UtilidadLinGen    = 0.0

			IF @Avr = 0
			BEGIN
				SELECT	@Utilidadlin_pesos = fRes_Obtenido
				FROM	BacFWDNY.dbo.MFCA with(nolock)
				WHERE	canumoper          = @nNumoper
				AND		fRes_Obtenido      > 0
				AND		cafecha            < @dFecPro
			END ELSE
			BEGIN
				SET @Utilidadlin_pesos = @Avr
			END

			IF	@Utilidadlin_pesos <= 0.0
				SET @Utilidadlin_pesos = 0.0

			SET @Utilidadlin        = @Utilidadlin_pesos
			SET @UtilidadLinPro     = @Utilidadlin_pesos
			SET @UtilidadLinSis     = @Utilidadlin_pesos
			SET @UtilidadLinGen		= @Utilidadlin_pesos
		END
	END

	IF @nCodigo = 0            
		SELECT @cNombre = clnombre
		,      @nCodigo = clcodigo
		FROM   BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE  clrut    = @nRutcli
	ELSE
		SELECT @cNombre = clnombre
		FROM   BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE  clrut    = @nRutcli            
		AND    clcodigo = @nCodigo

	SET @nCorrDet      = 0
	SET @cTipoMov      = 'S'   -- S.suma R.resta
	SET @cTipoLinea    = 'L'   -- L.linea
	SET @cTipoControl  = 'C'   -- C.control


	IF @fTipcambio = 0             
		SET @fTipcambio = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = 994), 1)            

	--+++jcamposd 20180518 para los coltes no aplica cambiar el tipo de cambio
	 IF @cSistema <> 'BEX'
	 BEGIN
	 --> Reemplaza el Tipo de Cambio Observado por el Tipo Cambio Contable para los SPOT              
		SET @fTipcambio = (  SELECT ISNULL(Tipo_Cambio, 1)   
		   FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)  
		   WHERE Fecha   = @dFechaDOContable  
		   AND  Codigo_Moneda = 994)  
	 --> Reemplaza el Tipo de Cambio Observado por el Tipo Cambio Contable para los SPOT  
	 END
	 -----jcamposd  20180518 para los coltes no aplica cambiar el tipo de cambio
	------------------------------------------------------------------------------------------------

	--> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO
	DECLARE @nMontoMitigado	FLOAT
		SET @nMontoMitigado	= 0.0
	DECLARE @nPorcentaje	FLOAT
		SET	@nPorcentaje	= 0.0
	--> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO

	IF (@cSistema = 'BTR'  OR (@cSistema = 'BFW' AND RTRIM(LTRIM(@cProducto)) = '10')and  @MetodoLCR in (1,4))    -- PRD8800    
	BEGIN
		--> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO
		IF @cSistema = 'BTR' and @cProducto = 'CI'
		BEGIN
			SET @nMontoMitigado	= BacLineas.dbo.fxlineas_calcula_mitigacion( @nNumdocu, @nCorrela )
			SET @nMonto			= CONVERT( NUMERIC(19,4), @nMontoMitigado )
		END
		--> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO
		SET @nmontolin_pesos = round(@nMonto, 0)
		SET @nMontolin       = round(@nMonto, 0)
	END ELSE
	BEGIN
		IF @cMonedaOp <> 999
		BEGIN
			
			--> Debiese calcular el Monto multiplicando por el VmValor de la Moneda Op
				SET @nmontolin_pesos = ROUND(@nMonto * @fTipcambio,4)
				SET @nMontolin       = @nMonto
			
		END ELSE
		BEGIN
			--> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO
			IF @cSistema = 'BTR' and @cProducto = 'CI'
			BEGIN
				SET @nMontoMitigado	= BacLineas.dbo.fxlineas_calcula_mitigacion( @nNumdocu, @nCorrela )
				SET @nMonto			= CONVERT( NUMERIC(19,4), @nMontoMitigado )
			END
			--> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO
			SET @nmontolin_pesos = round(@nMonto, 0)
			SET @nMontolin       = round(@nMonto, 0)
		END
	END
	-------------------------------------------------------------------------------------------------------------------
	---------------------------------> LD1_035_MITIGACION PARA LAS COMPRAS CON PACTO <---------------------------------
	-------------------------------------------------------------------------------------------------------------------

	IF (@cSistema = 'BTR' and @cProducto = 'CI')
	BEGIN
			DECLARE @cfamilia CHAR(6)
			SET @cfamilia	= (SELECT inserie FROM BacParamSuda.dbo.INSTRUMENTO i with(nolock) WHERE i.incodigo = @incodigo);

		INSERT INTO	BacLineas.dbo.mensajes_limite_permanencia
		(	Fecha,			Id_Sistema,		Producto,	NumOperacion,	NumDocumento,	NumCorrelativo,	Codigo,			Familia
		,	Instrumento,	RutEmisor,		Operador,	Nominal,		Tasa,			Pvp,			PlazoLimite,	PlazoActual
		,	Firma1,			Firma2,			Mensaje,	FechaSistema,	HoraSistema,	nIdRelacion,	nEstado
		)
		SELECT	
			Fecha			= @dFecPro
		,	Id_Sistema		= @cSistema
		,	Producto		= @cProducto
		,	NumOperacion	= @nNumoper
		,	NumDocumento	= @nNumdocu
		,	NumCorrelativo	= @nCorrela
		,	Codigo			= @nCodigo
		,	Familia			= @cfamilia
		,	Instrumento		= ''
		,	RutEmisor		= 0
		,	Operador		= @cUsuario
		,	Nominal			= @nMontoMitigado
		,	Tasa			= 0
		,	Pvp				= 0
		,	PlazoLimite		= 0
		,	PlazoActual		= 0
		,	Firma1			= ''
		,	Firma2			= ''
		,	Mensaje			= 'Operacion con Mitigacion, Monto Mitigado : ' + Format( @nMontoMitigado, 'F2','es-cl')
		,	FechaSistema	= convert(datetime, convert(char(10), getdate(), 112), 112)
		,	HoraSistema		= convert(datetime, convert(char(10), getdate(), 108), 112)
		,	nIdRelacion		= 0
		,	nEstado			= -1
			
	END
				
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


	
	
	---------------------------------- Conversion A Monedas ----------------------------------
	--+++CONTROL IDD jcamposd
	------IF EXISTS( SELECT 1 FROM LINEA_GENERAL WITH(NOLOCK) WHERE RUT_CLIENTE = @nRutcli AND LTRIM(RTRIM( MONEDA )) = '' )
	------	UPDATE LINEA_GENERAL SET moneda = '999' WHERE rut_cliente = @nRutcli and moneda = ''

	------IF EXISTS( SELECT 1 FROM LINEA_SISTEMA WITH(NOLOCK) WHERE RUT_CLIENTE = @nRutcli AND LTRIM(RTRIM( MONEDA )) = '' )
	------	UPDATE LINEA_SISTEMA SET moneda = '999' WHERE rut_cliente = @nRutcli and moneda = ''

	-------->		Se agrega para Evitar la Perdida de la Moneda 05-09-2013
	------SELECT	@nMoneda		= CONVERT(NUMERIC(3), RTRIM(LTRIM(moneda)) )
	------FROM	LINEA_GENERAL	with(nolock)
	------WHERE	rut_cliente		= @nRutcli
	------AND		codigo_cliente	= @nCodigo
	
	------	SET	@iMonedaPorPlazo	= @nMoneda
		-->	Se agrega para Evitar la Perdida de la Moneda 05-09-2013
		

		SET	@iMonedaPorPlazo = 999--@cMonedaOp
	
	-----CONTROL IDD jcamposd
	
	----- Monto en Moneda para Linea General -----            
	IF @cSistema <> 'PCS' and @MetodoLCR in (1,4)  -- PRD8800    
	BEGIN
		--+++CONTROL IDD, jcamposd            
		------SELECT @nMoneda       = CONVERT(NUMERIC(3), RTRIM(LTRIM(moneda)) )
		------FROM   LINEA_GENERAL  with(nolock)
		------WHERE  rut_cliente    = @nRutcli
		------AND    codigo_cliente = @nCodigo
		--+++jcamposd 20180518 para los coltes 
		SET @nMoneda = CASE WHEN @cMonedaOp <> 0 THEN @cMonedaOp ELSE 999 END
		--SET @nMoneda = 999
		-----jcamposd 20180518  para los coltes 
		-----CONTROL IDD, jcamposd
		
	

--      SET @nParidadMon      = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)  
		SET @nParidadMon      = ISNULL((SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)

		--> Contingencia  
		IF @nParidadMon = 0 AND @nMoneda = 13  
			SET @nParidadMon = @fTipcambio

		IF @nMoneda <> 999             
		BEGIN            
--			IF (SELECT mnrrda FROM VIEW_MONEDA WHERE mncodmon = @nMoneda) = 'D'           
			IF (SELECT mnrrda FROM BacParamSuda.dbo.MONEDA with(nolock) WHERE mncodmon = @nMoneda) = 'D'
				SET @nParidadMon = @nParidadMon / @fTipcambio
			ELSE
				SET @nParidadMon = @nParidadMon * @fTipcambio
		END

		SET @nMontoLinGen = @nmontolin_pesos / @nParidadMon

		IF @nMoneda = 999
			SET @nMontoLinGen = ROUND( @nMontoLinGen, 0)

		IF @cSistema = 'BFW' AND @UtilidadLinGen > 0.0
			SET @UtilidadLinGen = @UtilidadLinGen  / @nParidadMon
	END            
	--+++CONTROL IDD, jcamposd
	------	----- Monto en Moneda para Linea Sistema -----            
	------	IF @cSistema <> 'PCS'  and  @MetodoLCR in (1,4)  -- PRD8800    
	------	BEGIN    

	------		SELECT @nMoneda        = CONVERT(NUMERIC(05), RTRIM(LTRIM(moneda)) )
	------		FROM   LINEA_SISTEMA   with(nolock)
	------		WHERE  rut_cliente     = @nRutcli             
	------		AND    codigo_cliente  = @nCodigo             
	------		AND    id_sistema      = @cSistema            
	            
	------		SET @iMonedaPorPlazo   = @nMoneda            
	------	--	SET @nParidadMon       = ISNULL(( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)
	------		SET @nParidadMon       = ISNULL(( SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)
	  
	------		--> Contingencia  
	------		IF @nParidadMon = 0  AND  @nMoneda = 13  
	------			SET @nParidadMon = @fTipcambio  

	------		IF @nMoneda <> 999             
	------		BEGIN            
	--------			IF (SELECT mnrrda FROM VIEW_MONEDA WHERE mncodmon = @nMoneda) = 'D'
	------			IF (SELECT mnrrda FROM BacParamSuda.dbo.MONEDA with(nolock) WHERE mncodmon = @nMoneda) = 'D'
	------				SET @nParidadMon = @nParidadMon / @fTipcambio
	------			ELSE
	------				SET @nParidadMon = @nParidadMon * @fTipcambio
	------		END

	------		SET @nMontoLinSis = @nmontolin_pesos / @nParidadMon

	------		IF @nMoneda = 999
	------			SET @nMontoLinSis = round( @nMontoLinSis, 0)

	------		IF @cSistema = 'BFW' AND @UtilidadLinGen > 0.0
	------			SET @UtilidadLinSis = @UtilidadLinSis  / @nParidadMon            
	------	END
	
	-----CONTROL IDD, jcamposd

   /*========================================================================================*/            
   /* VGS 16/04/2005*/            
   /*========================================================================================*/            
   IF @cSistema = 'BCC' AND CHARINDEX(CONVERT(CHAR(03),@formapago),'12 -13 -14 -129-130') > 0
   BEGIN
      SELECT @dFecvctop = DATEADD(DAY, diasvalor, @dFeciniop)            
      FROM   BacParamSuda.dbo.FORMA_DE_PAGO with(nolock)
      WHERE  codigo     = @formapago
   END            
   /*========================================================================================*/            
  
	/*  
	IF @cSistema = 'BCC' AND (@formapago = 122 OR @formapago = 103 OR @formapago = 105)
	BEGIN            
		--> Ha solicitud de Roberto Fuentes las Operaciones Spot con Cargo Cta corriente, no debieran tomar linea.
		/*
		INSERT INTO ERRORES_CARGA
		VALUES ( @dFecPro, @cSistema, @nRutcli, @nCodigo, @cProducto, @dFecvctop, @nNumoper	)
		*/
		RETURN               
   END            
	*/
    
     
	----- Monto en Moneda para Linea Producto -----             
	DECLARE @nPlazoProdPla   NUMERIC(9)            
		SET @nPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)            
     
    --+++CONTROL IDD, jcamposd, no debe crear línea       
	------IF @MetodoLCR in (1,4)   -- PRD8800    
	------BEGIN    
	------	EXECUTE dbo.SP_VALIDA_LINPRODUCTO_PLAZO @nRutcli, @nCodigo, @cSistema, @cProducto, @incodigo, @nPlazoProdPla
	------END
	-----CONTROL IDD, jcamposd, no debe crear línea

	IF @cProducto = 'ICAP'
	BEGIN            
		/*
		INSERT INTO ERRORES_CARGA            
		VALUES ( @dFecPro, @cSistema, @nRutcli, @nCodigo, @cProducto, @dFecvctop, @nNumoper )
		*/
		RETURN
	END
    
    --+++CONTROL IDD, jcamposd no valida linea producto ni debe controlar        
	--------	SELECT	@nMoneda        =	mncodmon
	------	SELECT	@nMoneda        =	isnull(	case when mncodmon = 0 then @nMoneda else mncodmon end,	@nMoneda) --> 05-09-2013
	------	FROM	LINEA_PRODUCTO_POR_PLAZO with(nolock)
	------	WHERE	rut_cliente		=	@nRutcli                
	------	AND		codigo_cliente	=	@nCodigo       
	------	AND		id_sistema		=	@cSistema                
	------	AND		codigo_producto	=	@cProducto            
	------	AND	(	incodigo		=	@incodigo) -->  or incodigo = 0 or @incodigo = 0)             
	------	AND		plazodesde		<=	@nPlazoProdPla            
	------	AND		plazohasta		>=	@nPlazoProdPla            
	------	AND	(	@cProducto     <> 'ICAP')

	------	SET @nMoneda			= isnull(@iMonedaPorPlazo, @nMoneda) --> 05-09-2013
	--------	SET @nParidadMon		= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)  
	------	SET @nParidadMon		= ISNULL(( SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock) WHERE vmfecha = @dFeciniop AND vmcodigo = @nMoneda), 1)

	------	--> Contingencia  
	------	IF @nParidadMon = 0  AND  @nMoneda = 13  
	------		SET @nParidadMon = @fTipcambio
	  
	------	IF @nMoneda <> 999
	------	BEGIN
	--------		IF (SELECT mnrrda FROM VIEW_MONEDA WHERE mncodmon = @nMoneda ) = 'D'
	------		IF (SELECT mnrrda FROM BacParamSuda.dbo.MONEDA with(nolock) WHERE mncodmon = @nMoneda) = 'D'
	------			SET @nParidadMon = @nParidadMon / @fTipcambio
	------		ELSE
	------			SET @nParidadMon = @nParidadMon * @fTipcambio
	------	END

	------	SET @nMontoLinPro = @nmontolin_pesos / @nParidadMon

	------	if @nMoneda = 999
	------		set @nMontoLinPro = round( @nMontoLinPro, 0)

	------	IF @nMoneda = 13
	------		SET @nMontoLinGen = @nmontolin_pesos / @fTipcambio

	------	IF @nMoneda = 999
	------		set @nMontoLinGen = round( @nMontoLinGen, 0)

	------	IF @cSistema = 'BFW' AND @UtilidadLinGen > 0.0   and  @MetodoLCR in (1,4)  -- PRD8800    
	------		SET @UtilidadLinPro = @UtilidadLinPro / @nParidadMon

	------	IF @cSistema = 'PCS' AND @UtilidadLinGen > 0.0   and  @MetodoLCR in (1,4)  -- PRD8800    
	------		SET @UtilidadLinPro = @UtilidadLinPro / @nParidadMon
	
	-----CONTROL IDD, jcamposd no valida linea producto ni debe controlar

	----- Monto en Moneda para Linea Producto -----             
	---------------------------------------------------------------------------------            
	SET @nMatrizriesgo	= 0
	SET @Prc			= 0 

		   /* +++ VBF 15042019 <<< Cambio MX-CLP >>>  
				  Declaracion de variables para modificacion de calculo REC para operaciones MX-CLP  
			  --- VBF 15042019 
		    */
			 DECLARE @varmoneda2		NUMERIC(15) 		
            
   IF @cSistema  = 'BFW' and  @MetodoLCR in (1,4)  -- PRD8800    
   BEGIN

		IF @EsOperacionNY = 'No'
			begin	
	

					SELECT	@Serie_Valor    = caserie
					,		@Tipo_Oper      = catipoper
					,		@Capital_A      = CASE	WHEN cacodpos1 = 14  THEN camtomon1
												-->	WHEN cacodpos1 = 10  THEN caequusd1
													WHEN catipoper = 'C' THEN camtomon1
													WHEN catipoper = 'V' THEN camtomon1
												-->	ELSE (CASE WHEN cacodpos1 = 10 THEN caequusd1 ELSE camtomon2 END)
												END
					,		@Capital_P      = CASE	WHEN cacodpos1 = 14  THEN camtomon2
													WHEN catipoper = 'C' THEN camtomon1  --> CASE WHEN cacodpos1 = 10 THEN caequusd1 ELSE camtomon2 END
													ELSE camtomon1
												END
					,		@Plazo_A        = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, cafecEfectiva) END
					,		@Plazo_P       = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, cafecEfectiva) END
					,		@Moneda_A       = CASE	WHEN cacodpos1 = 14  THEN cacodmon1
													WHEN catipoper = 'C' THEN cacodmon1
													WHEN catipoper = 'V' THEN cacodmon1
													ELSE cacodmon1
												--> ELSE cacodmon2
												END
					,		@Moneda_P       = CASE	WHEN cacodpos1 = 14  THEN cacodmon2
													WHEN catipoper = 'C' THEN cacodmon2
													WHEN catipoper = 'V' THEN cacodmon2
													ELSE cacodmon1
												END
					,		@Duration_A     = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY, @dFecPro, cafecEfectiva) / 365.0 ,4) END
					,		@Duration_P     = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY, @dFecPro, cafecEfectiva) / 365.0 ,4) END
					,		@Tipo_Producto  = cacodpos1
					,		@M_Durat        = catasfwdcmp
					,		@FecVctoAux     = CaFecVcto
					 /* +++ VBF 15042019 <<< Cambio MX-CLP >>> */
					 ,@varmoneda2   = var_moneda2
					 /* --- VBF 15042019 <<< Cambio MX-CLP >>> */

					FROM	BacFwdsuda.dbo.MFCA with(nolock)
					WHERE	canumoper       = @nNumoper

					-- Se corrige la imputación de Compensaciones Parciales tradicional    
					-- Error encontrado por CEstay.    
					IF @Tipo_Producto = 7     
					BEGIN
						SET @Plazo_A	= CASE	WHEN DATEDIFF(DAY, @dFecPro, @FecVctoAux) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, @FecVctoAux) END
						SET @Plazo_P	= CASE	WHEN DATEDIFF(DAY, @dFecPro, @FecVctoAux) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, @FecVctoAux) END
						SET @Duration_A = @Plazo_A / 365.0
						SET @Duration_P = @Plazo_P / 365.0
				END

/*
			INSERT INTO dbo.revision( lineas ) 
			  VALUES ( '2.-Operacion: ' + RTRIM(CONVERT(VARCHAR,@nnumoper))    + 
					   ' Producto   : ' + RTRIM(CONVERT(VARCHAR, @Tipo_Producto)) +
					   ' Monedas	: ' + RTRIM(CONVERT(VARCHAR, @Moneda_A)) + '/' + RTRIM(CONVERT(VARCHAR, @Moneda_P)) +
					   ' relacion   : ' + RTRIM(CONVERT(VARCHAR, @varmoneda2))+ 
					   ' valor      : ' + RTRIM(CONVERT(VARCHAR, 0))
					  ) 
*/

		END

		IF @EsOperacionNY = 'Si'
			begin	
	

					SELECT	@Serie_Valor    = caserie
					,		@Tipo_Oper      = catipoper
					,		@Capital_A      = CASE	WHEN cacodpos1 = 14  THEN camtomon1
												-->	WHEN cacodpos1 = 10  THEN caequusd1
													WHEN catipoper = 'C' THEN camtomon1
													WHEN catipoper = 'V' THEN camtomon1
												-->	ELSE (CASE WHEN cacodpos1 = 10 THEN caequusd1 ELSE camtomon2 END)
												END
					,		@Capital_P      = CASE	WHEN cacodpos1 = 14  THEN camtomon2
													WHEN catipoper = 'C' THEN camtomon1  --> CASE WHEN cacodpos1 = 10 THEN caequusd1 ELSE camtomon2 END
													ELSE camtomon1
												END
					,		@Plazo_A        = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, cafecEfectiva) END
					,		@Plazo_P       = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, cafecEfectiva) END
					,		@Moneda_A       = CASE	WHEN cacodpos1 = 14  THEN cacodmon1
													WHEN catipoper = 'C' THEN cacodmon1
													WHEN catipoper = 'V' THEN cacodmon1
													ELSE cacodmon1
												--> ELSE cacodmon2
												END
					,		@Moneda_P       = CASE	WHEN cacodpos1 = 14  THEN cacodmon2
													WHEN catipoper = 'C' THEN cacodmon2
													WHEN catipoper = 'V' THEN cacodmon2
													ELSE cacodmon1
												END
					,		@Duration_A     = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY, @dFecPro, cafecEfectiva) / 365.0 ,4) END
					,		@Duration_P     = CASE	WHEN DATEDIFF(DAY, @dFecPro, cafecEfectiva) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY, @dFecPro, cafecEfectiva) / 365.0 ,4) END
					,		@Tipo_Producto  = cacodpos1
					,		@M_Durat        = catasfwdcmp
					,		@FecVctoAux     = CaFecVcto
					FROM	BacFWDNY.dbo.MFCA with(nolock)
					WHERE	canumoper       = @nNumoper

					-- Se corrige la imputación de Compensaciones Parciales tradicional    
					-- Error encontrado por CEstay.    
					IF @Tipo_Producto = 7     
					BEGIN
						SET @Plazo_A	= CASE	WHEN DATEDIFF(DAY, @dFecPro, @FecVctoAux) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, @FecVctoAux) END
						SET @Plazo_P	= CASE	WHEN DATEDIFF(DAY, @dFecPro, @FecVctoAux) < 0 THEN 0 ELSE DATEDIFF(DAY, @dFecPro, @FecVctoAux) END
						SET @Duration_A = @Plazo_A / 365.0
						SET @Duration_P = @Plazo_P / 365.0
					END
		END

    
		IF @M_Durat = 0 AND @Tipo_Producto = 10
			EXECUTE SP_BUSCA_DURATION	@Serie_Valor
									,	@dFecPro
                                    ,	@M_Durat   OUTPUT
            
		SET @M_Durat		= CASE WHEN @Tipo_Producto	= 10	THEN @M_Durat		ELSE @Duration_A END
		SET @Duration_A		= CASE WHEN @Tipo_Oper		= 'C'	THEN @M_Durat		ELSE @Duration_A END
		SET	@Duration_P		= CASE WHEN @Tipo_Oper		= 'C'	THEN @Duration_p	ELSE @M_Durat    END
		/*
		SELECT	@Duration_A		= CASE WHEN catipoper		= 'C'	THEN @M_Durat		ELSE @Duration_A END
			,   @Duration_P		= CASE WHEN catipoper		= 'C'	THEN @Duration_p	ELSE @M_Durat    END
		FROM	BacFwdSuda..MFCA
		WHERE	canumoper    = @nNumoper            
		AND		cacodpos1    IN(10,11)            
		*/

/* +++ VBF 15042019 <<< Cambio MX-CLP >>> */
			  IF (@Tipo_Producto = 1 AND  @varmoneda2 <>0 )
			  BEGIN
				SET @TotalGeneral	= 1 ;
				SET @SubTotal		= 1 ; -- valor 1  para evitar problema con IDD
				SET @Prc			= 1 ; 
			  END ELSE BEGIN 
		   
					IF (@Tipo_Producto = 2 AND  @varmoneda2 <>0 )
						SET @Moneda_P = 999
					
/* --- VBF 15042019 <<< Cambio MX-CLP >>> */



		EXECUTE SP_Riesgo_Potencial_Futuro		@nNumoper
											,	@cSistema
											,	@cProducto
											,	@Tipo_Oper
											,	@Capital_A
											,	@Capital_P
											,	@Plazo_A
											,	@Plazo_P
											,	@Moneda_A
											,	@Moneda_P            
											,	@Duration_A
											,	@Duration_P
											,	@dFecPro
											,	@SubTotal OUTPUT
											,	@Prc      OUTPUT
            END

		EXECUTE dbo.SP_LCR_VRAZONABLE_NEGATIVO	@dFecPro
											,	@cSistema
											,	@nNumoper
											,	@SubTotal
											,	@Utilidadlin_pesos
											,	@TotalGeneral OUTPUT
            
		SET @nMontolin_pesos  = ROUND(@TotalGeneral,0)
/*
			INSERT INTO dbo.revision( lineas ) 
			  VALUES ( '2.-Operacion: ' + RTRIM(CONVERT(VARCHAR,@nnumoper))    + 
					   ' Producto   : ' + RTRIM(CONVERT(VARCHAR, @Tipo_Producto)) +
					   ' Monedas	: ' + RTRIM(CONVERT(VARCHAR, @Moneda_A)) + '/' + RTRIM(CONVERT(VARCHAR, @Moneda_P)) +
					   ' relacion   : ' + RTRIM(CONVERT(VARCHAR, @varmoneda2))+ 
					   ' valor      : ' + RTRIM(CONVERT(VARCHAR, @SubTotal))
					  ) 

*/
        --> Se modifico por Dolar Contable            
		SET		@nMontolin			= @TotalGeneral            
		SELECT  @nMontolin			= ROUND(@TotalGeneral / CASE WHEN @cMonedaOp = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
		FROM    BacParamSuda.dbo.VALOR_MONEDA with(nolock)
		WHERE   vmfecha				= @dFechaHoy
		AND     vmcodigo			= CASE WHEN @cMonedaOp = 13 THEN 994 ELSE @cMonedaOp END

		--> Se modifico por Dolar Contable
		SET		@nMontoLinGen		= @TotalGeneral            
		--+++CONTROL IDD, jcamposd, se mantiene logica sin revisar linea general
		------SELECT  @nMontoLinGen		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
		------FROM    LINEA_GENERAL		with(nolock)
		------,       BacParamSuda.dbo.VALOR_MONEDA with(nolock)
		------WHERE   rut_cliente			= @nRutcli
		------AND     codigo_cliente		= @nCodigo
		------AND		vmfecha				= @dFechaHoy
		------AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END
       SELECT  @nMontoLinGen		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
		FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock)
		WHERE   vmfecha				= @dFechaHoy
		AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN 994 ELSE @cMonedaOp END
		-----CONTROL IDD, jcamposd, se mantiene logica sin revisar linea general
                  
		SET		@SoloCnvLinPro		= 1

		--+++CONTROL IDD, jcamposd
		--------> Se modifico por Dolar Contable            
		------SET		@nMontoLinSis		= @TotalGeneral
		------SELECT  @nMontoLinSis		= ROUND(@TotalGeneral / CASE WHEN rtrim(ltrim( moneda )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
		------,       @SoloCnvLinPro		= vmvalor
		------FROM    LINEA_SISTEMA       with(nolock)
		------,       BacParamSuda.dbo.VALOR_MONEDA with(nolock)
		------WHERE   rut_cliente			= @nRutcli
		------AND     codigo_cliente		= @nCodigo
		------AND     id_sistema			= @cSistema
		------AND     vmfecha				= @dFechaHoy
		------AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END
    
		------SELECT @nMontoLinPro = @TotalGeneral / @SoloCnvLinPro  -- Mientras no se grabe bien lo de la moneda x plazo              
            
		------      --> Se modifico por Dolar Contable            
		-------- Esto sólo se ejecutará cuando la moneda x Plazo sea consistente            
		------SELECT  @nMontoLinPro		= ROUND(@TotalGeneral / CASE WHEN vmcodigo = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END ,4)
		------FROM    LINEA_PRODUCTO_POR_PLAZO   with(nolock)
		------,       BACPARAMSUDA..VALOR_MONEDA with(nolock)
		------WHERE   rut_cliente			=	@nRutcli
		------AND     codigo_cliente		=	@nCodigo
		------AND     id_sistema			=	@cSistema
		------AND     codigo_producto		=	@cProducto
		------AND    (incodigo			=	@incodigo or incodigo = 0 or @incodigo = 0)
		------AND     plazodesde			<=	@nPlazoProdPla
		------AND     plazohasta			>=	@nPlazoProdPla
		------AND     vmfecha				=	@dFechaHoy
		------AND     vmcodigo			=	mncodmon
     
		SET @nMontolin_pesos	= @nMontolin_pesos
		SET @nMontolin			= @nMontolin
		------SET @nMontoLinPro		= @nMontoLinPro
		------SET @nMontoLinSis		= @nMontoLinSis
		
		-----CONTROL IDD, jcamposd		
		
		SET @nMontoLinGen		= @nMontoLinGen
	END

	IF @cSistema  = 'OPT' and  @MetodoLCR in (1,4)  -- PRD8800    
	BEGIN            
		SELECT @dFechaHoy = acfecproc             
		FROM   BacfwdSuda.dbo.MFAC with(nolock)

		/* Valores Operacion, montos serán grabados todos en CLP */            
		SELECT	@TotalGeneral = Resultado + Avr             
		,		@Prc          = PrcLCR            
		,		@subtotal     = Resultado              
		,		@cMonedaOp    = 999            
		FROM	LINEA_CHEQUEAR            
		WHERE	NumeroOperacion = @nNumoper               
		AND		Id_Sistema = 'OPT'            
            
		SET @nMontolin_pesos = ROUND(@TotalGeneral,0)            
            
		DECLARE	@ValorConvOPT	FLOAT;	SET @ValorConvOPT = 0.0  

		--> Reemplaza el Tipo de Cambio Observado por el Tipo Cambio Contable para los SPOT
		SET @ValorConvOPT = isnull((SELECT ISNULL(Tipo_Cambio, 1) FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) WHERE Fecha = @dFechaDOContable AND Codigo_Moneda = 994), 1)
		--> Reemplaza el Tipo de Cambio Observado por el Tipo Cambio Contable para los SPOT
          
		SET		@nMontolin      = @TotalGeneral            
		SELECT  @nMontolin      = ROUND(@TotalGeneral / ISNULL(Tipo_Cambio,1),4)		-- ROUND(@TotalGeneral / ISNULL(vmvalor,1),4) PROD-13828         
		FROM    BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)						-- BACPARAMSUDA..VALOR_MONEDA   PROD-13828         
		WHERE   Fecha			= @dFechaDOContable										-- vmfecha       = @dFechaHoy   PROD-13828              
 --		AND     vmcodigo		= CASE WHEN  @cMonedaOp = 13 THEN 994 ELSE @cMonedaOp END PROD-13828         
		AND     Codigo_Moneda	= CASE WHEN  @cMonedaOp = 13 THEN 994 ELSE @cMonedaOp END                     --   PROD-13828            

		SET		@nMontoLinGen   = @TotalGeneral            

		--+++CONTROL IDD, jcamposd
		--------		SELECT  @nMontoLinGen   = ROUND(@TotalGeneral / ISNULL(Tipo_Cambio,1),4)		-- ROUND(@TotalGeneral / ISNULL(vmvalor,1),4) PROD-13828         
		--------		FROM    LINEA_GENERAL   with(nolock)
		--------		,       BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)						-- BACPARAMSUDA..VALOR_MONEDA   PROD-13828       
		--------		WHERE   rut_cliente     = @nRutcli
		--------		AND     codigo_cliente  = @nCodigo
		--------		AND     Fecha			= @dFechaDOContable										-- AND  vmfecha = @dFechaHoy    PROD-13828  
		----------		AND     vmcodigo        = CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END          
		--------		AND     Codigo_Moneda	= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END              --   PROD-13828                    
		SELECT  @nMontoLinGen   = ROUND(@TotalGeneral / ISNULL(Tipo_Cambio,1),4)		-- ROUND(@TotalGeneral / ISNULL(vmvalor,1),4) PROD-13828         
		FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)						-- BACPARAMSUDA..VALOR_MONEDA   PROD-13828       
		WHERE   Fecha			= @dFechaDOContable										-- AND  vmfecha = @dFechaHoy    PROD-13828  
		AND     Codigo_Moneda	= CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN 994 ELSE @cMonedaOp END              --   PROD-13828                    
		
		-----CONTROL IDD,jcamposd
		
		SET		@SoloCnvLinPro	= 1            
		
		--+++CONTROL IDD,jcamposd
		------		SET		@nMontoLinSis	= @TotalGeneral                              
		------		SELECT	@nMontoLinSis	= ROUND(@TotalGeneral / ISNULL(Tipo_Cambio,1),4)			-- ROUND(@TotalGeneral / ISNULL(vmvalor,1),4) PROD-13828         
		------		,		@SoloCnvLinPro	= Tipo_Cambio												-- vmvalor                      PROD-13828                
		------		FROM	LINEA_SISTEMA   with(nolock)
		------		,		BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)							-- , BACPARAMSUDA..VALOR_MONEDA PROD-13828         
		------		WHERE	rut_cliente		= @nRutcli           
		------		AND		codigo_cliente  = @nCodigo             
		------		AND		id_sistema		= @cSistema            
		------		AND     Fecha			= @dFechaDOContable											-- AND vmfecha  = @dFechaHoy    PROD-13828       
		--------		AND		vmcodigo		= ( case when rtrim( ltrim( moneda ) ) = 13 then 994 else moneda end )                    PROD-1382   
		------		AND		Codigo_Moneda	= case when rtrim( ltrim( moneda ) ) = 13 then 994 else moneda end

		------		SET		@nMontoLinPro = @TotalGeneral / @SoloCnvLinPro  -- Mientras no se grabe bien lo de la moneda x plazo                  

		------		-- Esto sólo se ejecutará cuando la moneda x Plazo sea consistente            
		------		SELECT  @nMontoLinPro	= ROUND(@TotalGeneral / ISNULL(Tipo_Cambio,1),4)    -- ROUND(@TotalGeneral / ISNULL(vmvalor,1),4) PROD-13828       
		------		FROM	LINEA_PRODUCTO_POR_PLAZO with(nolock)           
		------		,		BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)					-- , BACPARAMSUDA..VALOR_MONEDA  PROD-13828         
		------		WHERE	rut_cliente		=	@nRutcli
		------		AND		codigo_cliente	=	@nCodigo
		------		AND		id_sistema		=	@cSistema
		------		AND		codigo_producto =	@cProducto
		------		AND	(	incodigo		=	@incodigo or incodigo = 0 or @incodigo = 0)
		------		AND		plazodesde		<=	@nPlazoProdPla
		------		AND		plazohasta		>=	@nPlazoProdPla
		------		AND     Fecha			=	@dFechaDOContable								--  AND vmfecha  = @dFechaHoy    PROD-13828      
		--------		AND		vmcodigo		=	mncodmon                                        PROD-13828  
		------		AND		Codigo_Moneda	=	mncodmon                                        -- PROD-13828          

		SET @nMontolin_pesos	= @nMontolin_pesos             
		SET @nMontolin			= @nMontolin                   
		------SET @nMontoLinPro		= @nMontoLinPro                
		------SET @nMontoLinSis		= @nMontoLinSis    
		SET @nMontoLinGen		= @nMontoLinGen 
		-----CONTROL IDD,jcamposd               
	END            

	

	IF @cSistema = 'PCS'   and  @MetodoLCR in (1,4)  -- PRD8800    
	BEGIN            

		--IF exists (select 1 from BacSwapSUDA..cartera where numero_operacion = @nNumoper)
		--		set @EsOperacionCH = 'Si'

		IF @EsOperacionNY = 'No'
		BEGIN

						SET @Serie_Valor  = ''            
						SET @Tipo_Oper    = ''            
						SET @Capital_A    = 0.0            
						SET @Plazo_A      = 0            
						SET @Moneda_A     = 999            
						SET @Duration_A   = 0            

						SELECT	@Capital_A			= compra_capital + compra_flujo_adicional            
						,		@Plazo_A			= CASE	WHEN Compra_codigo_tasa  = 0 THEN DATEDIFF(d,@dFecPro,fecha_Termino)
															ELSE                              DATEDIFF(d,@dFecPro,fecha_vence_Flujo)
														END
						,		@Moneda_A			= compra_moneda
						,		@Duration_A			= CASE WHEN vDurMacaulActivo < 0 THEN 0.0 ELSE vDurMacaulActivo  END
						FROM	BacSwapSuda.dbo.CARTERA with(nolock)
						WHERE	numero_operacion	= @nNumoper
						AND		Tipo_flujo			= 1
						AND	(	estado_flujo		= 1
							OR	estado_Flujo		= 2 and fecha_termino = @dFecPro
							)
                           
						SET @Capital_P    = 0.0            
						SET @Plazo_P      = 0            
						SET @Moneda_P     = 999            
						SET @Duration_P   = 0            
            
						SELECT	@Capital_P			= venta_capital + Venta_Flujo_Adicional
						,		@Plazo_P			= CASE	WHEN Venta_codigo_tasa  = 0 THEN DATEDIFF(d,@dFecPro,fecha_termino)
															ELSE                             DATEDIFF(d,@dFecPro,fecha_vence_flujo)
														END
						,		@Moneda_P			= venta_moneda
						,		@Duration_P			= CASE WHEN vDurMacaulPasivo < 0 THEN 0.0 ELSE vDurMacaulPasivo END
						FROM	BacSwapSuda.dbo.CARTERA with(nolock)
						WHERE	numero_operacion	= @nNumoper
						and		Tipo_flujo			= 2
						and	(	estado_flujo		= 1
							OR	estado_Flujo		= 2 and fecha_termino = @dFecPro
							)             

						EXECUTE SP_Riesgo_Potencial_Futuro		@nNumoper
															,	@cSistema
															,	@cProducto
															,	@Tipo_Oper
															,	@Capital_A
															,	@Capital_P
															,	@Plazo_A
															,	@Plazo_P
															,	@Moneda_A
															,	@Moneda_P
															,	@Duration_A
															,	@Duration_P
															,	@dFecPro
															,	@SubTotal OUTPUT
															,	@Prc      OUTPUT

						EXECUTE dbo.SP_LCR_VRAZONABLE_NEGATIVO	@dFecPro
															,	@cSistema
															,	@nNumoper
															,	@SubTotal
															,	@Utilidadlin_pesos
															,	@TotalGeneral OUTPUT            

						SET @nMontolin_pesos  = ROUND(@TotalGeneral,0)
        
						--> Se modifico por Dolar Contable            
						SET		@nMontolin			= @TotalGeneral
						SELECT  @nMontolin			= ROUND(@TotalGeneral / CASE WHEN @cMonedaOp = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						FROM  BacParamSuda.dbo.VALOR_MONEDA	with(nolock) 
						WHERE   vmfecha				= @dFechaHoy
						AND     vmcodigo			= CASE WHEN @cMonedaOp = 13 THEN 994 ELSE @cMonedaOp END

						--> Se modifico por Dolar Contable            
						SET		@nMontoLinGen		= @TotalGeneral
						
						--+++CONTROL IDD, jcamposd
						------SELECT  @nMontoLinGen		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						------FROM    LINEA_GENERAL					with(nolock) 
						------,		BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						------WHERE   rut_cliente			= @nRutcli
						------AND     codigo_cliente		= @nCodigo
						------AND     vmfecha				= @dFechaHoy
						------AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END
						
						SELECT  @nMontoLinGen		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						FROM  BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						WHERE  vmfecha				= @dFechaHoy
						AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN 994 ELSE @cMonedaOp END
						-----CONTROL IDD, jcamposd
            
						SET		@SoloCnvLinPro		= 1            

						--> Se modifico por Dolar Contable 
						--+++CONTROL IDD, jcamposd           
						------SET		@nMontoLinSis		= @TotalGeneral
						------SELECT  @nMontoLinSis		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						------,       @SoloCnvLinPro		= vmvalor            
						------FROM    LINEA_SISTEMA					with(nolock)
						------,       BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						------WHERE   rut_cliente			= @nRutcli             
						------AND     codigo_cliente		= @nCodigo             
						------AND     id_sistema			= @cSistema            
						------AND     vmfecha				= @dFechaHoy            
						------AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END            
            
						------SET @nMontoLinPro			= @TotalGeneral / @SoloCnvLinPro  -- Mientras no se grabe bien lo de la moneda x plazo                  
						--------> Se modifico por Dolar Contable
						------SELECT  @nMontoLinPro		= ROUND(@TotalGeneral / CASE WHEN vmcodigo = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						------FROM    LINEA_PRODUCTO_POR_PLAZO		with(nolock)
						------,       BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						------WHERE   rut_cliente			= @nRutcli
						------AND     codigo_cliente		= @nCodigo
						------AND     id_sistema			= @cSistema
						------AND     codigo_producto		= @cProducto
						------AND	(	incodigo			= @incodigo or incodigo = 0 or @incodigo = 0)
						------AND     plazodesde			<= @nPlazoProdPla
						------AND     plazohasta			>= @nPlazoProdPla
						------AND     vmfecha				= @dFechaHoy
						------AND     vmcodigo			= mncodmon
						
						SET @nMontolin_pesos	= @nMontolin_pesos
						SET @nMontolin			= @nMontolin
						------SET @nMontoLinPro		= @nMontoLinPro
						------SET @nMontoLinSis		= @nMontoLinSis
						SET @nMontoLinGen		= @nMontoLinGen
						
						-----CONTROL IDD, jcamposd
            
						IF @cProducto = 'ST'
							SET @cProducto = '3'

						IF @cProducto = 'SM'
							SET @cProducto = '2'
		END
		ELSE
		BEGIN

						SET @Serie_Valor  = ''            
						SET @Tipo_Oper    = ''            
						SET @Capital_A    = 0.0            
						SET @Plazo_A      = 0            
						SET @Moneda_A     = 999            
						SET @Duration_A   = 0            

						SELECT	@Capital_A			= compra_capital + compra_flujo_adicional            
						,		@Plazo_A			= CASE	WHEN Compra_codigo_tasa  = 0 THEN DATEDIFF(d,@dFecPro,fecha_Termino)
															ELSE                              DATEDIFF(d,@dFecPro,fecha_vence_Flujo)
														END
						,		@Moneda_A			= compra_moneda
						,		@Duration_A			= CASE WHEN vDurMacaulActivo < 0 THEN 0.0 ELSE vDurMacaulActivo  END
						FROM	BacSwapNY.dbo.CARTERA with(nolock)
						WHERE	numero_operacion	= @nNumoper
						AND		Tipo_flujo			= 1
						AND	(	estado_flujo		= 1
							OR	estado_Flujo		= 2 and fecha_termino = @dFecPro
							)
                           
						SET @Capital_P    = 0.0            
						SET @Plazo_P      = 0            
						SET @Moneda_P     = 999            
						SET @Duration_P   = 0            
            
						SELECT	@Capital_P			= venta_capital + Venta_Flujo_Adicional
						,		@Plazo_P			= CASE	WHEN Venta_codigo_tasa  = 0 THEN DATEDIFF(d,@dFecPro,fecha_termino)
															ELSE                             DATEDIFF(d,@dFecPro,fecha_vence_flujo)
														END
						,		@Moneda_P			= venta_moneda
						,		@Duration_P			= CASE WHEN vDurMacaulPasivo < 0 THEN 0.0 ELSE vDurMacaulPasivo END
						FROM	BacSwapNY.dbo.CARTERA with(nolock)
						WHERE	numero_operacion	= @nNumoper
						and		Tipo_flujo			= 2
						and	(	estado_flujo		= 1
							OR	estado_Flujo		= 2 and fecha_termino = @dFecPro
							)             

						EXECUTE SP_Riesgo_Potencial_Futuro		@nNumoper
															,	@cSistema
															,	@cProducto
															,	@Tipo_Oper
															,	@Capital_A
															,	@Capital_P
															,	@Plazo_A
															,	@Plazo_P
															,	@Moneda_A
															,	@Moneda_P
															,	@Duration_A
															,	@Duration_P
															,	@dFecPro
															,	@SubTotal OUTPUT
															,	@Prc      OUTPUT

						EXECUTE dbo.SP_LCR_VRAZONABLE_NEGATIVO	@dFecPro
															,	@cSistema
															,	@nNumoper
															,	@SubTotal
															,	@Utilidadlin_pesos
															,	@TotalGeneral OUTPUT            

						SET @nMontolin_pesos  = ROUND(@TotalGeneral,0)
        
						--> Se modifico por Dolar Contable            
						SET		@nMontolin			= @TotalGeneral
						SELECT  @nMontolin			= ROUND(@TotalGeneral / CASE WHEN @cMonedaOp = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						FROM    BacParamSuda.dbo.VALOR_MONEDA	with(nolock) 
						WHERE   vmfecha				= @dFechaHoy
						AND     vmcodigo			= CASE WHEN @cMonedaOp = 13 THEN 994 ELSE @cMonedaOp END

						--> Se modifico por Dolar Contable            
						SET		@nMontoLinGen		= @TotalGeneral
						--+++CONTROL IDD, jcamposd
						------SELECT  @nMontoLinGen		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						------FROM    LINEA_GENERAL					with(nolock) 
						------,		BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						------WHERE   rut_cliente			= @nRutcli
						------AND     codigo_cliente		= @nCodigo
						------AND     vmfecha				= @dFechaHoy
						------AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END
            
						SELECT  @nMontoLinGen		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						FROM    BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						WHERE vmfecha				= @dFechaHoy
								AND     vmcodigo	= CASE WHEN RTRIM(LTRIM( @cMonedaOp )) = 13 THEN 994 ELSE @cMonedaOp END
						-----CONTROL IDD, jcamposd
            
						SET		@SoloCnvLinPro		= 1            

						--> Se modifico por Dolar Contable     
						--+++CONTROL IDD, jcamposd       
						------SET		@nMontoLinSis		= @TotalGeneral
						------SELECT  @nMontoLinSis		= ROUND(@TotalGeneral / CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						------,       @SoloCnvLinPro		= vmvalor            
						------FROM    LINEA_SISTEMA					with(nolock)
						------,       BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						------WHERE   rut_cliente			= @nRutcli             
						------AND     codigo_cliente		= @nCodigo             
						------AND     id_sistema			= @cSistema            
						------AND     vmfecha				= @dFechaHoy            
						------AND     vmcodigo			= CASE WHEN RTRIM(LTRIM( moneda )) = 13 THEN 994 ELSE moneda END            
            
						------SET @nMontoLinPro			= @TotalGeneral / @SoloCnvLinPro  -- Mientras no se grabe bien lo de la moneda x plazo                  
						--------> Se modifico por Dolar Contable
						------SELECT  @nMontoLinPro		= ROUND(@TotalGeneral / CASE WHEN vmcodigo = 13 THEN @fTipcambio ELSE ISNULL(vmvalor,1) END, 4)
						------FROM    LINEA_PRODUCTO_POR_PLAZO		with(nolock)
						------,       BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						------WHERE   rut_cliente			= @nRutcli
						------AND     codigo_cliente		= @nCodigo
						------AND     id_sistema			= @cSistema
						------AND     codigo_producto		= @cProducto
						------AND	(	incodigo			= @incodigo or incodigo = 0 or @incodigo = 0)
						------AND     plazodesde			<= @nPlazoProdPla
						------AND     plazohasta			>= @nPlazoProdPla
						------AND     vmfecha				= @dFechaHoy
						------AND     vmcodigo			= mncodmon

						SET @nMontolin_pesos	= @nMontolin_pesos
						SET @nMontolin			= @nMontolin
						------SET @nMontoLinPro		= @nMontoLinPro
						------SET @nMontoLinSis		= @nMontoLinSis
						SET @nMontoLinGen		= @nMontoLinGen
            
						-----CONTROL IDD, jcamposd
						
						IF @cProducto = 'ST'
							SET @cProducto = '3'

						IF @cProducto = 'SM'
							SET @cProducto = '2'
					

		END
	
	
	END
    

	--+++CONTROL IDD, jcamposd           
    SET		@iFound				= 1
	--SET		@iFound				= 0
	--SELECT	@iFound				= 1
	--,		@nDisponible		= totaldisponible
	--,		@cBloqueado			= bloqueado
	--,		@dFecvctolinea		= fechavencimiento
	--FROM	LINEA_GENERAL       with(nolock)
	--WHERE	rut_cliente			= @nRutcli
	--AND		codigo_cliente		= @nCodigo
	-----CONTROL IDD, jcamposd
	               
	IF @iFound = 1             
	BEGIN            
		DECLARE @nValMoneda   FLOAT            
			SET @nValMoneda		= ISNULL((	SELECT	ISNULL(vmvalor, 1.0)
											FROM	BacParamSuda.dbo.VALOR_MONEDA			with(nolock)
											WHERE	vmfecha      = @dFechaHoy
											and		vmcodigo     = CASE WHEN @Moneda_A = 13 THEN 994 ELSE @Moneda_A END), 1.0)
		IF @Moneda_A <> 998            
			SET @nValMoneda		= ISNULL((	SELECT	ISNULL(Tipo_Cambio, 1.0)
											FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE	with(nolock)
											WHERE	Fecha         = @dFechaHoy
											and		Codigo_Moneda = CASE WHEN @Moneda_A = 13 THEN 994 ELSE @Moneda_A END), 1.0)
		IF @Moneda_A = 13
			SET @nValMoneda		= ISNULL((	SELECT	ISNULL(Tipo_Cambio, 1.0)
											FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE	with(nolock)
											WHERE	Fecha         = @dFechaHoy
											and		Codigo_Moneda = 994), 1.0)

		IF @SW = 1           
		BEGIN          
			IF @MetodoLCR in (1,4)     
			BEGIN
				SET  @nMontoLinGen = CASE	WHEN @MetodoLCR = 4 THEN 
												case when @nMontoLinGen - @Garantia > 0 then @nMontoLinGen - @Garantia else 0.0 end
											ELSE @nMontoLinGen 
										END
				--+++CONTROL IDD, jcamposd										
				------SET  @nMontoLinSis = CASE	WHEN @MetodoLCR = 4 THEN 
				------								case when @nMontoLinSis - @Garantia > 0  then @nMontoLinSis - @Garantia else 0.0 end
				------							ELSE @nMontoLinSis 
				------					END
				-----CONTROL IDD, jcamposd
				
				SELECT	@cMensaje = 'Linea pendiente control IDD ' + @cNombre
			,		@cError   = 'S'
			,       @nExceso  = 0
			,		@nCorrDet = @nCorrDet + 1
				
				INSERT INTO LINEA_TRANSACCION
				(		numerodocumento
				,		numerooperacion
				,		numerocorrelativo
				,		rut_cliente
				,		codigo_cliente
				,		id_sistema
				,		codigo_producto
				,		tipo_operacion
				,		tipo_riesgo
				,		fechainicio
				,		fechavencimiento
				,		montooriginal
				,		tipocambio
				,		matrizriesgo
				,		montotransaccion
				,		operador
				,		activo
				,		Resultado
				,		MetodoLCR
				,		Garantia
				)            
				SELECT	@nNumdocu
				,		@nNumoper
				,		@nCorrela
				,		@nRutcli
				,		@nCodigo
				,		@cSistema
				,		@cProducto
				,		''
				,		@cTipo_Riesgo
				,		@dFeciniop
				,		@dFecvctop
				,		(CASE WHEN @cSistema IN('BFW', 'PCS', 'OPT') THEN ISNULL(@subtotal , 0) ELSE @nMontolin_pesos END)
				,		@fTipcambio
				,		ROUND((CASE WHEN @cSistema IN('BFW', 'PCS', 'OPT') THEN ROUND(@Prc, 8)  ELSE @nMatrizriesgo	END), 8)
				,		ISNULL( @TotalGeneral - @subtotal, 0)
				,		@cUsuario
				,		'S'
				,		0
				,		@MetodoLCR
				,		@Garantia
				FROM    PRODUCTO_SISTEMA	with(nolock)
				WHERE   @cProducto   = codigo_producto
				AND     @cSistema    = id_sistema
				
				INSERT INTO LINEA_TRANSACCION_DETALLE
				(		NumeroOperacion
				,		NumeroDocumento
				,		NumeroCorrelativo
				,		NumeroCorre_Detalle
				,		Rut_Cliente
				,		Codigo_Cliente
				,		Id_Sistema
				,		Codigo_Producto
				,		Tipo_Detalle
				,		Tipo_Movimiento
				,		Linea_Transsaccion
				,		MontoTransaccion
				,		MontoExceso
				,		PlazoDesde
				,		PlazoHasta
				,		Actualizo_Linea
				,		Error
				,		Mensaje_Error
				,		instrumento
				,		moneda
				,		forma_pago
				)
				SELECT	@nNumoper
				,		@nNumdocu
				,		@nCorrela
				,		@nCorrDet
				,		@nRutcli
				,		@nCodigo
				,		@cSistema
				,		@cProducto
				,		@cTipoControl
				,		@cTipoMov
				,		'LINIDD'
				,		(CASE WHEN @cSistema IN('BFW', 'PCS', 'OPT') THEN ISNULL(ROUND(@TotalGeneral,0) , 0) ELSE ROUND(@nMontolin_pesos,0) END)
				,		0--@nExceso
				,		0
				,		0
				,		'S'
				,		@cError
				,		@cMensaje
				,		0
				,		@cMonedaOp
				,		@formapago	
				
				--+++CONTROL IDD, jcamposd	
                 if  Baclineas.dbo.Fn_Mesa_Cerrada( @cSistema ) = 'N' -- Imputación Online
						INSERT INTO Transacciones_IDD
							(	cModulo
							,cProducto
							,nOperacion
							,nDocumento
							,iCorrelativo
							,nIncodigo
							,nMoneda
							,nMontoOperacion
							,nPlazo		
							,iRut		
							,iCodigo		
							,nMontoLimite
							,sTrader		
							,sAprobador	
							,iEstadoIdd	
							,sEstadoCF		
							,Fecha			
							,Hora			
							,sMensajeIdd		
							,nNumeroIdd		
							,sControlLinea)

						SELECT
							@cSistema
							,@cProducto
							,@nNumoper
							,@nNumdocu
							,@nCorrela
							,@incodigo
							,999 -- @cMonedaOp
							,(CASE WHEN @cSistema IN('BFW', 'PCS', 'OPT') THEN ISNULL(ROUND(@TotalGeneral,0) , 0) ELSE ROUND(@nMontolin_pesos,0) END)
							,DATEDIFF(DAY, @dFecPro, @dFecvctop)
							,@nRutcli
							,@nCodigo
							,0
							,@cUsuario
							,''
							,'P' --"P" = Pendiente / "A" = Anulado / "R" = Rechazado / "X" = Otro
							, 0  --"0" = No procesado, este estado inicial es el generado cuando la operación es grabada /"1" = En proceso, este estado es el actualizado /"2" = Procesado, ya cuenta con numero IDD
							, @dFecPro -- convert(datetime, convert(char(10), getdate(), 112), 112)
							, convert(datetime, convert(char(10), getdate(), 108), 112)
							,'Linea pendiente control IDD'
							,0
							,'N'
							--  select * from Transacciones_IDD
				
		END 
		--+++CONTROL IDD, jcamposd
		------ELSE     -- PRD8800
		
		
		------IF @Id_SistemaNetting = 'DRV'
		------BEGIN

		------	INSERT INTO LINEA_TRANSACCION    
		------	(		numerodocumento    
		------	,		numerooperacion    
		------	,		numerocorrelativo   
		------	,		rut_cliente    
		------	,		codigo_cliente    
		------	,		id_sistema    
		------	,		codigo_producto    
		------	,		tipo_operacion    
		------	,		tipo_riesgo    
		------	,		fechainicio    
		------	,		fechavencimiento    
		------	,		montooriginal    
		------	,		tipocambio    
		------	,		matrizriesgo    
		------	,		montotransaccion    
		------	,		operador    
		------	,		activo    
		------	,		Resultado                  
		------	,		MetodoLCR                                   
		------	,		Garantia    
		------	)    
		------	SELECT	@nNumdocu    
		------	,		@nNumoper    
		------	,		@nCorrela    
		------	,		@nRutcli    
		------	,		@nCodigo    
		------	,		@cSistema    
		------	,		@cProducto    
		------	,		''    
		------	,		@cTipo_Riesgo    
		------	,		@dFeciniop    
		------	,		@dFecvctop    
		------	,		0    
		------	,		@fTipcambio    
		------	,		0    
		------	,		0    
		------	,		@cUsuario     
		------	,		'S'    
		------	,		@Resultado    
		------	,		@MetodoLCR    
		------	,		@Garantia     
		------	FROM    PRODUCTO_SISTEMA	with(nolock)
		------	WHERE   @cProducto   = codigo_producto
		------	AND     @cSistema = id_sistema

		------	EXECUTE SP_ACTUALIZA_REGISTRO_LINEAS_DERIVADOS		@dFecPro    
		------													,	@cSistema    
		------													,	@cProducto    
		------													,	@nRutcli    
		------													,	@nCodigo    
		------													,	@nNumoper    
		------													,	@nNumdocu   -- @nNumPantalla    
		------													,	@nCorrela   -- @NumeroCorrelativo    
		------													,	@dFecPro    
		------													,	@nMonto    
		------													,	@fTipcambio    
		------													,	@dFecvctop    
		------													,	@cUsuario    
		------													,	@cMonedaOp  -- @nMonedaOp    
		------													,	@cTipo_Riesgo    
		------													,	@incodigo   --@nInCodigo    
		------													,	@FormaPago    
		------													,	@nContraMoneda    
		------													,	@nMonedaOpera    
		------												--  ,	@SwithEjecucion    
		------													,	@Resultado          
		------													,	@MetodoLCR          
		------													,	@Garantia          
		------													,	@Id_SistemaNetting     
		------	RETURN    
		------END    
		-----CONTROL IDD, jcamposd
		
	END -- PRD8800    

	--*************************************            
	--***************            
    --*************** LINEA GENERAL            
    --***************            
    --*************************************            
    --+++COTROL IDD, jcamposd       
	--------IF @cBloqueado = 'S'             
	--------   BEGIN --** Linea General Bloqueada para operar **--            
	--------	SELECT	@cMensaje = 'Linea General Bloqueada Para ' + @cNombre              
	--------       ,		@cError   = 'S'             
	--------       ,		@nExceso  = 0              
	--------       ,		@nCorrDet = @nCorrDet + 1            
            
	--------	INSERT INTO LINEA_TRANSACCION_DETALLE            
	--------	(		NumeroOperacion
	--------	,		NumeroDocumento
	--------	,		NumeroCorrelativo
	--------	,		NumeroCorre_Detalle
	--------	,		Rut_Cliente
	--------	,		Codigo_Cliente
	--------	,		Id_Sistema
	--------	,		Codigo_Producto
	--------	,		Tipo_Detalle
	--------	,		Tipo_Movimiento
	--------	,		Linea_Transsaccion
	--------	,		MontoTransaccion
	--------	,		MontoExceso
	--------	,		PlazoDesde
	--------	,		PlazoHasta
	--------	,		Actualizo_Linea
	--------	,		Error
	--------	,		Mensaje_Error
	--------	,		instrumento
	--------	,		moneda
	--------	,		forma_pago
	--------	)
	--------	SELECT	@nNumoper
	--------	,		@nNumdocu
	--------	,		@nCorrela
	--------	,		@nCorrDet
	--------	,		@nRutcli
	--------	,		@nCodigo
	--------	,		@cSistema
	--------	,		@cProducto
	--------	,		@cTipoControl
	--------	,		@cTipoMov
	--------	,		'LINGEN'
	--------	,		@nMontoLinGen
	--------	,		@nExceso
	--------	,		0
	--------	,		0
	--------	,		'S'
	--------	,		@cError
	--------	,		@cMensaje
	--------	,		0
	--------	,		@cMonedaOp
	--------	,		@formapago
	--------END
            
	--------IF @dFecPro > @dFecvctolinea            
	--------   BEGIN            
	--------	SELECT	@cMensaje = 'Linea General Vencida Para ' + @cNombre
	--------	,		@cError   = 'S'
	--------	,		@nExceso  = 0
	--------	,		@nCorrDet = @nCorrDet + 1
            
	--------	INSERT INTO LINEA_TRANSACCION_DETALLE
	--------	(		NumeroOperacion
	--------	,		NumeroDocumento
	--------	,		NumeroCorrelativo
	--------	,		NumeroCorre_Detalle
	--------	,		Rut_Cliente
	--------	,		Codigo_Cliente
	--------	,		Id_Sistema
	--------	,		Codigo_Producto
	--------	,		Tipo_Detalle
	--------	,		Tipo_Movimiento
	--------	,		Linea_Transsaccion
	--------	,		MontoTransaccion
	--------	,		MontoExceso
	--------	,		PlazoDesde
	--------	,		PlazoHasta
	--------	,		Actualizo_Linea
	--------	,		Error
	--------	,		Mensaje_Error
	--------	,		instrumento
	--------	,		moneda
	--------	,		forma_pago
	--------	)
	--------	SELECT	@nNumoper
	--------	,		@nNumdocu
	--------	,		@nCorrela
	--------	,		@nCorrDet
	--------	,		@nRutcli
	--------	,		@nCodigo
	--------	,		@cSistema
	--------	,		@cProducto
	--------	,		@cTipoControl
	--------	,		@cTipoMov
	--------	,		'LINGEN'
	--------	,		@nMontoLinGen
	--------	,		@nExceso
	--------	,		0
	--------	,		0
	--------	,		'S'
	--------	,		@cError
	--------	,		@cMensaje
	--------	,		0
	--------	,		@cMonedaOp
	--------	,		@formapago
	--------END
    -----COTROL IDD, jcamposd        
	---------------------------------------------------            

	--+++CONTROL IDD, jcamposd
	------/*******************  COMDER *****************************/	
	-------- PRD21119-Consumo Línea Derivados COMDER
	------	SET @RutComder = 0
	------	SELECT @RutComder = acRutComder FROM bacfwdsuda.dbo.MFAC with(nolock)
	------	IF @nRutcli = @RutComder
	------	BEGIN
	------		SET @nMontoLinGen = 0.0
	------	END
	------/*********************************************************/	
		
	------    IF @nDisponible < 0             
	------		SET @nExceso = @nMontoLinGen * (-1)
	------	ELSE
	------		SET @nExceso = @nDisponible - @nMontoLinGen
	            
	------	UPDATE	LINEA_GENERAL
	------    SET		totalocupado		= totalocupado    + @nMontoLinGen
	------	,		totaldisponible		= totaldisponible - @nMontoLinGen
	------    WHERE	rut_cliente			= @nRutcli
	------	AND		codigo_cliente		= @nCodigo
	------	AND		@Id_SistemaNetting  <> 'DRV'	/*	IN (SELECT DISTINCT ID_SISTEMA FROM BACLINEAS..TBL_AGRPROD)     
	------    AND		@MetodoLCR			IN (1,4)	*/
	------	--------------------------------------------------------        

	------	IF @nExceso < 0            
	------		SELECT	@cMensaje = 'Limite General Excedido Para ' + @cNombre
	------		,		@cError   = 'S'
	------		,		@nExceso  = @nExceso * (-1)
	------	ELSE            
	------		SELECT	@cMensaje = ''
	------		,		@cError   = 'N'
	------		,		@nExceso  = 0
	            
	------	SET @nCorrDet = @nCorrDet + 1
	            
	------	INSERT INTO LINEA_TRANSACCION_DETALLE            
	------	(		NumeroOperacion
	------	,		NumeroDocumento
	------	,		NumeroCorrelativo
	------	,		NumeroCorre_Detalle
	------	,		Rut_Cliente
	------	,		Codigo_Cliente
	------	,		Id_Sistema
	------	,		Codigo_Producto
	------	,		Tipo_Detalle
	------	,		Tipo_Movimiento
	------	,		Linea_Transsaccion
	------	,		MontoTransaccion
	------	,		MontoExceso
	------	,		PlazoDesde
	------	,		PlazoHasta
	------	,		Actualizo_Linea
	------	,		Error
	------	,		Mensaje_Error
	------	,		instrumento
	------	,		moneda
	------	,		forma_pago
	------	)
	------	SELECT	@nNumoper
	------	,		@nNumdocu
	------	,		@nCorrela
	------	,		@nCorrDet
	------	,		@nRutcli
	------	,		@nCodigo
	------	,		@cSistema
	------	,		@cProducto
	------	,		@cTipoLinea
	------	,		@cTipoMov
	------	,		'LINGEN'
	------	,		@nMontoLinGen
	------	,		@nExceso
	------	,		0
	------	,		0
	------	,		'S'
	------	,		@cError
	------	,		@cMensaje
	------	,		0
	------	,		@cMonedaOp
	------	,		@formapago
	
	-----CONTROL IDD, jcamposd

	--*************************************            
    --***************             
    --*************** LINEA SISTEMA            
    --***************             
    --*************************************            

	--+++CONTROL IDD, jcamposd
	------SET		@nDisponible	= 0
	------   SELECT	@nDisponible	= totaldisponible
	------,		@cBloqueado		= bloqueado
	------,		@dFecvctolinea	= fechavencimiento
	------FROM	LINEA_SISTEMA	with(nolock)
	------WHERE	rut_cliente		= @nRutcli
	------   AND		codigo_cliente	= @nCodigo
	------   AND		id_sistema		= @cSistema
            
	------IF @cBloqueado = 'S'  --** Linea Sistema Bloqueada para operar **--            
	------   BEGIN            
	------	SELECT	@cMensaje = 'Linea Sistema Bloqueada Para ' + @cNombre
	------	,		@cError   = 'S'
	------	,       @nExceso  = 0
	------	,		@nCorrDet = @nCorrDet + 1
            
	------	INSERT INTO LINEA_TRANSACCION_DETALLE
	------	(		NumeroOperacion
	------	,		NumeroDocumento
	------	,		NumeroCorrelativo
	------	,		NumeroCorre_Detalle
	------	,		Rut_Cliente
	------	,		Codigo_Cliente
	------	,		Id_Sistema
	------	,		Codigo_Producto
	------	,		Tipo_Detalle
	------	,		Tipo_Movimiento
	------	,		Linea_Transsaccion
	------	,		MontoTransaccion
	------	,		MontoExceso
	------	,		PlazoDesde
	------	,		PlazoHasta
	------	,		Actualizo_Linea
	------	,		Error
	------	,		Mensaje_Error
	------	,		instrumento
	------	,		moneda
	------	,		forma_pago
	------	)
	------	SELECT	@nNumoper
	------	,		@nNumdocu
	------	,		@nCorrela
	------	,		@nCorrDet
	------	,		@nRutcli
	------	,		@nCodigo
	------	,		@cSistema
	------	,		@cProducto
	------	,		@cTipoControl
	------	,		@cTipoMov
	------	,		'LINSIS'
	------	,		@nMontoLinSis
	------	,		@nExceso
	------	,		0
	------	,		0
	------	,		'S'
	------	,		@cError
	------	,		@cMensaje
	------	,		0
	------	,		@cMonedaOp
	------	,		@formapago
	------END

	------IF @dFecPro>@dFecvctolinea            
	------   BEGIN            
	------	SELECT	@cMensaje = 'Linea Sistema Vencida Para ' + @cNombre
	------	,		@cError   = 'S'
	------	,		@nExceso  = 0
	------	,		@nCorrDet = @nCorrDet + 1
                  
	------	INSERT INTO LINEA_TRANSACCION_DETALLE
	------	(		NumeroOperacion
	------	,		NumeroDocumento
	------	,		NumeroCorrelativo
	------	,		NumeroCorre_Detalle
	------	,		Rut_Cliente
	------	,		Codigo_Cliente
	------	,		Id_Sistema
	------	,		Codigo_Producto
	------	,		Tipo_Detalle
	------	,		Tipo_Movimiento
	------	,		Linea_Transsaccion
	------	,		MontoTransaccion
	------	,		MontoExceso
	------	,		PlazoDesde
	------	,		PlazoHasta
	------	,		Actualizo_Linea
	------	,		Error
	------	,		Mensaje_Error
	------	,		instrumento
	------	,		moneda
	------	,		forma_pago
	------	)
	------	SELECT	@nNumoper
	------	,		@nNumdocu
	------	,		@nCorrela
	------	,		@nCorrDet
	------	,		@nRutcli
	------	,		@nCodigo
	------	,		@cSistema
	------	,		@cProducto
	------	,		@cTipoControl
	------	,		@cTipoMov
	------	,		'LINSIS'
	------	,		@nMontoLinSis
	------	,		@nExceso
	------	,		0
	------	,		0
	------	,		'S'
	------	,		@cError
	------	,		@cMensaje
	------	,		0
	------	,		@cMonedaOp
	------	,		@formapago
	------END
            
	------IF @nDisponible < 0
	------	SET @nExceso = @nMontoLinSis * (-1)
	------ELSE            
	------	SET @nExceso = @nDisponible - @nMontoLinSis

	------UPDATE LINEA_SISTEMA
	------   SET    totalocupado    = totalocupado    + @nMontoLinSis            
	------   ,      totaldisponible = totaldisponible - @nMontoLinSis              
	------WHERE  rut_cliente     = @nRutcli 
	------   AND    codigo_cliente  = @nCodigo             
	------   AND    id_sistema      = @cSistema            

	------IF @nExceso < 0            
	------	SELECT	@cMensaje = 'Limite Sistema Excedido Para ' + @cNombre
	------	,		@cError   = 'S'
	------	,       @nExceso  = @nExceso * (-1)
	------ELSE            
	------	SELECT	@cMensaje = ''
	------	,		@cError   = 'N'
	------       ,		@nExceso  = 0
            
	------SET @nCorrDet = @nCorrDet + 1            
            
	------INSERT INTO LINEA_TRANSACCION_DETALLE            
	------(		NumeroOperacion
	------,		NumeroDocumento
	------,		NumeroCorrelativo
	------,		NumeroCorre_Detalle
	------,		Rut_Cliente
	------,		Codigo_Cliente
	------,		Id_Sistema
	------,		Codigo_Producto
	------,		Tipo_Detalle
	------,		Tipo_Movimiento
	------,		Linea_Transsaccion
	------,		MontoTransaccion
	------,		MontoExceso
	------,		PlazoDesde
	------,		PlazoHasta
	------,		Actualizo_Linea
	------,		Error
	------,		Mensaje_Error
	------,		instrumento
	------,		moneda
	------,		forma_pago
	------)
	------SELECT	@nNumoper
	------,		@nNumdocu
	------,		@nCorrela
	------,		@nCorrDet
	------,		@nRutcli
	------,		@nCodigo
	------,		@cSistema
	------,		@cProducto
	------,		@cTipoLinea
	------,		@cTipoMov
	------,		'LINSIS'
	------,		@nMontoLinSis
	------,		@nExceso
	------,		0
	------,		0
	------,		'S'
	------,		@cError
	------,		@cMensaje
	------,		0
	------,		@cMonedaOp
	------,		@formapago
	--+++CONTROL IDD, jcamposd


	--*************************************            
	--***************             
    --*************** LINEA POR PRODUCTO PLAZO            
    --***************             
    --*************************************            

	--+++CONTROL IDD, jcamposd
	------   SET @cCtrlplazo = 'S'            

	------IF @cCtrlplazo = 'S'
	------   BEGIN
	------	SET @ndisponible = 0
	------	-- Cambio el 01/06/2004
	------       IF @cProducto = 'CP' AND @cSistema = 'BTR'
	------       BEGIN        
	------		SET @incodigo	= @incodigo            
	------           SET @formapago	= @formapago            
	------           SET @cMonedaOp	= @cMonedaOp            
	------	END ELSE             
	------       BEGIN            
	------		IF (@cProducto <> 'ICOL' AND @cSistema <> 'BTR' AND @cSistema <> 'BEX')
	------			SET @incodigo = 0

	------		SET @formapago = 0
	------		SET @cMonedaOp = 0
	------	END            

	------	IF @cProducto = 'ICAP'            
	------	BEGIN   
	------		/*
	------		INSERT INTO ERRORES_CARGA            
	------           VALUES ( @dFecPro, @cSistema, @nRutcli, @nCodigo, @cProducto, @dFecvctop, @nNumoper )
	------		*/
	------           EXECUTE Sp_Lineas_Actualiza
	------           RETURN
	------	END

	------	DECLARE @nnPlazoProdPla   NUMERIC(9)            
	------		SET @nnPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)            
            
	------	EXECUTE dbo.SP_VALIDA_LINPRODUCTO_PLAZO @nRutcli, @nCodigo, @cSistema, @cProducto, @incodigo, @nnPlazoProdPla

	------	SET ROWCOUNT 1
	------	SELECT @nPlazoDesde		=	ISNULL(PlazoDesde, 0)
	------       ,      @nPlazoHasta		=	ISNULL(PlazoHasta, 0)
	------       ,      @ndisponible		=	Totaldisponible
	------       FROM   LINEA_PRODUCTO_POR_PLAZO with(nolock)
	------       WHERE  rut_cliente		=	@nRutcli
	------       AND    codigo_cliente	=	@nCodigo
	------       AND    id_sistema		=	@cSistema
	------       AND    codigo_producto	=	@cProducto
	------       AND   (incodigo			=	@incodigo) -->  or incodigo = 0 or @incodigo = 0)
	------       AND   plazodesde		<=	@nnPlazoProdPla
	------       AND plazohasta		>=	@nnPlazoProdPla
	------	SET ROWCOUNT 0
            
	------	IF @nplazodesde = null            
	------       BEGIN            
	------		IF @MetodoLCR not in ( 2,3,5,6)  -- PRD 21119 - Consumo de Línea derivados ComDer
	------		BEGIN
	------			EXECUTE Sp_Lineas_Actualiza
	------			RETURN
	------		END
	------	END

	------	IF @nplazohasta = null
	------       BEGIN            
	------		IF @MetodoLCR not in ( 2,3,5,6)  -- PRD 21119 - Consumo de Línea derivados ComDer
	------		BEGIN
	------			EXECUTE Sp_Lineas_Actualiza
	------			RETURN
	------		END
	------	END

	------	IF @nDisponible < 0            
	------		SET @nExceso = @nMontoLinSis * (-1)
	------	ELSE            
	------		SET @nExceso = @nDisponible - @nMontoLinSis
            
	------	UPDATE  LINEA_PRODUCTO_POR_PLAZO            
	------       SET     totalocupado		= totalocupado		+ @nMontoLinSis
	------	,		totaldisponible		= totaldisponible	- @nMontoLinSis
	------	WHERE   rut_cliente			= @nRutcli                
	------       AND     codigo_cliente		= @nCodigo                
	------       AND     id_sistema			= @cSistema                
	------       AND     codigo_producto		= @cProducto          
	------       AND	(	incodigo			= @incodigo)            
	------       AND     plazodesde			= @nPlazoDesde   --> AND plazodesde <= @nnPlazoProdPla            
	------       AND		plazohasta			= @nPlazoHasta   --> AND plazohasta >= @nnPlazoProdPla            

	------	IF @nExceso < 0            
	------		SELECT  @cMensaje	= 'Limite Plazo desde ' 
	------							+ RTRIM(LTRIM((CONVERT(CHAR(06),@nplazodesde)))) + ' Hasta ' +  RTRIM(LTRIM((CONVERT(CHAR(06),@nplazohasta))))
	------							+ ' Exedido Para ' + @cNombre
	------		,		@cError		= 'S'
	------		,		@nExceso	= @nExceso * (-1)
	------	ELSE
	------		SELECT	@cMensaje	= ''
	------		,		@cError		= 'N'
	------		,		@nExceso	= 0

	------	SET @nCorrDet  = @nCorrDet + 1

	------	INSERT INTO LINEA_TRANSACCION_DETALLE
	------       (		NumeroOperacion
	------	,		NumeroDocumento
	------	,		NumeroCorrelativo
	------	,		NumeroCorre_Detalle
	------	,		Rut_Cliente
	------	,		Codigo_Cliente
	------	,		Id_Sistema
	------	,		Codigo_Producto
	------	,		Tipo_Detalle
	------	,		Tipo_Movimiento
	------	,		Linea_Transsaccion
	------	,		MontoTransaccion
	------	,		MontoExceso
	------	,		PlazoDesde
	------	,		PlazoHasta
	------	,		Actualizo_Linea
	------	,		Error
	------	,		Mensaje_Error
	------	,		instrumento
	------	,		moneda
	------	,		forma_pago
	------	)
	------	SELECT	@nNumoper
	------	,		@nNumdocu
	------	,		@nCorrela
	------	,		@nCorrDet
	------	,		@nRutcli
	------	,		@nCodigo
	------	,		@cSistema
	------	,		@cProducto
	------	,		@cTipoLinea
	------	,		@cTipoMov
	------	,		'LINPZO'
	------	,		@nMontoLinSis
	------	,		@nExceso
	------	,		ISNULL(@nPlazoDesde,0)
	------	,		case when @cSistema <> 'BEX' then ISNULL(@nPlazoDesde,0) else isnull( @nnPlazoProdPla, 0 ) end
	------	,		'S'
	------	,		@cError
	------	,		@cMensaje
	------	,		0
	------	,		@cMonedaOp
	------	,		@formapago
	------END
	-----CONTROL IDD, jcamposd
	
	--+++CONTROL IDD, jcamposd
	------IF @SOBREMONTO > 0           
	------	SELECT @cMensaje = 'Monto ocupado del o los hijos es superior a lo asignado al Padre' --+ @cNombre
	------ELSE
	------	SELECT @cMensaje = '', @cError   = 'N', @nExceso  = 0

	------SET @nCorrDet = @nCorrDet + 1


	------INSERT INTO LINEA_TRANSACCION_DETALLE
	------(		NumeroOperacion
	------,		NumeroDocumento
	------,		NumeroCorrelativo
	------,		NumeroCorre_Detalle
	------,		Rut_Cliente
	------,		Codigo_Cliente
	------,		Id_Sistema
	------,		Codigo_Producto
	------,		Tipo_Detalle
	------,		Tipo_Movimiento
	------,		Linea_Transsaccion
	------,		MontoTransaccion
	------,		MontoExceso
	------,		PlazoDesde
	------,		PlazoHasta
	------,		Actualizo_Linea
	------,		Error
	------,		Mensaje_Error
	------,		instrumento
	------,		moneda
	------,		forma_pago
	------)
	------SELECT	@nNumoper
	------,		@nNumdocu
	------,		@nCorrela
	------,		@nCorrDet
	------,		@nRutcli
	------,		@nCodigo
	------,		@cSistema
	------,		@cProducto
	------,		'C'
	------,		@cTipoMov
	------,		'LINSIS'
	------,		@nMontoLinSis
	------,		@nExceso
	------,		0
	------,		0
	------,		'S'
	------,		@cError
	------,		@cMensaje
	------,		0
	------,		@cMonedaOp
	------,		@formapago

	------IF @MetodoLCR not in ( 2,3,5,6) -- PRD 21119 - Consumo de Línea derivados ComDer
	------BEGIN
	------	EXECUTE Sp_Lineas_Actualiza
	------END
	-----CONTROL IDD, jcamposd
	
	END ELSE
	BEGIN
		RETURN
	END

	SET NOCOUNT OFF

END
GO
