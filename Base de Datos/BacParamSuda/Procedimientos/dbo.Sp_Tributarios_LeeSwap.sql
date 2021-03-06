USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_LeeSwap]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Sp_Tributarios_LeeSwap]
	(	@dFechaAnalisis		DATETIME	)
AS
BEGIN

	SET NOCOUNT ON
	--return -- por mientras !!!
	-- dbo.Sp_Tributarios_LeeSwap '20140829'
	----------------------------------------------------------------------------------------------------------------
	--	0.0				CONTROLES DE FECHA Y DE GENERACION DE FECHAS PARA DETERMINAR EL PERIODO				      --
	----------------------------------------------------------------------------------------------------------------

	DECLARE @cOrigen	VARCHAR(3)
		SET @cOrigen	= 'PCS'

	-->     [0.0] --> Control de Generación
	DECLARE @dFechaProceso			DATETIME
		SET @dFechaProceso			= ( SELECT FechaProc FROM BacSwapSuda.dbo.Swapgeneral with(nolock) )

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
		,	Grupo			INT				NOT NULL DEFAULT(0)
		,	nMoneda1		INT				NOT NULL DEFAULT(0)
		,	ParMonedas		CHAR(10)		NOT NULL DEFAULT('')
		)

	-->		[1.4]  -- Cartera Temporal ajustes Externos de AVR
	               -- Son del tipo AL
	CREATE TABLE #Tmp_CarteraAjustes
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Cuenta			VARCHAR(50)		NOT NULL DEFAULT('')
		,   CuentaRes       VARCHAR(50)		NOT NULL DEFAULT('') -- MAP 11-Sep-2014
		,	Ajuste			NUMERIC(21,4)	NOT NULL DEFAULT(0.0)		
		)
	-->		[1.5]  -- Cartera Temporal con ajustes Externos Complementarios
	               -- Coberturas y desarmes
				   -- Son del tipo ACUMULATIVO
	CREATE TABLE #Tmp_CarteraCob
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Cuenta			VARCHAR(20)		NOT NULL DEFAULT('')
		,   CuentaResultado VARCHAR(20)     NOT NULL DEFAULT('')
		,	Ajuste			NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		)		
	----------------------------------------------------------------------------------------------------------------
	--	2.0  CARGA LAS TABLAS TEMPORALES SALDO , VIGENTE E HISTORICA									          --
	----------------------------------------------------------------------------------------------------------------

	-->     [1.1]  -- Cartera Temporal para Almacenar el saldo a la fecha de cierre del periodo anterior
	INSERT INTO #Tmp_CarteraSaldo
	SELECT	Folio					= Saldo.Contrato  -- select * from bacparamsuda.dbo.DJ1829_Detalle
		,	Producto				= Saldo.Producto_Emp	-->	Saldo.Tipo_Swap
		,	Operacion				= ''
		,	Rut						= Saldo.Rut_Cliente_Emp 
		,	Codigo					= Saldo.Codigo_Cliente_Emp
		,	FechaCierre				= Saldo.Fecha_Curse_Contrato_Emp -- fecha_cierre -- Saldo.fecha_inicio
		,	FechaTermino			= isnull( Saldo.Fecha_Vencimiento, '19000101' )        -- Fecha_Termino
		,	Avr						= (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial)
		,	Signo					= CASE	WHEN (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial) >= 0 THEN '+'
											ELSE '-'
										END
		,	CuentaAvr				=  Saldo.Cta_VR_Inicial

		,   CtaRes                  = CASE	WHEN  (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial) >= 0  THEN Saldo.CntCtaVRPos + case when Saldo.CntCtaVRPos = '' then Saldo.CntCtaVRNeg else '' end -- MAP 11-Sep-2014
											ELSE									Saldo.CntCtaVRNeg
										END
		,	nMoneda1				= 0 -- Pendiente, la moneda nocional no se está registrando en el proceso
										
	FROM	bacparamsuda.dbo.DJ1829_Detalle Saldo	with(nolock)
	
	WHERE	Saldo.Fecha_Analisis		= @dFechaAnalisis 
	and		Saldo.Valida_Resultado_VR	= 'Cuadra VR'   -- Valida VR inicial
    and     Saldo.KeyCntId_sistema = 'PCS'              -- Ojo que esto descartó las provisiones
	


	

	/* Todos los ajustes serán aplicados de maner genérica
	   ya que n osolo existe PARGUA si no también 
	   PROVISIONES
	--------------------------------------------------------------------------
	--			A J U S T E      P A R G U A      A L      I N I C I O		--
	--			              (PERIODO DE CIERRE ANTERIOR)					--
	--------------------------------------------------------------------------
	UPDATE	#Tmp_CarteraSaldo
		SET Avr			= AjustePargua.Monto
		,	Signo		= CASE WHEN AjustePargua.Monto >= 0 THEN '+' ELSE '-' END
	FROM	(	SELECT	Contrato, Monto
				FROM	dbo.Tbl_Tributarios_Ajustes
				WHERE	Fecha	= @dFechaCierrePeriodo
				AND		Origen	= 'PCS'
			)	AjustePargua
	WHERE	AjustePargua.Contrato	= Folio
	----------------------------------------------------------------------------
	----------------------------------------------------------------------------
	*/


	-->     [1.2]  -- Cartera Temporal para Almacenar la Cartera Vigente a la Fecha de Analisis
	INSERT INTO #Tmp_CarteraRes
	SELECT	Folio					= Vigente.Contrato
		,	Producto				= Vigente.Producto_Emp
		,	Operacion				= ''
		,	Rut						= Vigente.Rut_Cliente_Emp 
		,	Codigo					= Vigente.Codigo_Cliente_Emp
		,	FechaCierre				= Vigente.Fecha_Curse_Contrato_Emp -- Vigente.Fecha_Inicio
		,	FechaTermino			= isnull( Vigente.Fecha_Vencimiento , '19000101' )
		,	Avr						= Vigente.Debe_VR - Vigente.Haber_VR
		,	Signo					= CASE WHEN (Vigente.Debe_VR - Vigente.Haber_VR) >= 0 THEN '+' ELSE '-' END
		,	CuentaAvr				= Vigente.Cta_Car_VR
		,   CtaRes                  = CASE	WHEN  (Vigente.Debe_VR - Vigente.Haber_VR) >= 0  THEN Vigente.CntCtaVRPos + case when Vigente.CntCtaVRPos = '' then Vigente.CntCtaVRNeg else '' end -- MAP 11-Sep-2014
											ELSE									Vigente.CntCtaVRNeg
										END
		,	nMoneda1				= 0 -- Pendiente la moneda nominal

	FROM	bacparamsuda.dbo.DJ1829_Detalle Vigente	with(nolock)
	WHERE	Vigente.Fecha_Analisis		= @dFechaAnalisis
	and     Vigente.Valida_VR  = 'Cuadra VR'    -- Valida VR Final
	and     Vigente.KeyCntId_sistema = 'PCS'    -- Ojo que esto descartó las provisiones


	-->     [1.3.1]  -- Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Analisis
	/*
	INSERT INTO #Tmp_CarteraHis
	SELECT	Folio					= Vencidos.Numero_Operacion
		,	Producto				= Vencidos.Tipo_Swap
		,	Operacion				= 'C'
		,	Rut						= Vencidos.Rut_Cliente
		,	Codigo					= Vencidos.Codigo_Cliente
		,	FechaCierre				= Vencidos.Fecha_Cierre
		,	FechaTermino			= Vencidos.Fecha_Termino
		,	Compensacion			= SUM( Round( case when Activo.nMoneda = 13 then Round( Activo.vFlujo * vDolar.vmvalor, 0 ) else Activo.vFlujo end
									            - case when Pasivo.nMoneda = 13 then Round( Pasivo.vFlujo * vDolar.vmvalor, 0 ) else Pasivo.vFlujo end, 0)
										 )
		,	Signo					= MIN( case when ( Round( case when Activo.nMoneda = 13 then Round( Activo.vFlujo * vDolar.vmvalor, 0 ) else Activo.vFlujo end
															- case when Pasivo.nMoneda = 13 then Round( Pasivo.vFlujo * vDolar.vmvalor, 0 ) else Pasivo.vFlujo end, 0)
													  ) >= 0 then '+' else '-' end
										 )
		,	CuentaResultado			= MIN( case when ( Round( case when Activo.nMoneda = 13 then Round( Activo.vFlujo * vDolar.vmvalor, 0 ) else Activo.vFlujo end
															- case when Pasivo.nMoneda = 13 then Round( Pasivo.vFlujo * vDolar.vmvalor, 0 ) else Pasivo.vFlujo end, 0)
													  ) >= 0 then Criterio.oCtaResPos else Criterio.oCtaResNeg end
										 )
		,	Grupo					= 0
		,	nMoneda1				= CASE	WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 999	THEN 999
											WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 998	THEN 998
											WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 13		THEN 13
											WHEN Vencidos.tipo_swap = 2										THEN 0
											WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 999	THEN 999
											WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 998	THEN 998
									  END
		,	ParMonedas				= case	when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 999	then 'CLP'
											when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 998	then 'UF'
											when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 13	then 'USD'
											when Vencidos.tipo_swap  = 2									then 'MX'
											when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 999	then 'CLP'
											when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 998	then 'UF'
									  end
	FROM	BacSwapSuda.dbo.CarteraHis Vencidos with(nolock)
			inner join (
						select	nFolio  = Act.Numero_Operacion
							,	nFlujo  = Act.Numero_Flujo
							,	dVcto   = Act.Fecha_Vence_Flujo
							,	nMoneda = Act.Recibimos_Moneda
							,	nMonto	= case when Act.Estado  = 'N' then Act.Recibimos_Monto
											   else						   Act.Compra_Interes + Act.Compra_Amortiza * Act.intercprinc + Act.Compra_Flujo_Adicional
										  end
							,	vFlujo	= Round(case when Act.Estado  = 'N' then Act.Recibimos_Monto
													 else						 Act.Compra_Interes + Act.Compra_Amortiza * Act.intercprinc + Act.Compra_Flujo_Adicional
										  end
										* (Case  when Act.Estado <> 'N' then (case when Act.Recibimos_Moneda <> Act.Compra_Moneda then case when Act.Compra_Moneda	  = 999 then 1.0 else vMonVta.vmvalor end else 1.0 end)
																		 /	 (case when Act.Recibimos_Moneda <> Act.Compra_Moneda then case when Act.Recibimos_Moneda = 999 then 1.0 else vMonPag.vmvalor end else 1.0 end)
												 else 1.0
										   End), 2)
						 from	BacSwapSuda.dbo.CarteraHis					 Act with(nolock)
								left  join BacParamSuda.dbo.Valor_Moneda vMonVta with(nolock) ON vMonVta.vmfecha = Act.Fechaliquidacion and vMonVta.vmcodigo = case when Act.Compra_Moneda    = 13 then 994 else Act.Compra_Moneda	 end
								left  join BacParamSuda.dbo.Valor_Moneda vMonPag with(nolock) ON vMonPag.vmfecha = Act.Fechaliquidacion and vMonPag.vmcodigo = case when Act.Recibimos_Moneda = 13 then 994 else Act.Recibimos_Moneda end
						where	Act.Fecha_Vence_Flujo BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
						  and	Act.Tipo_Flujo		  = 1
						  and   Act.Estado <> 'C'
						)	Activo ON Activo.nFolio = Vencidos.Numero_Operacion and Activo.dVcto = Vencidos.Fecha_Vence_Flujo

			inner join (
						select	nFolio  = Pas.Numero_Operacion
							,	nFlujo  = Pas.Numero_Flujo
							,	dVcto   = Pas.Fecha_Vence_Flujo
							,	nMoneda = Pas.Pagamos_Moneda
							,	nMonto	= case when Pas.Estado  = 'N' then Pas.Pagamos_Monto
											   else						   Pas.Venta_Interes + Pas.Venta_Amortiza * Pas.intercprinc + Pas.Venta_Flujo_Adicional
										  end
							,	vFlujo	= Round(case when Pas.Estado  = 'N' then Pas.Pagamos_Monto
											   else						   Pas.Venta_Interes + Pas.Venta_Amortiza * Pas.intercprinc + Pas.Venta_Flujo_Adicional
										  end
										* (Case  when Pas.Estado <> 'N' then (case when Pas.Pagamos_Moneda <> Pas.Venta_Moneda then case when Pas.Venta_Moneda	 = 999 then 1.0 else vMonVta.vmvalor end else 1.0 end)
																		 /	 (case when Pas.Pagamos_Moneda <> Pas.Venta_Moneda then case when Pas.Pagamos_Moneda = 999 then 1.0 else vMonPag.vmvalor end else 1.0 end)
												 else 1.0
										   End), 2)
						 from	BacSwapSuda.dbo.CarteraHis					 Pas with(nolock)
								left  join BacParamSuda.dbo.Valor_Moneda vMonVta with(nolock) ON vMonVta.vmfecha = Pas.Fechaliquidacion and vMonVta.vmcodigo = case when Pas.Venta_Moneda   = 13 then 994 else Pas.Venta_Moneda   end
								left  join BacParamSuda.dbo.Valor_Moneda vMonPag with(nolock) ON vMonPag.vmfecha = Pas.Fechaliquidacion and vMonPag.vmcodigo = case when Pas.Pagamos_Moneda = 13 then 994 else Pas.Pagamos_Moneda end
						where	Pas.Fecha_Vence_Flujo BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
						  and	Pas.Tipo_Flujo		  = 2
						  and   Pas.Estado <> 'C'
						)	Pasivo	ON Pasivo.nFolio = Vencidos.Numero_Operacion and Pasivo.dVcto = Vencidos.Fecha_Vence_Flujo
			
			inner join  BacParamSuda.dbo.Valor_Moneda   vDolar with(nolock) ON vDolar.vmfecha = Vencidos.Fecha_Vence_Flujo and vDolar.vmcodigo = 994

			inner join dbo.TBL_TRIBUTARIOS_CRITERIOS Criterio with(nolock) ON Criterio.oOrigen   = @cOrigen
																		  AND Criterio.oProducto = Vencidos.Tipo_Swap
																		  AND Criterio.oMoneda	 = case when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 999	then 'CLP'
																										when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 998	then 'UF'
																										when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 13	then 'USD'
																										when Vencidos.tipo_swap  = 2									then 'MX'
																										when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 999	then 'CLP'
																										when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 998	then 'UF'
																									end
																		 and  Criterio.oCartera  = case when Vencidos.chi_Cartera_Normativa = 'C' then 'C' else '' end


	WHERE	Vencidos.Fecha_Vence_Flujo BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Vencidos.Tipo_Flujo		   = 1
	AND		Vencidos.estado			  <> 'C'
	GROUP BY	Vencidos.Numero_Operacion
			,	Vencidos.Tipo_Swap
			,	Vencidos.Rut_Cliente
			,	Vencidos.Codigo_Cliente
			,	Vencidos.Fecha_Cierre
			,	Vencidos.Fecha_Termino
			,	CASE	WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 999	THEN 999
						WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 998	THEN 998
						WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 13		THEN 13
						WHEN Vencidos.tipo_swap = 2										THEN 0
						WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 999	THEN 999
						WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 998	THEN 998
				END
			,	case	when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 999	then 'CLP'
						when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 998	then 'UF'
						when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 13	then 'USD'
						when Vencidos.tipo_swap  = 2									then 'MX'
						when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 999	then 'CLP'
						when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 998	then 'UF'
				end
			,	case	when Vencidos.chi_Cartera_Normativa = 'C' then 'C' else '' end
*/

	-->     [1.3.2]  -- Carga Los Vctos del Día, en Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Proceso
/*
	INSERT INTO #Tmp_CarteraHis
	SELECT	Folio					= Vencidos.Numero_Operacion
		,	Producto				= Vencidos.Tipo_Swap
		,	Operacion				= 'C'
		,	Rut						= Vencidos.Rut_Cliente
		,	Codigo					= Vencidos.Codigo_Cliente
		,	FechaCierre				= Vencidos.Fecha_Cierre
		,	FechaTermino			= Vencidos.Fecha_Termino
		,	Compensacion			= SUM( Round( case when Activo.nMoneda = 13 then Round( Activo.vFlujo * vDolar.vmvalor, 0 ) else Activo.vFlujo end
									            - case when Pasivo.nMoneda = 13 then Round( Pasivo.vFlujo * vDolar.vmvalor, 0 ) else Pasivo.vFlujo end, 0)
										 )	
		,	Signo					= MIN( case when ( Round( case when Activo.nMoneda = 13 then Round( Activo.vFlujo * vDolar.vmvalor, 0 ) else Activo.vFlujo end
															- case when Pasivo.nMoneda = 13 then Round( Pasivo.vFlujo * vDolar.vmvalor, 0 ) else Pasivo.vFlujo end, 0)
													  ) >= 0 then '+' else '-' end
										 )	
		,	CuentaResultado			= MIN( case when ( Round( case when Activo.nMoneda = 13 then Round( Activo.vFlujo * vDolar.vmvalor, 0 ) else Activo.vFlujo end
															- case when Pasivo.nMoneda = 13 then Round( Pasivo.vFlujo * vDolar.vmvalor, 0 ) else Pasivo.vFlujo end, 0)
													  ) >= 0 then Criterio.oCtaResPos else Criterio.oCtaResNeg end
										 )
		,	Grupo					= 0
		,	nMoneda1				= CASE	WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 999	THEN 999
											WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 998	THEN 998
											WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 13		THEN 13
											WHEN Vencidos.tipo_swap = 2										THEN 0
											WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 999	THEN 999
											WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 998	THEN 998
									  END
		,	ParMonedas				= case	when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 999	then 'CLP'
											when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 998	then 'UF'
											when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 13	then 'USD'
											when Vencidos.tipo_swap  = 2									then 'MX'
											when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 999	then 'CLP'
											when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 998	then 'UF'
									  end

	FROM	BacSwapSuda.dbo.Cartera Vencidos with(nolock)
			inner join (
						select	nFolio  = Act.Numero_Operacion
							,	nFlujo  = Act.Numero_Flujo
							,	dVcto   = Act.Fecha_Vence_Flujo
							,	nMoneda = Act.Recibimos_Moneda
							,	nMonto	= case when Act.Estado  = 'N' then Act.Recibimos_Monto
											   else						   Act.Compra_Interes + Act.Compra_Amortiza * Act.intercprinc + Act.Compra_Flujo_Adicional
										  end
							,	vFlujo	= Round(case when Act.Estado  = 'N' then Act.Recibimos_Monto
													 else						 Act.Compra_Interes + Act.Compra_Amortiza * Act.intercprinc + Act.Compra_Flujo_Adicional
										  end
										* (Case  when Act.Estado <> 'N' then (case when Act.Recibimos_Moneda <> Act.Compra_Moneda then case when Act.Compra_Moneda	  = 999 then 1.0 else vMonVta.vmvalor end else 1.0 end)
																		 /	 (case when Act.Recibimos_Moneda <> Act.Compra_Moneda then case when Act.Recibimos_Moneda = 999 then 1.0 else vMonPag.vmvalor end else 1.0 end)
												 else 1.0
										   End), 2)
						 from	BacSwapSuda.dbo.Cartera						 Act with(nolock)
								left  join BacParamSuda.dbo.Valor_Moneda vMonVta with(nolock) ON vMonVta.vmfecha = Act.Fechaliquidacion and vMonVta.vmcodigo = case when Act.Compra_Moneda    = 13 then 994 else Act.Compra_Moneda	  end
								left  join BacParamSuda.dbo.Valor_Moneda vMonPag with(nolock) ON vMonPag.vmfecha = Act.Fechaliquidacion and vMonPag.vmcodigo = case when Act.Recibimos_Moneda = 13 then 994 else Act.Recibimos_Moneda end
						where	Act.Fecha_Vence_Flujo BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
						  and	Act.Tipo_Flujo		  = 1
							)	Activo  ON Activo.nFolio = Vencidos.Numero_Operacion and Activo.dVcto = Vencidos.Fecha_Vence_Flujo

			inner join (
						select	nFolio  = Pas.Numero_Operacion
							,	nFlujo  = Pas.Numero_Flujo
							,	dVcto   = Pas.Fecha_Vence_Flujo
							,	nMoneda = Pas.Pagamos_Moneda
							,	nMonto	= case when Pas.Estado  = 'N' then Pas.Pagamos_Monto
											   else						   Pas.Venta_Interes + Pas.Venta_Amortiza * Pas.intercprinc + Pas.Venta_Flujo_Adicional
										  end
							,	vFlujo	= Round(case when Pas.Estado  = 'N' then Pas.Pagamos_Monto
											   else						   Pas.Venta_Interes + Pas.Venta_Amortiza * Pas.intercprinc + Pas.Venta_Flujo_Adicional
										  end
										* (Case  when Pas.Estado <> 'N' then (case when Pas.Pagamos_Moneda <> Pas.Venta_Moneda then case when Pas.Venta_Moneda	 = 999 then 1.0 else vMonVta.vmvalor end else 1.0 end)
																		 /	 (case when Pas.Pagamos_Moneda <> Pas.Venta_Moneda then case when Pas.Pagamos_Moneda = 999 then 1.0 else vMonPag.vmvalor end else 1.0 end)
												 else 1.0
										   End), 2)
						 from	BacSwapSuda.dbo.Cartera						 Pas with(nolock)
								left  join BacParamSuda.dbo.Valor_Moneda vMonVta with(nolock) ON vMonVta.vmfecha = Pas.Fechaliquidacion and vMonVta.vmcodigo = case when Pas.Venta_Moneda   = 13 then 994 else Pas.Venta_Moneda   end
								left  join BacParamSuda.dbo.Valor_Moneda vMonPag with(nolock) ON vMonPag.vmfecha = Pas.Fechaliquidacion and vMonPag.vmcodigo = case when Pas.Pagamos_Moneda = 13 then 994 else Pas.Pagamos_Moneda end
						where	Pas.Fecha_Vence_Flujo BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
						  and	Pas.Tipo_Flujo		  = 2
							)	Pasivo	ON Pasivo.nFolio = Vencidos.Numero_Operacion and Pasivo.dVcto = Vencidos.Fecha_Vence_Flujo
			
			inner join  BacParamSuda.dbo.Valor_Moneda  vDolar  with(nolock) ON vDolar.vmfecha = Vencidos.Fecha_Vence_Flujo and vDolar.vmcodigo = 994

			inner join dbo.TBL_TRIBUTARIOS_CRITERIOS Criterio with(nolock) ON Criterio.oOrigen   = @cOrigen
																		  AND Criterio.oProducto = Vencidos.Tipo_Swap
																		  AND Criterio.oMoneda	 = case when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 999	then 'CLP'
																										when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 998	then 'UF'
																										when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 13	then 'USD'
																										when Vencidos.tipo_swap  = 2									then 'MX'
																										when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 999	then 'CLP'
																										when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 998	then 'UF'
																									end
	WHERE	Vencidos.Fecha_Vence_Flujo BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Vencidos.Tipo_Flujo		   = 1
	AND		Vencidos.estado			  <> 'C'
	GROUP BY	Vencidos.Numero_Operacion
			,	Vencidos.Tipo_Swap
			,	Vencidos.Rut_Cliente
			,	Vencidos.Codigo_Cliente
			,	Vencidos.Fecha_Cierre
			,	Vencidos.Fecha_Termino
			,	CASE	WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 999	THEN 999
						WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 998	THEN 998
						WHEN Vencidos.tipo_swap = 1 AND Vencidos.compra_moneda = 13		THEN 13
						WHEN Vencidos.tipo_swap = 2										THEN 0
						WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 999	THEN 999
						WHEN Vencidos.tipo_swap = 4 AND Vencidos.compra_moneda = 998	THEN 998
				END
			,	case	when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 999	then 'CLP'
						when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 998	then 'UF'
						when Vencidos.tipo_swap  = 1 and Vencidos.compra_moneda = 13	then 'USD'
						when Vencidos.tipo_swap  = 2									then 'MX'
						when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 999	then 'CLP'
						when Vencidos.tipo_swap  = 4 and Vencidos.compra_moneda = 998	then 'UF'
				end
*/
   /*
	INSERT  INTO #Tmp_CarteraHis
	SELECT	Folio			= His.Folio
		,	Producto		= His.Producto
		,	Operacion		= His.Operacion
		,	Rut				= Max(His.Rut)
		,	Codigo			= His.Codigo
		,	FechaCierre		= His.FechaCierre
		,	FechaTermino	= MAX( His.FechaTermino )
		,	Liquidacion		= SUM( His.Liquidacion  )
		,	Signo			= MIN( CASE WHEN His.Liquidacion >= 0 THEN '+'				   ELSE '-'					END )
		,	CuentaLiq		= MIN( CASE WHEN His.Liquidacion >= 0 THEN Criterio.oCtaResPos ELSE Criterio.oCtaResNeg END )
		,	Grupo			= 1
		,	Moneda1			= His.nMoneda1
		,	ParMonedas		= His.ParMonedas
	FROM    #Tmp_CarteraHis	His
			left  join  dbo.TBL_TRIBUTARIOS_CRITERIOS Criterio with(nolock) ON Criterio.oOrigen		= @cOrigen
															  			   AND Criterio.oProducto	= His.Producto
																		   AND Criterio.oMoneda		= His.ParMonedas
	WHERE	His.Grupo		= 0
	GROUP BY
			His.Folio
		,	His.Producto
		,	His.Operacion
--		,	His.Rut
		,	His.Codigo
		,	His.FechaCierre
		,	His.nMoneda1
		,	His.ParMonedas

	DELETE FROM #Tmp_CarteraHis
		  WHERE Grupo = 0
    */

	-- select * from BacParamSUda.dbo.TBL_TRIBUTARIOS where fechaAnalisis = '20131230'

	----------------------------------------------------------------------------------------------------------------
	--	3.0  PREPARA LA ESTRUCTURA FINAL CON LA INFORMACION SOBRE LA CARTERA SALDO A LA FECHA DE CIERRE PERIODO   --
	----------------------------------------------------------------------------------------------------------------

	-->     [3.0]   -- Limpia el Contenido de la tabla con respecto a los datos al nuevo periodo
	DELETE FROM dbo.TBL_TRIBUTARIOS -- delete dbo.TBL_TRIBUTARIOS where origen = 'PCS' and fechaAnalisis = '20140829'
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
		,	CtaResultado			= Saldos.CtaRes --  '' MAP 11-Sep-2014
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
		,	nMonedaConversion		= 0
		,   FluCajPer               = 0				
		,   FluCajPerAnt            = 0
	FROM	#Tmp_CarteraSaldo		Saldos
	
	----------------------------------------------------------------------------------------------------------------
	--	4.0  ACTUALIZACION DEL REGISTRO SALDO, CON EL AVR DE CARTERA VIGENTE A LA FECHA DE ANALISIS.			  --
	----------------------------------------------------------------------------------------------------------------
    /* MAP 11-Sep-2014 se creará registro nuevo para esto  
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
	/* Condicion Extraña, se elimina MAP 11-Sep-2014
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
		,	nMonedaConversion		= 0
	FROM	#Tmp_CarteraRes			Vigente
			INNER JOIN #Tmp_CarteraSaldo Saldo ON Saldo.Folio = Vigente.Folio AND Saldo.signo <> Vigente.Signo
    */
	----------------------------------------------------------------------------------------------------------------
	--	6.0 SE INCORPORAN LOS LAS OPERACIONES VIGENTES QUE NO CONTIENEN SALDO EN CARTERA	 				      --
	----------------------------------------------------------------------------------------------------------------

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
		,	nMonedaConversion		= 0
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM	#Tmp_CarteraRes			Vigente
	/* WHERE	Vigente.Folio			NOT IN ( SELECT Folio FROM #Tmp_CarteraSaldo ) 
	   MAP 11-Sep-2014 Se registrará el AVR de fecha analisis siempre en registro aparte.
	*/

	----------------------------------------------------------------------------------------------------------------
	--	7.0 SE DETERMINA EL RESULTADO DE LOS AVR CALCULANDO LA DIFERENCIA ENTRE EL SALDO Y LA FECHA DE ANALISIS	  --
	----------------------------------------------------------------------------------------------------------------

	UPDATE	dbo.TBL_TRIBUTARIOS
		SET nMontoResultado		= nMontoAVRNeto - nMontoAVRProceso
	WHERE	Origen				= @cOrigen
	AND		FechaAnalisis		= @dFechaAnalisis
	AND		FechaCierre			= @dFechaCierrePeriodo
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
	/* La liquidaciones se scarán de la DJ 1829
	UPDATE	dbo.TBL_TRIBUTARIOS
	SET		nMontoLiquidacion			= Vencida.Liquidacion
	,		CtaResultado				= Vencida.CuentaLiq
	FROM	dbo.TBL_TRIBUTARIOS			Cierre
			INNER JOIN #Tmp_CarteraHis	Vencida	ON Vencida.Folio = Cierre.FolioContrato AND Vencida.Signo = Cierre.nSignoAvr
	WHERE	Cierre.Origen				= @cOrigen
	AND		Cierre.FechaAnalisis		= @dFechaAnalisis
	AND		Cierre.FechaCierre			= @dFechaCierrePeriodo
	*/
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
		,	nMonedaConversion		= 0
	FROM	#Tmp_CarteraHis			Vencida
	WHERE	Vencida.Folio			NOT IN( SELECT Folio		 FROM #Tmp_CarteraSaldo )
	and		Vencida.Folio			NOT IN( SELECT FolioContrato FROM dbo.TBL_TRIBUTARIOS WHERE FechaAnalisis = @dFechaAnalisis AND Origen = @cOrigen )
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
		,	CtaResultado			= case when  DJ.Total_Pagos_Acum  >= 0 then DJ.CntCtaResultadoPos else DJ.CntCtaResultadoNeg end
		,	CtaCaja					= '' 
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= 0.0 
		,	nMontoCaja				= 0.0 
		,	nMontoPatrimonio		= 0.0 
		----------------------------------------------------
		,	nMontoResultado			= 0.0                      --  0 
		,	nMontoLiquidacion		= - DJ.Total_Pagos_Acum
		,	nMontoSaldoAvrTermino	= 0.0                      --  0
		----------------------------------------------------
		,	nSignoAvr				= case when DJ.Total_Pagos_Acum >= 0 then  '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= DJ.KeyCntMoneda1
		,	nMonedaConversion		= DJ.KeyCntMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM	BacParamSuda.dbo.DJ1829_Detalle		DJ
	where DJ.Modulo = 'BacSwap' and DJ.Total_Pagos_Acum <> 0
	    and DJ.Fecha_Analisis = @dFechaAnalisis
/*
	group by DJ.Fecha_Suscripcion_Contrato
	       , DJ.Fecha_Vencimiento
		   , DJ.Contrato
		   , DJ.CaNumEstructura
		   , DJ.KeyCntTipOper
		   , DJ.KeyCntProducto
		   , DJ.Rut_Cliente_Emp
		   , DJ.Codigo_Cliente_Emp
--		   , DJ.CntCtaResultadoPos 
--		   , DJ.CntCtaResultadoNeg
		   , DJ.KeyCntMoneda1
		   , DJ.KeyCntMoneda2
		   */
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
	INSERT INTO #Tmp_CarteraAjustes
	SELECT	Folio			= Contrato, Cuenta = Cuenta, CuentaRes = CuentaRes
		,	Ajuste			= SUM( Monto )
	FROM	BacParamSuda.dbo.TBL_Tributarios_ajustes  -- select * from BacParamSuda.dbo.TBL_Tributarios_ajustes
	WHERE	Fecha           = @dFechaCierrePeriodo  -- AND @dFechaAnalisis 	--		= @dFechaAnalisis	--> BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Origen			= @cOrigen
	GROUP BY Contrato, cuenta, CuentaRes

	INSERT INTO dbo.TBL_TRIBUTARIOS  -- select * from dbo.TBL_TRIBUTARIOS
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
		,	nMontoAVRNeto			= Aj.Ajuste -- 0.0
		,	nMontoAVRProceso		= 0.0 
		,	nMontoCaja				= 0.0 
		,	nMontoPatrimonio		= 0.0 
		----------------------------------------------------
		-- nMontoResultado		=  - ( nMontoAVRProceso - nMontoAVRNeto )
		,	nMontoResultado			= - ( 0.0 - Aj.Ajuste )
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Aj.Ajuste >= 0 then '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= DJ.KeyCntMoneda1
		,	nMonedaConversion		= DJ.KeyCntMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM #Tmp_CarteraAjustes	Aj
	     inner join   BacParamSuda.dbo.DJ1829_Detalle  DJ on Aj.Folio = DJ.Contrato and DJ.Fecha_Analisis = @dFechaAnalisis
    where DJ.Modulo = 'BacSwap'  and ( DJ.evento = 'Curse'  and DJ.Vigente_CierreAnoAnt	= 'S' )

	delete #Tmp_CarteraAjustes

	INSERT INTO #Tmp_CarteraAjustes
	SELECT	Folio			= Contrato, Cuenta = Cuenta, cuentaRes = CuentaREs
		,	Ajuste			= SUM( Monto )
	FROM	BacParamSuda.dbo.TBL_Tributarios_ajustes  
	WHERE	Fecha           = @dFechaAnalisis          
	AND		Origen			= @cOrigen
	GROUP BY Contrato, cuenta, cuentaRes

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
		,	nMontoResultado			= - ( Aj.Ajuste - 0.0 )
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Aj.Ajuste >= 0 then '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= DJ.KeyCntMoneda1
		,	nMonedaConversion		= DJ.KeyCntMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM #Tmp_CarteraAjustes	Aj
	     inner join   BacParamSuda.dbo.DJ1829_Detalle  DJ on Aj.Folio = DJ.Contrato and DJ.Fecha_Analisis = @dFechaAnalisis
    where DJ.Modulo = 'BacSwap' and ( DJ.evento = 'Curse' and DJ.Vigente_CierreAno	= 'S'  )

	-- Ajustes de AVR por Provisiones y Pargua

	----------------------------------------------------------------------------------------------------------------
	--	10.0 SE INYECTAN LOS REGISTROS ASOCIADOS A LAS COBERTURAS POR EL PATRIMONIO								  --
	----------------------------------------------------------------------------------------------------------------

	

	-->     [1.4]  -- Cartera Temporal para Aplicar ajustes a cuentas de resultado desde Patrimonio
	INSERT INTO #Tmp_CarteraCob
	SELECT	Folio			= Contrato
		,	Cuenta			= Cuenta
		,   CuentaResultado = CuentaResultado
		,	Ajuste			= SUM( Ajuste )
	FROM	BacParamSuda.dbo.TBL_PATRIMONIO 
	WHERE	Fecha BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis 	--		= @dFechaAnalisis	--> BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Origen			= @cOrigen
	GROUP BY Contrato, Cuenta, CuentaResultado

	


	-- Movimientos a Patrimonio deben ser vistos como pagos de AVR
	-- realizados por el dueño a la cartera
	-- no calza necesariamente con vigentes al inicio del 
	-- periodo o vigentes al cierre del periodo

	----UPDATE	dbo.TBL_TRIBUTARIOS
	----SET		nMontoPatrimonio		= #Tmp_CarteraCob.Ajuste
	----,		CtaPatrimonio			= #Tmp_CarteraCob.Cuenta
	----FROM	#Tmp_CarteraCob
	----WHERE	#Tmp_CarteraCob.Folio	= TBL_TRIBUTARIOS.FolioContrato
	----AND		@cOrigen				= TBL_TRIBUTARIOS.Origen
	----and		ABS(TBL_TRIBUTARIOS.nMontoAVRProceso) <> 0

	INSERT INTO dbo.TBL_TRIBUTARIOS   
	--- select * from BacParamSuda.dbo.TBL_TRIBUTARIOS where nMontoPatrimonio <> 0 or nMontoCaja <> 0 and fechaAnalisis = '20140131' order by fechaSuscripcion
	SELECT	
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= max( DJ.Fecha_Suscripcion_Contrato )      
		,	FechaLiquidacion		= max( DJ.Fecha_Vencimiento )                
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
		-- TMONDACA: colocar en la columna 10 solo cuentas de activo, pasivo incluyendo la '435001008'		
		,	CtaAVR					= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008' ,  '411501030') then
                                           Cob.Cuenta
      								   else
										    ''
                                       end
        -- TMONDACA: columna 11 solo cuentas de Patrimonio sin la '435001008'
		,	CtaPatrimonio			= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008',  '411501030' ) then ''
		                              else Cob.Cuenta end
		-- Temporal hay que crear algo parecido a lo de la planilla "Saldos Cuentas Externas AAAA"
		,	CtaResultado			= Cob.CuentaResultado 
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= 0.0 
		-- Se Usará la columna nMontoCaja para mostrar Otros Resultados
		,	nMontoCaja				= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008',  '411501030'  )
		                               then - Cob.Ajuste else 0 end  
		,	nMontoPatrimonio		= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008',  '411501030' ) 
		                               then 0 else - Cob.Ajuste  end
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Cob.Ajuste >= 0 then '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= max( DJ.KeyCntMoneda1 )
		,	nMonedaConversion		= max( DJ.KeyCntMoneda2 )
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM #Tmp_CarteraCob	Cob
	     inner join   BacParamSuda.dbo.DJ1829_Detalle  DJ on Cob.Folio = DJ.Contrato and DJ.Fecha_Analisis = @dFechaAnalisis
    where DJ.Modulo = 'BacSwap' 
	group by DJ.Contrato, Cob.Cuenta, Cob.Ajuste, Cob.CuentaResultado 	       

	-- Corrige como contingencia la fecha suscripcion de 
	-- estas operaciones, no han movido el periodo
	-- select * from dbo.TBL_TRIBUTARIOS where fechaSuscripcion = '19000101'
	UPDATE dbo.TBL_TRIBUTARIOS 
	  Set
			FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                		
		,	Correlativo				= DJ.CaNumEstructura 
		,	TipoOperacion			= DJ.KeyCntTipOper 
		,	Producto				= DJ.KeyCntProducto 		                              														 
		,	RutCliente				= DJ.Rut_Cliente_Emp 
		,	CodCliente				= DJ.Codigo_Cliente_Emp 
		,	nMonedaOperacion		= DJ.KeyCntMoneda1 
		,	nMonedaConversion		= DJ.KeyCntMoneda2 
		from  BacParamSuda.dbo.DJ1829_Detalle  DJ 
		        where dbo.TBL_TRIBUTARIOS.Origen	= @cOrigen                            -- Al no filtrar por fecha 
				  and dbo.TBL_TRIBUTARIOS.FolioContrato	= DJ.Contrato                     -- saca información de otros años 
				  and ( dbo.TBL_TRIBUTARIOS.nMontoCaja <> 0 or dbo.TBL_TRIBUTARIOS.nMontoPatrimonio <> 0 )    -- caso Potencial falta de data de operación
				  and dbo.TBL_TRIBUTARIOS.FechaSuscripcion = '19000101'		
				  and DJ.evento = 'Curse'
				  And dbo.TBL_TRIBUTARIOS.FechaAnalisis	= @dFechaAnalisis 
	RETURN 0
	
END
GO
