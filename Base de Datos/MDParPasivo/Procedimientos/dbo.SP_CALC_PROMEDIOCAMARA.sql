USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALC_PROMEDIOCAMARA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
--BASE DE DATOS :  ** P A R A M E T R O S **
/*******************************************
Ejecucción de Pruebas:
	BEGIN TRAN
		EXEC SP_CALC_PROMEDIOCAMARA
	ROLLBACK TRAN
********************************************/
CREATE PROCEDURE [dbo].[SP_CALC_PROMEDIOCAMARA]
AS 
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT DMY
	SET NOCOUNT ON 
	
	DECLARE @Fecha_Proceso		CHAR(8)
	DECLARE @Fecha_Proximo     	CHAR(8)
	DECLARE @PrimerDiaMes      	CHAR(8)
	DECLARE @UltimoDiaMes      	CHAR(8)
	DECLARE	@Fecha_Calculo		DATETIME


	SELECT	@Fecha_Proceso  = CONVERT(CHAR(8), fecha_proceso ,112)	,
		@Fecha_Proximo  = CONVERT(CHAR(8), fecha_proxima ,112)
	FROM 	DATOS_GENERALES WITH (NOLOCK)


	SELECT	@PrimerDiaMes = SUBSTRING(@Fecha_Proceso ,1,6) + '01'	,
		@UltimoDiaMes = SUBSTRING(CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,35,@PrimerDiaMes)),112),1,6) + '01',
		@UltimoDiaMes = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@UltimoDiaMes)),112)


	SELECT	@Fecha_Calculo = CONVERT(DATETIME, @Fecha_Proceso)


	IF CONVERT(DATETIME,@UltimoDiaMes) < CONVERT(DATETIME,@Fecha_Proximo)
		SELECT	@Fecha_Calculo = CONVERT(DATETIME, @UltimoDiaMes)

	--EBQ: INICIO RUTINA QUE CALCULA EL PROMEDIO CÁMARA
	--*************************************************	
	SELECT 'NUMERO_OPERACION'       = B.NUMERO_OPERACION
	,      'NUMERO_FLUJO'           = B.NUMERO_FLUJO
	,      'TIPO_FLUJO'             = B.TIPO_FLUJO
	,      'FECHA_PROCESO_ANTERIOR' = FECHA_PROCESO 
	,      'FECHA_INICIO_FLUJO'     = B.FECHA_INICIO_FLUJO 
	,      'FECHA_VENCE_FLUJO'      = B.FECHA_VENCE_FLUJO 
	,      'ICP1'                   = VMH.VMVALOR
	,      'ICP0'                   = VMI.VMVALOR
	,      'PERIODO'                = CONVERT( FLOAT, DATEDIFF(DD, FECHA_INICIO_FLUJO, (CASE WHEN ESTADO_FLUJO = 2 THEN @Fecha_Proceso ELSE @Fecha_Calculo END ) ) )
	,      'UF_F_PROCESO_ANTERIOR'  = (CASE WHEN (SELECT VMVALOR FROM VALOR_MONEDA WITH (NOLOCK) WHERE VMCODIGO = 998 AND VMFECHA= (CASE WHEN ESTADO_FLUJO = 2 THEN @Fecha_Proceso ELSE @Fecha_Calculo END )) > 0 THEN (SELECT VMVALOR FROM VALOR_MONEDA WITH (NOLOCK) WHERE VMCODIGO = 998 AND VMFECHA = (CASE WHEN ESTADO_FLUJO = 2 THEN @Fecha_Proceso ELSE @Fecha_Calculo END )) ELSE 1 END)
	,      'UF_F_INICIO_FLUJO'      = (CASE WHEN (SELECT VMVALOR FROM VALOR_MONEDA WITH (NOLOCK) WHERE VMCODIGO = 998 AND VMFECHA= B.FECHA_INICIO_FLUJO) > 0 THEN (SELECT VMVALOR FROM VALOR_MONEDA WITH (NOLOCK)  WHERE VMCODIGO = 998 AND VMFECHA = B.FECHA_INICIO_FLUJO) ELSE 1 END)
	,      'TNA'                    = CONVERT(FLOAT, 0.0)
	,      'TRA'                    = CONVERT(FLOAT, 0.0)
	,      'BASE'                   = TASA.MNBASE
	,      'MONEDA'		        = B.moneda_flujo
	,	   A.codigo_cliente 
	,	   A.rut_cliente 		
	INTO     #TMP_FLUJOS_VIGENTES
	FROM     VIEW_CONTRATO              A  
	,        VIEW_CONTRATO_FLUJO        B  
	,        DATOS_GENERALES    	WITH (NOLOCK)
	,        VALOR_MONEDA     VMH	WITH (NOLOCK)
	,        VALOR_MONEDA     VMI	WITH (NOLOCK)
	,        MONEDA           TASA	WITH (NOLOCK)
	WHERE A.NUMERO_OPERACION =  B.NUMERO_OPERACION
	AND   VMH.VMCODIGO        =  444
	AND   VMH.VMFECHA         =  FECHA_PROCESO
	AND   VMI.VMCODIGO        =  444
	AND   VMI.VMFECHA         =  B.FECHA_INICIO_FLUJO
	AND   ESTADO_FLUJO       in( 1, 2 )
	AND   TIPO_SWAP          =  'SC'
	AND   B.CODIGO_TASA      =  TASA.MNCODMON
--	AND   B.CODIGO_TASA      <> 333    
	AND   B.CODIGO_TASA      = 555

	-- ** EBQ: Se calcula TNA para todo los flujos ** --
	UPDATE	#TMP_FLUJOS_VIGENTES
	SET	TNA = ROUND(( (ICP1/ICP0)-1) * ( 36000.0 / PERIODO ) , 2)
	WHERE	periodo <> 0
	AND	ICP1 <> 0

	-- ** EBQ: Se calcula TRA para todo los flujos con cliente CITIBANK ** --
	-- **      El cálculo de TRA para CITIBANK es diferente ** --
	UPDATE	#TMP_FLUJOS_VIGENTES
	SET	TRA = ROUND(((ICP1/ICP0)*(UF_F_INICIO_FLUJO/UF_F_PROCESO_ANTERIOR)-1) * ( 36000.0 / PERIODO ) , 4)
	WHERE	rut_cliente = 97008000 --LAS OPERACIONES CON EL CITIBANK TIENE REDONDEO A CUATRO DECIMALES
	AND	periodo <> 0

	-- ** EBQ: El cálculo de TRA para todo los cliente, menos CITIBANK ** --
	UPDATE #TMP_FLUJOS_VIGENTES
	SET    TRA = ROUND(((((TNA*PERIODO)/36000.0) - ((UF_F_PROCESO_ANTERIOR/UF_F_INICIO_FLUJO)-1) ) / (UF_F_PROCESO_ANTERIOR/UF_F_INICIO_FLUJO))*(36000.0/PERIODO),4)
	WHERE  moneda = 998 
	AND	periodo <> 0
	AND	ICP1 <> 0
	AND 	rut_cliente <> 97008000
  
	-- ** EBQ: El cálculo de TRA = TNA para flujos en Pesos ** --
	UPDATE #TMP_FLUJOS_VIGENTES
	SET    TRA = TNA
	WHERE  moneda = 999

	UPDATE        VIEW_CONTRATO_FLUJO WITH (ROWLOCK)
	SET           VIEW_CONTRATO_FLUJO.VALOR_TASA           = #TMP_FLUJOS_VIGENTES.TRA
	,             VIEW_CONTRATO_FLUJO.INTERES_FLUJO       = ROUND((( VIEW_CONTRATO_FLUJO.SALDO_CAPITAL + VIEW_CONTRATO_FLUJO.AMORTIZA_CAPITAL )* DATEDIFF(DD, VIEW_CONTRATO_FLUJO.FECHA_INICIO_FLUJO, VIEW_CONTRATO_FLUJO.FECHA_VENCE_FLUJO) * #TMP_FLUJOS_VIGENTES.TRA)/(#TMP_FLUJOS_VIGENTES.BASE*100) , CASE WHEN (MONEDA_FLUJO = 999) THEN 0 ELSE 4 END)
	,	      VIEW_CONTRATO_FLUJO.interes_pago	      = ROUND((( VIEW_CONTRATO_FLUJO.SALDO_CAPITAL + VIEW_CONTRATO_FLUJO.AMORTIZA_CAPITAL )* DATEDIFF(DD, VIEW_CONTRATO_FLUJO.FECHA_INICIO_FLUJO, VIEW_CONTRATO_FLUJO.FECHA_VENCE_FLUJO) * #TMP_FLUJOS_VIGENTES.TRA)/(#TMP_FLUJOS_VIGENTES.BASE*100) , CASE WHEN (MONEDA_FLUJO = 999) THEN 0 ELSE 4 END)
	,	      VIEW_CONTRATO_FLUJO.interes_pago_origen = ROUND((( VIEW_CONTRATO_FLUJO.SALDO_CAPITAL + VIEW_CONTRATO_FLUJO.AMORTIZA_CAPITAL )* DATEDIFF(DD, VIEW_CONTRATO_FLUJO.FECHA_INICIO_FLUJO, VIEW_CONTRATO_FLUJO.FECHA_VENCE_FLUJO) * #TMP_FLUJOS_VIGENTES.TRA)/(#TMP_FLUJOS_VIGENTES.BASE*100) , CASE WHEN (MONEDA_FLUJO = 999) THEN 0 ELSE 4 END)
	FROM          VIEW_CONTRATO_FLUJO 
	,             #TMP_FLUJOS_VIGENTES
	WHERE         #TMP_FLUJOS_VIGENTES.NUMERO_OPERACION = VIEW_CONTRATO_FLUJO.NUMERO_OPERACION
	AND           VIEW_CONTRATO_FLUJO.NUMERO_FLUJO     = #TMP_FLUJOS_VIGENTES.NUMERO_FLUJO
	AND           VIEW_CONTRATO_FLUJO.TIPO_FLUJO       = #TMP_FLUJOS_VIGENTES.TIPO_FLUJO	
	AND	      #TMP_FLUJOS_VIGENTES.ICP1 <> 0

	--EBQ: TERMINO RUTINA QUE CALCULA EL PROMEDIO CÁMARA
	--**************************************************
END

GO
