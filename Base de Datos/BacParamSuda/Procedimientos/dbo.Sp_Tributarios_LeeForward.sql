USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_LeeForward]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Tributarios_LeeForward]
	(	@dFechaAnalisis		DATETIME	)
AS
BEGIN

	SET NOCOUNT ON
	-- return -- Por mientras !!!
	-- Sp_Tributarios_LeeForward '20140930'

	----------------------------------------------------------------------------------------------------------------
	--	0.0				CONTROLES DE FECHA Y DE GENERACION DE FECHAS PARA DETERMINAR EL PERIODO				      --
	----------------------------------------------------------------------------------------------------------------

	DECLARE @cOrigen	VARCHAR(3)
		SET @cOrigen	= 'BFW'
	
	-->     [0.0] --> Control de Generación
	DECLARE @dFechaProceso			DATETIME
		SET @dFechaProceso			= ( SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock) )

	-->     [0.1] --> Control Sobre la Fecha de Generacion v/s Fecha de Proceso.
	IF @dFechaAnalisis >= @dFechaProceso
	BEGIN
		SELECT -1, 'La fecha de Análisis, debe ser menor a la fecha de Proceso. ' + convert(char(10), @dFechaProceso, 103)
		RETURN -1
	END

	-->     [0.2] --> Control de Fecha por Feriado ... Determina la fecha maxima de los Datos sobre la base de la fecha de Selección a Anlizar la inf.
	-->		SET @dFechaAnalisis		=	( SELECT MAX( cafechaproceso ) FROM BacFwdSuda.dbo.MfcaRes With(nolock) WHERE cafechaproceso <= @dFechaAnalisis )

	-->     [0.3] -- Definicion de Variables con Respecto al Periodo de la Selección de Datos
	DECLARE @dFechaCierrePeriodo	DATETIME   --> Fecha de Cierre. Para leer la Cartera [freeze]
	DECLARE @dFechaInicioPeriodo	DATETIME   --> Para leer los Vencimientos entre el Periodo
	DECLARE @dFechaCierreMes		DATETIME

	-->     [0.4] -- Proceso que Retorna las fechas de: Cierre del Periodo Anterior e Inicio de Lectura de Datos
	EXECUTE BacParamSuda.dbo.SP_Tributarios_fechaCierrePeriodo	@dFechaAnalisis
															,	@dFechaCierrePeriodo	OUTPUT
															,	@dFechaInicioPeriodo	OUTPUT
															,	@dFechaCierreMes		OUTPUT

	----------------------------------------------------------------------------------------------------------------
	--	1.0  CREACION DE ESTRUCTURAS PARA ALMACENAR LAS CARTERAS VIGENTE E HISTORICA ENTRE LAS FECHAS DE ANALISIS --
	----------------------------------------------------------------------------------------------------------------

	-->     [1.1]  -- Cartera Temporal para Almacenar el saldo a la fecha de cierre del periodo anterior
	CREATE TABLE #Tmp_CarteraSaldo
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Producto		VARCHAR(5)		NOT NULL DEFAULT('')
		,	Operacion		VARCHAR(5)		NOT NULL DEFAULT('')
		,	Rut				NUMERIC(15)		NOT NULL DEFAULT(0)
		,	Codigo			NUMERIC(9)		NOT NULL DEFAULT(0)
		,	FechaCierre		DATETIME		NOT NULL DEFAULT('')
		,	FechaTermino	DATETIME		NOT NULL DEFAULT('')
		,	Avr				NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		,	Signo			CHAR(1)			NOT NULL DEFAULT('')
		,	CuentaAvr		VARCHAR(20)		NOT NULL DEFAULT('')
		,   CtaRes          VARCHAR(20)     NOT NULL DEFAULT('') -- MAP 11-Sep-2014
		,	nMoneda1		INT				NOT NULL DEFAULT(0)
		,	nMoneda2		INT				NOT NULL DEFAULT(0)
		,   Var_moneda2     numeric(21)     NOT NULL DEFAULT(0)
		)

	-->     [1.2]  -- Cartera Temporal para Almacenar la Cartera Vigente a la Fecha de Analisis
	CREATE TABLE #Tmp_CarteraRes
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Producto		VARCHAR(5)		NOT NULL DEFAULT('')
		,	Operacion		VARCHAR(5)		NOT NULL DEFAULT('')
		,	Rut				NUMERIC(15)		NOT NULL DEFAULT(0)
		,	Codigo			NUMERIC(9)		NOT NULL DEFAULT(0)
		,	FechaCierre		DATETIME		NOT NULL DEFAULT('')
		,	FechaTermino	DATETIME		NOT NULL DEFAULT('')
		,	Avr				NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		,	Signo			CHAR(1)			NOT NULL DEFAULT('')
		,	CuentaAvr		VARCHAR(20)		NOT NULL DEFAULT('')
		,   CtaRes          VARCHAR(20)     NOT NULL DEFAULT('') -- MAP 11-Sep-2014
		,	nMoneda1		INT				NOT NULL DEFAULT(0)
		,	nMoneda2		INT				NOT NULL DEFAULT(0)
		,   Var_moneda2     numeric(21)     NOT NULL DEFAULT(0)
		)

	-->     [1.3]  -- Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Analisis
	CREATE TABLE #Tmp_CarteraHis
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Producto		VARCHAR(5)		NOT NULL DEFAULT('')
		,	Operacion		VARCHAR(5)		NOT NULL DEFAULT('')
		,	Rut				NUMERIC(15)		NOT NULL DEFAULT(0)
		,	Codigo			NUMERIC(9)		NOT NULL DEFAULT(0)
		,	FechaCierre		DATETIME		NOT NULL DEFAULT('')
		,	FechaTermino	DATETIME		NOT NULL DEFAULT('')
		,	Liquidacion		NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		,	Signo			CHAR(1)			NOT NULL DEFAULT('')
		,	CuentaLiq		VARCHAR(20)		NOT NULL DEFAULT('')
		,	nMoneda1		INT				NOT NULL DEFAULT(0)
		,	nMoneda2		INT				NOT NULL DEFAULT(0)
		,	ParMonedas		CHAR(10)		NOT NULL DEFAULT('')
		,	Cartera			char(1)			NOT NULL DEFAULT('')
		)

	-->		[1.4]  -- Cartera Temporal ajustes Externos de AVR
	               -- Son del tipo AL
	CREATE TABLE #Tmp_CarteraAjustes
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Cuenta			VARCHAR(20)		NOT NULL DEFAULT('')
		,   CuentaRes       VARCHAR(50)		NOT NULL DEFAULT('') -- MAP 11-Sep-2014
		,	Ajuste			NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		)
	-->		[1.5]  -- Cartera Temporal con ajustes Externos Complementarios
	               -- Coberturas y desarmes
				   -- Son del tipo ACUMULATIVO

	-->		[1.4]  -- Cartera Temporal con las Coberturas del Periodo
	CREATE TABLE #Tmp_CarteraCob
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Cuenta			VARCHAR(20)		NOT NULL DEFAULT('')
		,	CuentaResultado	VARCHAR(20)		NOT NULL DEFAULT('')
		,	Ajuste			NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		)

	----------------------------------------------------------------------------------------------------------------
	--	2.0  CARGA LAS TABLAS TEMPORALES SALDO , VIGENTE E HISTORICA									          --
	----------------------------------------------------------------------------------------------------------------

	-->     [1.1]  -- Cartera Temporal para Almacenar el saldo a la fecha de cierre del periodo anterior
	INSERT INTO #Tmp_CarteraSaldo
	SELECT	Folio					= Saldo.Contrato 
		,	Producto				= Saldo.Producto_Emp
		,	Operacion				= Saldo.Posicion_Declarante_Emp
		,	Rut						= Saldo.Rut_Cliente_emp
		,	Codigo					= Saldo.Codigo_Cliente_emp
		,	FechaCierre				= Saldo.Fecha_Curse_Contrato_emp
		,	FechaTermino			= isnull( Saldo.fecha_Vencimiento, '19000101' )
		,	Avr						= (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial)
		,	Signo					= CASE	WHEN (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial) >= 0 THEN '+'
											ELSE '-'
										END
		,	CuentaAvr				= Saldo.Cta_VR_Inicial
        ,   CtaRes                  =CASE	WHEN  (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial) >= 0  
		                                    THEN Saldo.CntCtaVRPos + case when Saldo.CntCtaVRPos = '' then Saldo.CntCtaVRNeg else '' end -- MAP 11-Sep-2014
             								ELSE	Saldo.CntCtaVRNeg
									   END
		,	nMoneda1				= 0 -- Pendiente
		,	nMoneda2				= 0 -- Pendiente
		,   Var_moneda2             = 0 -- var_moneda2  Revisar qué sucede
	FROM	bacparamsuda.dbo.DJ1829_Detalle 			Saldo		WITH(NOLOCK)
	WHERE	Saldo.Fecha_Analisis	= @dFechaAnalisis 
	AND		Saldo.Valida_Resultado_VR	= 'Cuadra VR'   -- Valida VR Inicial
	-- AND     Saldo.KeyCntId_sistema    = 'BFW' -- Por mientras
    and     Saldo.Modulo = 'BacForward'          -- Esto incluyó las Provisiones
	-->     [1.2]  -- Cartera Temporal para Almacenar la Cartera Vigente a la Fecha de Analisis

	INSERT INTO #Tmp_CarteraRes
	SELECT	Folio					= Vigente.Contrato 
		,	Producto				= Vigente.Producto_Emp
		,	Operacion				= Vigente.Posicion_Declarante_Emp
		,	Rut						= Vigente.Rut_Cliente_emp
		,	Codigo					= Vigente.Codigo_Cliente_emp
		,	FechaCierre				= Vigente.Fecha_Curse_Contrato_emp	--> CASE WHEN Vigente.cafecha < Vigente.CaFechaStarting THEN Vigente.CaFechaStarting ELSE Vigente.cafecha END   
		,	FechaTermino			= isnull( Vigente.fecha_Vencimiento, '19000101' )
		,	Avr						= Vigente.Debe_VR - Vigente.Haber_VR
		,	Signo					= CASE WHEN (Vigente.Debe_VR - Vigente.Haber_VR) >= 0 THEN '+' ELSE '-' END
		,	CuentaAvr				= Vigente.Cta_Car_VR
		,   CtaRes                  = CASE	WHEN  (Vigente.Debe_VR - Vigente.Haber_VR) >= 0  THEN Vigente.CntCtaVRPos + case when Vigente.CntCtaVRPos = '' then Vigente.CntCtaVRNeg else '' end -- MAP 11-Sep-2014
											ELSE									Vigente.CntCtaVRNeg
										END
		,	nMoneda1				= 0 -- Pendiente
		,	nMoneda2				= 0 -- Pendiente
		,   Var_moneda2             = 0 -- var_moneda2 revisar qué sucede
	FROM	bacparamsuda.dbo.DJ1829_Detalle Vigente 	with(nolock)
	where   Vigente.Fecha_Analisis		= @dFechaAnalisis
	and     Vigente.Valida_VR  = 'Cuadra VR'    -- Valida VR Final
	-- and     Vigente.KeyCntId_sistema = 'BFW' -- Por mientras
	and     Vigente.Modulo = 'BacForward'       -- Esto incluyó las Provisiones  

	-->     [1.3.1]  -- Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Analisis
	/*
	INSERT INTO #Tmp_CarteraHis
	SELECT	Folio			= Vencidos.canumoper
		,	Producto		= case	when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 0	then 1
									when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 1	then 1
									when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 15	then 1 --> 15
									when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 16	then 1 --> 16
									when Vencidos.cacodpos1 = 14								then 14
									else Vencidos.cacodpos1 end
		,	Operacion		= Vencidos.catipoper
		,	Rut				= Vencidos.cacodigo
		,	Codigo			= Vencidos.cacodcli
		,	FechaCierre		= Vencidos.cafecha
		,	FechaTermino	= Vencidos.cafecvcto
		,	Compensacion	= Sum( case when Vencidos.catipmoda = 'C' then case when cli.clpais = 6 then Round( Vencidos.camtocomp, 0)
																				else					 Round( Vencidos.camtocomp * vDol.vmvalor, 0)
																			end
										else Round(((vMon.vmptacmp - Vencidos.catipcam) * Vencidos.camtomon1) * case when Vencidos.catipoper = 'C' then 1 else -1 end
											 																  / case when cli.clpais = 6 then 1 else vDol.vmvalor end, 0)
									end )
		,	Signo			= ''
		,	CuentaResultado	= ''
		,	nMoneda1		= Vencidos.cacodmon1
		,	nMoneda2		= Vencidos.cacodmon2
		,	ParMonedas		= case  when Vencidos.cacodpos1 = 10 then	ltrim(rtrim( Mon.mnnemo ))
									else								ltrim(rtrim( Mon.mnnemo )) + '-' + ltrim(rtrim( Cnv.mnnemo ))
							  end
		,	Cartera			= case when Vencidos.cacartera_normativa = 'C' then 'C' else '' end
	FROM	( select canumoper, cacodpos1, catipoper, cacodigo, cacodcli, cafecha, cafecvcto, camtomon1, catipcam, camtocomp, catipmoda, cacodmon1, cacodmon2, cacalvtadol, cacartera_normativa
				from BacFwdSuda.dbo.Mfca 
			   where cafecvcto BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
			   union 
			  select canumoper, cacodpos1, catipoper, cacodigo, cacodcli, cafecha, cafecvcto, camtomon1, catipcam, camtocomp, catipmoda, cacodmon1, cacodmon2, cacalvtadol, cacartera_normativa
				from BacFwdSuda.dbo.MfcaH
			   where cafecvcto BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
			) as Vencidos

			inner join BacParamSuda.dbo.Moneda		  Mon WITH(NOLOCK) on Mon.mncodmon			= Vencidos.cacodmon1
			inner join BacParamSuda.dbo.Moneda		  Cnv WITH(NOLOCK) on Cnv.mncodmon			= Vencidos.cacodmon2

			inner join BacParamSuda.dbo.Cliente		  cli on cli.clrut	   = Vencidos.cacodigo and cli.clcodigo = Vencidos.cacodcli
			inner join BacParamSuda.dbo.Valor_Moneda vMon on vMon.vmfecha  = Vencidos.cafecvcto
												         and vMon.vmcodigo = case when Vencidos.catipmoda = 'C' then 994
																				  else Vencidos.cacodmon1
																			 end
			inner join BacParamSuda.dbo.Valor_Moneda vDol on vDol.vmfecha  = Vencidos.cafecvcto
														 and vDol.vmcodigo = 994
	GROUP BY	Vencidos.canumoper
		,		case	when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 0	then 1
						when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 1	then 1
						when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 15	then 1 --> 15
						when Vencidos.cacodpos1 = 1  and Vencidos.cacalvtadol = 16	then 1 --> 16
						when Vencidos.cacodpos1 = 14								then 14
						else Vencidos.cacodpos1 end
		,		Vencidos.catipoper
		,		Vencidos.cacodigo
		,		Vencidos.cacodcli
		,		Vencidos.cafecha
		,		Vencidos.cafecvcto
		,		Vencidos.cacodmon1
		,		Vencidos.cacodmon2
		,		case	when Vencidos.cacodpos1 = 10 then	ltrim(rtrim( Mon.mnnemo ))
						else								ltrim(rtrim( Mon.mnnemo )) + '-' + ltrim(rtrim( Cnv.mnnemo ))
				end
		,		case when Vencidos.cacartera_normativa = 'C' then 'C' else '' end
	ORDER BY	Vencidos.cafecvcto

	UPDATE	#Tmp_CarteraHis
	SET		Signo					= CASE WHEN #Tmp_CarteraHis.Liquidacion >= 0 THEN '+'					ELSE '-'					END
	,		CuentaLiq				= CASE WHEN #Tmp_CarteraHis.Liquidacion >= 0 THEN Criterio.oCtaResPos	ELSE Criterio.oCtaResNeg	END 
	FROM	dbo.TBL_TRIBUTARIOS_CRITERIOS  Criterio
	WHERE	Criterio.oOrigen		= @cOrigen
	AND		Criterio.oProducto		= #Tmp_CarteraHis.Producto
	AND		Criterio.oTipOperacion	= #Tmp_CarteraHis.Operacion
	AND		Criterio.oMoneda		= #Tmp_CarteraHis.ParMonedas
	AND		Criterio.oCartera		= #Tmp_CarteraHis.Cartera
	*/


	----------------------------------------------------------------------------------------------------------------
	--	3.0  PREPARA LA ESTRUCTURA FINAL CON LA INFORMACION SOBRE LA CARTERA SALDO A LA FECHA DE CIERRE PERIODO   --
	----------------------------------------------------------------------------------------------------------------

	-->     [3.0]   -- Limpia el Contenido de la tabla con respecto a los datos al nuevo periodo
	DELETE FROM dbo.TBL_TRIBUTARIOS
		  WHERE FechaAnalisis	= @dFechaAnalisis
			AND Origen			= @cOrigen

	-->     [3.1]   -- Carga el Contenido de la tabla final con el Saldo a la fecha de Cierre.

	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	FechaAnalisis			= @dFechaAnalisis
		,	FechaCierre				= @dFechaCierrePeriodo
		----------------------------------------------------
		,	FechaSuscripcion		= Saldos.FechaCierre
		,	FechaLiquidacion		= Saldos.FechaTermino
		,	FolioContrato			= Saldos.Folio
		,	Correlativo				= 1
		,	NewRegistro				= 0
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= Saldos.Operacion
		,	Producto				= Saldos.Producto
		,	RutCliente				= Saldos.Rut
		,	CodCliente				= Saldos.Codigo
		----------------------------------------------------
		,	CtaAVR					= Saldos.CuentaAvr 
		,	CtaPatrimonio			= ''
		,	CtaResultado			= Saldos.CtaRes -- '' MAP 11-Sep-2014
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= ROUND( Saldos.Avr , 0)
		,	nMontoAVRProceso		= 0.0
		,	nMontoCaja				= 0.0
		,	nMontoPatrimonio		= 0.0
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= Saldos.Signo
		,	iSaldo					= 1
		,	nMonedaOperacion		= Saldos.nMoneda1
		,	nMonedaConversion		= Saldos.nMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM	#Tmp_CarteraSaldo		Saldos

	----------------------------------------------------------------------------------------------------------------
	--	4.0  ACTUALIZACION DEL REGISTRO SALDO, CON EL AVR DE CARTERA VIGENTE A LA FECHA DE ANALISIS.			  --
	----------------------------------------------------------------------------------------------------------------
/*
    Se generará registro aparte para el AVR a fecha de analisis MAP 11-Sep-2014
	-->     [4.0]   --> Actualizando los Avr de Proceso, para los contratos con arrastre (Saldo) de igual Signo.
	UPDATE	dbo.TBL_TRIBUTARIOS
	SET		nMontoAVRProceso			= Vigente.Avr
	FROM	dbo.TBL_TRIBUTARIOS			Cierre
			INNER JOIN #Tmp_CarteraRes	Vigente	ON Vigente.Folio = Cierre.FolioContrato AND Vigente.Signo = Cierre.nSignoAvr
	WHERE	Cierre.Origen				= @cOrigen
	AND		Cierre.FechaAnalisis		= @dFechaAnalisis
	AND		Cierre.FechaCierre			= @dFechaCierrePeriodo
		AND Cierre.Correlativo			= 1
		AND Cierre.iSaldo				= 1
*/
	----------------------------------------------------------------------------------------------------------------
	--	5.0  SE INCORPORA EL NUEVO REGISTRO POR EL CAMBIO DE SIGNO EN EL AVR, ENTRE EL SALDO Y LO VIGENTE		  --
	----------------------------------------------------------------------------------------------------------------

/* Caso extraño sería descartado 
	INSERT INTO dbo.TBL_TRIBUTARIOS
	SELECT	FechaAnalisis			= @dFechaAnalisis
		,	FechaCierre				= @dFechaCierrePeriodo
			----------------------------------------------------
		,	FechaSuscripcion		= Vigente.FechaCierre
		,	FechaLiquidacion		= Vigente.FechaTermino
		,	FolioContrato			= Vigente.Folio
		,	Correlativo				= 1
		,	NewRegistro				= 1
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= Vigente.Operacion
		,	Producto				= Vigente.Producto
		,	RutCliente				= Vigente.Rut
		,	CodCliente				= Vigente.Codigo
		----------------------------------------------------
		,	CtaAVR					= Vigente.CuentaAvr 
		,	CtaPatrimonio			= ''
		,	CtaResultado			= ''
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= ROUND( Vigente.Avr, 0)
		,	nMontoCaja				= 0.0
		,	nMontoPatrimonio		= 0.0
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= Vigente.Signo
		,	iSaldo					= 0
		,	nMonedaOperacion		= Vigente.nMoneda1
		,	nMonedaConversion		= Vigente.nMoneda2
	FROM	#Tmp_CarteraRes			Vigente
			INNER JOIN #Tmp_CarteraSaldo Saldo ON Saldo.Folio = Vigente.Folio AND Saldo.signo <> Vigente.Signo
*/
	----------------------------------------------------------------------------------------------------------------
	--	6.0 SE INCORPORAN LOS LAS OPERACIONES VIGENTES QUE NO CONTIENEN SALDO EN CARTERA	 				      --
	----------------------------------------------------------------------------------------------------------------
	-- MAP 11-Sep-2014 Se incorporan siempre en un registro aparte.

	INSERT INTO dbo.TBL_TRIBUTARIOS  -- select * from dbo.TBL_TRIBUTARIOS
	SELECT	FechaAnalisis			= @dFechaAnalisis
		,	FechaCierre				= @dFechaCierrePeriodo
			----------------------------------------------------
		,	FechaSuscripcion		= Vigente.FechaCierre
		,	FechaLiquidacion		= Vigente.FechaTermino
		,	FolioContrato			= Vigente.Folio
		,	Correlativo				= 1
		,	NewRegistro				= 1
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= Vigente.Operacion
		,	Producto				= Vigente.Producto
		,	RutCliente				= Vigente.Rut
		,	CodCliente				= Vigente.Codigo
		----------------------------------------------------
		,	CtaAVR					= Vigente.CuentaAvr 
		,	CtaPatrimonio			= ''
		,	CtaResultado			= Vigente.CtaRes --  '' MAP 11-Sep-2014 
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= ROUND( Vigente.Avr, 0)
		,	nMontoCaja				= 0.0
		,	nMontoPatrimonio		= 0.0
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= Vigente.Signo
		,	iSaldo					= 0
		,	nMonedaOperacion		= Vigente.nMoneda1
		,	nMonedaConversion		= Vigente.nMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM	#Tmp_CarteraRes			Vigente
	-- WHERE	Vigente.Folio			NOT IN ( SELECT Folio FROM #Tmp_CarteraSaldo ) MAP 11-Sep-2014
	 
	----------------------------------------------------------------------------------------------------------------
	--	7.0 SE DETERMINA EL RESULTADO DE LOS AVR CALCULANDO LA DIFERENCIA ENTRE EL SALDO Y LA FECHA DE ANALISIS	  --
	----------------------------------------------------------------------------------------------------------------
	-- select * from dbo.TBL_TRIBUTARIOS where origen = 'BFW' and FolioContrato =  43313 and fechaanalisis = '20131129'
	UPDATE	dbo.TBL_TRIBUTARIOS
		SET nMontoResultado		= -( nMontoAVRProceso - nMontoAVRNeto ) -- Pisado por app. VB	
		/*	  
		  , FolioContrato       = isnull( ( select moNroOpeMxClp from BacFwdSuda.dbo.Mfmoh where MoNumoper = FolioContrato and moNroOpeMxClp <> 0 )
		                                   , FolioContrato )  
           */ -- Ya no debería ser necesario
	WHERE	Origen				= @cOrigen
	AND		FechaAnalisis		= @dFechaAnalisis
	AND		FechaCierre			= @dFechaCierrePeriodo

	update  dbo.TBL_TRIBUTARIOS
	     SET FolioContrato = 550001   --- Error de Grabación de Mx/Clp
    WHERE	Origen				= @cOrigen
	AND		FechaAnalisis		= @dFechaAnalisis
	AND		FechaCierre			= @dFechaCierrePeriodo
	AND     FolioContrato       =  550037

	-- MAP 2014-01-07 Formula Resultado AVR				 			 
		----AND (	( abs(nMontoAVRNeto)	> 0 AND abs(nMontoAVRProceso) > 0)
		----	OR	( abs(nMontoAVRNeto)	> 0 AND abs(nMontoAVRProceso) = 0)
		----)	
	----UPDATE	dbo.TBL_TRIBUTARIOS
	----	SET nMontoResultado		= nMontoAVRProceso - nMontoAVRNeto 
	----WHERE	Origen				= @cOrigen
	----AND		FechaAnalisis		= @dFechaAnalisis
	----AND		FechaCierre			= @dFechaCierrePeriodo
	----	AND (	
	----			( abs(nMontoAVRNeto)	= 0 AND abs(nMontoAVRProceso) > 0)
	----		)

	----------------------------------------------------------------------------------------------------------------
	--	8.0 SE ACTUALIZAN LOS REGISTROS DE SALDO Y VIGENTES CON LOS ANTICIPOS Y VENCIMIENTOS DEL PERIODO	 	  --
	----------------------------------------------------------------------------------------------------------------

	----UPDATE	dbo.TBL_TRIBUTARIOS
	----SET		nMontoLiquidacion			= Vencida.Liquidacion
	----,		CtaResultado				= Vencida.CuentaLiq
	----FROM	dbo.TBL_TRIBUTARIOS			Cierre
	----		INNER JOIN #Tmp_CarteraHis	Vencida	ON Vencida.Folio = Cierre.FolioContrato AND Vencida.Signo = Cierre.nSignoAvr
	----WHERE	Cierre.Origen				= @cOrigen
	----AND		Cierre.FechaAnalisis		= @dFechaAnalisis
	----AND		Cierre.FechaCierre			= @dFechaCierrePeriodo

	----------------------------------------------------------------------------------------------------------------
	--	9.0 SE INYECTAN LOS REGISTROS DE ANTICIPO Y LIQUIDACION SIN SALDO O CARTERA VIGENTE	 					  --
	----------------------------------------------------------------------------------------------------------------
	/*
	INSERT INTO dbo.TBL_TRIBUTARIOS
	SELECT	FechaAnalisis			= @dFechaAnalisis
		,	FechaCierre				= @dFechaCierrePeriodo
			----------------------------------------------------
		,	FechaSuscripcion		= Vencida.FechaCierre
		,	FechaLiquidacion		= Vencida.FechaTermino
		,	FolioContrato			= Vencida.Folio
		,	Correlativo				= 1
		,	NewRegistro				= 1
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= Vencida.Operacion
		,	Producto				= Vencida.Producto
		,	RutCliente				= Vencida.Rut
		,	CodCliente				= Vencida.Codigo
		----------------------------------------------------
		,	CtaAVR					= '' 
		,	CtaPatrimonio			= ''
		,	CtaResultado			= Vencida.CuentaLiq
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= 0.0
		,	nMontoCaja				= 0.0
		,	nMontoPatrimonio		= 0.0
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= Vencida.Liquidacion
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= Vencida.Signo
		,	iSaldo					= 0
		,	nMonedaOperacion		= Vencida.nMoneda1
		,	nMonedaConversion		= Vencida.nMoneda2
	FROM	#Tmp_CarteraHis			Vencida
	WHERE	Vencida.Folio			NOT IN( SELECT Folio FROM #Tmp_CarteraSaldo )
	*/

			-->     [3.1]   -- Carga lo que cuadra con las cuentas de diferencia de Cambio.
	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato       
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                
		,	FolioContrato			= DJ.Contrato
		,	Correlativo				= DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= DJ.KeyCntTipOper
		,	Producto				= DJ.KeyCntProducto 		                              														 
		,	RutCliente				= DJ.Rut_Cliente_Emp
		,	CodCliente				= DJ.Codigo_Cliente_Emp
		----------------------------------------------------
		,	CtaAVR					= ''
		,	CtaPatrimonio			= ''
		,	CtaResultado			= case when DJ.Total_Pagos_Acum >= 0 then DJ.CntCtaResultadoPos else DJ.CntCtaResultadoNeg end
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= 0.0 
		,	nMontoCaja				= 0.0 
		,	nMontoPatrimonio		= 0.0 
		----------------------------------------------------
		,	nMontoResultado			= 0.0                      --  0 
		,	nMontoLiquidacion		= - (Total_Pagos_Acum)
		,	nMontoSaldoAvrTermino	= 0.0                      --  0
		----------------------------------------------------
		,	nSignoAvr				= case when (DJ.Total_Pagos_Acum) >= 0 then  '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= KeyCntMoneda1
		,	nMonedaConversion		= KeyCntMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM	BacParamSuda.dbo.DJ1829_Detalle		DJ
	where DJ.Modulo = 'BacForward' and DJ.Total_Pagos_Acum <> 0 and  DJ.Fecha_analisis = @dFechaAnalisis
/*	group by DJ.Fecha_Suscripcion_Contrato
	       , DJ.Fecha_Vencimiento
		   , DJ.Contrato
		   , DJ.CaNumEstructura
		   , DJ.KeyCntTipOper
		   , DJ.KeyCntProducto
		   , DJ.Rut_Cliente_Emp
		   , DJ.Codigo_Cliente_Emp
		   , DJ.CntCtaResultadoPos 
		   , DJ.CntCtaResultadoNeg
		   , DJ.KeyCntMoneda1
		   , DJ.KeyCntMoneda2 */
	-- select * from BacParamSuda.dbo.DJ1829_Detalle2013
	-- se cargan las diferencias de cambio de todo lo que proviene
	-- de opciones: Ei. Forward Asiático, Americano

    -- Ajustes de AVR por provisiones y Pargua

	----------------------------------------------------------------------------------------------------------------
	--	09.0 SE INYECTAN REGISTROS ASOCIADOS A LOS AJUSTES DE AVR POR SER OPERACION PARGUA y PROVISIONES          --
	----------------------------------------------------------------------------------------------------------------

	-->     [1.4]  -- Cartera Temporal para Aplicar ajustes de AVR, como no tiene correlativo la tabla
	-->               se asumirá siempre el componente 1 en el caso de SAO.
	--> Ajustes al inicio por contrato	

	/* Rescatados por el proceso DJ 

	INSERT INTO #Tmp_CarteraAjustes
	SELECT	Folio			= Contrato, Cuenta = Cuenta, CuentaRes = CuentaRes
		,	Ajuste			= SUM( Monto )
	FROM	BacParamSuda.dbo.TBL_Tributarios_ajustes  -- select * from BacParamSuda.dbo.TBL_Tributarios_ajustes
	WHERE	Fecha           = @dFechaCierrePeriodo  -- AND @dFechaAnalisis 	--		= @dFechaAnalisis	--> BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Origen			= @cOrigen
	GROUP BY Contrato, Cuenta, CuentaRes

	--INSERT INTO dbo.TBL_TRIBUTARIOS  -- select FolioCOntrato, nMontoAVRNeto from dbo.TBL_TRIBUTARIOS  where origen = 'BFW' and fechaAnalisis = '20140829' and folioContrato = 37956
	SELECT	'debug', 
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato       
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                
		,	FolioContrato			= DJ.Contrato 
		,	Correlativo				= DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= DJ.KeyCntTipOper
		,	Producto				= DJ.KeyCntProducto 		                              														 
		,	RutCliente				= DJ.Rut_Cliente_Emp
		,	CodCliente				= DJ.Codigo_Cliente_Emp
		----------------------------------------------------
		,	CtaAVR					= Aj.Cuenta
		,	CtaPatrimonio			= '' 
		,	CtaResultado			= Aj.CuentaRes -- '' MAP 11-Sep-2014
		,	CtaCaja					= ''
		----------------------------------------------------		
		,	nMontoAVRNeto			= Aj.Ajuste -- 0.0
		,	nMontoAVRProceso		= 0.0 
		,	nMontoCaja				= 0.0 
		,	nMontoPatrimonio		= 0.0 
		----------------------------------------------------
		-- nMontoResultado		=  - ( nMontoAVRProceso - nMontoAVRNeto )
		,	nMontoResultado			= - ( 0.0 -  Aj.Ajuste )
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Aj.Ajuste >= 0 then '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= DJ.KeyCntMoneda1
		,	nMonedaConversion		= DJ.KeyCntMoneda2
	FROM #Tmp_CarteraAjustes	Aj
	     inner join   BacParamSuda.dbo.DJ1829_Detalle  DJ on Aj.Folio = DJ.Contrato and DJ.Fecha_Analisis =  @dFechaAnalisis
    where DJ.Modulo = 'BacForward' and  DJ.evento = 'Curse' and DJ.Vigente_CierreAnoAnt	= 'S' 
	and  DJ.contrato = 37956
	

	delete #Tmp_CarteraAjustes

	INSERT INTO #Tmp_CarteraAjustes
	SELECT	Folio			= Contrato, Cuenta = Cuenta, CuentaRes
		,	Ajuste			= SUM( Monto )
	FROM	BacParamSuda.dbo.TBL_Tributarios_ajustes  
	WHERE	Fecha           = @dFechaAnalisis          
	AND		Origen			= @cOrigen
	GROUP BY Contrato, Cuenta, CuentaRes

	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	distinct
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato       
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                
		,	FolioContrato			= DJ.Contrato 
		,	Correlativo				= DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= DJ.KeyCntTipOper
		,	Producto				= DJ.KeyCntProducto 		                              														 
		,	RutCliente				= DJ.Rut_Cliente_Emp
		,	CodCliente				= DJ.Codigo_Cliente_Emp
		----------------------------------------------------
		,	CtaAVR					= Aj.Cuenta
		,	CtaPatrimonio			= '' 
		,	CtaResultado			= Aj.CuentaRes -- '' MAP 11-Sep-2014
		,	CtaCaja					= ''
		----------------------------------------------------		
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= Aj.Ajuste -- 0.0 
		,	nMontoCaja				= 0.0 
		,	nMontoPatrimonio		= 0.0 
		----------------------------------------------------
		-- nMontoResultado		= - ( nMontoAVRProceso - nMontoAVRNeto )
		,	nMontoResultado			= -( Aj.Ajuste - 0 )
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Aj.Ajuste >= 0 then '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= DJ.KeyCntMoneda1
		,	nMonedaConversion		= DJ.KeyCntMoneda2
	FROM #Tmp_CarteraAjustes	Aj
	     inner join   BacParamSuda.dbo.DJ1829_Detalle  DJ on Aj.Folio = DJ.Contrato and DJ.Fecha_Analisis = @dFechaAnalisis
    where DJ.Modulo = 'BacForward' and  DJ.evento = 'Curse' and DJ.Vigente_CierreAno	= 'S' 

	-- Ajustes de AVR por Provisiones y Pargua
	----------------------------------------------------------------------------------------------------------------
	--	10.0 SE INYECTAN LOS REGISTROS ASOCIADOS A LAS COBERTURAS POR EL PATRIMONIO								  --
	----------------------------------------------------------------------------------------------------------------
	*/
	-->  
	-->     [1.4]  -- Cartera Temporal para Almacenar Cobertura

	INSERT INTO #Tmp_CarteraCob
	SELECT	Folio			= Contrato
		,	Cuenta			= Cuenta
		,   CuentaResultado = CuentaResultado
		,	Ajuste			= SUM( Ajuste )
	FROM	BacParamSuda.dbo.TBL_PATRIMONIO 
	WHERE	Fecha BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis -- Fecha			= @dFechaAnalisis	--> BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Origen			= @cOrigen
	GROUP BY Contrato, Cuenta, CuentaResultado
	
	---- Los ajustes a patriminio deben ser vistos como pagos de AVR
	---- que el dueño del banco le aplica a las operaciones.
	---- No se puede depender de que sea una operación vigente
	---- al inicio o fin del periodo.

	----UPDATE	dbo.TBL_TRIBUTARIOS
	----SET		nMontoPatrimonio		= #Tmp_CarteraCob.Ajuste
	----,		CtaPatrimonio			= #Tmp_CarteraCob.Cuenta
	----FROM	#Tmp_CarteraCob
	----WHERE	#Tmp_CarteraCob.Folio	= TBL_TRIBUTARIOS.FolioContrato
	----AND		@cOrigen				= TBL_TRIBUTARIOS.Origen
	----AND		ABS(TBL_TRIBUTARIOS.nMontoAVRProceso) <> 0

	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= max( DJ.Fecha_Suscripcion_Contrato )      
		,	FechaLiquidacion		= max( DJ.Fecha_Vencimiento          )      
		,	FolioContrato			= DJ.Contrato 
		,	Correlativo				= max( DJ.CaNumEstructura )
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= max( DJ.KeyCntTipOper )
		,	Producto				= max( DJ.KeyCntProducto )		                              														 
		,	RutCliente				= max( DJ.Rut_Cliente_Emp )
		,	CodCliente				= max( DJ.Codigo_Cliente_Emp )
		----------------------------------------------------
		,	CtaAVR					= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030'  ) then
                                           Cob.Cuenta
      								   else
										    ''
                                       end
		,	CtaPatrimonio			= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030'  ) then ''
		                              else Cob.Cuenta end
		,	CtaResultado			= Cob.CuentaResultado
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= 0.0 
		,	nMontoCaja				= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030'  )
		                               then - Cob.Ajuste else 0 end  
		,	nMontoPatrimonio		= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008',  '411501030'  ) 
		                               then 0 else - Cob.Ajuste  end 
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Cob.Ajuste >= 0 then '-' else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= max( DJ.KeyCntMoneda1 )
		,	nMonedaConversion		= max( DJ.KeyCntMoneda2 )
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM #Tmp_CarteraCob	Cob
	     inner join   BacParamSuda.dbo.DJ1829_Detalle  DJ on Cob.Folio = DJ.Contrato and DJ.Fecha_analisis = @dFechaAnalisis
	where DJ.Modulo = 'BacForward' 
	group by DJ.Contrato , Cob.Cuenta, Cob.Ajuste , Cob.CuentaResultado
	RETURN 0

END
GO
