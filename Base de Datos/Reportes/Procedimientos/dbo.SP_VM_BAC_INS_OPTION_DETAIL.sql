USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_INS_OPTION_DETAIL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--BEGIN TRAN

-- ================================================

-- =============================================
---- Author:		SONDA S.A.
---- Create date: 13-02.2020
---- Description:	INTERFAZ VMETRIX INSTRUMENT
---- =============================================

--EXEC SP_VM_BAC_INS_OPTION_DETAIL
CREATE PROCEDURE [dbo].[SP_VM_BAC_INS_OPTION_DETAIL]
AS BEGIN  

	SET NOCOUNT ON 
 
	DECLARE @SEP VARCHAR(1); SET @SEP  = ',' 
    
	CREATE TABLE #VM_BAC_INS_OPTION_DETAIL( 
		INSOD_ID int, 
		CCY_ID_PREMIUM int, 
		SD_ID int, 
		INS_ID int, 
		OPTYPE_ID int, 
		PC_ID int, 
		INSOD_SPOT float, 
		INSOD_STRIKE float, 
		--INSOD_PREMIUM float, 
		INSOD_PREMIUM numeric(20, 5),
		INSOD_PREMIUM_DATE datetime)

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	CREATE TABLE #VM_BAC_INS_OPTION_DETAIL_SALIDA(
		INS_ID     Int,		--PARA COMPATIBILIDAD DE SALIDA
		REG_SALIDA			Varchar(500))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512 
	
	--	De/Para	BASE_CCY_ID
	SELECT "mu_BASE_CCY_ID" = 0, Cod_BAC = 'CLP' INTO #PasoBASE_CCY UNION
	SELECT "mu_BASE_CCY_ID" = 51, Cod_BAC = 'JPY' UNION
	SELECT "mu_BASE_CCY_ID" = 52, Cod_BAC = 'GBP' UNION
	SELECT "mu_BASE_CCY_ID" = 53, Cod_BAC = 'CHF' UNION
	SELECT "mu_BASE_CCY_ID" = 54, Cod_BAC = 'CAD' UNION
	SELECT "mu_BASE_CCY_ID" = 55, Cod_BAC = 'AUD' UNION
	SELECT "mu_BASE_CCY_ID" = 56, Cod_BAC = 'SEK' UNION
	SELECT "mu_BASE_CCY_ID" = 57, Cod_BAC = 'DKK' UNION
	SELECT "mu_BASE_CCY_ID" = 58, Cod_BAC = 'NOK' UNION
	SELECT "mu_BASE_CCY_ID" = 59, Cod_BAC = 'NZD' UNION
	SELECT "mu_BASE_CCY_ID" = 60, Cod_BAC = 'EUR' UNION
	SELECT "mu_BASE_CCY_ID" = 61, Cod_BAC = 'USD' UNION
	SELECT "mu_BASE_CCY_ID" = 62, Cod_BAC = 'CLF' UNION
	SELECT "mu_BASE_CCY_ID" = 63, Cod_BAC = 'BRL' UNION
	SELECT "mu_BASE_CCY_ID" = 64, Cod_BAC = 'ZAR' UNION
	SELECT "mu_BASE_CCY_ID" = 65, Cod_BAC = 'CNY' UNION
	SELECT "mu_BASE_CCY_ID" = 66, Cod_BAC = 'MXN' UNION
	SELECT "mu_BASE_CCY_ID" = 67, Cod_BAC = 'COP' UNION
	SELECT "mu_BASE_CCY_ID" = 68, Cod_BAC = 'HKD' UNION
	SELECT "mu_BASE_CCY_ID" = 69, Cod_BAC = 'PEN' 
	--SELECT * FROM #PasoBASE_CCY 
	
	DECLARE @OPTION_TYPE_American AS INT; SET @OPTION_TYPE_American = 0;   --American
	DECLARE @OPTION_TYPE_European AS INT; SET @OPTION_TYPE_European = 1;   --European
	DECLARE @OPTION_TYPE_Bermudan AS INT; SET @OPTION_TYPE_Bermudan = 2;   --Bermudan



	-->>RUTINA DEFINION OPTYPE SIID
	/*
	if exists(select name from tempdb..sysobjects where type='u' and name like '#OPTYPE%')
	begin 
		drop table #OPTYPE
	end
	*/
	create table #OPTYPE
	(
		 OpcEstCod		char(10)
		,OpcEstDsc		char(50)
		,OPTYPE_ID		char(10)
		,OPTYPE_NAME	char(50)
	)
	-->INSERCION DE VALORE CRUCE
	insert into #OPTYPE select '0'	,'Vanilla'						,'1'	,'European'
	insert into #OPTYPE select '2'	,'Collar (Risk Reversal)'	,'1'	,'European'
	insert into #OPTYPE select '5'	,'Forward Perdida Acotada'	,'1'	,'European'
	insert into #OPTYPE select '6'	,'Forward Asiático'			,'3'	,'Asiático'
	insert into #OPTYPE select '8'	,'Forward Americano'			,'0'	,'American'
	insert into #OPTYPE select '11'	,'Call Spread'					,'1'	,'European'
	insert into #OPTYPE select '13'	,'Forward Entrada Salida'	,'3'	,'Asiático'
	--select * from #OPTYPE
	--<<RUTINA DEFINION OPTYPE SIID

	-- ================================================
	-- OPCIONES
	-- ================================================
	INSERT INTO #VM_BAC_INS_OPTION_DETAIL
	SELECT DISTINCT --TOP 0 
		--INSOD_ID = CAST(DC.CaNumEstructura AS VARCHAR(10)), 
		INSOD_ID = CAST(EC.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10)), 
		CCY_ID_PREMIUM = ISNULL(CCP.mu_BASE_CCY_ID, 0), 
		SD_ID = CAST(DC.CaNumEstructura AS VARCHAR(10)),	--0, 
		INS_ID = CAST(EC.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10)), 
		OPTYPE_ID = ISNULL(T.OPTYPE_ID,'0'),-->>RUTINA DEFINION OPTYPE SIID @OPTION_TYPE_European,		-- valores VERIFICAR!!!!!
		PC_ID = CASE WHEN UPPER(DC.CaCallPut) = 'CALL' THEN 1 ELSE 0 END, 
		INSOD_SPOT = dc.CaSpotDet, 
		INSOD_STRIKE = DC.CaStrike, 
		INSOD_PREMIUM = EC.CaPrimaInicial,-->>20210602 EC.CaPrimaCosto, 
		INSOD_PREMIUM_DATE = EC.CaFechaPagoPrima
	FROM CbMdbOpc..CaEncContrato AS EC INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = EC.CanumContrato
		LEFT JOIN BacParamSuda.dbo.MONEDA AS MN ON 
			mn.mncodmon = EC.CaMonPrimaCosto	--CaCodMon1	
		INNER JOIN #PasoBASE_CCY AS CCP ON
			CCP.Cod_BAC = MN.mnnemo 
	LEFT JOIN #OPTYPE AS T  ON T.OpcEstCod = EC.cacodestructura-->>RUTINA DEFINION OPTYPE SIID			
	WHERE
		EC.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113
	
	INSERT INTO #VM_BAC_INS_OPTION_DETAIL_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"INS_ID" = INS_ID, 
			LTRIM(INSOD_ID) + @SEP + 
			LTRIM(CCY_ID_PREMIUM) + @SEP + 
			LTRIM(SD_ID) + @SEP + 
			LTRIM(INS_ID) + @SEP + 
			LTRIM(OPTYPE_ID) + @SEP + 
			LTRIM(PC_ID) + @SEP + 
			LTRIM(INSOD_SPOT) + @SEP + 
			LTRIM(INSOD_STRIKE) + @SEP + 
			LTRIM(INSOD_PREMIUM) + @SEP + 
			LTRIM(CONVERT(VARCHAR(20),INSOD_PREMIUM_DATE,103))
		AS REG_SALIDA
		FROM #VM_BAC_INS_OPTION_DETAIL
 --ORDER BY 1 


	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512      
	INSERT INTO #VM_BAC_INS_OPTION_DETAIL_SALIDA
		SELECT 
			"INS_ID" = -999, 
			"REG_SALIDA" = 'INSOD_ID' + @SEP 
							+ 'CCY_ID_PREMIUM' + @SEP 
							+ 'SD_ID' + @SEP 
							+ 'INS_ID' + @SEP 
							+ 'OPTYPE_ID' + @SEP 
							+ 'PC_ID' + @SEP 
							+ 'INSOD_SPOT' + @SEP 
							+ 'INSOD_STRIKE' + @SEP 
							+ 'INSOD_PREMIUM'	+ @SEP 
							+ 'INSOD_PREMIUM_DATE' 

	SELECT REG_SALIDA FROM #VM_BAC_INS_OPTION_DETAIL_SALIDA 
	ORDER BY INS_ID	--1
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
      
      
	DROP TABLE #VM_BAC_INS_OPTION_DETAIL
	DROP TABLE #VM_BAC_INS_OPTION_DETAIL_SALIDA

END
--ROLLBACK TRAN
GO
