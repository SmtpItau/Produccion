USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[FD52]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--dbo.FD52 '2021-10-01'
CREATE PROCEDURE [dbo].[FD52] (@dFechaProceso DateTime)
AS
BEGIN
SET NOCOUNT ON;

--DECLARE @dFechaProceso DateTime
--SET @dFechaProceso ='20220329'

  if @dFechaProceso is null  
	begin   
	 set @dFechaProceso = (select fechaproc from BacSwapSuda..swapgeneral)  
	end  

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
    ,   Amortizacion        FLOAT 
    ,   Interes             FLOAT 
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
   ,   M_interes			  NUMERIC(18,2)
   ,   C_sucursal             CHAR(3)
   ,   C_interno_sucursal     VARCHAR(3)
   ,   Registros			  INTEGER
   ,   Tipo_Flujo			  VARCHAR(1)
   ,   M_cuota_local_Aux      NUMERIC(18,2)
   ,   M_interes_Aux          NUMERIC(18,2)
   ,   M_Amortizacion_Aux     NUMERIC(18,2)
   ,   Numero_Flujo           NUMERIC(9)
   ,   Marca                  CHAR(3)		--> Este campo se usara para informar si el campo es C08 o C41
   ,   TipoFlujo             INTEGER
   )
   CREATE INDEX #ittrf_NEOSOFT ON #NEOSOFT (Nro_Operacion, Numero_Flujo, TipoFlujo)
-->	Crea la tabla que se entrega a la interfaz



Declare @FD52_SALIDA Table ( REG_SALIDA  Varchar(156))  
Declare @VM Table(Vmfecha Date, VmCodigo	Int, VmValor Float)

Declare @FD52 Table(
		ctry						VARCHAR(3)										
,		intf_dt						CHAR(8)
,		src_id						VARCHAR(14)
,		cem							VARCHAR(3)
,		prod						VARCHAR(16)
,		con_no						VARCHAR(20)
,		coup_dt						CHAR(8)
,		lcy_coup_amt				NUMERIC(19,2)
,		lcy_amrt_amt				NUMERIC(19,2)
,		Lcy_int_amt					NUMERIC(19,2)
,		br							CHAR(04)
,		cc							VARCHAR(10)
,		aset_liab_ind				VARCHAR(1)
,		flujo						VARCHAR(1)
)

/********************************************************************************
*																				*
*				Genera Tabla de Monedas											*
*																				*
********************************************************************************/

-->	Inserta datos a la tabla de valores de moneda
-->	Inserta valor para el Peso
   	INSERT INTO @VM
	SELECT
		@dFechaProceso
	,	999
	,	1
-->	Inserta valor para el Peso

-->	Inserta valor para monedas Mx
	INSERT INTO @VM
	SELECT
		@dFechaProceso
	,	CASE
			WHEN codigo_moneda = 994 THEN 13 
			ELSE codigo_moneda 
		END
	,	tipo_cambio
   	FROM
   		BacParamSuda..VALOR_MONEDA_CONTABLE
   	WHERE
   		Fecha = @dFechaProceso
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
	INSERT INTO @VM
	SELECT
		@dFechaProceso
	,	vmcodigo
	,	vmvalor
	FROM	
		BacParamSuda..VALOR_MONEDA
	WHERE
		vmfecha = @dFechaProceso 
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
		bacswapsuda..CARTERA
	WHERE	
--	fecha_proceso = @dFechaProceso
	fecha_Cierre <= @dFechaProceso
	AND fechaLiquidacion > @dFechaProceso
	AND Fecha_Termino > @dFechaProceso
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
    ,   Amortizacion = ROUND(vmvalor * (IntercPrinc * Amortiza + Flujo_Adicional),0)  
    ,   Interes      = ROUND(vmvalor * ( Interes ) ,0)                                   
	,	Flujo        = ROUND(vmvalor * (IntercPrinc * Amortiza + Interes + Flujo_Adicional),0)
	,	Tipo_Flujo
	FROM
		#CARTERA_VIGENTE, @VM
   	WHERE
   		vmcodigo = Moneda
-->	Entrega los datos a la tabla C08

-->	Crea la Salida Final por Flujo 
	INSERT INTO #NEOSOFT
	SELECT
		C_pais = 'CL'
	,	F_interfaz = @dFechaProceso
    ,  	N_identificacion = 'FDC2'
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
	,	@VM
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
			WHEN Codigo_Tasa = 13 THEN @dFechaProceso + 1
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
	,	@VM
    WHERE
		vmcodigo = Moneda
	AND	Fecha_Inicio_Flujo < @dFechaProceso
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
	,	@VM
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
	,	@VM
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
	,	F_interfaz = @dFechaProceso
    ,   N_identificacion = 'FDC2'
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

INSERT INTO @FD52
SELECT
		'CL '														AS			ctry		
,		LTRIM(CONVERT(CHAR(10),F_interfaz,112))						as			intf_dt	
,		'FDC2' + SPACE(10)											as			src_id
,		'001'														as			cem		
,		'MD02' + SPACE(12)	as			prod --'SWP'														as			prod
--,		(		REPLICATE('0',20- DATALENGTH(ltrim(rtrim(Nro_Operacion))) ) + LTRIM(RTRIM(CONVERT(CHAR(20),Nro_Operacion))) 
--		)															as			con_no	
,		Nro_Operacion												as			con_no	
,		convert(char(08),F_pago,112)								as			coup_dt
,		M_cuota_local												as			lcy_coup_amt
,		M_amortizacion												as			lcy_amrt_amt
,		M_interes													as			Lcy_int_amt
,		'0011'														as			br														
,		REPLICATE('0',10)											as			cc													
,		Tipo_Flujo													as			aset_liab_ind	
,		'A'															as			flujo
FROM
   		#NEOSOFT02

Declare @TipoSalida bit = 0
Declare @Pie_Archivo Varchar(20) = ''
Declare @iCantidadRegistros int = 1

set @iCantidadRegistros = (select count(1) from @FD52)
set @Pie_Archivo		= '99'+LTRIM(RTRIM(CONVERT(CHAR(10),getdate(),112)))+REPLICATE('0', 10 - len(LTRIM(RTRIM(@iCantidadRegistros))))+RTRIM(RTRIM(@iCantidadRegistros))


if @TipoSalida != 0
	SELECT 
			ctry		as ctry
		,	intf_dt		as intf_dt
		,	src_id		as src_id
		,	cem			as cem
		,	prod--left(prod+replicate(' ',16),16)
		,	left(con_no+space(20), 20)  as con_no	
		,	coup_dt as coup_dt
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_coup_amt*100))),19) as lcy_coup_amt
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_amrt_amt*100))),19) as lcy_amrt_amt
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(Lcy_int_amt*100))),19) as Lcy_int_amt
		,	br		as br												
		,	cc		as cc											
		,	aset_liab_ind	as aset_liab_ind
	
	
	
	 FROM @FD52 Order by cem ,  prod , con_no
else
	begin
		INSERT INTO @FD52_SALIDA
		SELECT
			ctry		
		+	intf_dt	
		+	src_id
		+	cem		
		+	prod--left(prod+replicate(' ',16),16)
		+   left(con_no+space(20), 20)--con_no	
		+	coup_dt
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_coup_amt*100))),19)
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_amrt_amt*100))),19)
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(Lcy_int_amt*100))),19)
		+	br														
		+	cc													
		+	aset_liab_ind	
--		+	flujo
		FROM @FD52

--		insert into @FD52_SALIDA
--		select @Pie_Archivo

		SELECT * FROM @FD52_SALIDA order  by  1 desc

	end

drop table #TABLA_FLUJOS_C41
drop table #TABLA_FLUJOS_C08
drop table #NEOSOFT
drop table #CARTERA_VIGENTE
drop table #NEOSOFT02

END
GO
