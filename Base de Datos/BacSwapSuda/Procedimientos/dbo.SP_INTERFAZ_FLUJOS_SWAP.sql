USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJOS_SWAP]   
AS
BEGIN

   declare @FechaProceso datetime
   select  @FechaProceso = fechaproc from swapgeneral



	SET NOCOUNT ON;
	
-->	Crea tabla con los valores de moneda para el día   
   CREATE TABLE #VALOR_TC_CONTABLE
	(
		vmcodigo			INTEGER NOT NULL DEFAULT(0)
   ,   vmvalor    FLOAT     NOT NULL DEFAULT(0.0)
   )
   CREATE INDEX #ixt_VALOR_TC_CONTABLE ON #VALOR_TC_CONTABLE ( vmcodigo )
-->	Crea tabla con los valores de moneda para el día   

-->	Crea la tabla final
	CREATE TABLE #TABLA_FLUJOS_C41
	(
		Numero_Operacion	INTEGER
	,	Numero_Flujo		INTEGER
	,	FechaLiquidacion	DATETIME
	,	Moneda				INTEGER
	,	Flujo_Capital		FLOAT
	,	Flujo_Interes		FLOAT
	,	Tipo_Flujo			INTEGER
    ,	Tipo_Tasa			INTEGER
	)
	CREATE INDEX #ixt_TABLA_FINAL ON #TABLA_FLUJOS_C41 (Numero_Operacion)
-->	Crea la tabla final

-->	Crea la tabla de flujos C08
	CREATE TABLE #TABLA_FLUJOS_C08
	(
		Numero_Operacion	INTEGER
	,	Numero_Flujo		INTEGER
	,	FechaLiquidacion	DATETIME
	,	Moneda_Pago			INTEGER
        ,       Amortizacion                    FLOAT 
        ,       Interes                         FLOAT 
	,	Flujo				FLOAT
	,	Tipo_Flujo			INTEGER
	)
	CREATE INDEX #ixt_TABLA_FINAL ON #TABLA_FLUJOS_C08 (Numero_Operacion)
-->	Crea la tabla de flujos C08

-->	Crea la tabla que se entrega a la interfaz
   CREATE TABLE #NEOSOFT
   (   C_pais		      CHAR(3)
   ,   F_interfaz	      DATETIME
   ,   N_identificacion       VARCHAR(4)
   ,   C_empresa              VARCHAR(3)
   ,   C_interno	      CHAR(16)
   ,   Nro_Operacion          VARCHAR(20)
   ,   F_pago		      DATETIME
   ,   M_cuota_local	      NUMERIC(18,2)
   ,   M_amortizacion	      NUMERIC(18,2)
   ,   M_interes	      NUMERIC(18,2)
   ,   C_sucursal             CHAR(3)
   ,   C_interno_sucursal     VARCHAR(3)
   ,   Registros	      INTEGER
   ,   Tipo_Flujo	      VARCHAR(1)
   ,   M_cuota_local_Aux      NUMERIC(18,2)
   ,   M_interes_Aux          NUMERIC(18,2)
   ,   M_Amortizacion_Aux     NUMERIC(18,2)
   ,   Numero_Flujo           NUMERIC(9)
    ,	Marca               CHAR(3)		--> Este campo se usara para informar si el campo es C08 o C41
   ,   TipoFlujo              INTEGER
   )
   CREATE INDEX #ittrf_NEOSOFT ON #NEOSOFT (Nro_Operacion, Numero_Flujo, TipoFlujo)
-->	Crea la tabla que se entrega a la interfaz

/********************************************************************************
*																				*
*				Genera Tabla de Monedas											*
*																				*
********************************************************************************/

-->	Inserta datos a la tabla de valores de moneda
-->	Inserta valor para el Peso
   	INSERT INTO #VALOR_TC_CONTABLE
	SELECT
		999
	,	1
-->	Inserta valor para el Peso

-->	Inserta valor para monedas Mx
	INSERT INTO #VALOR_TC_CONTABLE
	SELECT
		CASE
			WHEN codigo_moneda = 994 THEN 13 
			ELSE codigo_moneda 
		END
	,	tipo_cambio
   	FROM
   		BacParamSuda..VALOR_MONEDA_CONTABLE
   	WHERE
   		Fecha = @FechaProceso
	AND	Codigo_Moneda NOT IN(13,995,997,998,999)
	AND	Tipo_Cambio   <> 0.0

	-->	Control de error de que no esté cargada la tabla de paridades
	IF @@ROWCOUNT = 0 BEGIN
		RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
		SELECT '(RETURN -1)'
	END
	-->	Control de error de que no esté cargada la tabla de paridades
-->	Inserta valor para monedas Mx

-->	Inserta valor para UF
	INSERT INTO #VALOR_TC_CONTABLE
	SELECT
		vmcodigo
	,	vmvalor
	FROM	
		BacParamSuda..VALOR_MONEDA
	WHERE
		vmfecha = @FechaProceso 
	AND	vmcodigo IN(995,997,998,999)

	-->	Control de error de que no esté cargada la tabla de paridades
	IF @@ROWCOUNT = 0 BEGIN
		RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
		SELECT 'RETURN -1'
	END
	-->	Control de error de que no esté cargada la tabla de paridades
-->	Inserta valor para UF
-->	Inserta datos a la tabla de valores de moneda

/********************************************************************************
*																				*
*				Genera Tabla de Monedas											*
*																				*
********************************************************************************/

-->	Crea Temporal de la Cartera de Swaps Vigentes
	SELECT
		Numero_Operacion
	,	Numero_Flujo
    , 	Tipo_Flujo
	,	Fecha_Inicio_Flujo
	,	Fecha_Vence_Flujo
    , 	FechaLiquidacion
    , 	Moneda = 
		CASE 
			WHEN tipo_flujo=1 THEN compra_moneda
			ELSE venta_moneda
                        END
    ,	Saldo = 
		CASE
			WHEN tipo_flujo=1 THEN compra_saldo + compra_amortiza
			ELSE venta_saldo + venta_amortiza
                        END
    , 	Amortiza = 
		CASE
			WHEN tipo_flujo=1 THEN compra_amortiza
			ELSE venta_amortiza
                        END
    , 	Devengado = 
		CASE
			WHEN tipo_flujo=1 THEN devengo_compra_acum
			ELSE devengo_venta_acum
                        END
	,	Interes = 
		CASE
			WHEN tipo_flujo=1 THEN activo_mo_c08
			ELSE pasivo_mo_c08
		END
	,	Flujo_Adicional = 
		CASE
			WHEN tipo_flujo=1 THEN compra_flujo_adicional
			ELSE venta_flujo_adicional
                        END
	,	Codigo_Tasa = 
		CASE
			WHEN tipo_flujo=1 THEN compra_codigo_tasa
			ELSE venta_codigo_tasa
                        END
	,	Estado_Flujo
	,	IntercPrinc

	INTO #CARTERA_VIGENTE
	FROM	
--		BACSWAPSUDA..CARTERARES
		CARTERA
	WHERE	
--	fecha_proceso = @FechaProceso
	fecha_Cierre <= @FechaProceso
	AND fechaLiquidacion > @FechaProceso
	AND Fecha_Termino > @FechaProceso
  	AND Estado <> 'N'
    AND	Estado <> 'C'

	CREATE INDEX #ixt_CARTERA_VIGENTE ON #CARTERA_VIGENTE (numero_operacion, numero_flujo, tipo_flujo)
-->	Crea Temporal de la Cartera de Swaps Vigentes

/********************************************************************************
*																				*
*				Genera Flujos para C08											*
*																				*
********************************************************************************/
-->	Entrega los datos a la tabla C08
	INSERT INTO #TABLA_FLUJOS_C08
	SELECT
		Numero_Operacion
	,	Numero_Flujo
	,	FechaLiquidacion
	,	Moneda
        ,       Amortizacion = ROUND(vmvalor * (IntercPrinc * Amortiza + Flujo_Adicional),0)  
        ,       Interes      = ROUND(vmvalor * ( Interes ) ,0)                                   
	,	Flujo        = ROUND(vmvalor * (IntercPrinc * Amortiza + Interes + Flujo_Adicional),0)
	,	Tipo_Flujo
	FROM
		#CARTERA_VIGENTE, #VALOR_TC_CONTABLE
   	WHERE
   		vmcodigo = Moneda
-->	Entrega los datos a la tabla C08

-->	Crea la Salida Final por Flujo 
	INSERT INTO #NEOSOFT
	SELECT
		C_pais = 'CL'
	,	F_interfaz = @FechaProceso
    ,  	N_identificacion = 'FD52'
    ,	C_empresa = '001'
    ,	C_interno = 'MD02'
    ,	Nro_Operacion = Numero_Operacion
    ,	F_pago = FechaLiquidacion
    ,	M_cuota_local = Flujo
    ,   M_amortizacion = Amortizacion -- 0 
    ,	M_interes = Interes           -- 0 
    ,   C_sucursal = '1  '
	,	C_interno_sucursal = 'L'  -- "Centro de Costo" marca C08
    ,   Registros = 0
    ,   Tipo_Flujo = 
		CASE
			WHEN Tipo_Flujo = 1 THEN 'A'
			ELSE 'P'
                        END
    ,	M_cuota_local_Aux = 0
    ,	M_interes_Aux = 0
    ,  	M_Amortizacion_Aux = 0
    ,  	Numero_Flujo = Numero_Flujo
    ,  	Marca = 'C08'
    ,  	TipoFlujo = Tipo_Flujo
   	FROM
   		#TABLA_FLUJOS_C08
-->	Crea la Salida Final por Flujo 
/********************************************************************************
*																				*
*				Genera Flujos para C08											*
*																				*
********************************************************************************/
   

/********************************************************************************
*																				*
*				Genera Flujos para C41											*
*																				*
********************************************************************************/

-->	Calcula el flujo proyectado de las patas fijas
	INSERT INTO #TABLA_FLUJOS_C41
	SELECT
		Numero_Operacion
	,	Numero_Flujo
    ,	FechaLiquidacion
    ,	Moneda
    ,	ROUND (vmvalor * (Amortiza * Intercprinc + Flujo_Adicional), 0)
    ,	ROUND (vmvalor * Interes, 0)
    ,	Tipo_Flujo
    ,	1
   	FROM
   		#CARTERA_VIGENTE
	,	#VALOR_TC_CONTABLE
    WHERE
		vmcodigo = Moneda
	AND	Codigo_Tasa = 0
-->	Calcula el flujo proyectado de las patas fijas

-->	Elimina las patas fijas de la cartera vigente
	DELETE
	FROM
		#CARTERA_VIGENTE
    WHERE
		Codigo_Tasa = 0
-->	Elimina las patas fijas de la cartera vigente

-->	Calcula el flujo sometido a riesgo de tasa de los flujos activos de las patas flotantes
	INSERT INTO #TABLA_FLUJOS_C41
	SELECT
		Numero_Operacion
    ,	Numero_Flujo
    ,	CASE
			--> Cuando la tasa sigue la camara ICP, el riesgo de reprecio es de 1 día
			WHEN Codigo_Tasa = 13 THEN @FechaProceso + 1
			--> En los otros casos, el riesgo de reprecio es hasta la fecha de liquidacion del flujo activo
			ELSE FechaLiquidacion
		END
    ,	Moneda
    ,	ROUND (vmvalor * Saldo, 0)
    ,	CASE
			--> Cuando la tasa sigue la camara ICP, el flujo de interes en riesgo corresponde al devengado
			WHEN Codigo_Tasa = 13 THEN ROUND (vmvalor * Devengado, 0)
			--> En los otros casos, el interes en riesgo corresponde al generado por el indice conocido
			ELSE ROUND (vmvalor * Interes, 0)
                        END
    ,	Tipo_Flujo
    ,	2
  	FROM
  		#CARTERA_VIGENTE
	,	#VALOR_TC_CONTABLE
    WHERE
		vmcodigo = Moneda
	AND	Fecha_Inicio_Flujo < @FechaProceso
-->	Calcula el flujo sometido a riesgo de tasa de los flujos activos de las patas flotantes

-->	Calcula el riesgo de las amortizaciones no efectivas de las patas flotantes
	INSERT INTO #TABLA_FLUJOS_C41
	SELECT	
		Numero_Operacion
	,	Numero_Flujo
    ,	FechaLiquidacion
    ,	Moneda
    ,	- ROUND (vmvalor * Amortiza, 0)
    ,	0
    ,	Tipo_Flujo
    ,	1
   	FROM
   		#CARTERA_VIGENTE
	,	#VALOR_TC_CONTABLE
    WHERE
		vmcodigo = Moneda
	AND	Amortiza <> 0
	AND	IntercPrinc = 0
-->	Calcula el riesgo de las amortizaciones no efectivas de las patas flotantes

-->	Calcula el riesgo de los flujos adicionales de las patas flotantes
	INSERT INTO #TABLA_FLUJOS_C41
	SELECT
		Numero_Operacion
	,	Numero_Flujo
    ,	FechaLiquidacion
    ,	Moneda
    ,	ROUND (vmvalor * Flujo_Adicional, 0)
    ,	0
    ,	Tipo_Flujo
    ,	1
   	FROM
   		#CARTERA_VIGENTE
	,	#VALOR_TC_CONTABLE
    WHERE
		vmcodigo = Moneda
	AND	Flujo_Adicional <> 0
-->	Calcula el riesgo de los flujos adicionales de las patas flotantes

-->	Elimina datos que no aportan información
	DELETE
	FROM
		#TABLA_FLUJOS_C41
	WHERE
		Flujo_Capital+Flujo_Interes = 0
-->	Elimina datos que no aportan información

   -->    Crea la Salida Final por Flujo 
   INSERT INTO #NEOSOFT
	SELECT
		C_pais = 'CL'
	,	F_interfaz = @FechaProceso
    ,   N_identificacion = 'FD52'
    ,	C_empresa = '001'
    ,	C_interno = 'MD02'
    ,	Nro_Operacion = Numero_Operacion
    ,	F_pago = FechaLiquidacion
--    ,	M_cuota_local = 0
    ,	M_cuota_local = SUM(Flujo_Capital) + SUM(Flujo_Interes)
    ,   M_amortizacion = SUM(Flujo_Capital)
    ,	M_interes = SUM(Flujo_Interes)
    ,   C_sucursal = '1  '
	,	C_interno_sucursal = 'T'  -- "Centro de Costo" marca C41
    ,   Registros = 0
    ,   Tipo_Flujo =
		CASE
			WHEN Tipo_Flujo = 1 THEN 'A'
			ELSE 'P'
		END
    ,	M_cuota_local_Aux = 0
    ,	M_interes_Aux = 0
    ,   M_Amortizacion_Aux = 0
    ,  	Numero_Flujo = Numero_Flujo
    ,  	Marca = 'C41'
    ,   TipoFlujo = Tipo_Flujo
   	FROM
   		#TABLA_FLUJOS_C41
	GROUP BY
		Numero_Operacion
	,	Numero_Flujo
	,	FechaLiquidacion
	,	Tipo_Flujo
	,	Tipo_Tasa
	,	Moneda
-->	Crea la Salida Final por Flujo 
/********************************************************************************
*																				*
*				Genera Flujos para C41											*
*																				*
********************************************************************************/


/********************************************************************************************
*																				            *
*	Agrupación que corrige violación PK= Nro_Op + F_Pago + C_interno_sucursal + Tipo_Flujo	*
*																				            *
*********************************************************************************************/ 
select C_pais 
     , F_interfaz              
     , N_identificacion 
     , C_empresa 
     , C_interno        
     , Nro_Operacion        
     , F_pago                  
     , M_cuota_local  = Sum( M_cuota_local )
     , M_amortizacion = Sum( M_amortizacion )
     , M_interes      = Sum( M_interes )
     , C_sucursal 
     , C_interno_sucursal 
     , Registros   
     , Tipo_Flujo 
     , M_cuota_local_Aux                       
     , M_interes_Aux                           
     , M_Amortizacion_Aux                      
     --, Numero_Flujo                            
     , Marca 
     , TipoFlujo
into #NEOSOFT02
from #NEOSOFT
group by 
       C_pais 
     , F_interfaz              
     , N_identificacion 
     , C_empresa 
     , C_interno        
     , Nro_Operacion        
     , F_pago                  
     , C_sucursal 
     , C_interno_sucursal 
     , Registros   
     , Tipo_Flujo 
     , M_cuota_local_Aux                       
     , M_interes_Aux                           
     , M_Amortizacion_Aux                      
     --, Numero_Flujo                            
     , Marca 
     , TipoFlujo


-->	Llena el campo de numero de registros
	DECLARE @Contador INTEGER
	SELECT	@Contador=(SELECT COUNT(1) FROM #NEOSOFT02)

   UPDATE #NEOSOFT
	SET
		Registros = @Contador
	FROM
		#NEOSOFT
-->	Llena el campo de numero de registros


	SELECT
		*
	FROM
		#NEOSOFT02
	ORDER BY
		Marca
	,	CONVERT(INTEGER, Nro_operacion)
        , F_pago
	,	Tipo_Flujo

END
GO
