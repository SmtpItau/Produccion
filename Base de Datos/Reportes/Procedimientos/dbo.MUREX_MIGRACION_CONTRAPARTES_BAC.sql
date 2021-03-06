USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[MUREX_MIGRACION_CONTRAPARTES_BAC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC MUREX_MIGRACION_CONTRAPARTES_BAC
create PROCEDURE [dbo].[MUREX_MIGRACION_CONTRAPARTES_BAC]
AS BEGIN 

--*** GENERADOR DE INTERFAZ MUREX CONTRAPARTES							***
--*** CONTRAPARTES v7															***
--*** basado en el documento "Contrapartes_Murex_V4 - BQP.xlsx"	***
--*** 19/02/2020																	***
--20200325 - se incluye la restricción de que los clientes hayan tenido movimientos desde el 01/01/2019
--20200331 - se incluyen campos faltantes
--20200619 - se incluye campo SWIFT
--20200725 - se incluyen corresponsales (#PasoCorresponsales)

--*** CREA FUNCION TEMPORAL DE CONSULTA DE APODERADOS ***




---*********  FILTRO DE CONTRAPARTES PARA PRUEBAS  *********
--acota cantidad de clientes para asociarlos a salida de archivo de operaciones
-- comentar si se requiere 

--SELECT top 0 clRut = 90227000, clCodCli = 1 into #tmpClientes --UNION
/*SELECT 92844000, 1 UNION
SELECT 76323080, 1
*/

	SELECT DISTINCT 
		Clrut	,
		Cldv	,
		"clCodCli" = Clcodigo,
		Clnombre,
		"ENABLE_SPT" = 0,
		"ENABLE_FWD" = 1,
		"ENABLE_OPT" = 0, 
		"ENABLE_SWP" = 0
	INTO #tmpClientes_desglosado
	FROM 
		Bacfwdsuda..MFCARES AS FWD INNER JOIN  BacParamSuda..CLIENTE AS CL ON
			CL.CLRUT = FWD.cacodigo AND
			CL.CLCODIGO = FWD.cacodcli
	WHERE 
		NOT CL.clvigente = 'N' AND
		(LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%MALO_%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NULO_%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE ELIMINADO%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE BLOQUEADO%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO UTILIZAR%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%')) AND
		--FWD.CAESTADO <> 'A'
		CaFechaProceso >= '20190101' and 
		CAFECHA >= '20180101' --AND '20201201' --OR
		--Clfecingr BETWEEN '20190101' AND '20191231'
	--	cafecvcto >= '20190101')
	--ORDER BY CLRUT, clcodigo 
	--order by
	--	4 
	UNION
	--CLIENTES SAO MOVIMIENTOS
		SELECT DISTINCT --top 10 
		--	SAO.MoRutCliente, SAO.MoCodigo, 
			Clrut	,
			Cldv	,
			Clcodigo,
			Clnombre,
			"ENABLE_SPT" = 0,
			"ENABLE_FWD" = 0,
			"ENABLE_OPT" = 1, 
			"ENABLE_SWP" = 0
		FROM 
		--	CbMdbOpc..MoHisEncContrato AS SAO --LEFT JOIN BacParamSuda..CLIENTE AS cl ON
			CbMdbOpc..MoEncContrato AS SAO INNER JOIN BacParamSuda..CLIENTE AS CL ON
				CL.CLRUT = SAO.MoRutCliente AND
				CL.CLCODIGO = SAO.MoCodigo
		WHERE 
			NOT CL.clvigente = 'N' AND
			(LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%MALO_%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NULO_%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE ELIMINADO%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE BLOQUEADO%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO UTILIZAR%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%')) AND
			MoFechaContrato >= '20180101' OR --AND '20200801' OR
			MoFechaPagoPrima > '20180101'
		--	NOT CL.CLRUT IS NULL
		--ORDER BY 
		--	CLRUT, clcodigo
		--	4 
	UNION
	--CLIENTES SAO CARTERA
		SELECT DISTINCT --top 10 
		--	SAO.MoRutCliente, SAO.MoCodigo, 
			Clrut	,
			Cldv	,
			Clcodigo,
			Clnombre,
			"ENABLE_SPT" = 0,
			"ENABLE_FWD" = 0,
			"ENABLE_OPT" = 1, 
			"ENABLE_SWP" = 0
		FROM 
		--	CbMdbOpc..MoHisEncContrato AS SAO --LEFT JOIN BacParamSuda..CLIENTE AS cl ON
			CbMdbOpc..CaEncContrato AS SAO INNER JOIN BacParamSuda..CLIENTE AS CL ON
				CL.CLRUT = SAO.CaRutCliente AND
				CL.CLCODIGO = SAO.CaCodigo
		WHERE 
			NOT CL.clvigente = 'N' AND
			(LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%MALO_%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NULO_%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE ELIMINADO%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE BLOQUEADO%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO UTILIZAR%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%')) AND
			CaFechaContrato >= '20180101' OR --AND '20200801' OR
			CaFechaPagoPrima >= '20180101'
		--	NOT CL.CLRUT IS NULL
		--ORDER BY 
		--	CLRUT, clcodigo
		--	4 
	UNION
		SELECT DISTINCT --M.*
			Clrut	,
			Cldv	,
			Clcodigo,
			Clnombre,
			"ENABLE_SPT" = 1,
			"ENABLE_FWD" = 0,
			"ENABLE_OPT" = 0, 
			"ENABLE_SWP" = 0
		FROM [BacCamSuda].dbo.MEMOH AS M INNER JOIN BacParamSuda.dbo.CLIENTE AS cl ON 
				cl.clrut = M.MORUTCLI AND 
				cl.clcodigo = M.MOCODCLI
		WHERE
			NOT CL.clvigente = 'N' AND
			(LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%MALO_%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NULO_%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE ELIMINADO%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE BLOQUEADO%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO UTILIZAR%') AND
					LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%')) AND
			MOFECH >= '20180101' OR --and '20200801' OR 
			MOVALUTA1 >= '20180101' OR 
			MOVALUTA2>= '20180101'
		--	not  MOTIPMER = 'ARBI'
	--ORDER BY 4 
	UNION
		SELECT distinct --cl.* 
			cl.Clrut	,
			cl.Cldv	,
			cl.Clcodigo,
			cl.Clnombre,
			--,CL.clvigente
			"ENABLE_SPT" = 0,
			"ENABLE_FWD" = 0,
			"ENABLE_OPT" = 0, 
			"ENABLE_SWP" = 1 
      FROM   BacSwapSuda..CARTERAHIS AS SWP INNER JOIN BacParamSuda.dbo.CLIENTE AS cl ON 
			cl.clrut = SWP.rut_cliente AND 
			cl.clcodigo = SWP.codigo_cliente
      WHERE  
	      NOT CL.clvigente = 'N' AND
			(LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%MALO_%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NULO_%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE ELIMINADO%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE BLOQUEADO%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO UTILIZAR%') AND
				LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%')) AND
				(SWP.fecha_inicio >= '20180101' OR
				SWP.fecha_termino >= '20180101' )
      ORDER BY 4
      
--      select * FROM #tmpClientes_desglosado where clrut = 99520000
            
		SELECT Clrut,	Cldv,	clCodCli,	Clnombre,
			"ENABLE_SPT" = CASE WHEN SUM(ENABLE_SPT) >= 1 THEN CAST('Y' AS VARCHAR(4)) ELSE 'N' END,	
			"ENABLE_FWD" = CASE WHEN SUM(ENABLE_FWD) >= 1 THEN CAST('Y' AS VARCHAR(4)) ELSE 'N' END,		
			"ENABLE_OPT" = CASE WHEN SUM(ENABLE_OPT) >= 1 THEN CAST('Y' AS VARCHAR(4)) ELSE 'N' END,	
			"ENABLE_SWP" = CASE WHEN SUM(ENABLE_SWP) >= 1 THEN CAST('Y' AS VARCHAR(4)) ELSE 'N' END
		INTO #tmpClientes 
		FROM #tmpClientes_desglosado
		GROUP BY Clrut, Cldv, clCodCli, Clnombre

--		SELECT "Clientes ultimo año" = @@rowcount
  
		DROP TABLE #tmpClientes_desglosado

--      SELECT * FROM #tmpClientes  ORDER BY 1      
---*********  FILTRO DE CONTRAPARTES PARA PRUEBAS  *********
CREATE TABLE #pasoContraparte2 (
	"user" VARCHAR(35), 
	"group" VARCHAR(350), 
	"type" VARCHAR(35), 

	"NAME" VARCHAR(35) DEFAULT '', 
	"PARENT_COMPANY" VARCHAR(35) DEFAULT '', 
	"FULL_NAME" VARCHAR(70) DEFAULT '', 
	
	"partyCategory" varChar(35), 
	"partyFiscalCategory" varChar(35), 
	"businessActivities" varChar(70), 
	"partySectorLabel" varChar(35), 

	"LOCAL_EXTR" VARCHAR(35) DEFAULT '', 
	"PAIS_ORIGN" VARCHAR(35) DEFAULT '', 
	"CMF_CODE" VARCHAR(35) DEFAULT '', 
	"NEEDS_AVAL" VARCHAR(35) DEFAULT '', 
	"EJECUTIVO" VARCHAR(35) DEFAULT '', 
	"SUC_EJEC" VARCHAR(35), 
	"SUIT_RISK" VARCHAR(35), 
	"SEGMENTO" VARCHAR(35) DEFAULT '', 
	"SBIF_CODE" VARCHAR(35) DEFAULT '', 
	"SBIF_DESC" VARCHAR(35) DEFAULT '',  
--	"PEND_SEC_ECON_BC" VARCHAR(35) DEFAULT '', 
	"DEFAULT_ADDRESS_STREET_LEGAL" VARCHAR(60) DEFAULT '', 
	"OTHER_ADDRESSES_STREET_PART" VARCHAR(60) DEFAULT '', 
	"OTHER_ADDRESSES_STREET_COMERC" VARCHAR(60) DEFAULT '',
	"DEFAULT_ADDRESS_CITY" VARCHAR(60) DEFAULT '', 
	"OTHER_ADDRESSES_CITY_1" VARCHAR(60) DEFAULT '',
	"OTHER_ADDRESSES_CITY_2" VARCHAR(60) DEFAULT '',
	"DEFAULT_ADDRESS_TEL_LEGAL" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_TEL_1" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_TEL 2" VARCHAR(35) DEFAULT '', 
	"DEFAULT_ADDRESS_COUNTRY_TI" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_COUNTRY_TI1" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_COUNTRY_TI2" VARCHAR(35) DEFAULT '', 
	"KYC_FORM" VARCHAR(35) DEFAULT '', 
	"KYC_DATE" VARCHAR(35) DEFAULT '', 
	"PEP" VARCHAR(35) DEFAULT '', 
	"DEATH_DATE" VARCHAR(35) DEFAULT '', 
	"AS400_CODE" VARCHAR(35) DEFAULT '', 
	"US_PERSON" VARCHAR(35) DEFAULT '', 
	"PAYMENT_NETTING" VARCHAR(35) DEFAULT '', 
	"CPRTV_NET" VARCHAR(35) DEFAULT '', 
	"NRMTV_NET" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_STREET" VARCHAR(60) DEFAULT '', 
	"OTHER_ADDRESSES_TEL" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_COUNTRY" VARCHAR(35) DEFAULT '', 
	"OTHER_ADDRESSES_CITY" VARCHAR(35) DEFAULT '', 
	"CONT_EM1" VARCHAR(35) DEFAULT '', 
	"CONT_EM2" VARCHAR(35) DEFAULT '', 
	"CONT_EM3" VARCHAR(35) DEFAULT '', 
	"CONT_EM4" VARCHAR(35) DEFAULT '', 
	"CONT_EM5" VARCHAR(35) DEFAULT '', 
	"CONT_EM6" VARCHAR(35) DEFAULT '', 
	"CONT_EM7" VARCHAR(35) DEFAULT '', 
	"CONF_EM1" VARCHAR(35) DEFAULT '', 
	"CONF_EM2" VARCHAR(35) DEFAULT '', 
	"CONF_EM3" VARCHAR(35) DEFAULT '', 
	"CONF_EM4" VARCHAR(35) DEFAULT '', 
	"CONF_EM5" VARCHAR(35) DEFAULT '', 
	"CONF_EM6" VARCHAR(35) DEFAULT '', 
	"CONF_EM7" VARCHAR(35) DEFAULT '', 
	"CONF_VENCI" VARCHAR(35) DEFAULT '',

	"ACT_MTM" VARCHAR(35) DEFAULT '',
	"PRIOR_MTM" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL1" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL2" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL3" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL4" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL5" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL6" VARCHAR(35) DEFAULT '',
	"MTM_EMAIL7" VARCHAR(35) DEFAULT '',
--	"MTM_EMAIL8" VARCHAR(35) DEFAULT '',
 
	"COLAT_EML" VARCHAR(35) DEFAULT '', 
	
	"PTAGMT_ID" VARCHAR(35), 
	"AGMT_ID" VARCHAR(35), 
	"GRC_PERIOD" VARCHAR(35), 
	"VER_PERIOD" VARCHAR(35), 

	"ESCA_EMAIL" VARCHAR(35) DEFAULT '', 
	"CTP_ATRIB" VARCHAR(35) DEFAULT '', 
	"COMDER_ELI" VARCHAR(35) DEFAULT '', 
	"DOC_FOREIG" VARCHAR(35) DEFAULT '', 
	"DOC_LOCAL" VARCHAR(35) DEFAULT '', 
	"DOC_LOCAL2" VARCHAR(35) DEFAULT '', 
	"CONTR_COD" VARCHAR(35) DEFAULT '', 
	
	"FECHA_DCV" VARCHAR(35), 
	
	"COLATERALI" VARCHAR(35) DEFAULT '', 
	"COLA_GARAN" VARCHAR(35) DEFAULT '', 
	"THRESHOLD" VARCHAR(35) DEFAULT '', 
	"THRES_AMOUNT" VARCHAR(35) DEFAULT '', 

	"HAIRCUT" VARCHAR(35), 
	"MTA" VARCHAR(35), 
	"VAL_CURR" VARCHAR(35), 

	"ENABLE_FWD" VARCHAR(35) DEFAULT '', 
	"ENABLE_OPT" VARCHAR(35) DEFAULT '', 
	"ENABLE_SPT" VARCHAR(35) DEFAULT '', 
	"SEND_CONFIRMATION" VARCHAR(35) DEFAULT '', 
	"TAX_ID" VARCHAR(35) DEFAULT '', 
	"CLI_RELACI" VARCHAR(35) DEFAULT '', 
	"TIPO_RELAC" VARCHAR(35) DEFAULT '', 
	"EXCE_SOTUS" VARCHAR(35) DEFAULT '', 
	
	"CANAL" VARCHAR(35), 

	"SEGM_ITAU" VARCHAR(35) DEFAULT '', 
	"JEFE_GRUPO" VARCHAR(35) DEFAULT '', 
	"GERENCIA" VARCHAR(35) DEFAULT '', 
	"DIVISION" VARCHAR(35) DEFAULT '', 
--	"CANAL" VARCHAR(35) DEFAULT '', 
	"CTP_TYPE" VARCHAR(70) DEFAULT '', 
	"MEDIA_PDF" VARCHAR(35) DEFAULT '', 
	"APOD_ACT1" VARCHAR(60) DEFAULT '', 
	"APOD_ACT2" VARCHAR(60) DEFAULT '', 
	"CLT_APOD1" VARCHAR(60) DEFAULT '', 
	"APOD_RUT1" VARCHAR(35) DEFAULT '', 
	"CLT_APOD2" VARCHAR(60) DEFAULT '', 
	"APOD_RUT2" VARCHAR(35) DEFAULT '', 
	"CLT_APOD3" VARCHAR(60) DEFAULT '', 
	"APOD_RUT3" VARCHAR(35) DEFAULT '', 
	"CLT_APOD4" VARCHAR(60) DEFAULT '', 
	"APOD_RUT4" VARCHAR(35) DEFAULT '', 
	"CLT_APOD5" VARCHAR(60) DEFAULT '', 
	"APOD_RUT5" VARCHAR(35) DEFAULT '', 
	"CLT_APOD6" VARCHAR(60) DEFAULT '', 
	"APOD_RUT6" VARCHAR(35) DEFAULT '', 
	"CLT_APOD7" VARCHAR(60) DEFAULT '', 
	"APOD_RUT7" VARCHAR(35) DEFAULT '', 
	"CLT_APOD8" VARCHAR(60) DEFAULT '', 
	"APOD_RUT8" VARCHAR(35) DEFAULT '', 
	"CLT_APOD9" VARCHAR(60) DEFAULT '', 
	"APOD_RUT9" VARCHAR(35) DEFAULT '', 
	"CLT_APOD10" VARCHAR(60) DEFAULT '', 
	"APOD_RUT10" VARCHAR(35) DEFAULT '', 
	"STATUS" VARCHAR(35) DEFAULT '', 
	"VALIDITY_ATTRIBUTE" VARCHAR(35) DEFAULT '', 
	"CMM_SI_PREFERENCE" VARCHAR(35) DEFAULT '', 
	"SI_MODE" VARCHAR(35) DEFAULT '', 
	"CI_MODE" VARCHAR(35) DEFAULT '', 
	"SWIFT" VARCHAR(35) DEFAULT '',
	
	"CONFIRMACION VENC 2" VARCHAR(35) DEFAULT '',
	"CONFIRMACION VENC 3" VARCHAR(35) DEFAULT '',
	"CONFIRMACION VENC 4" VARCHAR(35) DEFAULT '',
	"CONFIRMACION VENC 5" VARCHAR(35) DEFAULT '',
	"CONFIRMACION VENC 6" VARCHAR(35) DEFAULT '',
	"CONFIRMACION VENC 7" VARCHAR(35) DEFAULT '',
	"COLAT_EML 2" VARCHAR(35) DEFAULT '', 
	"COLAT_EML 3" VARCHAR(35) DEFAULT '', 
	"COLAT_EML 4" VARCHAR(35) DEFAULT '', 
	"COLAT_EML 5" VARCHAR(35) DEFAULT ''
 )

--SELECT * FROM #pasoContraparte

--linea de encabezado --
--INSERT INTO #pasoContraparte

--	Estado Contraparte
SELECT "mu_STATUS" = 'live', "Cod_BAC" = 'V' INTO #PasopartySTATUS UNION
SELECT "mu_STATUS" = 'live', "Cod_BAC" = 'S' UNION
SELECT "mu_STATUS" = 'live', "Cod_BAC" = '' UNION
SELECT "mu_STATUS" = 'dead', "Cod_BAC" = 'N' 
--SELECT * FROM #PasopartySTATUS

--Configurar moneda o Monedas que seran empleada
--SELECT "mu_SettPrefType" = 'Basket', "Cod_BAC" = '1' INTO #PasocmmSettlPrefType UNION
--SELECT "mu_SettPrefType" = 'od', "Cod_BAC" = '2' UNION
--SELECT "mu_SettPrefType" = 'byCurrency', "Cod_BAC" = '3' 
--SELECT * FROM #PasocmmSettlPrefType

--Categoria Contraparte
--TABLA_GENERAL_DETALLE - tbcateg = 8020 - segmento comercial
SELECT "mu_partyCategory" = 'Corporate', "Cod_BAC" = 3 into #PasopartyCategory UNION
SELECT "mu_partyCategory" = 'Financial', "Cod_BAC" = 1 UNION
SELECT "mu_partyCategory" = 'Financial', "Cod_BAC" = 2 UNION
SELECT "mu_partyCategory" = 'Financial', "Cod_BAC" = 5 UNION
SELECT "mu_partyCategory" = 'Sovereign', "Cod_BAC" = 4
--SELECT * FROM #PasopartyCategory

--Actividad Contraparte
--TABLA_GENERAL_DETALLE - tbcateg = 13 - Actividad Económica
SELECT "mu_ACT_CONTRAPARTE" = 'BANK', "Cod_BAC" = 2 into #PasoActivContraparte UNION
--SELECT "ACT_CONTRAPARTE" = 'BROKER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CUSTOMER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'FICTIVE', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'INTERNAL PARTY', "Cod_BAC" = 9 UNION
SELECT "mu_ACT_CONTRAPARTE" = 'OTHER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'GROUP', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'SUBSIDIARY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'BRANCH', "Cod_BAC" = 9 UNION
SELECT "ACT_CONTRAPARTE" = 'CORPORATE', "Cod_BAC" = 7 UNION
SELECT "ACT_CONTRAPARTE" = 'STATE', "Cod_BAC" = 11 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLEARER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLIENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'ISSUER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'AGENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'LEGAL ENTITY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'REFERENCE ENTITY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'GUARANTOR', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'OPERATOR', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CUSTODIAN', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'AUDITOR', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'TRANSFER AGENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CENTRAL ADMINISTRATI', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'PROMOTER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'MANAGEMENT COMPANY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'INVESTMENT MANAGER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'PROCESSING AREA', "Cod_BAC" = 9 UNION
SELECT "ACT_CONTRAPARTE" = 'HEDGE FUND', "Cod_BAC" = 6 UNION
--SELECT "ACT_CONTRAPARTE" = 'FUND', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CCP', "Cod_BAC" = 9 UNION
SELECT "ACT_CONTRAPARTE" = 'SETTLEMENT AGENT', "Cod_BAC" = 8 
--SELECT "ACT_CONTRAPARTE" = 'TRIPARTY AGENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLEARING BROKER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'FUND.INTERNAL', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'FUND.MANDATE', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLS MEMBER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLS TPS MEMBER', "Cod_BAC" = 9
--SELECT * FROM #PasoActivContraparte

--Especifica preferencias de la moneda(s) que sera empleada
--settlementInstructionsMode		--fullDefinition/selectionOnly/defaultOnly
SELECT "mu_SettlInstrMode" = 'fullDefinition', "Cod_BAC" = '1' INTO #PasosettlInstrMode UNION
SELECT "mu_SettlInstrMode" = 'selectionOnly', "Cod_BAC" = '2' UNION
SELECT "mu_SettlInstrMode" = 'defaultOnly', "Cod_BAC" = '3' 
--SELECT * FROM #PasosettlInstrMode

--Especifica preferencias de la moneda(s) que sera empleada
--settlementInstructionsMode		--Specific And Common / Specific Only /Common Only
SELECT "mu_confInstrMode" = 'Specific And Common', "Cod_BAC" = '1' INTO #PasoConfirmationInstructionsMode UNION
SELECT "mu_confInstrMode" = 'Specific Only', "Cod_BAC" = '2' UNION
SELECT "mu_confInstrMode" = 'Common Only', "Cod_BAC" = '3' 
--SELECT * FROM #PasoConfirmationInstructionsMode

--Especifica preferencias de la moneda(s) que sera empleada
--settlementInstructionsMode		--Specific And Common / Specific Only /Common Only
SELECT "mu_LOCAL_EXTR" = 'Local', "Cod_BAC" = '1' INTO #PasoLOCAL_EXTR UNION
SELECT "mu_LOCAL_EXTR" = 'Extrangero', "Cod_BAC" = '2' 
--SELECT * FROM #PasoConfirmationInstructionsMode

--Counterparty Type - Tipo de Empresa y Atributo (Cliente/Trading)
SELECT "mu_CTP_TYPE" = 'Administradora General de fondos', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 1 INTO #PasoTipoEmpresa UNION
SELECT "mu_CTP_TYPE" = 'Administradora de fondos de pensiones', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 2 UNION
SELECT "mu_CTP_TYPE" = 'Agente de valores mercado formal', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 3 UNION
SELECT "mu_CTP_TYPE" = 'Agente de valores mercado no formal', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 4 UNION
SELECT "mu_CTP_TYPE" = 'Banco Central de Chile', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 5 UNION
SELECT "mu_CTP_TYPE" = 'Banco Exterior (Americano)', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 6 UNION
SELECT "mu_CTP_TYPE" = 'Banco Exterior (No americano)', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 7 UNION
SELECT "mu_CTP_TYPE" = 'Banco Local', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 8 UNION
SELECT "mu_CTP_TYPE" = 'Compania de seguros', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 9 UNION
SELECT "mu_CTP_TYPE" = 'Corporativo', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 10 UNION
SELECT "mu_CTP_TYPE" = 'Corredora de bolsa mercado formal', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 11 UNION
SELECT "mu_CTP_TYPE" = 'Corredora de bolsa mercado no formal', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 12 UNION
SELECT "mu_CTP_TYPE" = 'Empresas', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 13 UNION
SELECT "mu_CTP_TYPE" = 'Grandes Empresas', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 14 UNION
SELECT "mu_CTP_TYPE" = 'Inmobiliaria', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 15 UNION
SELECT "mu_CTP_TYPE" = 'Minorista', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 16 UNION
SELECT "mu_CTP_TYPE" = 'Otros', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 17 UNION
SELECT "mu_CTP_TYPE" = 'PYMES', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 18 UNION
SELECT "mu_CTP_TYPE" = 'Persona juridica', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 19 UNION
SELECT "mu_CTP_TYPE" = 'Persona natural', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 20 UNION
SELECT "mu_CTP_TYPE" = 'Personal Bank', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 21 UNION
SELECT "mu_CTP_TYPE" = 'Private Bank', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 22 UNION
SELECT "mu_CTP_TYPE" = 'Sucursales', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 23 UNION
SELECT "mu_CTP_TYPE" = 'Tesoreria General de la Republica', "mu_CTP_ATRIB" = 'Trading', "Cod_BAC" = 24 UNION
SELECT "mu_CTP_TYPE" = '', "mu_CTP_ATRIB" = 'Cliente', "Cod_BAC" = 99
--SELECT * FROM #PasoTipoEmpresa
--LEIentitySTATUS		--active/inactive

--#PasoTIPO_RELAC
SELECT "mu_TIPO_RELAC" = 'RELAC.POR PROPIEDAD', "Cod_BAC" = 1, "Desc_BAC" = 'RELAC.POR PROPIEDAD' INTO #PasoTIPO_RELAC UNION
SELECT "mu_TIPO_RELAC" = 'RELAC. POR GESTION', "Cod_BAC" = 2, "Desc_BAC" = 'RELAC. POR GESTION' UNION
SELECT "mu_TIPO_RELAC" = 'NO HAY RELACION', "Cod_BAC" = 3, "Desc_BAC" = 'NO RELACIONADO' 
--select * from #PasoTIPO_RELAC

--#PasoCorresponsales
SELECT DISTINCT --top 5
	"Rut_Cliente" = CL.CLRut,
	"Codigo_Cliente" = CL.CLCodigo,
	CC.Nombre_Corresponsal	,
	CC.Cuenta_Corresponsal	,
	CC.Codigo_SWIFT
INTO #PasoCorresponsales
FROM 
	BacParamSuda..CLIENTE AS CL 
LEFT JOIN  BacParamSuda..CLIENTE_CORRESPONSAL AS CC ON
	CL.CLRut = CC.Rut_Cliente AND
	CL.CLCodigo = CC.Codigo_Cliente 
--LEFT JOIN  BacParamSuda..CORRESPONSAL as CORR ON
--	CORR.Rut_Cliente = CC.Rut_Cliente AND
--	CORR.Codigo_Cliente = CC.Codigo_Cliente AND
--	CORR.cuenta_corriente = CC.Cuenta_Corresponsal
INNER JOIN DB_SADP_Filiales..SADP_Corresponsales as C with(nolock) ON
	CL.CLRut = C.iCOR_Rutcliente AND
	CL.CLCodigo = C.iCOR_CodCliente

INSERT INTO #pasoContraparte2
( 
		[user], [group], [type], 
		[NAME], [PARENT_COMPANY], [FULL_NAME], 

		[partyCategory], [partyFiscalCategory], [businessActivities], [partySectorLabel], 

		[LOCAL_EXTR], [PAIS_ORIGN], [CMF_CODE], [NEEDS_AVAL], [EJECUTIVO], [SUC_EJEC], 
		[SUIT_RISK], [SEGMENTO], [SBIF_CODE], 
		[SBIF_DESC], --[PEND_SEC_ECON_BC], 
		[DEFAULT_ADDRESS_STREET_LEGAL], [OTHER_ADDRESSES_STREET_PART], [OTHER_ADDRESSES_STREET_COMERC], 
		[DEFAULT_ADDRESS_CITY], [OTHER_ADDRESSES_CITY_1], [OTHER_ADDRESSES_CITY_2], [DEFAULT_ADDRESS_TEL_LEGAL], 
		[OTHER_ADDRESSES_TEL_1], [OTHER_ADDRESSES_TEL 2], [DEFAULT_ADDRESS_COUNTRY_TI], [OTHER_ADDRESSES_COUNTRY_TI1], 
		[OTHER_ADDRESSES_COUNTRY_TI2], [KYC_FORM], [KYC_DATE], [PEP], [DEATH_DATE], [AS400_CODE], 
		[US_PERSON], [PAYMENT_NETTING], [CPRTV_NET], [NRMTV_NET], [OTHER_ADDRESSES_STREET], [OTHER_ADDRESSES_TEL], 
		[OTHER_ADDRESSES_COUNTRY], [OTHER_ADDRESSES_CITY], 
		[CONT_EM1], [CONT_EM2], [CONT_EM3], [CONT_EM4], [CONT_EM5], [CONT_EM6], [CONT_EM7], 
		[CONF_EM1], [CONF_EM2], [CONF_EM3], [CONF_EM4], [CONF_EM5], [CONF_EM6], [CONF_EM7], 
		[CONF_VENCI], [ACT_MTM], [PRIOR_MTM], 
		[MTM_EMAIL1], [MTM_EMAIL2], [MTM_EMAIL3], [MTM_EMAIL4], [MTM_EMAIL5], [MTM_EMAIL6], [MTM_EMAIL7], --[MTM_EMAIL8], 
		[COLAT_EML], [PTAGMT_ID], [AGMT_ID], [GRC_PERIOD], [VER_PERIOD], [ESCA_EMAIL], [CTP_ATRIB], [COMDER_ELI], 
		[DOC_FOREIG], [DOC_LOCAL], [DOC_LOCAL2], [CONTR_COD], [FECHA_DCV], [COLATERALI], [COLA_GARAN], 
		[THRESHOLD], [THRES_AMOUNT], [HAIRCUT], [MTA], [VAL_CURR], [ENABLE_FWD], [ENABLE_OPT], [ENABLE_SPT], 
		[SEND_CONFIRMATION], [TAX_ID], [CLI_RELACI], [TIPO_RELAC], [EXCE_SOTUS], [SEGM_ITAU], 
		[JEFE_GRUPO], [GERENCIA], [DIVISION], [CANAL], [CTP_TYPE], [MEDIA_PDF], 
		[APOD_ACT1], [APOD_ACT2], [CLT_APOD1], [APOD_RUT1], [CLT_APOD2], [APOD_RUT2], 
		[CLT_APOD3], [APOD_RUT3], [CLT_APOD4], [APOD_RUT4], [CLT_APOD5], [APOD_RUT5], 
		[CLT_APOD6], [APOD_RUT6], [CLT_APOD7], [APOD_RUT7], [CLT_APOD8], [APOD_RUT8], 
		[CLT_APOD9], [APOD_RUT9], [CLT_APOD10], [APOD_RUT10], 
		[STATUS], [VALIDITY_ATTRIBUTE], [CMM_SI_PREFERENCE], [SI_MODE], [CI_MODE], [SWIFT],
		[CONFIRMACION VENC 2], [CONFIRMACION VENC 3], [CONFIRMACION VENC 4], [CONFIRMACION VENC 5], [CONFIRMACION VENC 6], [CONFIRMACION VENC 7],
		[COLAT_EML 2], [COLAT_EML 3], [COLAT_EML 4], [COLAT_EML 5]
		)

SELECT DISTINCT --TOP 50 
	"user" = 'MUREXBO', 
	"group" = 'BO_OPS',
	"Type" = 'party', 
 	"NAME" = SUBSTRING(CAST(CL.clrut AS VARCHAR(12)) + '-' + CAST(CL.CLDV AS VARCHAR(12)), 1, 35) +
								(CASE WHEN (SELECT COUNT(1) FROM bacparamsuda..cliente cl2 
												WHERE cl2.clrut = CL.clrut AND 
													clvigente = 'S' AND 
													LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('MALO_%') AND
													LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%') 
												GROUP BY cl2.clrut) > 1 THEN ('-' + RIGHT('0' + LTRIM(RTRIM(cl.clcodigo)), 2))
							ELSE ''
							END),	--Rut Ficticio
							
	"PARENT_COMPANY" = SUBSTRING(CAST(CL.clrut AS VARCHAR(12)) + '-' + CAST(CL.CLDV AS VARCHAR(12)), 1, 35), --Rut Legal
--	"FULL_NAME" = '"'+SUBSTRING(LTRIM(RTRIM(REPLACE(REPLACE(CL.Clnombre, ';', '_'), ',', '.'))), 1, 35)+'"', 
	"FULL_NAME" = '"' + SUBSTRING(LTRIM(RTRIM(REPLACE(CL.Clnombre, ';', '_'))), 1, 35) + '"', 
	--"partyCategory" = CASE  WHEN ISNULL(SEG.mu_partyCategory, '') = '' THEN
	--						CASE WHEN ISNULL(CL.cltipEMP, '')=11 THEN 
	--								'Sovereign' 
	--							ELSE 
	--								''
	--							END
	--						ELSE SEG.mu_partyCategory 
	--						END ,  
	"partyCategory" = '',			--no se informa
	"partyFiscalCategory" = '', 
	"businessActivities" = CASE WHEN EXISTS(SELECT 1 FROM #PasoCorresponsales AS PC WHERE 
												PC.Rut_Cliente	= cl.clRut AND
												PC.Codigo_Cliente	= cl.clCodigo) THEN 'SETTLEMENT AGENT' -- (corresponsales)
										ELSE
										ISNULL(RTRIM(LTRIM(AC.mu_ACT_CONTRAPARTE)), 'OTHER')
									END,
	"partySectorLabel" = '', 

	
	
	"LOCAL_EXTR" = CASE WHEN CL.cltipcli IN(2, 10, 12) THEN 'Extranjero' 
							ELSE
								'Local'
							END, 
	"PAIS_ORIGN" = RTRIM(LTRIM(ISNULL(pa.nombre, ''))),	--	PAIS, 
	"CMF_CODE" = '', 
	"NEEDS_AVAL" = '', 
	"EJECUTIVO" = '', 
	"SUC_EJEC" = '', 
	"SUIT_RISK" = '', 
	"SEGMENTO" = CASE  WHEN ISNULL(SEG.mu_partyCategory, '') = '' THEN
							CASE WHEN ISNULL(CL.cltipEMP, '')=11 THEN 
									'Sovereign' 
								ELSE 
									''
								END
							ELSE SEG.mu_partyCategory 
							END ,  
	"SBIF_CODE" = ISNULL(RTRIM(LTRIM(cl.Clclsbif)), ''), 
	"SBIF_DESC" = '', 
	--"PEND_SEC_ECON_BC" = SUBSTRING(REPLACE(ISNULL(RTRIM(LTRIM(SE.tbglosa)), ''),',', '.'), 1, 35),  --antes --> partySectorLabel
	"DEFAULT_ADDRESS_STREET_LEGAL" = SUBSTRING(REPLACE(RTRIM(LTRIM(ISNULL(cldirecc, ''))) + '. ' 
												+ RTRIM(LTRIM(ISNULL(co.nom_ciu, ''))), ',', '.'), 1, 60),
	"OTHER_ADDRESSES_STREET_PART" = '', 
	"OTHER_ADDRESSES_STREET_COMERC" = '', 
	"DEFAULT_ADDRESS_CITY" = SUBSTRING(RTRIM(LTRIM(ISNULL(CI.NOMBRE, ''))),1 ,35),	--	CITY - CIUDAD
	"OTHER_ADDRESSES_CITY_1" = '', 
	"OTHER_ADDRESSES_CITY_2" = '', 
	"DEFAULT_ADDRESS_TEL_LEGAL" = REPLACE(RTRIM(LTRIM(ISNULL(CL.clfono, ''))), ',', '_'),	--TELEFONO
	"OTHER_ADDRESSES_TEL_1" = '', 
	"OTHER_ADDRESSES_TEL 2" = '', 
	"DEFAULT_ADDRESS_COUNTRY_TI" = '', 
	"OTHER_ADDRESSES_COUNTRY_TI1" = '', 
	"OTHER_ADDRESSES_COUNTRY_TI2" = '', 
	"KYC_FORM" = 'A', --aprobado
	"KYC_DATE" = RTRIM(CONVERT(CHAR(10), CL.Clfecingr, 112)), 
	"PEP" = '', 
	"DEATH_DATE" = '', 
	"AS400_CODE" = CAST(Codigo_AS400 AS VARCHAR(35)), 
	"US_PERSON" = '', 
	"PAYMENT_NETTING" = '', 
	"CPRTV_NET" = 'No', 
	"NRMTV_NET" = 'No', 
	 "OTHER_ADDRESSES_STREET" = '', 
	 "OTHER_ADDRESSES_TEL" = '', 
	 "OTHER_ADDRESSES_COUNTRY" = '', 
	 "OTHER_ADDRESSES_CITY" = '', 
	 "CONT_EM1" = '', 
	 "CONT_EM2" = '', 
	 "CONT_EM3" = '', 
	 "CONT_EM4" = '', 
	 "CONT_EM5" = '', 
	 "CONT_EM6" = '', 
	 "CONT_EM7" = '', 
	 "CONF_EM1" = '', 
	 "CONF_EM2" = '', 
	 "CONF_EM3" = '', 
	 "CONF_EM4" = '', 
	 "CONF_EM5" = '', 
	 "CONF_EM6" = '', 
	 "CONF_EM7" = '', 
	 "CONF_VENCI" = '', 
	 "ACT_MTM" = '', 
	 "PRIOR_MTM" = '', 
	 "MTM_EMAIL1" = '', 
	 "MTM_EMAIL2" = '', 
	 "MTM_EMAIL3" = '', 
	 "MTM_EMAIL4" = '', 
	 "MTM_EMAIL5" = '', 
	 "MTM_EMAIL6" = '', 
	 "MTM_EMAIL7" = '', 
	 "COLAT_EML" = '', 
	 "PTAGMT_ID" = '', 
	 "AGMT_ID" = '', 
	 "GRC_PERIOD" = '', 
	 "VER_PERIOD" = '', 
	 
	"ESCA_EMAIL" = '', 
	"CTP_ATRIB" = ISNULL(TE.mu_CTP_ATRIB, ''), 
	 "COMDER_ELI" = '', 
	 "DOC_FOREIG" = '', 
	 "DOC_LOCAL" = '', 
	 "DOC_LOCAL2" = '', 
	 "CONTR_COD" = CASE WHEN ISNULL(DCV.CodDcv, 0) = 0 THEN '' ELSE CAST(DCV.CodDcv AS VARCHAR(35)) END, 
	 "FECHA_DCV" = '', 
	 "COLATERALI" = '', 
	 "COLA_GARAN" = '', 
	 "THRESHOLD" = '', 
	 "THRES_AMOUNT" = '', 
	 "HAIRCUT" = '', 
	 "MTA" = '', 
	 "VAL_CURR" = '', 

	"ENABLE_FWD" = TCL.ENABLE_FWD, 
	"ENABLE_OPT" = TCL.ENABLE_OPT, 
	"ENABLE_SPT" = TCL.ENABLE_SPT, 
	"SEND_CONFIRMATION" = '', 
	"TAX_ID" = ISNULL(TAX.TAXID_CLI, ''), 
	"CLI_RELACI" = CASE WHEN ISNULL(RIF.Cod_BAC, 3) <> 3 THEN 'Yes' ELSE 'No' END, 
	"TIPO_RELAC" = CASE WHEN ISNULL(RIF.mu_TIPO_RELAC, '') <> '' THEN ISNULL(RIF.mu_TIPO_RELAC, '') ELSE '' END,  
	"EXCE_SOTUS" = '', 
	"SEGM_ITAU" = '', 
	"JEFE_GRUPO" = '', 
	"GERENCIA" = '', 
	"DIVISION" = '', 
	"CANAL" = '', 
	"CTP_TYPE" = CASE WHEN TE.mu_CTP_TYPE <> '' THEN TE.mu_CTP_TYPE ELSE '' END,	--TIPO DE EMPRESA
	"MEDIA_PDF" = '', 
	"APOD_ACT1" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 1, 'NOMBRE'),
	"APOD_ACT2" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 2, 'NOMBRE'),
	"CLT_APOD1" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 1, 'NOMBRE'),
	"APOD_RUT1" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 1, 'RUT'),
	"CLT_APOD2" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 2, 'NOMBRE'),
	"APOD_RUT2" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 2, 'RUT'),
	"CLT_APOD3" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 3, 'NOMBRE'),
	"APOD_RUT3" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 3, 'RUT'),
	"CLT_APOD4" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 4, 'NOMBRE'),
	"APOD_RUT4" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 4, 'RUT'),
	"CLT_APOD5" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 5, 'NOMBRE'),
	"APOD_RUT5" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 5, 'RUT'),
	"CLT_APOD6" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 6, 'NOMBRE'),
	"APOD_RUT6" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 6, 'RUT'),
	"CLT_APOD7" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 7, 'NOMBRE'),
	"APOD_RUT7" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 7, 'RUT'),
	"CLT_APOD8" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 8, 'NOMBRE'), 
	"APOD_RUT8" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 8, 'RUT'),
	"CLT_APOD9" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 9, 'NOMBRE'),
	"APOD_RUT9" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 9, 'RUT'),
	"CLT_APOD10" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 10, 'NOMBRE'),
	"APOD_RUT10" = DBO.fnc_trae_apoderado_X_MUREX(CL.CLRUT, CL.CLCODIGO, 10, 'RUT'),
	"STATUS" = PPS.mu_STATUS, 
	"VALIDITY_ATTRIBUTE" = 'VALID', 
	"CMM_SI_PREFERENCE" = 'Basket',	--basket/od/byCurrency
	"SI_MODE" = 'Selection only', 
	"CI_MODE" = 'Specific and Common',
--	"SWIFT" = RTRIM(LTRIM(ISNULL(CL.clswift, ''))) --SWIFT
	"SWIFT" = RTRIM(LTRIM(ISNULL(BPG.sBAN_CodSwift, ''))), --SWIFT
	"CONFIRMACION VENC 2" = '', 
	"CONFIRMACION VENC 3" = '', 
	"CONFIRMACION VENC 4" = '', 
	"CONFIRMACION VENC 5" = '', 
	"CONFIRMACION VENC 6" = '', 
	"CONFIRMACION VENC 7" = '', 
	"COLAT_EML 2" = '', 
	"COLAT_EML 3" = '', 
	"COLAT_EML 4" = '', 
	"COLAT_EML 5" = ''
 FROM bacparamsuda..CLIENTE AS cl LEFT JOIN #PasopartySTATUS AS PPS ON
				PPS.Cod_BAC = RTRIM(CL.clvigente)
			LEFT JOIN BacParamSuda.dbo.CIUDAD_COMUNA AS CO ON
				--co.codigo_CIUDAD = CASE WHEN (ltrim(CL.CLCIUDAD) in(0, 3))  THEN cl.clcomuna ELSE CL.CLCIUDAD END AND
				co.cod_com = cl.clcomuna
			LEFT JOIN BacParamSuda.dbo.CIUDAD AS CI ON
				CI.CODIGO_CIUDAD = CASE WHEN CL.CLCIUDAD in(0, 3) THEN co.cod_CIU ELSE CL.CLCIUDAD END 
			LEFT JOIN BacParamSuda.dbo.REGION AS RE ON
				RE.CODIGO_REGION = CL.CLREGION	
			LEFT JOIN BacParamSuda.dbo.Pais AS PA ON
				PA.CODIGO_PAIS = co.cod_pai
/*
			LEFT JOIN TABLA_GENERAL_DETALLE AS CJ ON	--CALIDAD JURIDICA
				CJ.tbcateg = 39 AND
				CJ.tbcodigo1 = CL.clcalidadjuridica
			LEFT JOIN TABLA_GENERAL_DETALLE AS M ON		--MERCADO
				M.tbcateg = 202 AND
				M.tbcodigo1 = CL.clmercado
			LEFT JOIN TABLA_GENERAL_DETALLE AS CDE ON	--CATEGORIA DEUDOR
				CDE.tbcateg = 42 AND
				CDE.tbcodigo1 = CL.clcatego
*/
			LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS SE ON	--SECTOR ECONOMICO o 
				SE.tbcateg = 41 AND
				SE.tbcodigo1 = CL.clsector

			--LEFT JOIN TABLA_GENERAL_DETALLE AS TC ON	--TIPO CLIENTE
			--	TC.tbcateg = 72 AND
			--	TC.tbcodigo1 = CL.cltipcli

			LEFT JOIN #PasoActivContraparte AS AC ON --cltipcli
				(((
					ac.cod_bac = 2 and cl.cltipcli IN(1, 2)) or	--BANCOS
					(ac.cod_bac = 11 and cl.cltipcli IN(10, 11)) or	--ESTADO
					(ac.cod_bac = 7 and cl.cltipcli not IN(1,2,10,11) and CL.seg_comercial = 3) or		--CORPORATIVO
--					(ac.cod_bac = 6 and cl.cltipcli = 6) or		--AFPs
					
					(ac.cod_bac = 9 and cl.cltipcli not IN(1,2,10,11) AND CL.seg_comercial <> 3)) 		-- OTROS
				)
/*
			LEFT JOIN TABLA_GENERAL_DETALLE AS TE ON	--TIPO EMPRESA
				TE.tbcateg = 72 AND
				TE.tbcodigo1 = CL.cltipEMP
			LEFT JOIN TABLA_GENERAL_DETALLE AS EN ON	--ENTIDAD
				EN.tbcateg = 234 AND
				EN.tbcodigo1 = CL.clentidad
			LEFT JOIN TABLA_GENERAL_DETALLE AS GRE ON	--GRUPO ECONOMICO
				GRE.tbcateg = 233 AND
				GRE.tbcodigo1 = CL.clGRUPO
*/
			LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS AE ON	--ACTIVIDAD ECONOMICA
				AE.tbcateg = 13 AND
				AE.tbcodigo1 = CL.clactivida		
/*
			LEFT JOIN TABLA_GENERAL_DETALLE AS RB ON	--RELACION BANCO
				RB.tbcateg = 32 AND
				RB.tbcodigo1 = CL.relbco
*/
--			LEFT JOIN TABLA_GENERAL_DETALLE AS RIF ON	--RELACION GESTION BANCO - I.F.
--select * from 			TABLA_GENERAL_DETALLE AS RIF where
--				RIF.tbcateg = 40 AND
--				RIF.tbcodigo1 = CL.clrelacion
LEFT JOIN #PasoTIPO_RELAC AS RIF ON	--RELACION GESTION BANCO - I.F.				
				RIF.COD_BAC = CL.clrelacion

			LEFT JOIN #PasopartyCategory AS SEG ON	--SEGMENTO COMERCIAL
--				SEG.tbcateg = 8020 AND
				SEG.cod_bac = CL.seg_comercial

/*				
			LEFT JOIN TABLA_GENERAL_DETALLE AS CCT ON	--CODIGO CONTRAPARTE
				CCT.tbcateg = 552 AND
				CCT.tbcodigo1 = CL.clCod_Contra
			LEFT JOIN TABLA_GENERAL_DETALLE AS ECT ON	--COD. EMP. CENTRA. CONTRAP
				ECT.tbcateg = 553 AND
				ECT.tbcodigo1 = CL.clCod_Emp_Cen			
*/
			LEFT JOIN #PasoSettlInstrMode AS SIM ON
				SIM.cod_bac = 1
			LEFT JOIN #PasoConfirmationInstructionsMode	AS CIM ON
				CIM.cod_bac = 1
			--LEFT JOIN  dbo.CLIENTE_APODERADO  AS AP ON
			--	AP.aprutcli = CL.CLRUT AND
			--	AP.apdvcli	= CL.CLDV AND
			--	AP.apcodcli = CL.CLCODIGO	
			INNER JOIN #tmpClientes AS TCL ON
				CL.clRUT = TCL.clRUT AND
				CL.CLCODIGO = TCL.clCodCli
			--LEFT (SELECT "NRO" = CAST((ROW_NUMBER() OVER(ORDER BY apnombre ASC)) as VARCHAR(2)),
			--			AP.*
			--		FROM 
			--			dbo.CLIENTE_APODERADO  AS AP
			--		WHERE 
			--			AP.aprutcli = CL.CLRUT AND
			--			AP.apdvcli	= CL.CLDV AND
			--			AP.apcodcli = CL.CLCODIGO) AS CAPO
			LEFT JOIN #PasoTipoEmpresa AS TE ON
				TE.Cod_BAC = CASE WHEN CL.cltipcli = 1 THEN 8
									WHEN CL.cltipcli = 2 AND NOT cl.CLNOMBRE LIKE '%USA%' THEN 7
									WHEN CL.cltipcli = 2 AND cl.CLNOMBRE LIKE '%USA%' THEN 8
									WHEN CL.cltipcli = 3 AND CL.clRUT>40000000 THEN 3
									WHEN CL.cltipcli = 4 THEN 11
									WHEN CL.cltipcli = 5 THEN 3
									WHEN CL.cltipcli = 6 THEN 2
									WHEN CL.cltipcli = 7 THEN 13
									WHEN CL.cltipcli = 8 THEN 20
									WHEN CL.cltipcli = 9 THEN 17
									WHEN CL.cltipcli = 10 THEN 17	--REPUBLICAS EXTRANJERAS
									WHEN CL.CLRUT = 60805000 THEN 24	--Tesoreria General de la Republica
									WHEN CL.cltipcli = 11 AND CL.CLRUT <>60805000 THEN 24
									WHEN CL.CLRUT = 97029000 THEN 5	--Banco Central de Chile
									WHEN CL.CLNOMBRE LIKE '%SEGUROS%' THEN 9	--Compania de seguros
									WHEN CL.CLNOMBRE LIKE '%CORREDORA DE BOLSA%' THEN 11 --Corredora de bolsa mercado formal
									WHEN CL.cltipcli = 12 THEN 17
									ELSE
										'99'	--OTROS
									END
			LEFT JOIN BacParamSuda.dbo.TBL_CODIGO_CLIENTE_DCV AS DCV ON
				DCV.RutCliente = cl.CLRUT AND
				DCV.CodCliente = cl.CLCODIGO	
			LEFT JOIN BDDW.dbo.DJB_TA_GNL_CLI_TAXID	AS TAX ON
				TAX.ID_CLI_EMP = cl.CLRUT AND
				TAX.ID_CLI_CODIGO_EMP = cl.CLCODIGO
			LEFT JOIN DB_SADP_Filiales..SADP_Bancos AS BPG ON
				--select iBAN_Rut, iBAN_Dv, BPG.sBAN_CodSwift, *
				iBAN_Rut	= cl.CLRUT AND
				iBAN_Dv = cl.CLDV 


WHERE
	LTRIM(ISNULL(CL.clvigente, '')) in('S', '') --AND 
	--(LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%MALO_%') AND
	--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NULO_%') AND
	--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE ELIMINADO%') AND
	--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%CLIENTE BLOQUEADO%') AND
	--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO UTILIZAR%') AND
	--LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%')) --AND
--	CL.clCondicionesGenerales = 'S' --AND
--	CL.clFechaFirma_cond <> '1900-01-01'

--	cl.clrut IN(VER TABLA ANEXA muestra) --muestra
--	and not (CL.Clnombre like '%banco%' or CL.Clnombre like '%banc%' or CL.Clnombre like '%bank%')
--	and (CL.cltipcli = 6 ) --and not CL.Clnombre like '%tipo%')
--	AND CL.cltipcli = 1 --IN(1,2)
-- AND CL.CLRUT = 480256200
--	AND CL.Clnombre LIKE '%;%'
--ORDER BY 
--	cl.clrut DESC, CL.CLCODIGO	

SELECT "lineas_datos" = 
	'user' + ',' + 
	'group' + ',' + 
	'type' + ',' + 
	'NAME' + ',' + 
	'PARENT_COMPANY' + ',' + 
	'FULL_NAME' + ',' + 

	'partyCategory' + ',' + 
	'partyFiscalCategory' + ',' + 
	'businessActivities' + ',' + 
	'partySectorLabel' + ',' + 

	'LOCAL_EXTR' + ',' + 
	'PAIS_ORIGN' + ',' + 
	'CMF_CODE' + ',' + 
	'NEEDS_AVAL' + ',' + 
	'EJECUTIVO' + ',' + 
	'SUC_EJEC' + ',' + 
	'SUIT_RISK' + ',' + 
	'SEGMENTO' + ',' + 
	'SBIF_CODE' + ',' + 
	'SBIF_DESC' + ',' + 
	--'PEND_SEC_ECON_BC' + ',' + 
	'DEFAULT_ADDRESS_STREET_LEGAL' + ',' + 
	'OTHER_ADDRESSES_STREET_PART' + ',' + 
	'OTHER_ADDRESSES_STREET_COMERC' + ',' + 
	'DEFAULT_ADDRESS_CITY' + ',' + 
	'OTHER_ADDRESSES_CITY1' + ',' + 
	'OTHER_ADDRESSES_CITY2' + ',' + 
	'DEFAULT_ADDRESS_TEL_LEGAL' + ',' + 
	'OTHER_ADDRESSES_TEL1' + ',' + 
	'OTHER_ADDRESSES_TEL2' + ',' + 
	'DEFAULT_ADDRESS_COUNTRY_TI' + ',' + 
	'OTHER_ADDRESSES_COUNTRY_TI1' + ',' + 
	'OTHER_ADDRESSES_COUNTRY_TI2' + ',' + 
	'KYC_FORM' + ',' + 
	'KYC_DATE' + ',' + 
	'PEP' + ',' + 
	'DEATH_DATE' + ',' + 
	'AS400_CODE' + ',' + 
	'US_PERSON' + ',' + 
	'PAYMENT_NETTING' + ',' + 
	'CPRTV_NET' + ',' + 
	'NRMTV_NET' + ',' + 
	'OTHER_ADDRESSES_STREET' + ',' + 
	'OTHER_ADDRESSES_TEL' + ',' + 
	'OTHER_ADDRESSES_COUNTRY' + ',' + 
	'OTHER_ADDRESSES_CITY' + ',' + 
	'CONT_EM1' + ',' + 
	'CONT_EM2' + ',' + 
	'CONT_EM3' + ',' + 
	'CONT_EM4' + ',' + 
	'CONT_EM5' + ',' + 
	'CONT_EM6' + ',' + 
	'CONT_EM7' + ',' + 
	'CONF_EM1' + ',' + 
	'CONF_EM2' + ',' + 
	'CONF_EM3' + ',' + 
	'CONF_EM4' + ',' + 
	'CONF_EM5' + ',' + 
	'CONF_EM6' + ',' + 
	'CONF_EM7' + ',' + 
	'CONF_VENCI' + ',' + 
	'ACT_MTM' + ',' + 
	'PRIOR_MTM' + ',' + 
	'MTM_EMAIL1' + ',' + 
	'MTM_EMAIL2' + ',' + 
	'MTM_EMAIL3' + ',' + 
	'MTM_EMAIL4' + ',' + 
	'MTM_EMAIL5' + ',' + 
	'MTM_EMAIL6' + ',' + 
	'MTM_EMAIL7' + ',' + 
--	'MTM_EMAIL8' + ',' + 
	'COLAT_EML' + ',' + 
	'PTAGMT_ID' + ',' + 
	'AGMT_ID' + ',' + 
	'GRC_PERIOD' + ',' + 
	'VER_PERIOD' + ',' + 
	'ESCA_EMAIL' + ',' + 
	'CTP_ATRIB' + ',' + 
	'COMDER_ELI' + ',' + 
	'DOC_FOREIG' + ',' + 
	'DOC_LOCAL' + ',' + 
	'DOC_LOCAL2' + ',' + 
	'CONTR_COD' + ',' + 
	'FECHA_DCV' + ',' + 
	'COLATERALI' + ',' + 
	'COLA_GARAN' + ',' + 
	'THRESHOLD' + ',' + 
	'THRES_AMOUNT' + ',' + 
	'HAIRCUT' + ',' + 
	'MTA' + ',' + 
	'VAL_CURR' + ',' + 
	'ENABLE_FWD' + ',' + 
	'ENABLE_OPT' + ',' + 
	'ENABLE_SPT' + ',' + 
	'SEND_CONFIRMATION' + ',' + 
	'TAX_ID' + ',' + 
	'CLI_RELACI' + ',' + 
	'TIPO_RELAC' + ',' + 
	'EXCE_SOTUS' + ',' + 
	'CANAL' + ',' + 
	'SEGM_ITAU' + ',' + 
	'JEFE_GRUPO' + ',' + 
	'GERENCIA' + ',' + 
	'DIVISION' + ',' + 
	'CTP_TYPE' + ',' + 
	'MEDIA_PDF' + ',' + 
	'APOD_ACT1' + ',' + 
	'APOD_ACT2' + ',' + 
	'CLT_APOD1' + ',' + 
	'APOD_RUT1' + ',' + 
	'CLT_APOD2' + ',' + 
	'APOD_RUT2' + ',' + 
	'CLT_APOD3' + ',' + 
	'APOD_RUT3' + ',' + 
	'CLT_APOD4' + ',' + 
	'APOD_RUT4' + ',' + 
	'CLT_APOD5' + ',' + 
	'APOD_RUT5' + ',' + 
	'CLT_APOD6' + ',' + 
	'APOD_RUT6' + ',' + 
	'CLT_APOD7' + ',' + 
	'APOD_RUT7' + ',' + 
	'CLT_APOD8' + ',' + 
	'APOD_RUT8' + ',' + 
	'CLT_APOD9' + ',' + 
	'APOD_RUT9' + ',' + 
	'CLT_APOD10' + ',' + 
	'APOD_RUT10' + ',' + 
	'STATUS' + ',' + 
	'VALIDITY_ATTRIBUTE' + ',' + 
	'CMM_SI_PREFERENCE' + ',' + 
	'SI_MODE' + ',' + 
	'CI_MODE' + ',' +  
	'SWIFT' + ',' +  
	'CONFIRMACION VENC 2' + ',' +  
	'CONFIRMACION VENC 3' + ',' +  
	'CONFIRMACION VENC 4' + ',' +  
	'CONFIRMACION VENC 5' + ',' +  
	'CONFIRMACION VENC 6' + ',' +  
	'CONFIRMACION VENC 7' + ',' +  
	'COLAT_EML 2' + ',' +  
	'COLAT_EML 3' + ',' +  
	'COLAT_EML 4' + ',' +  
	'COLAT_EML 5'
UNION
	SELECT DISTINCT "lineas_datos" = 
		PC.[user] + ',' + 
		PC.[group] + ',' + 
		PC.[type] + ',' + 

		PC.[NAME] + ',' + 
		PC.[PARENT_COMPANY] + ',' + 
		PC.[FULL_NAME] + ',' + 
		
		PC.[partyCategory] + ',' + 
		PC.[partyFiscalCategory] + ',' + 
		PC.[businessActivities] + ',' + 
		PC.[partySectorLabel] + ',' + 
		
		PC.[LOCAL_EXTR] + ',' + 
		PC.[PAIS_ORIGN] + ',' + 
		PC.[CMF_CODE] + ',' + 
		PC.[NEEDS_AVAL] + ',' + 
		PC.[EJECUTIVO] + ',' + 
		PC.[SUC_EJEC] + ',' + 
		PC.[SUIT_RISK] + ',' + 
		PC.[SEGMENTO] + ',' + 
		PC.[SBIF_CODE] + ',' + 
		PC.[SBIF_DESC] + ',' + 
		--PC.[PEND_SEC_ECON_BC] + ',' + 
		PC.[DEFAULT_ADDRESS_STREET_LEGAL] + ',' + 
		PC.[OTHER_ADDRESSES_STREET_PART] + ',' + 
		PC.[OTHER_ADDRESSES_STREET_COMERC] + ',' + 
		PC.[DEFAULT_ADDRESS_CITY] + ',' + 
		PC.[OTHER_ADDRESSES_CITY_1] + ',' + 
		PC.[OTHER_ADDRESSES_CITY_2] + ',' + 
		PC.[DEFAULT_ADDRESS_TEL_LEGAL] + ',' + 
		PC.[OTHER_ADDRESSES_TEL_1] + ',' + 
		PC.[OTHER_ADDRESSES_TEL 2] + ',' + 
		PC.[DEFAULT_ADDRESS_COUNTRY_TI] + ',' + 
		PC.[OTHER_ADDRESSES_COUNTRY_TI1] + ',' + 
		PC.[OTHER_ADDRESSES_COUNTRY_TI2] + ',' + 
		PC.[KYC_FORM] + ',' + 
		PC.[KYC_DATE] + ',' + 
		PC.[PEP] + ',' + 
		PC.[DEATH_DATE] + ',' + 
		PC.[AS400_CODE] + ',' + 
		PC.[US_PERSON] + ',' + 
		PC.[PAYMENT_NETTING] + ',' + 
		PC.[CPRTV_NET] + ',' + 
		PC.[NRMTV_NET] + ',' + 
		PC.[OTHER_ADDRESSES_STREET] + ',' + 
		PC.[OTHER_ADDRESSES_TEL] + ',' + 
		PC.[OTHER_ADDRESSES_COUNTRY] + ',' + 
		PC.[OTHER_ADDRESSES_CITY] + ',' + 
		PC.[CONT_EM1] + ',' + 
		PC.[CONT_EM2] + ',' + 
		PC.[CONT_EM3] + ',' + 
		PC.[CONT_EM4] + ',' + 
		PC.[CONT_EM5] + ',' + 
		PC.[CONT_EM6] + ',' + 
		PC.[CONT_EM7] + ',' + 
		PC.[CONF_EM1] + ',' + 
		PC.[CONF_EM2] + ',' + 
		PC.[CONF_EM3] + ',' + 
		PC.[CONF_EM4] + ',' + 
		PC.[CONF_EM5] + ',' + 
		PC.[CONF_EM6] + ',' + 
		PC.[CONF_EM7] + ',' + 
		PC.[CONF_VENCI] + ',' + 
		PC.[ACT_MTM] + ',' + 
		PC.[PRIOR_MTM] + ',' + 
		PC.[MTM_EMAIL1] + ',' + 
		PC.[MTM_EMAIL2] + ',' + 
		PC.[MTM_EMAIL3] + ',' + 
		PC.[MTM_EMAIL4] + ',' + 
		PC.[MTM_EMAIL5] + ',' + 
		PC.[MTM_EMAIL6] + ',' + 
		PC.[MTM_EMAIL7] + ',' + 
--		PC.[MTM_EMAIL8] + ',' + 
		PC.[COLAT_EML] + ',' + 
		PC.[PTAGMT_ID] + ',' + 
		PC.[AGMT_ID] + ',' + 
		PC.[GRC_PERIOD] + ',' + 
		PC.[VER_PERIOD] + ',' + 
		PC.[ESCA_EMAIL] + ',' + 
		PC.[CTP_ATRIB] + ',' + 
		PC.[COMDER_ELI] + ',' + 
		PC.[DOC_FOREIG] + ',' + 
		PC.[DOC_LOCAL] + ',' + 
		PC.[DOC_LOCAL2] + ',' + 
		PC.[CONTR_COD] + ',' + 
		PC.[FECHA_DCV] + ',' + 
		PC.[COLATERALI] + ',' + 
		PC.[COLA_GARAN] + ',' + 
		PC.[THRESHOLD] + ',' + 
		PC.[THRES_AMOUNT] + ',' + 
		PC.[HAIRCUT] + ',' + 
		PC.[MTA] + ',' + 
		PC.[VAL_CURR] + ',' + 
		PC.[ENABLE_FWD] + ',' + 
		PC.[ENABLE_OPT] + ',' + 
		PC.[ENABLE_SPT] + ',' + 
		PC.[SEND_CONFIRMATION] + ',' + 
		PC.[TAX_ID] + ',' + 
		PC.[CLI_RELACI] + ',' + 
		PC.[TIPO_RELAC] + ',' + 
		PC.[EXCE_SOTUS] + ',' + 
		PC.[CANAL] + ',' + 
		PC.[SEGM_ITAU] + ',' + 
		PC.[JEFE_GRUPO] + ',' + 
		PC.[GERENCIA] + ',' + 
		PC.[DIVISION] + ',' + 
		PC.[CTP_TYPE] + ',' + 
		PC.[MEDIA_PDF] + ',' + 
		PC.[APOD_ACT1] + ',' + 
		PC.[APOD_ACT2] + ',' + 
		PC.[CLT_APOD1] + ',' + 
		PC.[APOD_RUT1] + ',' + 
		PC.[CLT_APOD2] + ',' + 
		PC.[APOD_RUT2] + ',' + 
		PC.[CLT_APOD3] + ',' + 
		PC.[APOD_RUT3] + ',' + 
		PC.[CLT_APOD4] + ',' + 
		PC.[APOD_RUT4] + ',' + 
		PC.[CLT_APOD5] + ',' + 
		PC.[APOD_RUT5] + ',' + 
		PC.[CLT_APOD6] + ',' + 
		PC.[APOD_RUT6] + ',' + 
		PC.[CLT_APOD7] + ',' + 
		PC.[APOD_RUT7] + ',' + 
		PC.[CLT_APOD8] + ',' + 
		PC.[APOD_RUT8] + ',' + 
		PC.[CLT_APOD9] + ',' + 
		PC.[APOD_RUT9] + ',' + 
		PC.[CLT_APOD10] + ',' + 
		PC.[APOD_RUT10] + ',' + 
		PC.[STATUS] + ',' + 
		PC.[VALIDITY_ATTRIBUTE] + ',' + 
		PC.[CMM_SI_PREFERENCE] + ',' + 
		PC.[SI_MODE] + ',' + 
		PC.[CI_MODE] + ',' + 
		PC.[SWIFT] + ',' + 
		PC.[CONFIRMACION VENC 2] + ',' + 
		PC.[CONFIRMACION VENC 3] + ',' + 
		PC.[CONFIRMACION VENC 4] + ',' + 
		PC.[CONFIRMACION VENC 5] + ',' + 
		PC.[CONFIRMACION VENC 6] + ',' + 
		PC.[CONFIRMACION VENC 7] + ',' + 
		PC.[COLAT_EML 2] + ',' + 
		PC.[COLAT_EML 3] + ',' +  
		PC.[COLAT_EML 4] + ',' +  
		PC.[COLAT_EML 5]
	FROM 	
		#pasoContraparte2 AS PC 
--		order by partyName desc)
--where PC.[SWIFT] <> '-'
	ORDER BY 
		1 DESC

--SELECT * FROM #pasoContraparte2 AS PC




END 
GO
