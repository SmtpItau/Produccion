USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_LIQUIDACION_PROYECCION]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GENERA_LIQUIDACION_PROYECCION] ( @Fecha_Vencimiento   DATETIME, @NumOper numeric(10) = 0  , @His varchar(2) = 'NO' )    
AS    
BEGIN    
	SET NOCOUNT ON     
  
	declare @fechaSistema datetime  
	
	DECLARE @Fecha_ProcAnt     DATETIME    
	DECLARE @Utilidad_ML       FLOAT  
       
	DECLARE @Perdida_ML        FLOAT   
	DECLARE @Debug  char(1)

	set @Debug  =  'N'

	select  @fechaSistema	= fechaProc 
			,@Fecha_ProcAnt = fechaant
	from bacswapsuda.dbo.swapgeneral  

	IF @Fecha_Vencimiento < @fechaSistema 
	BEGIN 
		 SET @His =  'SI'   
	END
	ELSE
	BEGIN
		 SET @His =  'NO' 
	END 

	--SET @His =  'si' 
	if @Debug  =  'S' 
		SELECT '@His'=@His,'@fechaSistema'=@fechaSistema, '@Fecha_Vencimiento'=@Fecha_Vencimiento

	if @His <> 'NO' 
	BEGIN 
      SELECT @fechaSistema = fechaProc 
			,@Fecha_ProcAnt = fechaant
	  FROM BacSwapSuda..SWAPGENERALHIS 
	  where fechaproc =  @Fecha_Vencimiento   
	END  

	
	select * into #VALOR_MONEDA_COMPLETO from BacParamSuda.dbo.valor_moneda where vmvalor <> 0  
  
	-->>RESCATE CARTERA OPERACION
	select 	numero_operacion
		,	numero_flujo
		,	tipo_flujo
		,	tipo_swap
		,	cartera_inversion
		,	tipo_operacion
		,	codigo_cliente
		,	rut_cliente
		,	fecha_cierre
		,	fecha_inicio
		,	fecha_termino
		,	fecha_inicio_flujo
		,	fecha_vence_flujo
		,	fecha_fijacion_tasa
		,	compra_moneda
		,	compra_capital
		,	compra_amortiza
		,	compra_saldo
		,	compra_interes
		,	compra_spread
		,	compra_codigo_tasa
		,	compra_valor_tasa
		,	compra_valor_tasa_hoy
		,	compra_codamo_capital
		,	compra_mesamo_capital
		,	compra_codamo_interes
		,	compra_mesamo_interes
		,	compra_base
		,	venta_moneda
		,	venta_capital
		,	venta_amortiza
		,	venta_saldo
		,	venta_interes
		,	venta_spread
		,	venta_codigo_tasa
		,	venta_valor_tasa
		,	venta_valor_tasa_hoy
		,	venta_codamo_capital
		,	venta_mesamo_capital
		,	venta_codamo_interes
		,	venta_mesamo_interes
		,	venta_base
		,	operador
		,	operador_cliente
		,	estado_flujo
		,	modalidad_pago
		,	pagamos_moneda
		,	pagamos_documento
		,	pagamos_monto
		,	pagamos_monto_USD
		,	pagamos_monto_CLP
		,	recibimos_moneda
		,	recibimos_documento
		,	recibimos_monto
		,	recibimos_monto_USD
		,	recibimos_monto_CLP
		,	observaciones
		,	fecha_modifica
		,	devengo_dias
		,	devengo_monto
		,	devengo_monto_peso
		,	devengo_monto_acum
		,	devengo_monto_ayer
		,	devengo_compra
		,	devengo_compra_acum
		,	devengo_compra_acum_peso
		,	devengo_compra_ayer
		,	devengo_compra_ayer_peso
		,	devengo_venta
		,	devengo_venta_acum
		,	devengo_venta_acum_peso
		,	devengo_venta_ayer
		,	devengo_venta_ayer_peso
		,	fecha_valoriza
		,	compra_zcr
		,	compra_mercado_tasa
		,	compra_mercado
		,	compra_mercado_usd
		,	compra_mercado_clp
		,	compra_duration_tasa
		,	compra_duration_monto
		,	compra_duration_monto_usd
		,	compra_duration_monto_clp
		,	compra_valor_presente
		,	venta_zcr
		,	venta_mercado_tasa
		,	venta_mercado
		,	venta_mercado_usd
		,	venta_mercado_clp
		,	venta_duration_tasa
		,	venta_duration_monto
		,	venta_duration_monto_usd
		,	venta_duration_monto_clp
		,	venta_valor_presente
		,	monto_mtm
		,	monto_mtm_usd
		,	monto_mtm_clp
		,	compra_valorizada
		,	compra_variacion
		,	venta_valorizada
		,	venta_variacion
		,	valorizacion_dia
		,	estado
		,	Estado_oper_lineas
		,	Observacion_Lineas
		,	Observacion_Limites
		,	Especial
		,	Capital_Pesos_Actual
		,	Capital_Pesos_Ayer
		,	Hora
		,	Tasa_Compra_Curva
		,	Tasa_Venta_Curva
		,	Activo_MO_C08
		,	Pasivo_MO_C08
		,	Activo_USD_C08
		,	Pasivo_USD_C08
		,	Activo_CLP_C08
		,	Pasivo_CLP_C08
		,	Tasa_Compra_CurvaVR
		,	Tasa_Venta_CurvaVR
		,	Activo_FlujoMO
		,	Activo_FlujoUSD
		,	Activo_FlujoCLP
		,	Pasivo_FlujoMO
		,	Pasivo_FlujoUSD
		,	Pasivo_FlujoCLP
		,	Valor_RazonableMO
		,	Valor_RazonableUSD
		,	Valor_RazonableCLP
		,	Monto_Spread
		,	Monto_diferido_inicial
		,	Monto_diferido_diario
		,	Monto_diferido_acumulado
		,	TC_MO_Inicial
		,	Monto_TC_Diario
		,	Monto_TC_Acumulado
		,	Monto_Reajuste_Diario
		,	Monto_Reajuste_Acumulado
		,	Monto_Valorizacion
		,	Monto_Capital_TC_ini
		--,	car_area_Responsable
		--,	car_Cartera_Normativa
		--,	car_SubCartera_Normativa
		--,	car_Libro
		,	DevAntPromCam
		,	vRazAjustado_Mo
		,	vRazAjustado_Mn
		,	vRazAjustado_Do
		,	vRazActivoAjus_Mo
		,	vRazPasivoAjus_Mo
		,	vRazActivoAjus_Mn
		,	vRazPasivoAjus_Mn
		,	vRazActivoAjus_Do
		,	vRazPasivoAjus_Do
		,	vTasaActivaAjusta
		,	vTasaPasivaAjusta
		,	vDurMacaulActivo
		,	vDurMacaulPasivo
		,	vDurModifiActivo
		,	vDurModifiPasivo
		,	vDurConvexActivo
		,	vDurConvexPasivo
		,	FeriadoFlujoChile
		,	FeriadoFlujoEEUU
		,	FeriadoFlujoEnglan
		,	FeriadoLiquiChile
		,	FeriadoLiquiEEUU
		,	FeriadoLiquiEnglan
		,	Convencion
		,	DiasReset
		,	FechaEfectiva
		,	PrimerPago
		,	PenultimoPago
		,	Madurez
		,	Note
		,	IntercPrinc
		,	Tikker
		,	FechaLiquidacion
		,	FechaReset
		,	CompraTasaProyectada
		,	VentaTasaProyectada
		,	estado_sinacofi
		,	fecha_sinacofi
		,	Moneda_Valorizacion
		,	Valor_Mercado_Activo_Mda_Val
		,	Devengo_Recibido_Mda_Val
		,	Valor_Mercado_Pasivo_Mda_Val
		,	Devengo_Pagar_Mda_Val
		,	Principal_Mda_Val
		,	Devengo_Neto_Mda_Val
		,	Valor_Mercado_Mda_Val
		,	Porcentaje_Margen
		,	Monto_Margen
		,	Monto_Margen_CLP
		,	OrigenCurva
		,	ActivoTir
		,	PasivoTir
		,	ActivoTirCnv
		,	PasivoTirCnv
		,	FxRate
		,	Compra_amortiza_Prc
		,	Venta_amortiza_Prc
		,	Compra_Flujo_Adicional
		,	Venta_Flujo_Adicional
		,	FechaValuta
		,	CompraPerResetCod
		,	VentaPerResetCod
		,	CompraLiqDefault
		,	VentaLiqDefault
		,	CompraResetDefault
		,	VentaResetDefault
		,	Compra_DV01_Forward
		,	Venta_DV01_Forward
		,	Compra_DV01_Descuento
		,	Venta_DV01_Descuento
		,	Compra_curva_TIR
		,	Venta_curva_TIR
		,	Compra_Curva_Descont
		,	Venta_Curva_Descont
		,	Compra_Curva_Forward
		,	Venta_Curva_Forward
		,	Monto_LCR_Matriz
		,	Monto_LCR_Ajuste_AVR
		,	Trader_Contraparte
		,	Especifica_Negocio
		,	Compra_Tasa_Forward_larga
		,	Compra_Tasa_Forward_corta
		,	PlazoFlujo
		,	PortaFolio
		,	Threshold
		,	bEarlyTermination
		,	FechaInicio
		,	Periodicidad
		,	ReferenciaUSDCLP
		,	ReferenciaMEXUSD
		,	FechaUSDCLP
		,	FechaMEXUSD
		,	InterNocIni
		,	InterNocFin
	INTO #TMP_CARTERA
	from BacSwapSuda..cartera 
	where FechaLiquidacion  = @Fecha_Vencimiento
	--and @fechaSistema = @Fecha_Vencimiento
	--and numero_operacion = @NumOper
UNION ALL
	select top 0 	numero_operacion
		,	numero_flujo
		,	tipo_flujo
		,	tipo_swap
		,	cartera_inversion
		,	tipo_operacion
		,	codigo_cliente
		,	rut_cliente
		,	fecha_cierre
		,	fecha_inicio
		,	fecha_termino
		,	fecha_inicio_flujo
		,	fecha_vence_flujo
		,	fecha_fijacion_tasa
		,	compra_moneda
		,	compra_capital
		,	compra_amortiza
		,	compra_saldo
		,	compra_interes
		,	compra_spread
		,	compra_codigo_tasa
		,	compra_valor_tasa
		,	compra_valor_tasa_hoy
		,	compra_codamo_capital
		,	compra_mesamo_capital
		,	compra_codamo_interes
		,	compra_mesamo_interes
		,	compra_base
		,	venta_moneda
		,	venta_capital
		,	venta_amortiza
		,	venta_saldo
		,	venta_interes
		,	venta_spread
		,	venta_codigo_tasa
		,	venta_valor_tasa
		,	venta_valor_tasa_hoy
		,	venta_codamo_capital
		,	venta_mesamo_capital
		,	venta_codamo_interes
		,	venta_mesamo_interes
		,	venta_base
		,	operador
		,	operador_cliente
		,	estado_flujo
		,	modalidad_pago
		,	pagamos_moneda
		,	pagamos_documento
		,	pagamos_monto
		,	pagamos_monto_USD
		,	pagamos_monto_CLP
		,	recibimos_moneda
		,	recibimos_documento
		,	recibimos_monto
		,	recibimos_monto_USD
		,	recibimos_monto_CLP
		,	observaciones
		,	fecha_modifica
		,	devengo_dias
		,	devengo_monto
		,	devengo_monto_peso
		,	devengo_monto_acum
		,	devengo_monto_ayer
		,	devengo_compra
		,	devengo_compra_acum
		,	devengo_compra_acum_peso
		,	devengo_compra_ayer
		,	devengo_compra_ayer_peso
		,	devengo_venta
		,	devengo_venta_acum
		,	devengo_venta_acum_peso
		,	devengo_venta_ayer
		,	devengo_venta_ayer_peso
		,	fecha_valoriza
		,	compra_zcr
		,	compra_mercado_tasa
		,	compra_mercado
		,	compra_mercado_usd
		,	compra_mercado_clp
		,	compra_duration_tasa
		,	compra_duration_monto
		,	compra_duration_monto_usd
		,	compra_duration_monto_clp
		,	compra_valor_presente
		,	venta_zcr
		,	venta_mercado_tasa
		,	venta_mercado
		,	venta_mercado_usd
		,	venta_mercado_clp
		,	venta_duration_tasa
		,	venta_duration_monto
		,	venta_duration_monto_usd
		,	venta_duration_monto_clp
		,	venta_valor_presente
		,	monto_mtm
		,	monto_mtm_usd
		,	monto_mtm_clp
		,	compra_valorizada
		,	compra_variacion
		,	venta_valorizada
		,	venta_variacion
		,	valorizacion_dia
		,	estado
		,	Estado_oper_lineas
		,	Observacion_Lineas
		,	Observacion_Limites
		,	Especial
		,	Capital_Pesos_Actual
		,	Capital_Pesos_Ayer
		,	Hora
		,	Tasa_Compra_Curva
		,	Tasa_Venta_Curva
		,	Activo_MO_C08
		,	Pasivo_MO_C08
		,	Activo_USD_C08
		,	Pasivo_USD_C08
		,	Activo_CLP_C08
		,	Pasivo_CLP_C08
		,	Tasa_Compra_CurvaVR
		,	Tasa_Venta_CurvaVR
		,	Activo_FlujoMO
		,	Activo_FlujoUSD
		,	Activo_FlujoCLP
		,	Pasivo_FlujoMO
		,	Pasivo_FlujoUSD
		,	Pasivo_FlujoCLP
		,	Valor_RazonableMO
		,	Valor_RazonableUSD
		,	Valor_RazonableCLP
		,	Monto_Spread
		,	Monto_diferido_inicial
		,	Monto_diferido_diario
		,	Monto_diferido_acumulado
		,	TC_MO_Inicial
		,	Monto_TC_Diario
		,	Monto_TC_Acumulado
		,	Monto_Reajuste_Diario
		,	Monto_Reajuste_Acumulado
		,	Monto_Valorizacion
		,	Monto_Capital_TC_ini
		--,	car_area_Responsable
		--,	car_Cartera_Normativa
		--,	car_SubCartera_Normativa
		--,	car_Libro
		,	DevAntPromCam
		,	vRazAjustado_Mo
		,	vRazAjustado_Mn
		,	vRazAjustado_Do
		,	vRazActivoAjus_Mo
		,	vRazPasivoAjus_Mo
		,	vRazActivoAjus_Mn
		,	vRazPasivoAjus_Mn
		,	vRazActivoAjus_Do
		,	vRazPasivoAjus_Do
		,	vTasaActivaAjusta
		,	vTasaPasivaAjusta
		,	vDurMacaulActivo
		,	vDurMacaulPasivo
		,	vDurModifiActivo
		,	vDurModifiPasivo
		,	vDurConvexActivo
		,	vDurConvexPasivo
		,	FeriadoFlujoChile
		,	FeriadoFlujoEEUU
		,	FeriadoFlujoEnglan
		,	FeriadoLiquiChile
		,	FeriadoLiquiEEUU
		,	FeriadoLiquiEnglan
		,	Convencion
		,	DiasReset
		,	FechaEfectiva
		,	PrimerPago
		,	PenultimoPago
		,	Madurez
		,	Note
		,	IntercPrinc
		,	Tikker
		,	FechaLiquidacion
		,	FechaReset
		,	CompraTasaProyectada
		,	VentaTasaProyectada
		,	estado_sinacofi
		,	fecha_sinacofi
		,	Moneda_Valorizacion
		,	Valor_Mercado_Activo_Mda_Val
		,	Devengo_Recibido_Mda_Val
		,	Valor_Mercado_Pasivo_Mda_Val
		,	Devengo_Pagar_Mda_Val
		,	Principal_Mda_Val
		,	Devengo_Neto_Mda_Val
		,	Valor_Mercado_Mda_Val
		,	Porcentaje_Margen
		,	Monto_Margen
		,	Monto_Margen_CLP
		,	OrigenCurva
		,	ActivoTir
		,	PasivoTir
		,	ActivoTirCnv
		,	PasivoTirCnv
		,	FxRate
		,	Compra_amortiza_Prc
		,	Venta_amortiza_Prc
		,	Compra_Flujo_Adicional
		,	Venta_Flujo_Adicional
		,	FechaValuta
		,	CompraPerResetCod
		,	VentaPerResetCod
		,	CompraLiqDefault
		,	VentaLiqDefault
		,	CompraResetDefault
		,	VentaResetDefault
		,	Compra_DV01_Forward
		,	Venta_DV01_Forward
		,	Compra_DV01_Descuento
		,	Venta_DV01_Descuento
		,	Compra_curva_TIR
		,	Venta_curva_TIR
		,	Compra_Curva_Descont
		,	Venta_Curva_Descont
		,	Compra_Curva_Forward
		,	Venta_Curva_Forward
		,	Monto_LCR_Matriz
		,	Monto_LCR_Ajuste_AVR
		,	Trader_Contraparte
		,	Especifica_Negocio
		,	Compra_Tasa_Forward_larga
		,	Compra_Tasa_Forward_corta
		,	PlazoFlujo
		,	PortaFolio
		,	Threshold
		,	bEarlyTermination
		,	FechaInicio
		,	Periodicidad
		,	ReferenciaUSDCLP
		,	ReferenciaMEXUSD
		,	FechaUSDCLP
		,	FechaMEXUSD
		,	InterNocIni
		,	InterNocFin
 	from BacSwapSuda..carterares 
	where Fecha_Proceso = @Fecha_Vencimiento
	--and numero_operacion = @NumOper
	and FechaLiquidacion = @Fecha_Vencimiento
	AND @fechaSistema <> @Fecha_Vencimiento

		
	update #TMP_CARTERA 
		set  FechaUSDCLP = fechaLiquidacion  
	from #TMP_CARTERA where  FechaUSDCLP is null or FechaUSDCLP = '19000101'  
	and ( numero_Operacion = @NumOper or @NumOper = 0 )  
	and @His = 'NO'  


	update #TMP_CARTERA 
		set FechaMEXUSD = fechaLiquidacion  
	where  FechaMEXUSD is null or FechaMEXUSD = '19000101'    
	and ( numero_Operacion = @NumOper or @NumOper = 0 )  
	and @His = 'NO'  

	if @Debug  =  'S' 
	begin
		SELECT '#TMP_CARTERA' AS TABLA ,'@His'=@His ,FechaUSDCLP,fechaLiquidacion,* FROM #TMP_CARTERA
		SELECT '@Fecha_ProcAnt' = @Fecha_ProcAnt,'@fechaSistema'=@fechaSistema
	end 

   SELECT 
		C.numero_operacion  
		, C.numero_flujo  
		, C.Tipo_Flujo  
		, C.FechaLiquidacion   
		, C.tipo_swap   
		, C.modalidad_pago   
		, C.recibimos_moneda   
		, C.pagamos_moneda   
		, C.compra_moneda   
		, C.venta_moneda  
		, FechaUSDCLP  
		, FechaMEXUSD   
		, ReferenciaUSDCLP  
		, ReferenciaMEXUSD  
		, c.FeriadoFlujoEEUU    
		, c.FeriadoFlujoEnglan    
		, c.Fecha_Vence_flujo  
		, c.Rut_Cliente  
		, c.Codigo_Cliente  
		, c.Estado  
		, c.Cartera_Inversion --   
		, c.recibimos_documento  
		, c.Operador  
		, c.Compra_Amortiza  
		, c.IntercPrinc  
		, c.Compra_Flujo_Adicional  
		, c.Compra_Interes  
		, c.Recibimos_Monto  
		, c.fecha_inicio_Flujo  
		, c.Compra_Mercado_tasa  
		, c.Pagamos_Documento --  
		, c.venta_amortiza  
		, c.venta_flujo_adicional  
		, c.venta_interes  
		, c.Pagamos_Monto  
		, c.Venta_Mercado_tasa  
	INTO #CARTERACOMP  
	from BacSwapSuda..Cartera C where 1 = 2  

	--set @His = 'SI'--aqui

   if @His = 'NO'  
   BEGIN
		Insert #CARTERACOMP    
		select 
			C.numero_operacion  
			, C.numero_flujo  
			, C.Tipo_Flujo  
			, C.FechaLiquidacion   
			, C.tipo_swap   
			, C.modalidad_pago   
			, C.recibimos_moneda   
			, C.pagamos_moneda   
			, C.compra_moneda   
			, C.venta_moneda  
			, FechaUSDCLP  
			, FechaMEXUSD   
			, ReferenciaUSDCLP  
			, ReferenciaMEXUSD  
			, c.FeriadoFlujoEEUU    
			, c.FeriadoFlujoEnglan    
			, c.Fecha_Vence_flujo  
			, c.Rut_Cliente  
			, c.Codigo_Cliente  
			, c.Estado  
			, c.Cartera_Inversion --   
			, c.recibimos_documento  
			, c.Operador  
			, c.Compra_Amortiza  
			, c.IntercPrinc  
			, c.Compra_Flujo_Adicional  
			, c.Compra_Interes  
			, c.Recibimos_Monto  
			, c.fecha_inicio_Flujo  
			, c.Compra_Mercado_tasa  
			, c.Pagamos_Documento --  
			, c.venta_amortiza  
			, c.venta_flujo_adicional  
			, c.venta_interes  
			, c.Pagamos_Monto  
			, c.Venta_Mercado_tasa  
		FROM BacSwapSuda..CARTERA c    
		WHERE fechaliquidacion = @Fecha_Vencimiento    
		AND Estado          <> 'C'          -- No Cotizaciones     
		AND ( Numero_Operacion = @NumOper or @NumOper = 0 )  
	END 
	else  
	BEGIN
	   insert #CARTERACOMP    
	   select 
			C.numero_operacion  
			, C.numero_flujo  
			, C.Tipo_Flujo  
			, C.FechaLiquidacion   
			, C.tipo_swap   
			, C.modalidad_pago   
			, C.recibimos_moneda   
			, C.pagamos_moneda   
			, C.compra_moneda   
			, C.venta_moneda  
			, FechaUSDCLP  
			, FechaMEXUSD   
			, ReferenciaUSDCLP  
			, ReferenciaMEXUSD  
			, c.FeriadoFlujoEEUU    
			, c.FeriadoFlujoEnglan    
			, c.Fecha_Vence_flujo  
			, c.Rut_Cliente  
			, c.Codigo_Cliente  
			, c.Estado  
			, c.Cartera_Inversion --   
			, c.recibimos_documento  
			, c.Operador  
			, c.Compra_Amortiza  
			, c.IntercPrinc  
			, c.Compra_Flujo_Adicional  
			, c.Compra_Interes  
			, c.Recibimos_Monto  
			, c.fecha_inicio_Flujo  
			, c.Compra_Mercado_tasa  
			, c.Pagamos_Documento --  
			, c.venta_amortiza  
			, c.venta_flujo_adicional  
			, c.venta_interes  
			, c.Pagamos_Monto  
			, c.Venta_Mercado_tasa  
	   FROM BACSWAPSUDA..CARTERAHIS c    -- select fechaliquidacion, estado, * from CARTERAHIS where numero_operacion = 7066  
	   WHERE fechaliquidacion = @Fecha_Vencimiento    
	   AND Estado          <> 'C'          -- No Cotizaciones     
	   AND ( Numero_Operacion = @NumOper or @NumOper = 0 )  
	END


	if @Debug  =  'S' 
		SELECT '#CARTERACOMP' AS TABLA,* FROM #CARTERACOMP
  
 -- Para probar de a poco todas las combinaciones  
 -- and venta_moneda = 999 and pagamos_Moneda = 13  
    
    
    /* Estructura de conversión */  
    declare @DiaLiquidacion datetime  
    select  @DiaLiquidacion = @Fecha_Vencimiento -- Parametro de llamador GENERA_COMPENSACION_CNT  
  
    set nocount on  
    select 
		C.numero_operacion  
		, C.numero_flujo  
		, C.Tipo_Flujo  
		, C.FechaLiquidacion   
		, C.tipo_swap   
		, C.modalidad_pago   
		, Moneda_Pago = C.recibimos_moneda + C.pagamos_moneda   
		, Moneda_Pata = C.compra_moneda +  C.venta_moneda  
    
		/* Refencia de Mercado default */  
		, ReferenciaUSDCLP = isnull( ReferenciaUSDCLP, 31 )                                   -- T0 default 30 => T-1  
		, ReferenciaMEXUSD = isnull( ReferenciaMEXUSD, 0 )                                    --   
    
  
		/* Se asume la fecha de liquidacion como fechas de referencia de mercado */  
		, FechaUSDCLP = case when c.estado = 'N' then c.FechaLiquidacion else  isnull(c.FechaUSDCLP, FechaLiquidacion ) end    
		, FechaMEXUSD = case when c.estado = 'N' then c.FechaLiquidacion else  isnull( c.FechaMEXUSD, FechaLiquidacion  ) end                 
  
		/* Se asume el valor USD observado del dia de liquidacion como valor ref. usdClp */  
		, ValorUSDCLP                 = convert( float, 0 )                                  -- Segunda pasada  
  
			, ValorMdaPagoCLP             = convert( float, 0 )                                  -- Segunda pasada  
		, ValorMdaPataCLP             = convert( float, 0 )                                  -- Segunda pasada  
  
			, ParidadMdaPago             = convert( float, 0 )                                  -- Segunda pasada  
		, ParidadMdaPata             = convert( float, 0 )                                  -- Segunda pasada  
  
  
			, FactorConvMdaPataAMdaPago   = convert( float, 0 )                                  -- Segunda pasada            
		, Feriados        =  ';6'   
										+ case when c.FeriadoFlujoEEUU  = 1 then ';255' else '' end  
				+ case when c.FeriadoFlujoEnglan = 1 then  ';510' else '' end  
				+ ';'  
			, FeriadosSinPtoComa          = '6'   
										+ case when c.FeriadoFlujoEEUU  = 1 then ' 255 ' else '' end  
				+ case when c.FeriadoFlujoEnglan = 1 then  ' 510' else '' end  
		, Correlativo                 = identity(INT)   
  
		, MdaCapMultiplicaoDivide     = Cap.mnrrda  
		, MdaPagMultiplicaoDivide     = Pag.mnrrda  
		, ConvUFconFechaVencimiento   = isnull( case when TG.tbvalor <> 0 then 'S' else null end, 'N' )   
		, Fecha_Vence_flujo    
		, MdaCapCurrency              = Cap.MnMx     
		, MdaPagCurrency              = Pag.MnMx  
		, PasaPorParidad              = Case when ( Cap.MnMx = 'C' or Pag.MnMx = 'C'  ) then 'Si' else 'No' End  
		, MdaPago_distinta_MdaCap     = case when c.compra_moneda + c.venta_moneda <> c.recibimos_moneda + c.pagamos_moneda then 'Si' else 'No' end  
	into #TempValorMdaPataPago    
	from #CARTERACOMP C  
	left join BacParamSuda.dbo.Moneda Pag on Pag.mncodmon = recibimos_moneda + pagamos_moneda   
	left join BacParamSuda.dbo.Moneda Cap on Cap.mncodmon = Compra_moneda + Venta_moneda   
	left join BacParamSuda.dbo.TABLA_GENERAL_DETALLE TG on TG.tbCateg = 29 and TG.tbvalor = Rut_Cliente and TG.nemo = Codigo_Cliente  
	where fechaliquidacion = @DiaLiquidacion and c.estado <> 'C'     
  
  
     update #TempValorMdaPataPago    
     Set  
		ValorUSDCLP = isnull(  ( select vmvalor from #VALOR_MONEDA_COMPLETO    
                                    where vmcodigo = 994 and   
                  vmfecha = FechaUSDCLP  ) ,   
         isnull( (select vmvalor from #VALOR_MONEDA_COMPLETO  
                                    where vmcodigo = 994 and   
                  vmfecha = @fechaSistema) , 1 ) )  
  
		,ValorMdaPagoCLP = case when moneda_pago = 999 then 1.0 else isnull( ( select vmvalor from   
                                                                           #VALOR_MONEDA_COMPLETO   
                      where vmcodigo = case when Moneda_Pago = 13 then 994 else moneda_pago end  
                                                          and vmfecha  = FechaUSDCLP ),   
                   isnull( (select vmvalor from   
                      #VALOR_MONEDA_COMPLETO   
                                  where vmcodigo = case when Moneda_pago = 13 then 994 else moneda_pago end  
                      and vmfecha = @fechaSistema ) , 1 )  
                             ) end  
		,ValorMdaPataCLP = case when Moneda_pata = 999 then 1.0 else isnull( ( select vmvalor from   
                                                                             #VALOR_MONEDA_COMPLETO  
                    where vmcodigo = case when Moneda_Pata = 13 then 994 else moneda_pata end  
                                                           and vmfecha  = case when moneda_pata = 998   
                                    then case when ConvUFconFechaVencimiento = 'S' then fecha_Vence_Flujo  
                      else fechaLiquidacion end  
                                    else FechaUSDCLP end ),   
                                                                               isnull( ( select vmvalor from   
                                                                             #VALOR_MONEDA_COMPLETO  
                    where vmcodigo = case when Moneda_Pata = 13 then 994 else moneda_pata end  
                                        and vmfecha  = case when moneda_pata = 998   
                                    then case when ConvUFconFechaVencimiento = 'S' then fecha_Vence_Flujo  
                      else fechaLiquidacion end  
                                    else @fechaSistema end ) , 1 )                     
                       
                      )  end  
  

--  select 'debug', * from #TempValorMdaPataPago where ValorMdaPagoCLP = 0 or ValorUSDCLP = 0 or ValorMdaPataCLP = 0  
  -- goto FIN  
	update #TempValorMdaPataPago  
	Set  
		FactorConvMdaPataAMdaPago = case when Moneda_Pata = Moneda_Pago then 1.0  
                                       else  ValorMdaPataCLP / ValorMdaPagoCLP end   
		,ParidadMdaPago           = round( case when MdaPagMultiplicaoDivide = 'M' then  
                                      ValorMdaPagoCLP / ValorUSDCLP     
           else  
                 ValorUSDCLP / ValorMdaPagoCLP   
           end , case when MdaPagCurrency = 'C' then 6 else 20 end )  
		,ParidadMdaPata           = round( case when MdaCapMultiplicaoDivide = 'M' then  
                                      ValorMdaPataCLP / ValorUSDCLP     
           else  
                 ValorUSDCLP / ValorMdaPataCLP   
           end, case when MdaCapCurrency = 'C' then 6 else 20 end )  
  
  
	update #TempValorMdaPataPago  
		set ValorMdaPagoCLP = round( ValorUSDCLP * case when MdaPagMultiplicaoDivide = 'M' then ParidadMdaPago else 1.0000 / ParidadMdaPago end , 6 )  
	where ( MdaPagCurrency = 'C')   
      
	update #TempValorMdaPataPago  
		set ValorMdaPataCLP = round( ValorUSDCLP * case when MdaCapMultiplicaoDivide = 'M' then ParidadMdaPata else 1.0000 / ParidadMdaPata end , 6 )  
	WHERE  MdaCapCurrency = 'C'   
  
  
	-- En la pantalla "Ingreso de TC/paridad de Flujos se   
	-- instruye una fecha de rescate o también se instruye un   
	-- valor específico. Este caso se buscar el valor   
	-- en parámetros usando la fecha indicada en Cartera_Conversion  
	update #TempValorMdaPataPago   
	set       ValorUSDCLP        = isnull(  convert( float, ( select vmvalor from #VALOR_MONEDA_COMPLETO    
                                                              where vmcodigo = 994 and   
                                      vmfecha = CConv.Fecha_rescate  ) )  , ValorUSDCLP )      -- OK  
	from BacSwapSuda.dbo.Cartera_Conversion CConv  
	where CConv.Numero_Operacion = #TempValorMdaPataPago.numero_operacion   
	and CConv.numero_Flujo = #TempValorMdaPataPago.numero_Flujo  
	and CConv.Tipo_Flujo   = #TempValorMdaPataPago.Tipo_Flujo  
	and CConv.digitaSN     = 'N'  
	and  CConv.TCMoParidad = 'TCM'  
  

	-- En la pantalla "Ingreso de TC/paridad de Flujos se   
	-- instruye una fecha de rescate o también se instruye un   
	-- valor específico.    
	-- Caso en que hay un valor específico indicado en Cartera_Conversión  
	-- se utiliza en las fórmulas de conversión.  
	update #TempValorMdaPataPago   
	set       ValorUSDCLP        = isnull(  CConv.valor      , ValorUSDCLP )        
	from BacSwapSuda.dbo.Cartera_Conversion CConv       --   
	where CConv.Numero_Operacion = #TempValorMdaPataPago.numero_operacion   
	and CConv.numero_Flujo = #TempValorMdaPataPago.numero_Flujo  
	and CConv.Tipo_Flujo   = #TempValorMdaPataPago.Tipo_Flujo  
	and CConv.digitaSN     = 'S'  
	and  CConv.TCMoParidad = 'TCM'  
  
	/* Uso de ValorUSDCLP cuando la moneda de pago o pata  
	sea USD                                              */  
	update #TempValorMdaPataPago  
		set  ValorMdaPagoCLP = case when Moneda_Pago = 13 then ValorUSDCLP else ValorMdaPagoCLP end  
			,ValorMdaPataCLP = case when Moneda_Pata = 13 then ValorUSDCLP else ValorMdaPataCLP end  
    
	update #TempValorMdaPataPago  
		set FactorConvMdaPataAMdaPago = case when Moneda_Pata = Moneda_Pago then 1.0  
                                       else  ValorMdaPataCLP / ValorMdaPagoCLP end   
			,ParidadMdaPago           = round( case when MdaPagMultiplicaoDivide = 'M' then  
                                      ValorMdaPagoCLP / ValorUSDCLP     
									   else  
											 ValorUSDCLP / ValorMdaPagoCLP   
									   end,  case when MdaPagCurrency = 'C' then 6 else 20 end )   
			,ParidadMdaPata           = round( case when MdaCapMultiplicaoDivide = 'M' then  
                                      ValorMdaPataCLP / ValorUSDCLP     
									   else  
											 ValorUSDCLP / ValorMdaPataCLP   
									   end,  case when MdaCapCurrency = 'C' then 6 else 20 end )  
  
      -- CARGA DE PARIDAD  
   -- En la pantalla "Ingreso de TC/paridad de Flujos se   
   -- instruye un   
   -- valor específico. Este caso se buscar el valor   
   -- en parámetros usando la fecha indicada en Cartera_Conversion  
  
   -- PENDIENTE Aplciar la paridad digitada  
   -- No deberia tocar flujos en UF.  
	update #TempValorMdaPataPago   
	set       ParidadMdaPata        =  CConv.valor   
         ,   ValorMdaPataCLP       = case when  MdaCapMultiplicaoDivide = 'M'  
                               then  round( CConv.valor   *  ValorUSDCLP , 6 )  
							  else  round( ValorUSDCLP / CConv.valor , 6)   
															end      
	from BacSwapSuda.dbo.Cartera_Conversion CConv                                          
	where CConv.Numero_Operacion = #TempValorMdaPataPago.numero_operacion   
	and CConv.numero_Flujo = #TempValorMdaPataPago.numero_Flujo  
	and CConv.Tipo_Flujo   = #TempValorMdaPataPago.Tipo_Flujo  
	and CConv.digitaSN     = 'S'  
	and  CConv.TCMoParidad = 'PARIDAD2' -- Paridad de moneda Pata   
  

	update #TempValorMdaPataPago   
	set       ParidadMdaPago        =  CConv.valor    
         ,   ValorMdaPagoCLP       = case when  MdaCapMultiplicaoDivide = 'M'  
                               then  ROUND( ValorUSDCLP *  CConv.valor, 6 )   
							  else  round( ValorUSDCLP / CConv.valor, 6 )   
															end      
	from BacSwapSuda.dbo.Cartera_Conversion CConv                                           --   
	where CConv.Numero_Operacion = #TempValorMdaPataPago.numero_operacion   
	and CConv.numero_Flujo = #TempValorMdaPataPago.numero_Flujo  
	and CConv.Tipo_Flujo   = #TempValorMdaPataPago.Tipo_Flujo  
	and CConv.digitaSN     = 'S'  
	and  CConv.TCMoParidad = 'PARIDAD3' -- Paridad de moneda Pago 3ra moneda!!! RBL  
  
  
  
  /* Uso de ValorUSDCLP cuando la moneda de pago o pata  
     sea USD                                              */  
	update #TempValorMdaPataPago  
	set  ValorMdaPagoCLP = case when Moneda_Pago = 13 then ValorUSDCLP else ValorMdaPagoCLP end  
		,ValorMdaPataCLP = case when Moneda_Pata = 13 then ValorUSDCLP else ValorMdaPataCLP end  
  
  
	update #TempValorMdaPataPago  
	set FactorConvMdaPataAMdaPago = case	when Moneda_Pata = Moneda_Pago then 1.0  
											else ValorMdaPataCLP / ValorMdaPagoCLP end   
 
 
 ------------------------------FLUJO COMPRAS DEPURADO  
----------------------------------------------TIPO SWAP 1,2.4     
  
   SELECT MiOperacion       = cp.numero_operacion     
   ,      MiTipoSwap        = cp.Tipo_Swap    
   ,      MiTipoFlujo       = cp.Tipo_Flujo    
   ,      MiNumeroFlujo     = 1    
   ,      Moneda            = cp.Compra_Moneda    
   ,      Pago              = cp.Recibimos_Moneda    
   ,      AmortizacionMO    = SUM(Compra_Amortiza * IntercPrinc + Compra_Flujo_Adicional)    
   ,      AmortizacionMn    = SUM(ROUND((Compra_Amortiza * IntercPrinc + Compra_Flujo_Adicional)* ISNULL(mon.ValorMdaPataCLP, 0.0), 0))    
   ,      InteresMO         = SUM(Compra_Interes)    
   ,      InteresMn         = SUM(ROUND(Compra_Interes   * ISNULL(mon.ValorMdaPataCLP,0.0),0))   
     
   -- Monto en CLP, usar ValorMdaPagoCLP   
   ,      FlujoPesos        = SUM(round( CASE WHEN Estado = 'N' THEN Recibimos_Monto * ISNULL(mon.ValorMdaPagoCLP,0.0)    
                                       ELSE (compra_amortiza * intercprinc + compra_interes + compra_flujo_adicional) * isnull(mon.ValorMdaPataCLP,0.0)    
                                        END, 0 )  
          )   
   -- Monto en Moneda de Pago CLP o USD  
  
   ,      AmortizaMonPago   = SUM( (Compra_Amortiza * IntercPrinc + Compra_Flujo_Adicional)     
                                   * CASE WHEN PasaPorParidad = 'Si' THEN   
                      (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                                                +  isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                                              )  -- Monto Capital en USD  
             *  case when Recibimos_Moneda = 999   
                          then isnull(mon.ValorUSDCLP ,0.0) /* Clp */   
                  when recibimos_moneda = 13   
                       then 1.0                          /* Usd */   
                                                 else 1.0                                    /*  3ras monedas */  
            end  
                                          ELSE 1.0     
                                     END  
          )    
   ,      InteresMonPago    = SUM( (Compra_Interes   )    
                                           * CASE WHEN PasaPorParidad = 'Si' THEN   
                      (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                                                +  isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                                              )  -- Monto Capital en USD  
             *  case when Recibimos_Moneda = 999   
                          then isnull(mon.ValorUSDCLP ,0.0) /* Clp */   
                  when recibimos_moneda = 13   
                       then 1.0                          /* Usd */   
                                                 else 1.0                                    /*  3ras monedas */  
            end  
                                          ELSE 1.0     
                                     END)  
    
   ,      TipoCliente = CASE WHEN clpais = 6 THEN 1 ELSE 2 END    
   ,      TipCartera        = cp.cartera_inversion    
   ,      FormaPago         = cp.recibimos_documento    
   ,      MarcaControl      = '-'    
   ,      FlujoMOaCLP      = SUM( round( CASE WHEN Estado = 'N' THEN Recibimos_Monto  -- <-- Monto ya expresado en moneda de pago  
                                          ELSE ( compra_amortiza * intercprinc + compra_interes + compra_flujo_adicional  )   
                                                                  *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Recibimos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when recibimos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )   
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                END  
            END    
                                          * ValorMdaPagoCLP  
               , 0 ) )  
                                
  
   ,      FlujoMOaMdaPago  =  SUM( round( CASE WHEN Estado = 'N' THEN Recibimos_Monto  -- <-- Monto ya expresado en moneda de pago  
                                          ELSE ( compra_amortiza * intercprinc + compra_interes + compra_flujo_adicional  ) * 1.0000   
                                                 *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Recibimos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when recibimos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )  
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                END  
                                            END   
              , case when recibimos_moneda = 999 then 0 else 4 end   
           )  
          )   
   ,     FlujoMO          =  SUM( CASE WHEN Estado = 'N' THEN Recibimos_Monto  -- <-- Monto ya expresado en moneda de pago  
                                          ELSE  compra_amortiza * intercprinc + compra_interes + compra_flujo_adicional       
            END  
            )       
   ,   Rut_Cliente  
   ,     Codigo_Cliente                                   
   ,     Estado  
   ,     Modalidad_pago = case when cp.estado = 'N' then 'C' else cp.Modalidad_pago end  
   ,     Fecha_Inicio_Flujo = max(cp.fecha_inicio_Flujo)  
   ,     fecha_vence_flujo  = max(cp.fecha_vence_flujo )  
   ,     mon.ValorMdaPagoCLP    
   ,     mon.ValorMdaPataCLP  
   ,     mon.ValorUSDCLP  
   ,     mon.ParidadMdaPata  
   ,     Mon.ParidadMdaPago   
   ,     cp.Operador  
	INTO   #FlujoCompras    
	FROM   #CARTERACOMP  cp  
	LEFT  JOIN BacParamSuda..CLIENTE ON clrut = cp.rut_cliente and clcodigo = cp.codigo_cliente    
	INNER JOIN #TempValorMdaPataPago mon ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo  and mon.numero_flujo =cp.numero_flujo   
	WHERE  cp.FechaLiquidacion  = @Fecha_Vencimiento    
	AND    cp.tipo_flujo        = 1    
	AND    cp.tipo_swap         IN(1,4, 2)    
	AND    Estado           <> 'C'     
	GROUP  BY cp.Numero_Operacion    
	, cp.Tipo_Swap    
	, cp.Tipo_Flujo    
	, Compra_Moneda    
	, Recibimos_Moneda    
	, clpais    
	, cartera_inversion    
	, recibimos_documento    
	, rut_Cliente  
	, Codigo_Cliente  
	, Estado  
	, cp.Modalidad_pago  
	, mon.ValorMdaPagoCLP  
	, mon.ValorMdaPataCLP  
	, mon.ValorUSDCLP  
	, mon.ParidadMdaPata  
	, Mon.ParidadMdaPago   
	, Cp.Operador  


----------------------------------------------TIPO SWAP 3    
   INSERT INTO #FlujoCompras    
   SELECT MiOperacion       = cp.Numero_Operacion  
   ,      MiTipoSwap        = cp.Tipo_Swap    
   ,      MiTipoFlujo       = cp.Tipo_Flujo    
   ,      MiNumeroFlujo     = 1    
   ,      Moneda            = Compra_Moneda    
   ,      Pago              = Recibimos_Moneda    
    
   ,      AmortizacionMO    = SUM( Compra_Amortiza)    
   ,      AmortizacionMn    = SUM(ROUND( Compra_Amortiza * ISNULL( mon.ValorMdaPataCLP,0.0),0))    
   ,      InteresMO         = SUM( Compra_Interes)    
   ,      InteresMn         = SUM(ROUND( Compra_Interes  * ISNULL( mon.ValorMdaPataCLP,0.0),0))    
   ,      FlujoPesos        = SUM(CASE WHEN Estado <> 'N' THEN Compra_Interes / (1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo) /360.0 * compra_mercado_tasa / 100.0) * mon.ValorMdaPataCLP    
                                       ELSE                    recibimos_monto * mon.ValorMdaPagoCLP     
                                  END)    
   ,      AmortizaMonPago   = SUM( (Compra_Amortiza   
                                      * CASE WHEN PasaPorParidad = 'Si' THEN   
                      (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                                                +  isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                                              )  -- Monto Capital en USD  
             *  case when Recibimos_Moneda = 999   
                          then isnull(mon.ValorUSDCLP ,0.0) /* Clp */   
                  when recibimos_moneda = 13   
                       then 1.0                          /* Usd */   
                                                 else 1.0                                    /*  3ras monedas */  
            end  
                                          ELSE 1.0     
                                     END  
                                    )  
         )     
   ,      InteresMonPago    = SUM( ( Compra_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * compra_mercado_tasa / 100.0 )   
                                     ) * CASE WHEN PasaPorParidad = 'Si' THEN   
                      (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                                                +  isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                          )  -- Monto Capital en USD  
             *  case when Recibimos_Moneda = 999   
                          then isnull(mon.ValorUSDCLP ,0.0) /* Clp */   
                  when recibimos_moneda = 13   
                       then 1.0                          /* Usd */   
                                                 else 1.0                                    /*  3ras monedas */  
            end  
                                          ELSE 1.0     
                                     END  
           )    
   ,      TipoCliente       = CASE WHEN clpais = 6 THEN 1 ELSE 2 END    
   ,      TipCartera        = cartera_inversion    
   ,      FormaPago         = recibimos_documento    
   ,      MarcaControl      = '-'    
   ,      FlujoMOaCLP      =   SUM( round(    
                                           ( Compra_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * compra_mercado_tasa / 100.0 )   
                                            )  
                                             *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Pagamos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when Pagamos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )   
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                                                 END * ValorMdaPagoCLP                                            
            , case when recibimos_moneda = 999 then 0 else 4 end ) * mon.ValorUSDCLP  
            )   
   ,      FlujoMOaMdaPago  = SUM( round(    
                                           ( Compra_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * compra_mercado_tasa / 100.0 )   
                                            )  
                                             *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Pagamos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when Pagamos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )   
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                                                 END                                            
            , case when recibimos_moneda = 999 then 0 else 4 end )  
            )   
   ,      FlujoMO          = SUM(    Compra_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * compra_mercado_tasa / 100.0 )   
         )   
   ,     Rut_Cliente  
   ,     Codigo_Cliente                                   
   ,     Estado  
   ,     Modalidad_pago = case when cp.estado = 'N' then 'C' else cp.Modalidad_pago end  
   ,     Fecha_Inicio_Flujo = max(cp.fecha_inicio_Flujo)  
   ,     fecha_vence_flujo  = max(cp.fecha_vence_flujo )  
   ,     Mon.ValorMdaPagoCLP  
   ,     Mon.ValorMdaPataCLP  
   ,     mon.ValorUSDCLP     
   ,     mon.ParidadMdaPata  
   ,     Mon.ParidadMdaPago   
   ,     cp.Operador  
FROM   #CarteraComp  cp  
        LEFT  JOIN BacParamSuda..CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente    
        INNER JOIN #TempValorMdaPataPago mon ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo  and mon.numero_flujo =cp.numero_flujo  -- EL ultimo and estaba comentado!!  
    --   INNER JOIN #TempValorMdaPataPago pag ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo and mon.numero_flujo =cp.numero_flujo   -- EL ultimo and estaba comentado!!  
WHERE  cp.FechaLiquidacion  = @Fecha_Vencimiento    
AND    cp.tipo_flujo        = 1    
AND    cp.tipo_swap         = 3    
AND    Estado            <> 'C'      
GROUP  BY cp.Numero_Operacion    
, cp.Tipo_Swap    
, cp.Tipo_Flujo    
    , Compra_Moneda    
, Recibimos_Moneda    
        , clpais    
        , cartera_inversion    
        , recibimos_documento    
    , rut_Cliente  
    , Codigo_Cliente  
    , Estado  
    , cp.Modalidad_pago  
    , mon.ValorMdaPagoCLP  
        , mon.ValorMdaPataCLP  
    , mon.ValorUSDCLP  
    , mon.ParidadMdaPata  
    , Mon.ParidadMdaPago   
    , cp.Operador  
  
 ---------------------------------FLUJO VENTAS  
  
----------------------------------------------TIPO SWAP 1,2.4     
  
   SELECT MiOperacion       = cp.Numero_Operacion    
   ,      MiTipoSwap        = cp.Tipo_Swap    
   ,      MiTipoFlujo       = cp.Tipo_Flujo    
   ,      MiNumeroFlujo     = 1    
   ,      Moneda            = Venta_Moneda    
   ,      Pago              = Pagamos_Moneda    
   ,      AmortizacionMO    = SUM( venta_amortiza * intercprinc +  venta_flujo_adicional)    
   ,      AmortizacionMn    = SUM(ROUND( (venta_amortiza * intercprinc + venta_flujo_adicional) * ISNULL( mon.ValorMdaPataCLP,0.0),0))    
   ,      InteresMO         = SUM( venta_interes)    
   ,      InteresMn         = SUM(ROUND( venta_interes * ISNULL( mon.ValorMdaPataCLP, 0.0), 0))    
   ,      FlujoPesos        = SUM(round( CASE WHEN Estado = 'N' THEN Pagamos_Monto * ISNULL(mon.ValorMdaPagoCLP,0.0) --> 0.0     
                                       ELSE (venta_amortiza * intercprinc + venta_interes + venta_flujo_adicional) * ISNULL( mon.ValorMdaPataCLP,0.0)    
                                   END, 0 )  
           )    
   ,      AmortizaMonPago   = SUM( (venta_amortiza * intercprinc + venta_flujo_adicional)  
                                    * CASE WHEN PasaPorParidad = 'Si' THEN   
                      (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                                                +  isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                                              )  -- Monto Capital en USD  
             *  case when Pagamos_Moneda = 999   
                          then isnull(mon.ValorUSDCLP ,0.0) /* Clp */   
                  when pagamos_moneda = 13   
                       then 1.0                          /* Usd */   
          else 1.0                                    /*  3ras monedas */  
            end  
                                          ELSE 1.0     
                                     END  
          )    
   ,      InteresMonPago    = SUM( (Venta_Interes)   
                                         * CASE WHEN PasaPorParidad = 'Si' THEN   
                      (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                                                +  isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                                              )  -- Monto Capital en USD  
             *  case when Pagamos_Moneda = 999   
                          then isnull(mon.ValorUSDCLP ,0.0) /* Clp */   
                  when pagamos_moneda = 13   
                       then 1.0                          /* Usd */   
                                                 else 1.0                                    /*  3ras monedas */  
            end  
                                          ELSE 1.0     
                                     END  
         )    
   ,      TipoCliente       = CASE WHEN clpais = 6 THEN 1 ELSE 2 END    
   ,      TipCartera        = cartera_inversion          
   ,      FormaPago         = Pagamos_documento    
   ,      MarcaControl      = '-'    
   ,      FlujoMOaCLP      = SUM( round( CASE WHEN Estado = 'N' THEN Pagamos_Monto  -- <-- Monto ya expresado en moneda de pago  
                                          ELSE ( Venta_amortiza * intercprinc + Venta_interes + Venta_flujo_adicional  )   
                 *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Pagamos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when Pagamos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )   
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                END  
            END    
                                          * ValorMdaPagoCLP  
               , 0 ) )  
                                
  
   ,      FlujoMOaMdaPago  =  SUM( round( CASE WHEN Estado = 'N' THEN Pagamos_Monto  -- <-- Monto ya expresado en moneda de pago  
                            ELSE ( Venta_amortiza * intercprinc + Venta_interes + Venta_flujo_adicional  ) * 1.0000   
                                                 *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Pagamos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when Pagamos_Moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )  
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                END  
                                            END   
              , case when Pagamos_Moneda = 999 then 0 else 4 end   
           )  
          )   
   ,      FlujoMO          = SUM( CASE WHEN Estado = 'N' THEN pagamos_monto  -- <-- Monto ya expresado en moneda de pago  
                                          ELSE  Venta_amortiza * intercprinc + Venta_interes + Venta_flujo_adicional       
            END  
            )   
   ,     Rut_Cliente  
   ,     Codigo_Cliente                                   
   ,     Estado  
   ,     Modalidad_pago = case when cp.estado = 'N' then 'C' else cp.Modalidad_pago end  
   ,     Fecha_Inicio_Flujo = max(cp.fecha_inicio_Flujo)  
   ,     fecha_vence_flujo  = max(cp.fecha_vence_flujo )  
   ,     Mon.ValorMdaPagoCLP  
   ,     Mon.ValorMdaPataCLP  
   ,     mon.ValorUSDCLP  
   ,     mon.ParidadMdaPata  
   ,     Mon.ParidadMdaPago   
   ,     cp.Operador  
   INTO   #FlujoVentas    
   FROM   #CarteraComp  cp  
          LEFT  JOIN BacParamSuda..CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente    
          INNER JOIN #TempValorMdaPataPago mon ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo  and mon.numero_flujo =cp.numero_flujo       
--          INNER JOIN #TempValorMdaPataPago pag ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo and mon.numero_flujo =cp.numero_flujo   
   WHERE  cp.fechaLiquidacion  = @Fecha_Vencimiento    
   AND    cp.tipo_flujo        = 2    
   AND    cp.tipo_swap         IN(1,4,2)    
   AND   Estado   <> 'C'     
-- AND   modalidad_pago    = 'C'    
  
  
   GROUP  BY cp.Numero_Operacion    
    , cp.Tipo_Swap    
    , cp.Tipo_Flujo    
       , Venta_Moneda    
    , Pagamos_Moneda    
           , clpais    
           , cartera_inversion    
           , Pagamos_documento    
     , rut_Cliente  
     , Codigo_Cliente  
     , Estado  
     , cp.Modalidad_pago  
     , mon.ValorMdaPagoCLP  
           , mon.ValorMdaPataCLP  
           , mon.ValorUSDCLP  
     ,     mon.ParidadMdaPata  
     ,     Mon.ParidadMdaPago   
     ,  cp.Operador  
 
             
  
----------------------------------------------TIPO SWAP 3   
INSERT INTO #FlujoVentas    
   SELECT MiOperacion       = cp.Numero_Operacion    
   ,      MiTipoSwap        = cp.Tipo_Swap    
   ,      MiTipoFlujo       = cp.Tipo_Flujo    
   ,      MiNumeroFlujo     = 1   
   ,      Moneda            = Venta_Moneda    
   ,      Pago              = Pagamos_Moneda    
   ,      AmortizacionMO    = SUM( venta_amortiza)    
   ,      AmortizacionMn    = SUM(ROUND( venta_amortiza  * ISNULL( mon.ValorMdaPataCLP, 0.0), 0))    
   ,      InteresMO         = SUM( venta_interes)    
   ,      InteresMn         = SUM(ROUND( venta_interes   * ISNULL( mon.ValorMdaPataCLP, 0.0), 0))    
   ,      FlujoPesos        = SUM( CASE WHEN Estado <> 'N' THEN Venta_interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo, cp.Fecha_vence_flujo) / 360.0 * venta_mercado_tasa / 100.0) * mon.ValorMdaPataCLP     
                                        ELSE 0.0     
                                   END)    
   ,      AmortizaMonPago   = SUM( (venta_amortiza * ISNULL( mon.ValorMdaPataCLP, 0.0)) / ISNULL( mon.ValorMdaPagoCLP, 0.0))    
   ,      InteresMonPago    = SUM( (venta_interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/360.0 * Venta_mercado_tasa /100.0 ) * ISNULL( mon.ValorMdaPataCLP,0.0)) / ISNULL( mon.ValorMdaPagoCLP, 0.0))    
   ,      TipoCliente       = CASE WHEN clpais = 6 THEN 1 ELSE 2 END    
   ,      TipCartera        = cartera_inversion          
   ,      FormaPago         = Pagamos_documento    
   ,      MarcaControl      = '-'    
   ,      FlujoMOaCLP      =  SUM( round(    
                                           ( Venta_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * Venta_mercado_tasa / 100.0 )   
                                            )  
                                             *   
                  CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Pagamos_Moneda = 999          /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when Pagamos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )   
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                                                 END * ValorMdaPagoCLP  
            , case when Pagamos_moneda = 999 then 0 else 4 end )    
            )   
  ,      FlujoMOaMdaPago  = SUM( round(    
                                           ( Venta_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * Venta_mercado_tasa / 100.0 )   
                                            )  
                                             *   
                 CASE WHEN MdaPago_distinta_MdaCap = 'Si' THEN    
             CASE WHEN PasaPorParidad = 'Si'   THEN                  
             (     1.0 / isnull(mon.ParidadMdaPata,1.0) * ( case when mon.MdaCapMultiplicaoDivide = 'D' then 1.0 else 0 end )  
             +     isnull(mon.ParidadMdaPata,0.0) * ( case when mon.MdaCapMultiplicaoDivide = 'M' then 1.0 else 0 end )  
              )  -- Monto Capital Expresado USD  
             *  case when Pagamos_Moneda = 999     /* Clp */   
                  then isnull(mon.ValorUSDCLP ,0.0)   
                when Pagamos_moneda = 13             /* Usd */   
                  then 1.0                          
                else                                   /*  3ras monedas desde USD a MX */  
                    (  isnull(mon.ParidadMdaPago ,0.0) * ( case when mon.MdaPagMultiplicaoDivide = 'D' then 1.0 else 0 end )  
                        + 1.0 / isnull(mon.ParidadMdaPago,1.0) * ( case when mon.MdaPagMultiplicaoDivide = 'M' then 1.0 else 0 end )  
                        )   
                end  
              ELSE -- Se trata de UF-CLP o CLP-CLP   
                  ValorMdaPataCLP   
              END   
                   ELSE -- MdaPago_distinta_MdaCap = 'No'  
                     1.0   
                                                 END  
                                            
            , case when Pagamos_moneda = 999 then 0 else 4 end )  
            )   
   ,      FlujoMO          = SUM(    Venta_Interes / ( 1 + DATEDIFF(DAY, Fecha_inicio_Flujo ,cp.Fecha_vence_flujo )/ 360.0 * Venta_mercado_tasa / 100.0 )   
         )   
   ,     Rut_Cliente  
   ,     Codigo_Cliente     
   ,     Estado  
   ,     Modalidad_pago = case when cp.estado = 'N' then 'C' else cp.Modalidad_pago end  
   ,     Fecha_Inicio_Flujo = max(cp.fecha_inicio_Flujo)  
   ,     fecha_vence_flujo  = max(cp.fecha_vence_flujo )  
   ,     Mon.ValorMdaPagoCLP  
   ,     Mon.ValorMdaPataCLP  
   ,     mon.ValorUSDCLP  
   ,     mon.ParidadMdaPata  
   ,     Mon.ParidadMdaPago   
   ,     cp.Operador  
   FROM   #CarteraComp  cp  
          LEFT  JOIN BacParamSuda..CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente    
          INNER JOIN #TempValorMdaPataPago mon ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo  and mon.numero_flujo =cp.numero_flujo   
      -- Erro   INNER JOIN #TempValorMdaPataPago pag ON mon.numero_operacion =cp.numero_operacion  and mon.tipo_Flujo = cp.tipo_flujo  and mon.numero_flujo =cp.numero_flujo   
   WHERE  cp.FechaLiquidacion  = @Fecha_Vencimiento    
   AND    cp.tipo_flujo        = 2    
   AND    cp.tipo_swap         = 3    
   AND   Estado     <> 'C'     
   GROUP  BY cp.Numero_Operacion    
    , cp.Tipo_Swap    
    , cp.Tipo_Flujo    
       , Venta_Moneda    
    , Pagamos_Moneda    
           , clpais    
           , cartera_inversion    
           , Pagamos_documento    
     , rut_Cliente  
     , Codigo_Cliente  
     , Estado  
     , cp.Modalidad_pago  
        , mon.ValorMdaPagoCLP  
           , mon.ValorMdaPataCLP  
           , mon.ValorUSDCLP  
     ,     mon.ParidadMdaPata  
     ,     Mon.ParidadMdaPago  
     ,  cp.operador   
 
    
  ---------------------------MODIFICACIONES---------------------------------------------------------------  
  
   UPDATE #FlujoCompras    
   SET    MarcaControl = 'x'    
   FROM   #FlujoVentas    
   WHERE  #FlujoCompras.MiOperacion = #FlujoVentas.MiOperacion  and  #FlujoCompras.modalidad_pago = 'C'  
    
   UPDATE #FlujoVentas    
   SET    MarcaControl = 'x'    
   FROM   #FlujoCompras    
   WHERE  #FlujoCompras.MiOperacion = #FlujoVentas.MiOperacion   and  #FlujoVentas.modalidad_pago = 'C'  
  
  --------------------------------FIN MODIFICACIONES  
     


   select * 
   into #temp_TBL_CAJA_DERIVADOS_DETALLE
   from BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE
   where 1=2

   Insert  #temp_TBL_CAJA_DERIVADOS_DETALLE---BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE  
   Select Modulo = 'PCS'  
        , Tipo_swap = MiTipoSwap  
  , Numero_operacion = MiOperacion  
  , fechaLiquidacion = @Fecha_Vencimiento  
  , Correlativo = MiNumeroFlujo  
  , Tipo_Flujo   = 1  -- Flujo Compras   
  , MonedaM1     = Pago  
  , MonedaM2     = 0  
  , MontoM1      = FlujoMOaMdaPago  
  , MontoM2      = 0  
  , MontoM1Local = FlujoMOaCLP    
  , MontoM2Local = 0   
     , ValorMdaPagoCLP  
        , ValorMdaPataCLP  
        , ValorUSDCLP  
  , ParidadMdaPata  
  , ParidadMdaPago     
  , VctoNatural_Anticipo = case when estado = 'N' then 'ANTICIPO' else 'VCTO_NAT' end   
   from #FlujoCompras   
    
  
   

   Insert #temp_TBL_CAJA_DERIVADOS_DETALLE--BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE  
   Select Modulo = 'PCS'  
        , Tipo_swap = MiTipoSwap  
  , Numero_operacion = MiOperacion  
  , fechaLiquidacion = @Fecha_Vencimiento  
  , Correlativo = MiNumeroFlujo  
  , Tipo_Flujo   = 2  -- Flujo Ventas   
  , MonedaM1     = Pago  
  , MonedaM2     = 0  
  , MontoM1      = FlujoMOaMdaPago  
  , MontoM2      = 0  
  , MontoM1Local = FlujoMOaCLP    
  , MontoM2Local = 0   
     , ValorMdaPagoCLP  
        , ValorMdaPataCLP  
        , ValorUSDCLP  
  , ParidadMdaPata  
  , ParidadMdaPago   
  , VctoNatural_Anticipo = case when estado = 'N' then 'ANTICIPO' else 'VCTO_NAT' end    
   from #FlujoVentas   
    
  
    
   SELECT Operacion     = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.MiOperacion     ELSE v.MiOperacion   END    
   ,      TipoSwap      = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.MiTipoSwap      ELSE v.MiTipoSwap    END    
   ,      TipoFlujo     = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.MiTipoFlujo     ELSE v.MiTipoFlujo   END    
   ,      NumeroFlujo   = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.MiNumeroFlujo   ELSE v.MiNumeroFlujo END    
   , MonOperacion  = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.Moneda          ELSE v.Moneda        END    
   ,      MonPago       = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.Pago            ELSE v.Pago          END    
   ,      Liquidacion   = @DiaLiquidacion    
   ,      AmortizaMo    = c.AmortizacionMO - v.AmortizacionMO  -- Amortizacion Moneda Origen  
   ,      AmortizaMn    = c.AmortizacionMn - v.AmortizacionMn  -- Amortizacion Moneda Nacional  
   ,      AmortizaMx    = c.AmortizaMonPago - v.AmortizaMonPago -- Amortización Moneda de Pago    
   ,      InteresMO     = c.InteresMO      - v.InteresMO        -- Interes Moneda Origen   
   ,      InteresMn     = c.InteresMn      - v.InteresMn        -- Interes Moneda Nacional  
   ,   InteresMx     = c.InteresMonPago - v.InteresMonPago   -- Interes Moneda Pago    
   ,      FlujoMonPago  = c.FlujoMOaMdaPago - v.flujoMOaMdaPago -- Flujo en moneda de pago    
   ,      AMonPagoCom   = c.AmortizaMonPago    
   ,      IMonPagoCom   = c.InteresMonPago    
  
   ,      AMonPagoVta   = v.AmortizaMonPago    
   ,      IMonPagoVta   = v.InteresMonPago    
   ,      TipoCliente   = c.TipoCliente    
   ,      TipCartera    = c.TipCartera    
   ,      MedioPago     = CASE WHEN c.FlujoPesos >= v.FlujoPesos THEN c.FormaPago ELSE v.FormaPago END    
   ,   FlujoMOaCLP   = c.FlujoMOaCLP - v.FlujoMOaCLP  
   ,      FlujoMO       = c.FlujoMO     - v.FlujoMO  
    ,     c.Rut_Cliente  
   ,      c.Codigo_Cliente    
   ,      c.Estado  
   ,      c.Modalidad_pago  
   ,      c.fecha_inicio_Flujo  
   ,      c.fecha_vence_flujo   
   ,      c.operador  
   INTO   #COMPENSACION    
   FROM   #FlujoCompras c    
          INNER JOIN #FlujoVentas v ON c.MiOperacion = v.MiOperacion   
                             AND c.Estado      = v.Estado  
                            AND c.MarcaControl = v.MarcaControl              
   WHERE  c.MarcaControl    = 'x'  and c.modalidad_pago = 'C'  
   


   INSERT INTO #COMPENSACION    
   SELECT Operacion    = c.MiOperacion    
   ,      TipoSwap     = c.MiTipoSwap    
   ,      TipoFlujo    = c.MiTipoFlujo    
   ,      NumeroFlujo  = c.MiNumeroFlujo    
   ,      MonOperacion = c.Moneda    
   ,      MonPago      = c.Pago    
   ,      Liquidacion   = @DiaLiquidacion    
   ,      AmortizaMO   = c.AmortizacionMO    
   ,      AmortizaMn   = c.AmortizacionMn    
   ,      AmortizaMx   = c.AmortizaMonPago  
   ,      InteresMO    = c.InteresMO    
   ,      InteresMn    = c.InteresMn    
   ,      InteresMx    = c.InteresMonPago     
   ,      FlujoMonPago = c.FlujoMOaMdaPago  
   ,      AMonPagoCom   = c.AmortizaMonPago    
   ,      IMonPagoCom   = c.InteresMonPago    
   ,      AMonPagoVta   = 0.0    
   ,      IMonPagoVta   = 0.0    
   ,      TipoCliente   = c.TipoCliente    
   ,      TipCartera    = c.TipCartera    
   ,      MedioPago     = c.FormaPago  
   ,   FlujoMOaCLP   = c.FlujoMOaCLP     
   ,      FlujoMO       = c.FlujoMO  
   ,      c.Rut_Cliente  
   ,      c.Codigo_Cliente    
   ,      c.Estado  
   ,      c.modalidad_pago  
   ,      c.fecha_inicio_Flujo  
   ,      c.fecha_vence_flujo   
   ,      c.operador  
   FROM   #FlujoCompras c              
   WHERE  c.MarcaControl   = '-'    
  
   INSERT INTO #COMPENSACION    
   SELECT Operacion     = v.MiOperacion    
   ,      TipoSwap      = v.MiTipoSwap    
   ,      TipoFlujo     = v.MiTipoFlujo    
   ,      NumeroFlujo   = v.MiNumeroFlujo    
   ,      MonOperacion  = v.Moneda    
   ,      MonPago       = v.Pago    
   ,      Liquidacion   = @DiaLiquidacion    
   ,      AmortizaMO    =  -  v.AmortizacionMO   
   ,      AmortizaMn    =  -  v.AmortizacionMn   
   ,      AmortizaMx    =  -  v.AmortizaMonPago  
   ,      InteresMO     = -  v.InteresMO         
   ,      InteresMn     = -  v.InteresMn         
   ,      InteresMx     = -  v.InteresMonPago  
   ,      FlujoMonPago  = -  v.flujoMOaMdaPago   
   ,      AMonPagoCom   = 0.0    
   ,      IMonPagoCom   = 0.0    
   ,      AMonPagoVta   = v.AmortizaMonPago    
   ,      IMonPagoVta   = v.InteresMonPago    
   ,      TipoCliente   = v.TipoCliente    
   ,      TipCartera    = v.TipCartera    
   ,      MedioPago     = v.FormaPago  
   ,   FlujoMOaCLP   = -v.FlujoMOaCLP     
   ,      FlujoMO       = -v.FlujoMO  
    ,     v.Rut_Cliente  
   ,      v.Codigo_Cliente    
   ,      v.Estado  
   ,      v.modalidad_pago  
   ,      v.fecha_inicio_Flujo  
   ,      v.fecha_vence_flujo   
   ,      v.Operador  
   FROM   #FlujoVentas v              
   WHERE  v.MarcaControl   = '-'     
  
    if @Debug  =  'S' 
		select '#COMPENSACION' as tabla,* from #COMPENSACION--aqui

  --aqui	
  --delete BacParamSuda.dbo.TBL_CAJA_DERIVADOS   
 --where fechaLiquidacion = @DiaLiquidacion and ( numero_operacion = @NumOper or @NumOper = 0 )  
  
  
  --  Grabar en tabla BacParamSuda.dbo.TBL_CAJA_DERIVADOS  
  --  Compensados  
  
     
	select * 
	into #tmp_TBL_CAJA_DERIVADOS
	from BacParamSuda.dbo.TBL_CAJA_DERIVADOS
	where 1=2

   INSERT INTO #tmp_TBL_CAJA_DERIVADOS--BacParamSuda.dbo.TBL_CAJA_DERIVADOS   
   SELECT Modulo = 'PCS'    
   ,      Producto = cp.TipoSwap  
   ,      NUmero_oepracion = cp.Operacion   
   ,      fechaLiquidacion = cp.Liquidacion  
   ,      Correlativo                       = cp.NumeroFlujo   
   ,      Rut_Contraparte                   = cp.rut_cliente   
   ,      Codigo_Contraparte                = cp.codigo_cliente      
   ,   Compra_moneda = ( select max(ccp.Moneda) from #FlujoCompras ccp where ccp.MiOperacion = cp.Operacion )  
   ,   Venta_Moneda  = ( select max(vvp.Moneda) from #FlujoVentas vvp where vvp.MiOperacion = cp.Operacion )  
   ,      MonedaM1     = cp.MonPago      
   ,      MontoM1      = cp.FlujoMonPago     
   ,      FormaPago1   = cp.MedioPago  
   -- Compensación no informa Monto2  
   ,      MonedaM2   = 0  
   ,      MontoM2    = 0.0  
   ,      FormaPago2 = 0    
 ,     MontoM1Local = cp.FlujoMOaCLP  
 ,     MontoM2Local = 0.0   
    ,     modalidad_pago = cp.modalidad_pago   
    ,     Tipo_Flujo     = cp.tipoFlujo  
 ,     VctoNatural_Anticipo = case when cp.estado = 'N' then 'ANTICIPO' else 'VCTO_NAT' end  
    ,     cp.fecha_inicio_Flujo  
    ,     cp.fecha_vence_flujo   
 ,     cp.Operador  
    FROM   #COMPENSACION cp where cp.modalidad_pago = 'C'  
  
 --select 'debug', * from #COMPENSACION where modalidad_pago = 'E'  
  
  
   -- Insertar las EF que esperemos siempre estén pareadas  
  
  --  Grabar en tabla BacParamSuda.dbo.TBL_CAJA_DERIVADOS  
  --  Entrega Fisica  
   -- Definición de Prioridad de monedas  
 SELECT mncodmon      
   ,      mnPrioridad = isnull((select MnPRioridad       
                                from BacParamSuda..MonedaPrioridad Pri      
                                where Pri.MnCodMon = Mda.MnCodMon)      
                  , case when mnCodMon = 999 then 0      
                                       when mnCodMon = 998 then 1      
                                       when mnCodMon = 13  then 2      
                                       else 3 end)      
   into #MdaPri      
   from BacParamSuda..MONEDA Mda where mnmx = 'C'       
   Union      
   Select mnCodMon      
   ,      MnPrioridad = isnull( (select MnPrioridad       
                          from BacParamSuda..MonedaPrioridad Pri      
                          where Pri.MnCodMon = Mda.MnCodMon)      
                          , case when Mda.MnCodMon = 999 then 0       
                                 when Mda.MnCodMon = 998 then 1      
                                 when Mda.MnCodMon = 13  then 2      
                                 else 3 end)      
   from  BacParamSuda..Moneda Mda      
   where MnCodMon in ( 999, 998 )     -- select * from #MdaPri  
  
  
	select *   
		into #TempCaja  
		from BacParamSuda.dbo.TBL_CAJA_DERIVADOS  where 1 = 2  
  
  INSERT INTO #tmp_TBL_CAJA_DERIVADOS--#TempCaja      
   SELECT Modulo = 'PCS'    
   ,      Producto = c.TipoSwap  
   ,      Numero_operacion = c.Operacion   
   ,      fechaLiquidacion = c.Liquidacion  
   ,      Correlativo                       = c.NumeroFlujo   
   ,      Rut_Contraparte                   = c.rut_cliente   
   ,      Codigo_Contraparte                = c.codigo_cliente      
   ,   Compra_moneda = C.MonOperacion  
   ,   Venta_Moneda  = 0   
   ,      MonedaM1     = c.MonPago      
   ,      MontoM1      = c.FlujoMonPago     
   ,      FormaPago1   = c.MedioPago     
   ,      MonedaM2     = c.MonPago      
   ,      MontoM2      = c.FlujoMonPago  
   ,      FormaPago2   = c.MedioPago    
 ,     MontoM1Local = c.FlujoMOaCLP  
 ,     MontoM2Local = c.FlujoMOaCLP  
    ,     modalidad_pago = c.modalidad_pago   
    ,     Tipo_Flujo     = c.tipoFlujo  
    ,     VctoNatural_Anticipo = 'VCTO_NAT'   
    ,      c.fecha_inicio_Flujo  
    ,      c.fecha_vence_flujo   
 ,      c.Operador  
    FROM   #COMPENSACION c          
 where c.modalidad_pago = 'E' and c.TipoFlujo = 1  
  
 -- En moneda M1 queda el flujo con  
 -- la moneda de mayor prioridad  
    update #TempCaja  
  set       
       Venta_Moneda  = v.MonOperacion  
    ,     MonedaM1     = case when PrioridadRecibe.MnPrioridad > PrioridadPaga.mnPrioridad then MonedaM1   else  v.MonPago end     
    ,     MontoM1      = case when PrioridadRecibe.MnPrioridad > PrioridadPaga.mnPrioridad then MontoM1   else v.FlujoMonPago end    
    ,     FormaPago1   = case when PrioridadRecibe.MnPrioridad > PrioridadPaga.mnPrioridad then FormaPago1 else v.MedioPago end    
 ,     MontoM1Local = case when PrioridadRecibe.MnPrioridad > PrioridadPaga.mnPrioridad then MontoM1Local else v.FlujoMOaCLP end  
  
 ,     MonedaM2   = case when PrioridadRecibe.MnPrioridad < PrioridadPaga.mnPrioridad   then MonedaM2 else v.MonPago end            
    ,     MontoM2    = case when PrioridadRecibe.MnPrioridad < PrioridadPaga.mnPrioridad   then MontoM2 else v.FlujoMonPago end  
    ,     FormaPago2 = case when PrioridadRecibe.MnPrioridad < PrioridadPaga.mnPrioridad   then FormaPago2 else v.MedioPago end   
 ,     MontoM2Local = case when PrioridadRecibe.MnPrioridad < PrioridadPaga.mnPrioridad  then MontoM2Local else v.FlujoMOaCLP end  
  
     FROM   #COMPENSACION v             
    left join #MdaPri  PrioridadPaga   on PrioridadPaga.MnCodMon   =  v.MonPago         
    , #MdaPri  PrioridadRecibe   
        where v.modalidad_pago = 'E' and v.TipoFlujo = 2 and v.Operacion = #TempCaja.numero_operacion  
     and PrioridadRecibe.MnCodMon =  #TempCaja.MonedaM1  
       
  INSERT INTO #tmp_TBL_CAJA_DERIVADOS--#TempCaja      
   SELECT Modulo = 'PCS'    
   ,      Producto = v.TipoSwap  
   ,      Numero_operacion = v.Operacion   
   ,      fechaLiquidacion = v.Liquidacion  
   ,      Correlativo                       = v.NumeroFlujo   
   ,      Rut_Contraparte                   = v.rut_cliente   
   ,      Codigo_Contraparte                = v.codigo_cliente      
   ,   Compra_moneda = 0  
   ,   Venta_Moneda  = v.MonOperacion  
   ,      MonedaM1     = v.MonPago      
   ,      MontoM1      = -v.FlujoMonPago     
   ,      FormaPago1   = v.MedioPago     
   ,      MonedaM2     = 0  
   ,      MontoM2      = 0.0  
   ,      FormaPago2   = 0  
 ,     MontoM1Local = -v.FlujoMOaCLP  
 ,     MontoM2Local = 0  
    ,     modalidad_pago = v.modalidad_pago   
    ,     Tipo_Flujo     = v.tipoFlujo  
    ,     VctoNatural_Anticipo = 'VCTO_NAT'   
    ,     v.fecha_inicio_Flujo  
    ,     v.fecha_vence_flujo   
 ,     v.Operador  
    FROM   #COMPENSACION v          
 where v.modalidad_pago = 'E' and v.TipoFlujo = 2  
   and  v.Operacion not in ( select numero_operacion from #TempCaja )  
  
   --aqui insert into BacParamSuda.dbo.TBL_CAJA_DERIVADOS 
	if @Debug  =  'S' 
	begin 
		select '#TempCaja' as tabla,* from #TempCaja  
		select '#tmp_TBL_CAJA_DERIVADOS' as tabla,* from #tmp_TBL_CAJA_DERIVADOS
	end 

	--vencimiento en el dia y no proyectado
	insert into #tmp_TBL_CAJA_DERIVADOS
	select * from BacParamSuda..TBL_CAJA_DERIVADOS 
	where fechaLiquidacion = @Fecha_Vencimiento
	and modulo = 'PCS'

	select * from #tmp_TBL_CAJA_DERIVADOS
   
END  
GO
