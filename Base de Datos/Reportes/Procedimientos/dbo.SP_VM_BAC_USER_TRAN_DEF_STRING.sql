USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_USER_TRAN_DEF_STRING]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--IF OBJECT_ID('SP_VM_BAC_USER_TRAN_DEF_STRING')>0	
--	DROP PROCEDURE DBO.SP_VM_BAC_USER_TRAN_DEF_STRING
--GO


-- =============================================
-- Author:          SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX USER_TRAN_DEF_STRING
-- =============================================

--EXEC SP_VM_BAC_USER_TRAN_DEF_STRING
CREATE PROCEDURE [dbo].[SP_VM_BAC_USER_TRAN_DEF_STRING]
AS BEGIN 

SET NOCOUNT ON 

CREATE TABLE #VM_BAC_USER_TRAN_DEF_STRING(
      UDT_ID      INT,
      TRAN_ID     INT,
		UTDS_VALUE  VARCHAR(100))		--	UTDD_VALUE --> PLL-20200512 - corrige nombre según version 11               

--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512

CREATE TABLE #VM_BAC_USER_TRAN_DEF_STRING_SALIDA(
		TRAN_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
		UDT_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
		REG_SALIDA			Varchar(1000))
--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512


DECLARE @SEP    VARCHAR(1); SET @SEP    = ','
DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>ISNULL((SELECT acfecproc FROM BACFWDSUDA..MFAC), '') 
DECLARE @FECHA_FWD  DATETIME; SET @FECHA_FWD  = ISNULL((SELECT acfecproc FROM BACFWDSUDA..MFAC), '')-->>ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')
DECLARE @FECHA_OPT  DATETIME; SET @FECHA_OPT  = ISNULL((SELECT fechaproc FROM CbMdbOpc..OpcionesGeneral), '')

DECLARE @Nombre_Cliente AS INT; SET @Nombre_Cliente = 0;   --Corresponde al nombre original de la transacción, aplica para operaciones Fx Spot origen CMX o eCambios.
DECLARE @Banco_de_Referencia_1 AS INT; SET @Banco_de_Referencia_1 = 3;   --Bancos garantes, utilizados como referentes ante la ejecución de un ET si existieran diferencias en los PV a liquidar.
DECLARE @Banco_de_Referencia_2 AS INT; SET @Banco_de_Referencia_2 = 4;   --Bancos garantes, utilizados como referentes ante la ejecución de un ET si existieran diferencias en los PV a liquidar.
DECLARE @Banco_de_Referencia_3 AS INT; SET @Banco_de_Referencia_3 = 5;   --Bancos garantes, utilizados como referentes ante la ejecución de un ET si existieran diferencias en los PV a liquidar.
DECLARE @Observaciones AS INT; SET @Observaciones = 6;   --Texto libre
DECLARE @Codigo_IDD AS INT; SET @Codigo_IDD = 7;   --Codigo generado por el core de credito AS 400
DECLARE @Mda_Ref AS INT; SET @Mda_Ref = 8;   --Marca la moneda de referencia para el nocional flotante, aplica para SWAP
DECLARE @Codigo_Unico AS INT; SET @Codigo_Unico = 11;   --
DECLARE @Fecha_Hora AS INT; SET @Fecha_Hora = 12;   --
DECLARE @ModalidadPago AS INT; SET @ModalidadPago = 13;   --Determina el tipo de liquidación (DF o NDF) 
DECLARE @Canal_Transaccional AS INT; SET @Canal_Transaccional = 14;   --Indica el origen de la transacción, pudiendo ser : CMX, WEB, Sucursales, Mesa Trading, Mesa Clientes, estas ultimas utilizadas por CMX para determinar el area responsable por su liquidación.
DECLARE @Medio_Transaccional AS INT; SET @Medio_Transaccional = 15;   --Indica el origen del cierre, pudiendo ser: Telefono, Bloomberg, Camara Comder, Broker, Datatec, etc.
DECLARE @Especialista AS INT; SET @Especialista = 16;   --Indica el area o usuario encargado de la liquidación: Middle Office Corporate, User Name, Security Service, etc.  
DECLARE @Horario_Especial AS INT; SET @Horario_Especial = 17;   --Indica si la operacipon es de tipo de liquidación Pago Mañana.
DECLARE @Sucursal AS INT; SET @Sucursal = 18;   --Indica el numero de sucursal de cierre de la operación, aplica solo para spot
DECLARE @Indicador_FX AS INT; SET @Indicador_FX = 19;   --Indica si una operación fx spot corresponde a un Hedge o entrega Fisica.
DECLARE @Usuario_Operacion AS INT; SET @Usuario_Operacion = 27;   --Indica el operador del sistema origen, aplica para migración u operaciones de origen externo
DECLARE @Data_Hora AS INT; SET @Data_Hora = 28;   --Data sistema origen
DECLARE @ID_Cliente AS INT; SET @ID_Cliente = 29;   --ID Cliente sistema origen
DECLARE @Tipo_CC AS INT; SET @Tipo_CC = 30;   --Indica el tipo de cobertura contable
DECLARE @Estrategia_CC AS INT; SET @Estrategia_CC = 31;   --Indica la estrategia de cobertura contable.
DECLARE @ET_Next_Period AS INT; SET @ET_Next_Period = 33;   --Indica el periodo de revisión del Early Termination (1w, 1m, 1y, etc.)
DECLARE @Tipo_ET AS INT; SET @Tipo_ET = 34;   --Indica el tipo de Early Termination (ET Brasil o Sin ET)
DECLARE @Rounding_Method AS INT; SET @Rounding_Method = 35;   --
DECLARE @Tipo_LoadDep AS INT; SET @Tipo_LoadDep = 36;   --
DECLARE @Modalidad_de_Pago_FX_Fwd AS INT; SET @Modalidad_de_Pago_FX_Fwd = 37;   --Corresponde a la modalidad de pago en el fwd, esto es; Comp USD, Comp CLP o Entrega Fisica.
DECLARE @FX_Fwd_Multiplier AS INT; SET @FX_Fwd_Multiplier = 48;   --
DECLARE @Cod_Pro AS INT; SET @Cod_Pro = 52;   --
DECLARE @Cod_Sub_Pro AS INT; SET @Cod_Sub_Pro = 53;   --
DECLARE @Credito_Relacionado AS INT; SET @Credito_Relacionado = 54;   --
DECLARE @Ajuste_Valuta AS INT; SET @Ajuste_Valuta = 55;   --
DECLARE @Glosa_Causales AS INT; SET @Glosa_Causales = 56;   --
DECLARE @Nro_Transaccion AS INT; SET @Nro_Transaccion = 57;   --Numero generado por un sistema de negociación externo como: BBG, Datatec, OTC, CMX, Comder, SEF, etc.
DECLARE @Contraparte_Original AS INT; SET @Contraparte_Original = 58;   --Corresponde al nombre original de la transacción, aplica para operaciones Fx Spot origen CMX o eCambios.
		--Para forward aplica en los casos en que la operación es novada hacia una contraparte central (Comder)"
DECLARE @Justificacion_VR AS INT; SET @Justificacion_VR = 59;   --Tipo de justificación Volcker Rule
DECLARE @FCM AS INT; SET @FCM = 60;   --FCM asociada al cierre de la transacción y a la respectiva Camara (A esta le es imputado el RCO)
DECLARE @Tipo_Garantias AS INT; SET @Tipo_Garantias = 61;   --Determina el tipo de garantia a ser constituida
DECLARE @Estado_SEF AS INT; SET @Estado_SEF = 62;   --Determina el estado de la SEF, esto en Accepted o Rejected
DECLARE @Codigo_IDR AS INT; SET @Codigo_IDR = 63;   --Codigo reverso de uso de linea, origen AS 400.
DECLARE @Toma_Linea_Puntual AS INT; SET @Toma_Linea_Puntual = 64;   --
DECLARE @FX_Fwd_ET_Tipo_Term AS INT; SET @FX_Fwd_ET_Tipo_Term = 65;   --Determina el Tipo de ET, Unilateral, Bilateral o Sin ET.
DECLARE @Tran_Collateral_CCY AS INT; SET @Tran_Collateral_CCY = 66;   --Corresponde a la moneda de valuación.
DECLARE @Tp_Strtgy AS INT; SET @Tp_Strtgy = 112;   --Determina la estrategia o variante de producto Murex

DECLARE @Adquisicion_por_cesion AS INT; SET @Adquisicion_por_cesion = 126;   --Indica si la operación ingresada corresponde  a una adquisición por cesión.
	--Yes/No
DECLARE @Tipo_de_Modificacion AS INT; SET @Tipo_de_Modificacion = 127;   --Indica el tipo de modificación que se esta realizando
	--1 Recouponing
	--2 Modificación de contraparte por cesión
	--3 Otras modificaciones
	--4 Corrección de reporte
	--5 N/A
DECLARE @Termino_por_Cesion AS INT; SET @Termino_por_Cesion = 128;   --Indica si el termino de la operación es debido a un Cesión del contrato
	--Yes/No
DECLARE @RUT_Agente_de_Calculo_2 AS INT; SET @RUT_Agente_de_Calculo_2 = 130;   --RUT (Rol Único Tributario) de la persona o entidad que actuará como Agente de Cálculo para cuando se pone término al Contrato.
DECLARE @RUT_Agente_de_Calculo_3 AS INT; SET @RUT_Agente_de_Calculo_3 = 131;   --RUT (Rol Único Tributario) de la persona o entidad que actuará como Agente de Cálculo para cuando se pone término al Contrato.
DECLARE @Nombre_o_Razon_Social_Agente_de_Calculo_2 AS INT; SET @Nombre_o_Razon_Social_Agente_de_Calculo_2 = 133;   --Razón Social de la persona o entidad que actuará como Agente de Cálculo para cuando se pone término al Contrato.
DECLARE @Nombre_o_Razon_Social_Agente_de_Calculo_3 AS INT; SET @Nombre_o_Razon_Social_Agente_de_Calculo_3 = 134;   --Razón Social de la persona o entidad que actuará como Agente de Cálculo para cuando se pone término al Contrato.
DECLARE @RUT_del_Cedente_o_Cesionario AS INT; SET @RUT_del_Cedente_o_Cesionario = 135;   --RUT de la Contraparte que cede (evento suscripción “Adquisición por Cesión”, evento de modificación “Modificación de Contraparte por Cesión”) o a la que se cede (evento término por “Cesión”) un Contrato
DECLARE @Compresion_de_Cartera AS INT; SET @Compresion_de_Cartera = 138;   --Identifica si el nuevo Contrato o el término anticipado de uno previamente informado es resultado de una compresión u optimización de cartera
	--Yes/No
DECLARE @Plataforma_de_Negociacion AS INT; SET @Plataforma_de_Negociacion = 139;   --Código de la Plataforma de Negociación en la cual fue pactado el contrato de derivado, según código MIC (Market Identifier Code) de la norma ISO 10383. En el caso que el contrato fuese negociado fuera de Bolsa, se deberá indicar en este campo el código “OTC
DECLARE @RUT_Intermediario AS INT; SET @RUT_Intermediario = 140;   --RUT del Intermediario (Broker) que actuó como intermediario en el cierre de la operación.  

-------------------------------------------------------------------------------
	-- ================================================
	--3	Banco de Referencia 1				*** PENDIENTE ***
	-- ================================================
	--4	Banco de Referencia 2				*** PENDIENTE ***
	-- ================================================	
	--5	Banco de Referencia 3				*** PENDIENTE ***
	-- ================================================
	--6 - OBSERVACIONES
	-- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Observaciones
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		--, UTDS_VALUE  =   LEFT(CAB.OBSERVACIONES, 100)  
		, UTDS_VALUE  =   LEFT(LTRIM(RTRIM(REPLACE(REPLACE(CAB.OBSERVACIONES,CHAR(13), ' '),CHAR(10), ''))), 100)	--ELIMINA CARACFTERES EXTRAÑOS ANTES DEL VALOR RETORNADO
	FROM BACSWAPSUDA..CARTERA AS CAB
	WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 AND 
		NOT LTRIM(CAB.OBSERVACIONES) = ''
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	  --AND CAB.FECHA_CIERRE=@FECHA 
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID      =  @Observaciones
		, TRAN_ID     =  CAB.CANUMOPER 
		--, UTDS_VALUE  =   LEFT(CAB.CAOBSERV, 100)  
		, UTDS_VALUE  =   LEFT(LTRIM(RTRIM(REPLACE(REPLACE(CAB.CAOBSERV,CHAR(13),' '),CHAR(10),''))), 100)			----ELIMINA CARACFTERES EXTRAÑOS ANTES DEL VALOR RETORNADO
	FROM BACFWDSUDA..MFCA AS CAB  
	WHERE  --CAFECHA=@FECHA_FWD AND 
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P') AND
		NOT LTRIM(CAB.CAOBSERV) = ''

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Observaciones
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		--, UTDS_VALUE  =   LEFT(CAB.OBSERVACIONES, 100)  
		, UTDS_VALUE  =   LEFT(LTRIM(RTRIM(REPLACE(REPLACE(CAB.OBSERVACIONES,CHAR(13), ' '),CHAR(10), ''))), 100)	--ELIMINA CARACFTERES EXTRAÑOS ANTES DEL VALOR RETORNADO
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB
	WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 AND 
		NOT LTRIM(CAB.OBSERVACIONES) = ''
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	  --AND CAB.FECHA_CIERRE=@FECHA 
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS
	

	-- ================================================
	--7   Codigo IDD					*** PENDIENTE ***
	-- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Codigo_IDD
		, TRAN_ID     =  CAB.NOPERACION
		, UTDS_VALUE  =  CAB.NNUMEROIDD
	FROM BACLINEAS..Transacciones_IDD AS CAB
	--WHERE CAB.CMODULO IN ('PCS','BFW','BCC') AND FECHA=@FECHA_SWP
	--WHERE CAB.CMODULO IN ('PCS','BFW','OPT') AND FECHA=@FECHA_SWP
	WHERE CAB.CMODULO IN ('PCS','BFW') AND FECHA=@FECHA_SWP

	--8   Mda Ref
	-- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Mda_Ref
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  A.TBGLOSA
	FROM BACSWAPSUDA..CARTERA AS CAB
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON A.TBCATEG = 75 AND A.TBCODIGO1 = (CASE WHEN modalidad_pago = 'E' THEN COMPRA_MONEDA ELSE RECIBIMOS_MONEDA END )
	WHERE CAB.COMPRA_CODIGO_TASA <> 0 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			and CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
     --AND CAB.FECHA_CIERRE=@FECHA 


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Mda_Ref
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  A.TBGLOSA
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON A.TBCATEG = 75 AND A.TBCODIGO1 = (CASE WHEN modalidad_pago = 'E' THEN COMPRA_MONEDA ELSE RECIBIMOS_MONEDA END )
	WHERE CAB.COMPRA_CODIGO_TASA <> 0 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FECHAANTICIPO = @FECHA_SWP
     --AND CAB.FECHA_CIERRE=@FECHA 
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS



	---- ================================================
	----11  Codigo Unico					*** PENDIENTE ***
	---- ================================================
	----12  Fecha Hora
	---- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Fecha_Hora
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CONVERT(CHAR(20),CAB.FECHA_CIERRE + ' ' + CAB.HORA ,120)
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	--AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID     =  @Fecha_Hora
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  CONVERT(CHAR(20),CAB.CAFECHA + ' ' + CAB.CAHORA  ,120)
	FROM BACFWDSUDA..MFCA AS CAB 
	--WHERE CAFECHA=@FECHA_FWD
	WHERE NOT LTRIM(RTRIM(caestado)) IN('A', 'P')


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Fecha_Hora
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CONVERT(CHAR(20),CAB.FECHA_CIERRE + ' ' + CAB.HORA ,120)
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	---- ================================================
	----13  ModalidadPago
	---- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @ModalidadPago
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	--AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID     =  @ModalidadPago
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  CASE CAB.CATIPMODA WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
	FROM BACFWDSUDA..MFCA AS CAB 
	--	 WHERE CAFECHA=@FECHA _FWD
	WHERE 
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P') 
	
	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @ModalidadPago
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	---- ================================================	
	----14  Canal Transaccional
	---- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Canal_Transaccional
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  B.TBGLOSA
	FROM BACSWAPSUDA..CARTERA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE AS B ON B.TBCATEG  = 204  
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1
		AND B.TBCODIGO1 =  CAB.CARTERA_INVERSION  
				and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
				AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	 --AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID     =  @Canal_Transaccional
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  B.TBGLOSA
	FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE AS B ON B.TBCATEG  = 204  
	WHERE 
		B.TBCODIGO1 =  CAB.CACODCART AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')		
	 --AND  CAFECHA=@FECHA_FWD

	 -->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Canal_Transaccional
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  B.TBGLOSA
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE AS B ON B.TBCATEG  = 204  
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1
		AND B.TBCODIGO1 =  CAST(CAB.CARTERA_INVERSION  AS NUMERIC)
				and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
				AND CAB.FECHAANTICIPO = @FECHA_SWP
	 --<<CVM.20211105 SIID FLUJOS ANTICIPADOS
	 
	---- ================================================	
	----15  Medio Transaccional
	---- ================================================	
	/*
    INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
    SELECT UDT_ID     =  @Medio_Transaccional
         , TRAN_ID     =  CAB.MONUMOPE
         , UTDS_VALUE  =  MOTERM
      FROM BACCAMSUDA..MEMO AS CAB 	
	 WHERE CAB.MOESTATUS <> 'A'  AND MOFECH=@FECHA_FWD
	 */
	 
	---- ================================================	
	----16  Especialista
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT UDT_ID     =  @Especialista
		, TRAN_ID     =  NUMERO_OPERACION 
		, UTDS_VALUE  =  A.TBGLOSA
	FROM BACSWAPSUDA..CARTERA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE AS A ON A.TBCATEG = 1553 
	WHERE CAB.CAR_AREA_RESPONSABLE = A.TBCODIGO1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
		--AND CAB.FECHA_CIERRE=@FECHA 
	UNION  
	SELECT DISTINCT UDT_ID     =  @Especialista
		, TRAN_ID     =  canumoper
		, UTDS_VALUE  =  TBGLOSA
	FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE AS A ON A.TBCATEG = 1553 
	WHERE 
		CAB.CAAREA_RESPONSABLE = A.TBCODIGO1 AND  
	--CAFECHA=@FECHA 
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P') 

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT UDT_ID     =  @Especialista
		, TRAN_ID     =  NUMERO_OPERACION 
		, UTDS_VALUE  =  A.TBGLOSA
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE AS A ON A.TBCATEG = 1553 
	WHERE CAB.CAR_AREA_RESPONSABLE = A.TBCODIGO1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FECHAANTICIPO = @FECHA_SWP
	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS


	---- ================================================	
	----17  Horario Especial
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Horario_Especial
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  'PAGO HOY'
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	--AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID     =  @Horario_Especial
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  'PAGO HOY'
	FROM BACFWDSUDA..MFCA AS CAB 
--	 WHERE  CAFECHA=@FECHA 
	WHERE 
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Horario_Especial
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  'PAGO HOY'
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	---- ================================================	
	----18  Sucursal					*** PENDIENTE ***
	---- ================================================	
	---- ================================================	
	----19  Indicador FX
	---- ================================================	
--    INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
--    SELECT UDT_ID     =  @Indicador_FX
--         , TRAN_ID     =  CAB.MONUMOPE
--         , UTDS_VALUE  =  MOTERM
--      FROM BACCAMSUDA..MEMOh AS CAB 	
--	 WHERE CAB.MOESTATUS <> 'A'
--	   AND MOTERM in ('OPCIONES','SWAP','FORWARD','UNWIND') AND MOFECH=@FECHA 

	---- ================================================	
	----0   Nombre Cliente
	---- ================================================	
	/*
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT UDT_ID     =  @Nombre_Cliente
		, TRAN_ID     =  CAB.MONUMOPE
		, UTDS_VALUE  =  C.CLNOMBRE 
	FROM BACCAMSUDA..MEMOH AS CAB 	
		INNER JOIN BACPARAMSUDA..CLIENTE AS C ON C.CLRUT= CAB.MORUTCLI AND C.CLCODIGO = CAB.MOCODCLI
	WHERE CAB.MOESTATUS <> 'A'
		AND MOTERM IN ('OPCIONES','SWAP','FORWARD','UNWIND') AND MOFECH=@FECHA_SWP
	*/	

	------ ================================================	
	------26  Numero Operacion
	------ ================================================	
 --   INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
 --   SELECT UDT_ID     =  26
 --        , TRAN_ID     =  CAB.MONUMOPE
 --        , UTDS_VALUE  =  MONUMFUT
 --     FROM BACCAMSUDA..MEMOH AS CAB 	
	-- WHERE CAB.MOESTATUS <> 'A'
	--   AND MOTERM in ('OPCIONES','SWAP','FORWARD','UNWIND') AND MOFECH=@FECHA 

	---- ================================================	
	----27  Usuario Operacion
	---- ================================================	
	/*
    INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
    SELECT UDT_ID     =  @Usuario_Operacion
         , TRAN_ID     =  CAB.MONUMOPE
         , UTDS_VALUE  =  MOOPER
    FROM BACCAMSUDA..MEMOH AS CAB 	
	 WHERE CAB.MOESTATUS <> 'A'
	   AND MOTERM in ('OPCIONES','SWAP','FORWARD','UNWIND') AND MOFECH=@FECHA_SWP
	*/
	---- ================================================	

	----28  Data Hora					*** PENDIENTE ***
	---- ================================================	
	----29  ID Cliente
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
	       UDT_ID      =  @ID_Cliente
	     , TRAN_ID     =  CAB.NUMERO_OPERACION
         , UTDS_VALUE  =  C.CODIGO_AS400
	FROM BACSWAPSUDA..CARTERA AS CAB
	INNER JOIN BACPARAMSUDA..CLIENTE AS C ON C.CLRUT= CAB.RUT_CLIENTE AND C.CLCODIGO = CAB.CODIGO_CLIENTE
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
     --AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID      =  @ID_Cliente
		, TRAN_ID     =  CAB.CANUMOPER 
		, UTDS_VALUE  =  C.CODIGO_AS400
	FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..CLIENTE AS C ON C.CLRUT= CAB.CACODIGO AND C.CLCODIGO = CAB.CACODCLI
--   WHERE  CAFECHA=@FECHA 
	WHERE
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P') 

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
	       UDT_ID      =  @ID_Cliente
	     , TRAN_ID     =  CAB.NUMERO_OPERACION
         , UTDS_VALUE  =  C.CODIGO_AS400
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB
	INNER JOIN BACPARAMSUDA..CLIENTE AS C ON C.CLRUT= CAB.RUT_CLIENTE AND C.CLCODIGO = CAB.CODIGO_CLIENTE
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	---- ================================================	
	----30  Tipo CC
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Tipo_CC
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  'COBERTURA'
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1
		AND car_Cartera_Normativa = 'C'  
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	--AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID     =  @Tipo_CC
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  'COBERTURA'
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE 
		cacartera_normativa='C' AND --CAFECHA=@FECHA 
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	 

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Tipo_CC
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  'COBERTURA'
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1
		AND car_Cartera_Normativa = 'C'  
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	
	---- ================================================		
	----31  Estrategia CC
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Estrategia_CC
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  C.TBGLOSA
	FROM BACSWAPSUDA..CARTERA AS CAB 
		INNER JOIN bacparamsuda..tabla_general_detalle AS C ON C.tbcateg = 1554 AND C.TBCODIGO1 = CAB.car_SUBCartera_Normativa 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1
		AND car_Cartera_Normativa = 'C' 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	--AND CAB.FECHA_CIERRE=@FECHA 
	UNION 
	SELECT UDT_ID     =  @Estrategia_CC
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  C.TBGLOSA
	FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN bacparamsuda..tabla_general_detalle AS C ON 
			C.tbcateg = 1554 AND C.TBCODIGO1 = CAB.cASUBCartera_Normativa 
	WHERE 
		cacartera_normativa='C' AND --CAFECHA=@FECHA 
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	
	
	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Estrategia_CC
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  C.TBGLOSA
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN bacparamsuda..tabla_general_detalle AS C ON C.tbcateg = 1554 AND C.TBCODIGO1 = CAB.car_SUBCartera_Normativa 
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1
		AND car_Cartera_Normativa = 'C' 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	---- ================================================	
	----33  ET Next Period				*** PENDIENTE ***
	----34  Tipo ET						*** PENDIENTE ***
	----35  Rounding Method				*** PENDIENTE ***
	----36  Tipo_LoadDep					*** PENDIENTE ***
	
	---- ================================================	
	----37  Modalidad de Pago FX	--Fwd	Corresponde a la modalidad de pago en el fwd, esto es; Comp USD, Comp CLP o Entrega Fisica.
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @Modalidad_de_Pago_FX_Fwd
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN 'COMPENSACION ' + PAG.TBGLOSA ELSE 'ENTREGA FISICA' END 
	FROM BACSWAPSUDA..CARTERA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON PAG.TBCATEG = 75 AND PAG.TBCODIGO1 = (CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN RECIBIMOS_MONEDA ELSE PAGAMOS_MONEDA END )
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	 --AND CAB.FECHA_CIERRE=@FECHA 
   UNION 
   SELECT UDT_ID     =  @Modalidad_de_Pago_FX_Fwd
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  CASE CAB.CATIPMODA WHEN 'C' THEN 'COMPENSACION ' + PAG.TBGLOSA ELSE 'ENTREGA FISICA' END 
   FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON PAG.TBCATEG = 75 AND PAG.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON2 ELSE moneda_compensacion END )
	--WHERE  CAFECHA=@FECHA 
	WHERE
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	
	
	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @Modalidad_de_Pago_FX_Fwd
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN 'COMPENSACION ' + PAG.TBGLOSA ELSE 'ENTREGA FISICA' END 
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON PAG.TBCATEG = 75 AND PAG.TBCODIGO1 = (CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN RECIBIMOS_MONEDA ELSE PAGAMOS_MONEDA END )
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	
	---- ================================================	
	----48  FX Fwd Multiplier				*** PENDIENTE ***
	----52  Cod_Pro						*** PENDIENTE ***
	----53  Cod_Sub_Pro					*** PENDIENTE ***
	----54  Num_Oper						*** PENDIENTE ***
	----55  Credito Relacionado			*** PENDIENTE ***
	----56  Ajuste Valuta					*** PENDIENTE ***
	----57  Glosa Causales				*** PENDIENTE ***
	---- ================================================	
	----58  Nro Transaccion ComDer		
	---- ================================================	
--	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
--	SELECT UDT_ID     =  58
--         , TRAN_ID     =  CAB.numero_operacion
--         , UTDS_VALUE  =  ID
--    FROM  BDBOMESA.dbo.COMDER_Solicitud AS CAB 
--    WHERE fecha_proceso=@fecha
 --   -- ================================================	
	----  Contraparte Original			
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT  UDT_ID      =  @Contraparte_Original
		  , TRAN_ID     =  CAB.monumoper
		  , UTDS_VALUE  =  c.clnombre
	FROM   BacFwdSuda..MFmo CAB                 with(nolock)
		INNER JOIN BDBOMESA.dbo.COMDER_RelacionMarcaComDer mc ON 
			mc.nReNumOper = cab.monumoper   
		INNER JOIN BacParamSuda..CLIENTE  C with(nolock) ON 
			mc.nReRutCliente = c.clrut AND 
			mc.nReCodCliente = c.clcodigo
	WHERE  cab.monumoper =  cab.monumoper AND mc.cReSistema = 'BFW'
		AND mc.iReNovacion = 1 AND mc.vReEstado = 'V' AND MOFECHA=@FECHA_FWD
	
	
	----60  Justificacion VR				*** PENDIENTE ***
	----61  Nro Bloomberg SEF				*** PENDIENTE ***
	----62  FCM							*** PENDIENTE ***
	----63  Tipo Garantias				*** PENDIENTE ***
	----64  Estado SEF					*** PENDIENTE ***
	----65  Codigo IDR					*** PENDIENTE ***
	----66  Toma Linea Puntual			*** PENDIENTE ***
	---- ================================================	
	----67  FX Fwd ET Tipo Term
	---- ================================================	
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @FX_Fwd_ET_Tipo_Term
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  'SIN ET'
	FROM BACSWAPSUDA..CARTERA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON 
			PAG.TBCATEG = 75 AND 
			PAG.TBCODIGO1 = (CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN RECIBIMOS_MONEDA ELSE PAGAMOS_MONEDA END )
	WHERE 
		CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID     =  @FX_Fwd_ET_Tipo_Term
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  'SIN ET'
   FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON 
			PAG.TBCATEG = 75 AND 
			PAG.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON2 ELSE moneda_compensacion END )
	WHERE  
	--	CAFECHA=@FECHA 	
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @FX_Fwd_ET_Tipo_Term
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  'SIN ET'
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON 
			PAG.TBCATEG = 75 AND 
			PAG.TBCODIGO1 = (CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN RECIBIMOS_MONEDA ELSE PAGAMOS_MONEDA END )
	WHERE 
		CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


---campos SIDD
--126-- Indica si la operación ingresada corresponde  a una adquisición por cesión.
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Adquisicion_por_cesion
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE WHEN SIID.Adquisicion_PorCesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'PCS' AND
		SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE 
		CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID     =  @Adquisicion_por_cesion
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  CASE WHEN SIID.Adquisicion_PorCesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'BFW' AND
		SIID.Operacion = CAB.CANUMOPER
	WHERE  
		--CAFECHA=@FECHA 	
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	UNION 
	SELECT UDT_ID     =  @Adquisicion_por_cesion
		, TRAN_ID     =  CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  =  CASE WHEN SIID.Adquisicion_PorCesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	--WHERE  CAFECHA=@FECHA 	
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS---KJKJI
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Adquisicion_por_cesion
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE WHEN SIID.Adquisicion_PorCesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'PCS' AND
		SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE 
		CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS


--127;   --Indica el tipo de modificación que se esta realizando

	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Tipo_de_Modificacion
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  SIID.Tipo_Modificacion
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'PCS' AND
		SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID     =  @Tipo_de_Modificacion
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  SIID.Tipo_Modificacion
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'BFW' AND
		SIID.Operacion = CAB.CANUMOPER
	WHERE  
		CAFECHA=@FECHA_FWD AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	UNION 
	SELECT UDT_ID     =  @Tipo_de_Modificacion
		, TRAN_ID     =  CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  =  SIID.Tipo_Modificacion
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Tipo_de_Modificacion
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  SIID.Tipo_Modificacion
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'PCS' AND
		SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


--	128;   --Indica si el termino de la operación es debido a un Cesión del contrato
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Termino_por_Cesion 
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE WHEN SIID.Termino_Cesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'PCS' AND
		SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID     =  @Termino_por_Cesion 
		, TRAN_ID     =  CAB.CANUMOPER
		, UTDS_VALUE  =  CASE WHEN SIID.Termino_Cesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'BFW' AND
		SIID.Operacion = CAB.CANUMOPER
	--WHERE  CAFECHA=@FECHA_FWD
	WHERE
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	UNION 
	SELECT UDT_ID    =  @Termino_por_Cesion
		, TRAN_ID     =  CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  =  CASE WHEN SIID.Termino_Cesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
		 UDT_ID      =  @Termino_por_Cesion 
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =  CASE WHEN SIID.Termino_Cesion = 'Y' THEN 'Yes' ELSE 'No' END
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
		SIID.Sistema = 'PCS' AND
		SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


--	135;   --RUT de la Contraparte que cede (evento suscripción “Adquisición por Cesión”, evento de modificación “Modificación de Contraparte por Cesión”) o a la que se cede (evento término por “Cesión”) un Contrato
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @RUT_del_Cedente_o_Cesionario
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  SIID.Rut_Cedente
   FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
	 WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  AND
			NOT LTRIM(SIID.Rut_Cedente) = ''
		and estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
    UNION 
    SELECT UDT_ID      = @RUT_del_Cedente_o_Cesionario
         , TRAN_ID     = CAB.CANUMOPER
         , UTDS_VALUE  = SIID.Rut_Cedente
      FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'BFW' AND
			SIID.Operacion = CAB.CANUMOPER
	 WHERE  --CAFECHA=@FECHA 	AND
			NOT LTRIM(SIID.Rut_Cedente) = ''
	UNION 
	SELECT UDT_ID    = @RUT_del_Cedente_o_Cesionario
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  = SIID.Rut_Cedente
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @RUT_del_Cedente_o_Cesionario
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  SIID.Rut_Cedente
   FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
	 WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  AND
			NOT LTRIM(SIID.Rut_Cedente) = ''
		and estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


--138;   --Identifica si el nuevo Contrato o el término anticipado de uno previamente informado es resultado de una compresión u optimización de cartera
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @Compresion_de_Cartera 
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  CASE WHEN monto_mtm = 0 THEN 'No' ELSE 'Yes' END--cvm20211223--CASE WHEN SIID.Comprension_Cartera = 'N' THEN 'No' ELSE 'Yes' END
   FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID     =  @Compresion_de_Cartera 
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDS_VALUE  =  CASE WHEN SIID.Comprension_Cartera = 'N' THEN 'No' ELSE 'Yes' END
   FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'BFW' AND
			SIID.Operacion = CAB.CANUMOPER
	 --WHERE  CAFECHA=@FECHA
	WHERE
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P') 
	UNION 
	SELECT UDT_ID    = @Compresion_de_Cartera
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  = CASE WHEN SIID.Comprension_Cartera = 'N' THEN 'No' ELSE 'Yes' END
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @Compresion_de_Cartera 
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  CASE WHEN monto_mtm = 0 THEN 'No' ELSE 'Yes' END--cvm20211223--CASE WHEN SIID.Comprension_Cartera = 'N' THEN 'No' ELSE 'Yes' END
   FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	--139;   --Código de la Plataforma de Negociación en la cual fue pactado el contrato de derivado, según código MIC (Market Identifier Code) de la norma ISO 10383. En el caso que el contrato fuese negociado fuera de Bolsa, se deberá indicar en este campo el código “OTC
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @Plataforma_de_Negociacion 
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  SIID.Plataforma
   FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
--		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON PAG.TBCATEG = 75 AND PAG.TBCODIGO1 = (CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN RECIBIMOS_MONEDA ELSE PAGAMOS_MONEDA END )
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	UNION 
	SELECT UDT_ID     =  @Plataforma_de_Negociacion 
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDS_VALUE  =  SIID.Plataforma
   FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'BFW' AND
			SIID.Operacion = CAB.CANUMOPER
--    INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON PAG.TBCATEG = 75 AND PAG.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON2 ELSE moneda_compensacion END )
	 --WHERE  CAFECHA=@FECHA
	WHERE 	
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
	UNION 
	SELECT UDT_ID    = @Plataforma_de_Negociacion
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  = SIID.Plataforma
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @Plataforma_de_Negociacion 
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  SIID.Plataforma
   FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
--		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE PAG ON PAG.TBCATEG = 75 AND PAG.TBCODIGO1 = (CASE CAB.MODALIDAD_PAGO WHEN 'C' THEN RECIBIMOS_MONEDA ELSE PAGAMOS_MONEDA END )
	WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1 
	and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


--	140;   --RUT del Intermediario (Broker) que actuó como intermediario en el cierre de la operación.  
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @RUT_Intermediario
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  SIID.RUT_Intermediario
   FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
	 WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  AND
			NOT LTRIM(SIID.RUT_Intermediario) = ''
		and estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
    UNION 
    SELECT UDT_ID     =  @RUT_Intermediario
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDS_VALUE  =  SIID.RUT_Intermediario
      FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'BFW' AND
			SIID.Operacion = CAB.CANUMOPER
	 WHERE  --CAFECHA=@FECHA 	AND
			NOT LTRIM(RTRIM(caestado)) IN('A', 'P') AND
			NOT LTRIM(SIID.RUT_Intermediario) = ''
	UNION 
	SELECT UDT_ID    = @RUT_Intermediario
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  = SIID.RUT_Intermediario
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING
	SELECT DISTINCT 
       UDT_ID      =  @RUT_Intermediario
      , TRAN_ID     =  CAB.NUMERO_OPERACION
      , UTDS_VALUE  =  SIID.RUT_Intermediario
   FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION
	 WHERE CAB.TIPO_FLUJO  = 1 AND CAB.ESTADO_FLUJO = 1  AND
			NOT LTRIM(SIID.RUT_Intermediario) = ''
		and estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"TRAN_ID" = TRAN_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"UDT_ID" = UDT_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
				LTRIM(UDT_ID)          + @SEP
          + LTRIM(TRAN_ID)         + @SEP
          + RTRIM(LTRIM(UTDS_VALUE))
       FROM #VM_BAC_USER_TRAN_DEF_STRING
--      ORDER BY TRAN_ID, UDT_ID	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_TRAN_DEF_STRING_SALIDA
		SELECT 
			"TRAN_ID" = -999,
			"UDT_ID" = -999,
			"REG_SALIDA" = 'UDT_ID'          + @SEP
							 + 'TRAN_ID'         + @SEP
							 + 'UTDS_VALUE' 
		WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_USER_TRAN_DEF_STRING_SALIDA 
	--WHERE TRAN_ID = 756--AQUI
	ORDER BY TRAN_ID, UDT_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

--SELECT * FROM #VM_BAC_USER_TRAN_DEF_STRING WHERE TRAN_ID IN(756, 618540) ORDER BY TRAN_ID, UDT_ID

	DROP TABLE #VM_BAC_USER_TRAN_DEF_STRING
	DROP TABLE #VM_BAC_USER_TRAN_DEF_STRING_SALIDA

END 
GO
