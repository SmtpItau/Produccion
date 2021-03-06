USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_USER_TRAN_DEF_INTEGER]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IF OBJECT_ID('SP_VM_BAC_USER_TRAN_DEF_INTEGER')>0	
--	DROP PROCEDURE DBO.SP_VM_BAC_USER_TRAN_DEF_INTEGER
--GO

-- =============================================
-- Author:			SONDA S.A.
-- Create date:	30-09-2020
-- Description:	INTERFAZ VMETRIX USER_TRAN_DEF_INTEGER
-- =============================================


--EXEC SP_VM_BAC_USER_TRAN_DEF_INTEGER
CREATE PROC [dbo].[SP_VM_BAC_USER_TRAN_DEF_INTEGER]
AS BEGIN 
--BEGIN TRAN

SET NOCOUNT ON 

--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA 
CREATE TABLE #VM_BAC_USER_TRAN_DEF_INTEGER_SALIDA
(
	TRAN_ID           Int,		--PARA COMPATIBILIDAD DE SALIDA
	UDT_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

CREATE TABLE #VM_BAC_USER_TRAN_DEF_INTEGER
            ( UDT_ID      INT
            , TRAN_ID     INT
            , UTDI_VALUE  BIGINT)
            
 
DECLARE @SEP    VARCHAR(1); SET @SEP   = ',';
DECLARE @FECHA  DATETIME ;	SET @FECHA = ISNULL((SELECT acfecproc FROM BACFWDSUDA..MFAC), '');
DECLARE @Con_Linea_Encabezado VARCHAR(1);    SET @Con_Linea_Encabezado = 'Y'	-- PLL-20200512

DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

--*** UDT_ID ***
DECLARE @Numero_Operacion AS INT; SET @Numero_Operacion = 26;   --Indica el numero de operación del sistema origen, aplica para migración de carteras.
DECLARE @ID_Contraparte_Original AS INT; SET @ID_Contraparte_Original = 113;   
	--Corresponde al rut sin digito verificador y adicionando la secuencia si es un fondo, de la contraparte original de la transacción, 
	--aplica para operaciones Fx Spot origen CMX o eCambios.
	--Para forward aplica en los casos en que la operación es novada hacia una contraparte central (Comder)."
DECLARE @ID_Migracion AS INT; SET @ID_Migracion = 114;   
	--Corresponde al Id asignado a cada sistema de origen, este para las operaciones migradas a Murex desde los sistemas Findur, Bac y Turing SAO.
	--Los codigos seran:
	--		2 = Operaciones migradas desde Findur a Murex
	--		3= Operaciones Origen nativo Murex
	--	  *4= Operaciones migradas desde Bac a Murex
	--		6= Operaciones migradas de Turing SAO a Murex
DECLARE @Clausula_de_Termino_Anticipado AS INT; SET @Clausula_de_Termino_Anticipado = 137;   
	--Indicar si la operación fue pactada o no con cláusula de término (ya sea obligatoria o voluntaria) y exigibilidad anticipada de obligaciones para la Contraparte 1, Contraparte 2, o cualquiera de las partes
	--1 CO1: A favor de la Contraparte 1, con liquidación
	--2 C1S: A favor de la Contraparte 1, sin liquidación
	--3 CO2: A favor de la Contraparte 2, con liquidación
	--4 C2S: A favor de la Contraparte 2, sin liquidación
	--5 AMP: Opcional ambas partes, con liquidación
	--6 AMS: Opcional ambas partes, sin liquidación
	--7 NOT: Sin cláusula de término anticipado 


--***	De/Para	Clausula_de_Termino_Anticipado ***
SELECT "mu_ClaTerAnt" = 1, "Cod_BAC" = 'CO1' INTO #PasoClaTerAnt UNION
SELECT "mu_ClaTerAnt" = 2, "Cod_BAC" = 'C1S' UNION
SELECT "mu_ClaTerAnt" = 3, "Cod_BAC" = 'CO2' UNION
SELECT "mu_ClaTerAnt" = 4, "Cod_BAC" = 'C2S' UNION
SELECT "mu_ClaTerAnt" = 5, "Cod_BAC" = 'AMP' UNION
SELECT "mu_ClaTerAnt" = 6, "Cod_BAC" = 'AMS' UNION
SELECT "mu_ClaTerAnt" = 7, "Cod_BAC" = 'NOT' 
--SELECT * FROM #PasoClaTerAnt

	--SET @FECHA = '2020-07-29'
	--SELECT @FECHA
	
   --===================================================
   --	SWAP
   --===================================================
   INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @Numero_Operacion
		, TRAN_ID	 = CAB.NUMERO_OPERACION
      , UTDI_VALUE = CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	and CAB.estado			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @Numero_Operacion
		, TRAN_ID	 = CAB.NUMERO_OPERACION
      , UTDI_VALUE = CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>NO APLICA FUE DESCARTADO TOP 0 			
   INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT TOP 0
       UDT_ID		 = @ID_Contraparte_Original
		, TRAN_ID	 = CAB.NUMERO_OPERACION
      --, UTDI_VALUE = CAB.rut_cliente
      , UTDI_VALUE = /*SUBSTRING(CAST(CL.clrut AS VARCHAR(12)), 1, 35) +		--+ CAST(CL.CLDV AS VARCHAR(12))
							(CASE WHEN (SELECT COUNT(1) FROM bacparamsuda..cliente cl2 
											WHERE cl2.clrut = CL.clrut --AND 
												--cl2.clvigente = 'S' AND 
												--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('MALO_%') AND
												--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%') 
											GROUP BY cl2.clrut) > 1 
							THEN (LTRIM(RTRIM(cl.secuencia)))--LTRIM(RTRIM(cl.clcodigo))
						ELSE ''
						END)*/
						SUBSTRING(CAST(CL.CLRUT AS VARCHAR(12)), 1, 35) 
								+ CASE WHEN CL.SECUENCIA = 0 THEN '' ELSE CAST(cl.secuencia AS VARCHAR(9)) END
								
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN bacparamsuda..CLIENTE AS CL ON
		CL.clrut = CAB.rut_cliente AND
		CL.CLCODIGO = CAB.codigo_cliente
	WHERE 
		CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
   
  

   INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
		SELECT DISTINCT 
	       UDT_ID		 = @ID_Migracion
			, TRAN_ID	 = CAB.NUMERO_OPERACION
         , UTDI_VALUE = 4							--4= Operaciones migradas desde Bac a Murex
		FROM BACSWAPSUDA..CARTERA AS CAB 
		WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and CAB.estado			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	 INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
		SELECT DISTINCT 
			UDT_ID		 = @ID_Migracion
			, TRAN_ID	 = CAB.NUMERO_OPERACION
			, UTDI_VALUE = 4							--4= Operaciones migradas desde Bac a Murex
		FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


   --137;   Indicar si la operación fue pactada o no con cláusula de término (ya sea obligatoria o voluntaria) y exigibilidad anticipada de obligaciones para la Contraparte 1, Contraparte 2, o cualquiera de las partes
   INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @Clausula_de_Termino_Anticipado
		, TRAN_ID	 = CAB.NUMERO_OPERACION
      , UTDI_VALUE = CT.mu_ClaTerAnt							
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION 
		INNER JOIN #PasoClaTerAnt AS CT ON
			CT.Cod_BAC = SIID.Termino_Anticipado
	WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1  
   and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
   and CAB.estado			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
   
   -->>CVM.20211105 SIID FLUJOS ANTICIPADOS
   INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @Clausula_de_Termino_Anticipado
		, TRAN_ID	 = CAB.NUMERO_OPERACION
      , UTDI_VALUE = CT.mu_ClaTerAnt							
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'PCS' AND
			SIID.Operacion = CAB.NUMERO_OPERACION 
		INNER JOIN #PasoClaTerAnt AS CT ON
			CT.Cod_BAC = SIID.Termino_Anticipado
	WHERE CAB.TIPO_FLUJO = 1 AND CAB.ESTADO_FLUJO = 1  
   and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
   and cab.FechaAnticipo = @FECHA_SWP
   --<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	--===================================================
	--	FORWARD
	--===================================================
	--Indica el numero de operación del sistema origen, aplica para migración de carteras.
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @Numero_Operacion
		, TRAN_ID	 = CAB.CANUMOPER
      , UTDI_VALUE = CAB.CANUMOPER
	FROM bacfwdsuda..mfca AS CAB 
	WHERE
--		CAFECHA=@FECHA 
		LTRIM(RTRIM(caestado)) IN('A', 'P')

	--Indica el numero de operación del sistema origen, aplica para migración de carteras.
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT   
       UDT_ID		 = @ID_Contraparte_Original
		 ,TRAN_ID	 = CAB.CANUMOPER
--         , UTDI_VALUE = CAB.cacodigo
      , UTDI_VALUE = /*SUBSTRING(
							CAST(CL.clrut AS VARCHAR(12)), 1, 35) +		--+ CAST(CL.CLDV AS VARCHAR(12))
							(CASE WHEN (SELECT COUNT(1) FROM bacparamsuda..cliente cl2 
											WHERE cl2.clrut = CL.clrut AND 
												cl2.clvigente = 'S' AND 
												LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('MALO_%') AND
												LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%') 
											GROUP BY cl2.clrut) > 1 
							THEN (LTRIM(RTRIM(cl.secuencia)))--LTRIM(RTRIM(cl.clcodigo))
						ELSE ''
						END)*/
						SUBSTRING(CAST(CL.CLRUT AS VARCHAR(12)), 1, 35) 
								+ CASE WHEN CL.SECUENCIA = 0 THEN '' ELSE CAST(cl.secuencia AS VARCHAR(9)) END
	/*							
	FROM bacfwdsuda..mfca AS CAB 
	INNER JOIN bacparamsuda..CLIENTE AS CL ON CL.clrut = CAB.cacodigo 
													AND	CL.CLCODIGO = CAB.cacodcli
	*/												
	FROM BacFwdSuda..mfca										CAB with(nolock)
	INNER JOIN BDBOMESA.dbo.COMDER_RelacionMarcaComDer mc					ON mc.nReNumOper	= cab.canumoper  
																						AND	mc.cReSistema	= 'BFW'
																						AND	mc.iReNovacion = 1 
																						AND	mc.vReEstado	= 'V'
	INNER JOIN BacParamSuda..CLIENTE							Cl with(nolock) ON mc.nReRutCliente	= cl.clrut 
																						AND	mc.nReCodCliente	= cl.clcodigo	
														
--	WHERE 
--		CAFECHA=@FECHA 


	--114;   Indica el numero de operación del sistema origen, aplica para migración de carteras.
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @ID_Migracion
		, TRAN_ID	 = CAB.CANUMOPER
      , UTDI_VALUE = 4					--4= Operaciones migradas desde Bac a Murex
	FROM bacfwdsuda..mfca AS CAB 
	WHERE
		LTRIM(RTRIM(caestado)) IN('A', 'P')

	--137;   Indicar si la operación fue pactada o no con cláusula de término (ya sea obligatoria o voluntaria) y exigibilidad anticipada de obligaciones para la Contraparte 1, Contraparte 2, o cualquiera de las partes
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT 
       UDT_ID		 = @Clausula_de_Termino_Anticipado
		, TRAN_ID	 = CAB.CANUMOPER
      , UTDI_VALUE = CT.mu_ClaTerAnt
	FROM bacfwdsuda..mfca AS CAB INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'BFW' AND
			SIID.Operacion = CAB.CANUMOPER
		INNER JOIN #PasoClaTerAnt AS CT ON
			CT.Cod_BAC = SIID.Termino_Anticipado
	UNION 
	SELECT UDT_ID    = @Clausula_de_Termino_Anticipado
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  = CT.mu_ClaTerAnt
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
		INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
		INNER JOIN #PasoClaTerAnt AS CT ON
			CT.Cod_BAC = SIID.Termino_Anticipado
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113


	--===================================================
	--	OPCIONES
	--===================================================
	--114;   Indica el numero de operación del sistema origen, aplica para migración de carteras.
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT DISTINCT --TOP 0 
       UDT_ID		 = @ID_Migracion
		, TRAN_ID	 = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
      , UTDI_VALUE = 4					--4= Operaciones migradas desde Bac a Murex
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113
		
	--137;   Indicar si la operación fue pactada o no con cláusula de término (ya sea obligatoria o voluntaria) y exigibilidad anticipada de obligaciones para la Contraparte 1, Contraparte 2, o cualquiera de las partes
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER
	SELECT UDT_ID    = @Clausula_de_Termino_Anticipado
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, UTDS_VALUE  = CT.mu_ClaTerAnt
	FROM CbMdbOpc..CaEncContrato AS CAB INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = CAB.CanumContrato 
		INNER JOIN BacLineas.dbo.SIID AS SIID ON
			SIID.Sistema = 'OPT' AND
			SIID.Operacion = CAB.CanumContrato
		INNER JOIN #PasoClaTerAnt AS CT ON
			CT.Cod_BAC = SIID.Termino_Anticipado
	WHERE
		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113

	
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"TRAN_ID" = TRAN_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"UDT_ID" = UDT_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
				LTRIM(UDT_ID)          + @SEP
          + LTRIM(TRAN_ID)         + @SEP
          + LTRIM(UTDI_VALUE)	AS REG_SALIDA 
       FROM #VM_BAC_USER_TRAN_DEF_INTEGER
     -- ORDER BY TRAN_ID, UDT_ID	-- se comenta porque no es necesario a este nivel-- PLL-20200512--AQUI 

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_TRAN_DEF_INTEGER_SALIDA
		SELECT 
			"TRAN_ID" = -999,
			"UDT_ID" = -999,
			"REG_SALIDA" = 'UDT_ID'          + @SEP
							 + 'TRAN_ID'         + @SEP
							 + 'UTDI_VALUE' 
		WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_USER_TRAN_DEF_INTEGER_SALIDA
	--WHERE TRAN_ID = 756--AQUI
	ORDER BY TRAN_ID, UDT_ID--AQUI

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

--SELECT * FROM #VM_BAC_USER_TRAN_DEF_INTEGER ORDER BY TRAN_ID, UDT_ID

	DROP TABLE #VM_BAC_USER_TRAN_DEF_INTEGER
	DROP TABLE #VM_BAC_USER_TRAN_DEF_INTEGER_SALIDA

END
--ROLLBACK TRAN
GO
