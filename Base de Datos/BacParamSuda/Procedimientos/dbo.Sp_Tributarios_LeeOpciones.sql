USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_LeeOpciones]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Tributarios_LeeOpciones]
	(	@dFechaAnalisis		DATETIME	)
AS
BEGIN

	SET NOCOUNT ON


	-- dbo.Sp_Tributarios_LeeOpciones '20140829'
	----------------------------------------------------------------------------------------------------------------
	--	0.0				CONTROLES DE FECHA Y DE GENERACION DE FECHAS PARA DETERMINAR EL PERIODO				      --
	----------------------------------------------------------------------------------------------------------------

	DECLARE @cOrigen	VARCHAR(3)
		SET @cOrigen	= 'OPT'
	
	-->     [0.0] --> Control de Generación
	DECLARE @dFechaProceso			DATETIME
		SET @dFechaProceso			= ( SELECT FechaProc FROM LnkOpc.CbMdbOpc.dbo.OpcionesGeneral with(nolock) )

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
		,	Correla			NUMERIC(21)		NOT NULL DEFAULT(0)
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
		,   nPrimaCLP       numeric(15)     NOT NULL DEFAULT(0)
		)

	-->     [1.2]  -- Cartera Temporal para Almacenar la Cartera Vigente a la Fecha de Analisis
	CREATE TABLE #Tmp_CarteraRes
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Correla			NUMERIC(21)		NOT NULL DEFAULT(0)
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
		,   nPrimaCLP       numeric(15)     NOT NULL DEFAULT(0)
		)

	-->     [1.3]  -- Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Analisis
	CREATE TABLE #Tmp_CarteraHis
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Correla			NUMERIC(21)		NOT NULL DEFAULT(0)
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
		,	Concepto		VARCHAR(10)		NOT NULL DEFAULT('')
		,	nMoneda1		INT				NOT NULL DEFAULT(0)
		,	nMoneda2		INT				NOT NULL DEFAULT(0)
		,	ParMonedas		CHAR(10)		NOT NULL DEFAULT('')
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
	CREATE TABLE #Tmp_CarteraCob
		(	Folio			NUMERIC(21)		NOT NULL DEFAULT(0)
		,	Cuenta			VARCHAR(20)		NOT NULL DEFAULT('')
		,	CuentaResultado VARCHAR(20)		NOT NULL DEFAULT('')
		,	Ajuste			NUMERIC(21,4)	NOT NULL DEFAULT(0.0)
		)

	----------------------------------------------------------------------------------------------------------------
	--	2.0  CARGA LAS TABLAS TEMPORALES SALDO , VIGENTE E HISTORICA									          --
	----------------------------------------------------------------------------------------------------------------

	-->     [1.1]  -- Cartera Temporal para Almacenar el saldo a la fecha de cierre del periodo anterior
	INSERT INTO #Tmp_CarteraSaldo
	SELECT	Folio					= Saldo.Contrato -- Opciones no forward tienen pegado el correlativo
		,	Correla					= Saldo.CaNumEstructura 
		,	Producto				= case  when Saldo.KeyCntId_Sistema = 'BFW'  then KeyCntProducto
															  when Saldo.KeyCntCallPut = 'Call' and Saldo.KeyCntTipOper = 'C' then 1
															  when Saldo.KeyCntCallPut = 'Call' and Saldo.KeyCntTipOper = 'V' then 2
															  when Saldo.KeyCntCallPut = 'Put'  and Saldo.KeyCntTipOper = 'C' then 3
															  when Saldo.KeyCntCallPut = 'Put'  and Saldo.KeyCntTipOper = 'V' then 4
															  else Saldo.producto_Emp
									  end
		,	Operacion				= Saldo.KeyCntTipOper -- Compra o Venta de La Opciones
		,	Rut						= Saldo.Rut_Cliente_Emp 
		,	Codigo					= Saldo.Codigo_Cliente_Emp 
		,	FechaCierre				= Saldo.Fecha_Curse_Contrato_Emp 
		,	FechaTermino			= Saldo.Fecha_Vencimiento 
		,	Avr						= saldo.AVR_Cierre_Ant --(Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial)
		,	Signo					= case when saldo.AVR_Cierre_Ant >= 0 then '+' else '-' end
		,	CuentaAvr				= Saldo.Cta_VR_Inicial
		,   CtaRes                  = CASE	WHEN  saldo.AVR_Cierre_Ant >= 0  
		                                    THEN Saldo.CntCtaVRPos + case when Saldo.CntCtaVRPos = '' then Saldo.CntCtaVRNeg else '' end -- MAP 11-Sep-2014
             								ELSE	Saldo.CntCtaVRNeg
									   END
		,	nMoneda1				= Saldo.KeyCntMoneda1
		,	nMoneda2				= Saldo.KeyCntMoneda2
		,   nPrimaCLP               = - case when Saldo.evento = 'Curse' then Saldo.Prima_Total_CLP else 0 end 		                            
									 * ( Case when Saldo.Vigente_CierreAnoAnt = 'S' Then 1.0 else 0.0 end )    -- 1. Esta Vigente al cierre Anterior
									 
	FROM	bacparamsuda.dbo.DJ1829_Detalle 			Saldo		WITH(NOLOCK)
	where Saldo.Fecha_Analisis		= @dFechaAnalisis 
	--and  Saldo.Valida_Resultado_VR	= 'Cuadra VR'   -- Valida VR Inicial
	--and (Saldo.Debe_VR_Inicial - Saldo.Haber_VR_Inicial) <> 0
	-- AND     Saldo.KeyCntId_sistema    = 'OPT' -- Por mientras, hasta cuadrar	
	and     Saldo.AVR_Cierre_Ant <> 0
	and     Saldo.evento in ( 'Curse', 'Provisiones' )
    and     Saldo.Modulo = 'SAO'

	-->     [1.2]  -- Cartera Temporal para Almacenar la Cartera Vigente a la Fecha de Analisis

	INSERT INTO #Tmp_CarteraRes  -- select distinct modulo, KeyCntId_Sistema, producto_Emp, KeyCntProducto, KeyCntTipOper, KeyCntCallPut  from bacparamsuda.dbo.DJ1829_Detalle where fecha_analisis = '20140829' and contrato = 1954 or modulo = 'SAO'
	SELECT	Folio					= Vigente.Contrato -- Opciones no forward tienen pegado el correlativo
		,	Correla					= Vigente.CaNumEstructura 
		,	Producto				= case  when Vigente.KeyCntId_Sistema = 'BFW'  then KeyCntProducto
															  when Vigente.KeyCntCallPut = 'Call' and Vigente.KeyCntTipOper = 'C' then 1
															  when Vigente.KeyCntCallPut = 'Call' and Vigente.KeyCntTipOper = 'V' then 2
															  when Vigente.KeyCntCallPut = 'Put'  and Vigente.KeyCntTipOper = 'C' then 3
															  when Vigente.KeyCntCallPut = 'Put'  and Vigente.KeyCntTipOper = 'V' then 4
															  else Vigente.producto_Emp
									  end
		,	Operacion				= Vigente.KeyCntTipOper -- Compra o Venta de La Opciones
		,	Rut						= Vigente.Rut_Cliente_Emp
		,	Codigo					= Vigente.Codigo_Cliente_Emp
		,	FechaCierre				= Vigente.Fecha_Curse_Contrato_Emp
		,	FechaTermino			= Vigente.Fecha_Vencimiento 
		,	Avr						= Vigente.AVR_Cierre -- Vigente.Debe_VR - Vigente.Haber_VR  
		,	Signo					= case when Vigente.AVR_Cierre >= 0 then '+' else '-' end
		,	CuentaAvr				= Vigente.Cta_Car_VR
		,   CtaRes                  = CASE	WHEN  Vigente.AVR_Cierre>= 0  THEN Vigente.CntCtaVRPos + case when Vigente.CntCtaVRPos = '' then Vigente.CntCtaVRNeg else '' end -- MAP 11-Sep-2014
											ELSE									Vigente.CntCtaVRNeg
										END
		,	nMoneda1				= Vigente.KeyCntMoneda1
		,	nMoneda2				= Vigente.KeyCntMoneda2
		,   nPrimaCLP               = - case when Vigente.evento = 'Curse' then VIgente.Prima_Total_CLP else 0 end 		                            
									  * ( Case when Vigente.Vigente_CierreAno = 'S' Then 1.0 else 0.0 end )    -- 1. Esta Vigente al cierre
									  
									 
									 
	FROM	bacparamsuda.dbo.DJ1829_Detalle Vigente 	with(nolock)
	where   Vigente.Fecha_Analisis		= @dFechaAnalisis
	--and     Vigente.Valida_VR  = 'Cuadra VR'    -- Valida VR Final
	--and     (Vigente.Debe_VR - Vigente.Haber_VR) <> 0
	-- and     Vigente.KeyCntId_sistema = 'OPT' -- Por mientras hasta cuadrar
    and     Vigente.AVR_Cierre <> 0
	and     Vigente.evento in ( 'Curse', 'Provisiones' )
	and     Vigente.Modulo = 'SAO'

	-->     [1.3.1]  -- Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Analisis
	/* Los pagos serán rescatados de la DJ1829
	INSERT INTO #Tmp_CarteraHis
	SELECT  Folio			= Liquidacion.Folio
		,	Correla			= Contratos.Correla
		,	Producto		= Contratos.Producto
		,	Operacion		= Contratos.Operacion
		,	Rut				= Contratos.Rut
		,	Codigo			= Contratos.Codigo
		,	FechaCierre		= Contratos.FechaCierre
		,	FechaTermino	= Liquidacion.Fecha
		,	Liquidacion		= Round(
							  CASE	WHEN Liquidacion.Concepto	= 'PP'									THEN	Liquidacion.Monto1 * isnull( vMon.vmValor, 1.0)
									WHEN Liquidacion.Modalidad	= 'C'									THEN    Liquidacion.Monto1 * isnull( vMon.vmValor, 1.0)
									WHEN Liquidacion.Modalidad	= 'E' and TipoEstructura Not In(8,13)	THEN ((vMon.vmValor - abs( Liquidacion.Monto2 / Liquidacion.Monto1 )) * Liquidacion.Monto1)
									WHEN Liquidacion.Modalidad	= 'E' and TipoEstructura  = 13			THEN ((vMon.vmValor - abs( Liquidacion.Monto2 / Liquidacion.Monto1 )) * Liquidacion.Monto1)
																										  *  ( case when Contratos.CallPut = 'Call' then -1.0 else +1.0 end )
									WHEN Liquidacion.Modalidad	= 'E' and TipoEstructura  = 8			THEN ((vMon.vmValor - abs( Liquidacion.Monto2 / Liquidacion.Monto1 )) * Liquidacion.Monto1)
																										  *  ( case when Contratos.CallPut = 'Call' then -1.0 else +1.0 end )
								END, 0) 	
		,	Signo			= ''
		,	Cuenta			= ''
		,	Grupo			= ''
		,	Concepto		= Liquidacion.Concepto
		,	nMoneda1		= Contratos.Moneda1
		,	nMoneda2		= Contratos.Moneda2
		,	ParMonedas		= Contratos.ParMonedas
	FROM (	select	Folio			= CaNumContrato
				,	Correla			= CaNumEstructura
				,	Fecha			= CaCajFecPago
				,	Moneda1			= CaCajMdaM1
				,	Monto1			= CaCajMtoMon1
				,	Monto2			= CaCajMtoMon2
				,	Modalidad		= CaCajModalidad
				,	Concepto		= CaCajOrigen
			from	LnkOpc.CbMdbOpc.dbo.CaCaja with(nolock)
			where	CaCajFecPago	BETWEEN @dFechaInicioPeriodo and @dFechaAnalisis
			and     CaCajOrigen		IN ( 'PV', 'PA', 'PP' )
			and	(	(CaCajOrigen	= 'PP' AND CaCajMtoMon1	> 0)
				OR	(CaCajOrigen   <> 'PP' AND CaCajMtoMon1	> 0) --> = CaCajMtoMon1)
				)
					union
			select	Folio			= CaNumContrato
				,	Correla			= CaNumEstructura
				,	Fecha			= CaCajFecPago
				,	Moneda1			= CaCajMdaM1
				,	Monto1			= CaCajMtoMon1
				,	Monto2			= CaCajMtoMon2
				,	Modalidad		= CaCajModalidad
				,	Concepto		= CaCajOrigen
			from	LnkOpc.CbMdbOpc.dbo.CaVenCaja
			where	CaCajFecPago	BETWEEN @dFechaInicioPeriodo and @dFechaAnalisis
			and     CaCajOrigen		IN ( 'PV', 'PA', 'PP' )
			and	(	(CaCajOrigen	= 'PP' AND CaCajMtoMon1	> 0)
				OR	(CaCajOrigen   <> 'PP' AND CaCajMtoMon1	> 0) --> = CaCajMtoMon1)
				)
		 )	Liquidacion 

			inner join (	select	Folio			= Enc.CaNumContrato
								,	Correla			= Det.CaNumEstructura
								,	TipoEstructura	= Enc.CaCodEstructura
								,	CallPut			= Det.CaCallPut
								,	Rut				= Enc.CaRutCliente
								,	Codigo			= Enc.CaCodigo
								,	FechaCierre		= Enc.CaFechaContrato
								,	Producto		= case	when Enc.CaCodEstructura = 6					  then 17
															when Enc.CaCodEstructura = 8					  then 15
															when Enc.CaCodEstructura = 13					  then 13
															when Det.CaCallPut = 'Call' and Det.CaCVOpc = 'C' then 1
															when Det.CaCallPut = 'Call' and Det.CaCVOpc = 'V' then 2
															when Det.CaCallPut = 'Put'  and Det.CaCVOpc = 'C' then 3
															when Det.CaCallPut = 'Put'  and Det.CaCVOpc = 'V' then 4
															else Enc.CaCodEstructura
													  end
								,	Operacion		= Det.CaCVOpc --< Enc.CaCvEstructura
								,	Moneda1			= Det.CaCodMon1
								,	Moneda2			= Det.CaCodMon2
								,	ParMonedas		= case	when Enc.CaCodEstructura = 6  then 'USD-CLP'
															when Enc.CaCodEstructura = 8  then 'USD-CLP'
															when Enc.CaCodEstructura = 13 then 'USD-CLP'
															else							  ''
													  end
							from	LnkOpc.CbMdbOpc.dbo.CaEncContrato Enc
									inner join LnkOpc.CbMdbOpc.dbo.CaDetContrato Det ON Enc.CaNumContrato = Det.CaNumContrato
							where	Enc.CaEstado <> 'C'
									union
							select	Folio			= Enc.CaNumContrato
								,	Correla			= Det.CaNumEstructura
								,	TipoEstructura	= Enc.CaCodEstructura
								,	CallPut			= Det.CaCallPut
								,	Rut				= Enc.CaRutCliente
								,	Codigo			= Enc.CaCodigo
								,	FechaCierre		= Enc.CaFechaContrato
								,	Producto		= case	when Enc.CaCodEstructura = 6					  then 17
															when Enc.CaCodEstructura = 8					  then 15
															when Enc.CaCodEstructura = 13					  then 13
															when Det.CaCallPut = 'Call' and Det.CaCVOpc = 'C' then 1
															when Det.CaCallPut = 'Call' and Det.CaCVOpc = 'V' then 2
															when Det.CaCallPut = 'Put'  and Det.CaCVOpc = 'C' then 3
															when Det.CaCallPut = 'Put'  and Det.CaCVOpc = 'V' then 4
															else Enc.CaCodEstructura
													  end
								,	Operacion		= Det.CaCVOpc --< Enc.CaCvEstructura
								,	Moneda1			= Det.CaCodMon1
								,	Moneda2			= Det.CaCodMon2
								,	ParMonedas		= case	when Enc.CaCodEstructura = 6  then 'USD-CLP'
															when Enc.CaCodEstructura = 8  then 'USD-CLP'
															when Enc.CaCodEstructura = 13 then 'USD-CLP'
															else							  ''
													  end
							from	LnkOpc.CbMdbOpc.dbo.CaVenEncContrato Enc
									inner join LnkOpc.CbMdbOpc.dbo.CaVenDetContrato Det ON Enc.CaNumContrato = Det.CaNumContrato
							where	Enc.CaEstado <> 'C'
						)	Contratos ON Contratos.Folio	= Liquidacion.Folio
									 AND Contratos.Correla	= Liquidacion.Correla

			left join BacParamSuda.dbo.Valor_Moneda vMon	ON	vMon.vmFecha	= Liquidacion.Fecha
															and	vMon.vmCodigo	= CASE  WHEN Liquidacion.Modalidad	= 'E'	THEN 994
																						WHEN Liquidacion.Moneda1	= 13	THEN 994 
																						ELSE Liquidacion.Moneda1 
																					END

    -- Deja todas las liquidaciones 
	-- agrupadas con el campo Grupo = 1
	-- elimina todas las liquidaciones originales. 																					             
	insert into #Tmp_CarteraHis
	select  Folio			= Folio
		,	Correla			= Correla
		,	Producto		= Producto
		,	Operacion		= Operacion
		,	Rut				= Rut
		,	Codigo			= Codigo
		,	FechaCierre		= FechaCierre
		,	FechaTermino	= MAX( FechaTermino )
		,	Liquidacion		= SUM( Liquidacion )
		,	Signo			= Signo
		,	CuentaLiq		= CuentaLiq
		,	Grupo			= 1
		,	Concepto		= Concepto
		,	nMoneda1		= nMoneda1
		,	nMoneda2		= nMoneda2
		,	ParMonedas		= ParMonedas
	from	#Tmp_CarteraHis
	where	Grupo			= 0
	group 
	by		Folio, Correla, Producto, Operacion, Rut, Codigo, FechaCierre, Signo, CuentaLiq, Concepto, nMoneda1, nMoneda2, ParMonedas

	delete from #Tmp_CarteraHis
		  where Grupo = 0

	UPDATE	#Tmp_CarteraHis
	SET		Signo	= CASE WHEN Liquidacion >= 0 THEN '+' ELSE '-' END

	UPDATE	#Tmp_CarteraHis
	SET		CuentaLiq				= CASE WHEN #Tmp_CarteraHis.Concepto = 'pp' THEN 
												CASE WHEN #Tmp_CarteraHis.Signo >= 0 THEN Criterios.oCtaCajPos	ELSE Criterios.oCtaCajNeg END
										   ELSE 
												CASE WHEN #Tmp_CarteraHis.Signo >= 0 THEN Criterios.oCtaResPos  ELSE Criterios.oCtaResNeg END
									  END
	FROM	TBL_TRIBUTARIOS_CRITERIOS Criterios
	WHERE	Criterios.oOrigen		= @cOrigen
	AND		Criterios.oTipOperacion = #Tmp_CarteraHis.Operacion
	AND		Criterios.oProducto		= #Tmp_CarteraHis.Producto
	AND		Criterios.oMoneda		= #Tmp_CarteraHis.ParMonedas
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
	SELECT	FechaAnalisis			= @dFechaAnalisis          -- Cierre Periodo              -- Trib
		,	FechaCierre				= @dFechaCierrePeriodo     -- Cierre Periodo Anterior     -- Trib
		----------------------------------------------------
		,	FechaSuscripcion		= Saldos.FechaCierre       -- Fecha suscripción de Contrato -- DJ
		,	FechaLiquidacion		= Saldos.FechaTermino      -- Fecha término de contrato     -- DJ 
		,	FolioContrato			= Saldos.Folio             -- Numero De Contrato            -- DJ Agregar en SAO?
		,	Correlativo				= Saldos.Correla           -- DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen                 -- 'OPT'
		,	TipoOperacion			= Saldos.Operacion         -- KeyCntTipOper
		,	Producto				= Saldos.Producto          
		,	RutCliente				= Saldos.Rut               -- Rut_Cliente_Emp
		,	CodCliente				= Saldos.Codigo            -- Codigo_Cliente_Emp
		----------------------------------------------------
		,	CtaAVR					= Saldos.CuentaAvr         -- ''
		,	CtaPatrimonio			= ''                       -- ''
		,	CtaResultado			=  Saldos.CtaRes --  '' MAP 11-Sep-2014
		,	CtaCaja					= ''                       -- case when Total_Pagos_Acum > 0 then CntCtaResultadoPos else CntCtaResultadoNeg end
		----------------------------------------------------
		,	nMontoAVRNeto			= ROUND( Saldos.Avr  , 0) --  0
		,	nMontoAVRProceso		= 0.0                      --  0
		,	nMontoCaja				= 0.0                      --  0  
		,	nMontoPatrimonio		= 0.0                      --  0
		----------------------------------------------------
		,	nMontoResultado			= 0.0                      --  0 
		,	nMontoLiquidacion		= 0.0                      -- Total_Pagos_Acum
		,	nMontoSaldoAvrTermino	= 0.0                      --  0
		----------------------------------------------------
		,	nSignoAvr				= Saldos.Signo             -- '+'  
		,	iSaldo					= 1                        -- 0
		,	nMonedaOperacion		= Saldos.nMoneda1          -- 13
		,	nMonedaConversion		= Saldos.nMoneda2          -- 999		
		,   FluCajPer               = 0
        ,   FluCajPerAnt            = Saldos.nPrimaCLP
	FROM	#Tmp_CarteraSaldo		Saldos

	----------------------------------------------------------------------------------------------------------------
	--	4.0  ACTUALIZACION DEL REGISTRO SALDO, CON EL AVR DE CARTERA VIGENTE A LA FECHA DE ANALISIS.			  --
	----------------------------------------------------------------------------------------------------------------
	/* Saldo vigente se mostrará en registro aparte MAP 11-Sep-2014
	-->     [4.0]   --> Actualizando los Avr de Proceso, para los contratos con arrastre (Saldo) de igual Signo.
	UPDATE	dbo.TBL_TRIBUTARIOS
	SET		nMontoAVRProceso			= Vigente.Avr
	FROM	dbo.TBL_TRIBUTARIOS			Cierre
			INNER JOIN #Tmp_CarteraRes	Vigente	ON Vigente.Folio	= Cierre.FolioContrato 
											   AND Vigente.Correla	= Cierre.Correlativo
											   AND Vigente.Signo	= Cierre.nSignoAvr
	WHERE	Cierre.Origen				= @cOrigen
	AND		Cierre.FechaAnalisis		= @dFechaAnalisis
	AND		Cierre.FechaCierre			= @dFechaCierrePeriodo
--		AND Cierre.Correlativo			= 1
		AND Cierre.iSaldo				= 1

		*/

	----------------------------------------------------------------------------------------------------------------
	--	5.0  SE INCORPORA EL NUEVO REGISTRO POR EL CAMBIO DE SIGNO EN EL AVR, ENTRE EL SALDO Y LO VIGENTE		  --
	----------------------------------------------------------------------------------------------------------------
	/* COndicion extraña se elimina 
	INSERT INTO dbo.TBL_TRIBUTARIOS
	SELECT	FechaAnalisis			= @dFechaAnalisis
		,	FechaCierre				= @dFechaCierrePeriodo
			----------------------------------------------------
		,	FechaSuscripcion		= Vigente.FechaCierre
		,	FechaLiquidacion		= Vigente.FechaTermino
		,	FolioContrato			= Vigente.Folio
		,	Correlativo				= Vigente.Correla
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
			INNER JOIN #Tmp_CarteraSaldo Saldo ON Saldo.Folio	 = Vigente.Folio 
											  AND Saldo.Correla  = Vigente.Correla
											  AND Saldo.Signo   <> Vigente.Signo
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
		,	Correlativo				= Vigente.Correla
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
		,	nMontoAVRProceso		= ROUND( Vigente.Avr , 0)
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
		,   FluCajPer               = Vigente.nPrimaCLP
		,   FluCajPerAnt            = 0
	FROM	#Tmp_CarteraRes			Vigente
	/* Se incoporan siempre MAP 11-Sep-2014
	WHERE	NOT EXISTS( SELECT 1 FROM #Tmp_CarteraSaldo Saldo 
								WHERE Saldo.Folio	= Vigente.Folio 
								  AND Saldo.Correla = Vigente.Correla )
   */
	
	----------------------------------------------------------------------------------------------------------------
	--	7.0 SE DETERMINA EL RESULTADO DE LOS AVR CALCULANDO LA DIFERENCIA ENTRE EL SALDO Y LA FECHA DE ANALISIS	  --
	----------------------------------------------------------------------------------------------------------------

	UPDATE	dbo.TBL_TRIBUTARIOS
		SET nMontoResultado		= nMontoAVRNeto - nMontoAVRProceso -- - FluCajPer 
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

	
	/* Se comenta todo esto para obtener los datos de la DJ1829 
	----------------------------------------------------------------------------------------------------------------
	--	8.0 SE ACTUALIZAN LOS REGISTROS DE SALDO Y VIGENTES CON LOS ANTICIPOS Y VENCIMIENTOS DEL PERIODO	 	  --
	----------------------------------------------------------------------------------------------------------------

	UPDATE	dbo.TBL_TRIBUTARIOS
	SET		nMontoLiquidacion			= Vencida.Liquidacion
	,		CtaResultado				= Vencida.CuentaLiq
	FROM	dbo.TBL_TRIBUTARIOS			Cierre
			INNER JOIN #Tmp_CarteraHis	Vencida	ON Vencida.Folio   = Cierre.FolioContrato 
											   AND Vencida.Correla = Cierre.Correlativo
											   AND Vencida.Signo   = Cierre.nSignoAvr
	WHERE	Cierre.Origen				= @cOrigen
	AND		Cierre.FechaAnalisis		= @dFechaAnalisis
	AND		Cierre.FechaCierre			= @dFechaCierrePeriodo
	and     Vencida.Concepto		   <> 'PP'


	UPDATE	dbo.TBL_TRIBUTARIOS
	SET		nMontoCaja					= Vencida.Liquidacion
	,		CtaResultado				= Vencida.CuentaLiq
	FROM	dbo.TBL_TRIBUTARIOS			Cierre
			INNER JOIN #Tmp_CarteraHis	Vencida	ON Vencida.Folio   = Cierre.FolioContrato 
											   AND Vencida.Correla = Cierre.Correlativo
											   AND Vencida.Signo   = Cierre.nSignoAvr
	WHERE	Cierre.Origen				= @cOrigen
	AND		Cierre.FechaAnalisis		= @dFechaAnalisis
	AND		Cierre.FechaCierre			= @dFechaCierrePeriodo
	and     Vencida.Concepto		    = 'PP'

	----------------------------------------------------------------------------------------------------------------
	--	9.0 SE INYECTAN LOS REGISTROS DE ANTICIPO Y LIQUIDACION SIN SALDO O CARTERA VIGENTE	 					  --
	----------------------------------------------------------------------------------------------------------------
	
	INSERT INTO dbo.TBL_TRIBUTARIOS
	SELECT	FechaAnalisis			= @dFechaAnalisis
		,	FechaCierre				= @dFechaCierrePeriodo
			----------------------------------------------------
		,	FechaSuscripcion		= Vencida.FechaCierre
		,	FechaLiquidacion		= Vencida.FechaTermino
		,	FolioContrato			= Vencida.Folio
		,	Correlativo				= Vencida.Correla
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
	WHERE   NOT EXISTS ( SELECT 1 FROM #Tmp_CarteraSaldo Saldo 
								 WHERE Saldo.Folio		= Vencida.Folio
								   AND Saldo.Correla	= Vencida.Correla )
	
	AND		NOT EXISTS ( SELECT 1 FROM TBL_TRIBUTARIOS
								  WHERE FechaAnalisis	= @dFechaAnalisis
									AND Origen			= @cOrigen
									AND FolioContrato	= Vencida.Folio
									AND Correlativo		= Vencida.Correla )
	*/  
	----------------------------------------------------------------------------------------------------------------
	--	10.0 SE INYECTAN LOS REGISTROS ASOCIADOS A LAS COBERTURAS POR EL PATRIMONIO								  --
	----------------------------------------------------------------------------------------------------------------
	-- PENDIENTE: Cargar PATRIMONIO ACUMULADO COMO SI FUERAN PAGOS
	-- EN RIGOR HAY OPERACIONES QUE NO TIENEN AVR QUE MOVIERON
	-- PATRIMONIO DURANTE EL PERIODO

	----UPDATE	dbo.TBL_TRIBUTARIOS
	----SET		nMontoPatrimonio		= #Tmp_CarteraCob.Ajuste
	----,		CtaPatrimonio			= #Tmp_CarteraCob.Cuenta
	----FROM	#Tmp_CarteraCob
	----WHERE	#Tmp_CarteraCob.Folio	= TBL_TRIBUTARIOS.FolioContrato
	----AND		@cOrigen				= TBL_TRIBUTARIOS.Origen
	----AND		ABS(TBL_TRIBUTARIOS.nMontoAVRProceso) <> 0


		-->     [3.1]   -- Carga lo que cuadra con las cuentas de diferencia de Cambio.
	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato       
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                
		,	FolioContrato			= DJ.Contrato  -- Para opciones no Forward incluye el correlativo al final
		,	Correlativo				= DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= 'OPT'
		,	TipoOperacion			= DJ.KeyCntTipOper
		,	Producto				= case  when DJ.KeyCntId_Sistema = 'BFW'  then KeyCntProducto
															  when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'C' then 1
															  when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'V' then 2
															  when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'C' then 3
															  when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'V' then 4
															  else DJ.producto_Emp
									  end														 
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
		,	nMontoLiquidacion		= - Total_Pagos_Acum
		,	nMontoSaldoAvrTermino	= 0.0                      --  0
		----------------------------------------------------
		,	nSignoAvr				= case when DJ.Total_Pagos_Acum >= 0 then  '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= KeyCntMoneda1
		,	nMonedaConversion		= KeyCntMoneda2
		,   FluCajPer               = 0
		,   FluCajPerAnt            = 0
	FROM	BacParamSuda.dbo.DJ1829_Detalle		DJ
	where Modulo = 'SAO' and DJ.Total_Pagos_Acum <> 0 and DJ.Fecha_Analisis = @dFechaAnalisis
	-- select * from BacParamSuda.dbo.DJ1829_Detalle2013
	-- se cargan las diferencias de cambio de todo lo que proviene
	-- de opciones: Ei. Forward Asiático, Americano

	    -- Ajustes de AVR por provisiones y Pargua

	----------------------------------------------------------------------------------------------------------------
	--	09.0 SE INYECTAN REGISTROS ASOCIADOS A LOS AJUSTES DE AVR POR SER OPERACION PARGUA y PROVISIONES          --
	----------------------------------------------------------------------------------------------------------------
	/* Registro de provisiones ya fue cargado al procesar el AVR
	-- Adpatación NUmero de Contrato en caso que el origen sea SAO.
	select *  , ContratoOri = DJ.Contrato
	  into #DJ1829_DetalleIni
	  From BacParamSuda.dbo.DJ1829_Detalle DJ
	  where  DJ.Modulo = 'SAO' and DJ.evento = 'Curse' 
	       and (  DJ.KeyCntId_sistema = 'BFW' or DJ.KeyCntId_sistema = 'OPT' and DJ.CaNumEstructura = 1 )	
		   and DJ.Vigente_CierreAnoAnt	= 'S' 
		   and DJ.Fecha_Analisis = @dFechaAnalisis
		


    -- Corrige numero de Contrato SAO para compatibilizar con Provisiones
	update #DJ1829_DetalleIni
	   set Contrato = case when KeyCntId_sistema = 'BFW' then Contrato 
	                       else convert( numeric(10),  substring( rtrim( convert(varchar(10), Contrato) ) , 1, len( rtrim( convert(varchar(10), Contrato) ) )- 1 ) )
						   end	

	-->     [1.4]  -- Cartera Temporal para Aplicar ajustes de AVR, como no tiene correlativo la tabla
	-->               se asumirá siempre el componente 1 en el caso de SAO.
	--> Ajustes al inicio por contrato
	INSERT INTO #Tmp_CarteraAjustes
	SELECT	Folio			= Contrato, Cuenta = Cuenta, CuentaRes
		,	Ajuste			= SUM( Monto )
	FROM	BacParamSuda.dbo.TBL_Tributarios_ajustes  -- select * from BacParamSuda.dbo.TBL_Tributarios_ajustes
	WHERE	Fecha           = @dFechaCierrePeriodo  -- AND @dFechaAnalisis 	--		= @dFechaAnalisis	--> BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis
	AND		Origen			= @cOrigen
	GROUP BY Contrato, Cuenta, CuentaRes


	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	distinct
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato       
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                
		,	FolioContrato			= DJ.ContratoOri           -- Para indicar en Opciones no Forward el correlativo al final 
		,	Correlativo				= DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= DJ.KeyCntTipOper
		,	Producto				= case when DJ.KeyCntId_sistema = 'BFW' then DJ.KeyCntProducto 
		                              else Case when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'C' then 1
															when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'V' then 2
															when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'C' then 3
															when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'V' then 4
															else ''
													              end
									  end	 		                              														 
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
		-- nMontoResultado		=  -  ( nMontoAVRProceso - nMontoAVRNeto )
		,	nMontoResultado			= - ( 0.0 - Aj.Ajuste )
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Aj.Ajuste >= 0 then '-'  else '+' end
		,	iSaldo					= 0
		,	nMonedaOperacion		= DJ.KeyCntMoneda1
		,	nMonedaConversion		= DJ.KeyCntMoneda2
	FROM #Tmp_CarteraAjustes	Aj
	     inner join   #DJ1829_DetalleIni  DJ 
		             on Aj.Folio = DJ.Contrato 
	
	delete #Tmp_CarteraAjustes

	INSERT INTO #Tmp_CarteraAjustes
	SELECT	Folio			= Contrato, Cuenta = Cuenta, cuentaRes = CuentaREs
		,	Ajuste			= SUM( Monto )
	FROM	BacParamSuda.dbo.TBL_Tributarios_ajustes  
	WHERE	Fecha           = @dFechaAnalisis          
	AND		Origen			= @cOrigen
	GROUP BY Contrato, Cuenta, cuentaRes


      select *, ContratoOri = DJ.Contrato  
	  into #DJ1829_DetalleFin
	  From BacParamSuda.dbo.DJ1829_Detalle DJ
	  where  DJ.Modulo = 'SAO' and DJ.evento = 'Curse' 
	       and (  DJ.KeyCntId_sistema = 'BFW' or DJ.KeyCntId_sistema = 'OPT' and DJ.CaNumEstructura = 1 )	
		   and DJ.Vigente_CierreAno	= 'S' 
		   and DJ.Fecha_Analisis = @dFechaAnalisis

    -- Corrige numero de Contrato SAO para compatibilizar con Tributario
	update #DJ1829_DetalleFin
	   set Contrato = case when KeyCntId_sistema = 'BFW' then Contrato 
	                       else convert( numeric(10),  substring( rtrim( convert(varchar(10), Contrato) ) , 1, len( rtrim( convert(varchar(10), Contrato) ) )- 1 ) )
						   end	
	

	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	distinct
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= DJ.Fecha_Suscripcion_Contrato       
		,	FechaLiquidacion		= DJ.Fecha_Vencimiento                
		,	FolioContrato			= DJ.ContratoOri 
		,	Correlativo				= DJ.CaNumEstructura
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= @cOrigen
		,	TipoOperacion			= DJ.KeyCntTipOper
		,	Producto				= case when DJ.KeyCntId_sistema = 'BFW' then DJ.KeyCntProducto 
		                              else Case when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'C' then 1
															when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'V' then 2
															when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'C' then 3
															when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'V' then 4
															else ''
													              end
									  end			                              														 
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
	FROM #Tmp_CarteraAjustes	Aj
	     	     inner join   #DJ1829_DetalleFin  DJ 
		             on Aj.Folio = DJ.Contrato 


	-- Ajustes de AVR por Provisiones y Pargua
	*/

	-->  
	-->     [1.4]  -- Cartera Temporal para Almacenar la Cartera Vencida a la fecha de Analisis
	-- Hay un error de diseño Las coberturas no están por componente
	INSERT INTO #Tmp_CarteraCob
	SELECT	Folio			= Contrato
		,	Cuenta			= Cuenta
		,   CuentaResultado = CuentaResultado
		,	Ajuste			= SUM( Ajuste )
	FROM	BacParamSuda.dbo.TBL_PATRIMONIO 
	WHERE	/* Fecha			= @dFechaAnalisis --> BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis */
	        Fecha BETWEEN @dFechaInicioPeriodo AND @dFechaAnalisis -- Tiene que ser acumulado
	AND		Origen			= @cOrigen  
	GROUP BY Contrato, Cuenta, CuentaResultado

	-- Se generará registro cuya tabla base será #Tmp_CarteraCob
	-- los datos de las operaciones saldrán de lo que hay en  
	-- BacParamSuda.dbo.DJ1829_Detalle2013	

     select *  , ContratoOri = DJ.Contrato
	  into #DJ1829_Detalle
	  From BacParamSuda.dbo.DJ1829_Detalle DJ
	  where  DJ.Modulo = 'SAO' 
		   and DJ.Fecha_Analisis = @dFechaAnalisis

    -- Corrige numero de Contrato SAO para compatibilizar con Tributario
	update #DJ1829_Detalle
	   set Contrato = case when KeyCntId_sistema = 'BFW' then Contrato 
	                       else convert( numeric(10),  substring( rtrim( convert(varchar(10), Contrato) ) , 1, len( rtrim( convert(varchar(10), Contrato) ) )- 1 ) )
						   end	




	INSERT INTO dbo.TBL_TRIBUTARIOS  
	SELECT	distinct 
	        FechaAnalisis			= @dFechaAnalisis          
		,	FechaCierre				= @dFechaCierrePeriodo     
		----------------------------------------------------
		,	FechaSuscripcion		= max(DJ.Fecha_Suscripcion_Contrato)       
		,	FechaLiquidacion		= max(DJ.Fecha_Vencimiento)
		,	FolioContrato			= DJ.ContratoOri 
		,	Correlativo				= max(DJ.CaNumEstructura )
		,	NewRegistro				= 0                        -- ?
		----------------------------------------------------
		,	Origen					= 'OPT'
		,	TipoOperacion			= max( DJ.KeyCntTipOper )
		,	Producto				= max( case when DJ.KeyCntId_sistema = 'BFW' then DJ.KeyCntProducto 
		                              else Case when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'C' then 1
															when DJ.KeyCntCallPut = 'Call' and DJ.KeyCntTipOper = 'V' then 2
															when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'C' then 3
															when DJ.KeyCntCallPut = 'Put'  and DJ.KeyCntTipOper = 'V' then 4
															else DJ.Producto_Emp 
													              end
									  end )														 
		,	RutCliente				= max(DJ.Rut_Cliente_Emp)
		,	CodCliente				= max(DJ.Codigo_Cliente_Emp)
		----------------------------------------------------
		,	CtaAVR					= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030' ) then
                                           Cob.Cuenta
      								   else
										    ''
                                       end
		,	CtaPatrimonio			= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030' ) then ''
		                              else Cob.Cuenta end
		,	CtaResultado			= Cob.CuentaResultado
		,	CtaCaja					= ''
		----------------------------------------------------
		,	nMontoAVRNeto			= 0.0
		,	nMontoAVRProceso		= 0.0 
		,	nMontoCaja				= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030'  )
		                               then - Cob.Ajuste else 0 end  
		,	nMontoPatrimonio		= case when Cob.Cuenta in ( '411501026', '411501031', '411501027', '411501029', '411501033', '435001008', '411501030'  ) 
		                               then 0 else - Cob.Ajuste  end
		----------------------------------------------------
		,	nMontoResultado			= 0.0
		,	nMontoLiquidacion		= 0.0
		,	nMontoSaldoAvrTermino	= 0.0
		----------------------------------------------------
		,	nSignoAvr				= case when Cob.Ajuste >= 0 then '-' else '+'  end
		,	iSaldo					= 0
		,	nMonedaOperacion		= max(DJ.KeyCntMoneda1)
		,	nMonedaConversion		= max(DJ.KeyCntMoneda2)
		,   FluCajPer               = 0		
		,   FluCajPerAnt            = 0
	FROM #Tmp_CarteraCob	Cob
	     inner join   #DJ1829_Detalle  DJ on Cob.Folio = DJ.Contrato and (    DJ.KeyCntId_sistema = 'BFW' and  DJ.CaNumEstructura = 0 
																			       or 
																		      DJ.KeyCntId_sistema = 'OPT' and  DJ.CaNumEstructura = 1 ) 
	where DJ.Modulo = 'SAO' 
	    group by  DJ.Contrato , Cob.Cuenta, Cob.Ajuste , Cob.CuentaResultado, DJ.ContratoOri



	RETURN 0

END


GO
