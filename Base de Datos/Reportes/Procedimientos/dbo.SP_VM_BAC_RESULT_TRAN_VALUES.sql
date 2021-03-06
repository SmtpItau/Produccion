USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_RESULT_TRAN_VALUES]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--IF OBJECT_ID('SP_VM_BAC_RESULT_TRAN_VALUES')>0
--	DROP PROCEDURE DBO.SP_VM_BAC_RESULT_TRAN_VALUES
--GO

-- =============================================
-- Author:          SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX RESULT_TRAN_VALUES
-- =============================================

--20200625 - PLL - Se asigna correlativo de salida a campo RTV_ID
--20200903 - PLL - Se modifica formato campos date y datetime (dd/MM/aaaa y dd/MM/aaaa hh:mm) - Camilo
--20201109 - PLL - Se corrigen valores de datos de campo SD_ID valores deben ser >=1
--20201111 - PLL - Se corrigen patas de FWD

-- EXEC SP_VM_BAC_RESULT_TRAN_VALUES
CREATE PROCEDURE [dbo].[SP_VM_BAC_RESULT_TRAN_VALUES]
AS BEGIN 

--BEGIN TRAN

SET NOCOUNT ON 
 
DECLARE @SEP VARCHAR(1); SET @SEP = ','
DECLARE @Fecha_Proceso DATETIME ; SET @Fecha_Proceso = ISNULL((SELECT acfecproc FROM BACFWDSUDA..MFAC), '')
DECLARE @soloSWAP VARCHAR(1); SET @soloSWAP = 'N'




--Códigos validados para salida de Datos - Camilo - email 22/09/2020
--		Catalogo SAT			Campos RTT posibles
--..................................................
--0	MTM					= pricing_mtm
--12	Realized P&L		= pricing_pnl
--13	FX P/L Unrealized	= pricing_pnl_fx_unrealized
--27	Base MTM				= pricing_base_mtm
--32	Base MTM ITAU		= pricing_base_mtm_itau
--39	NV Total By Leg Result	= interest_payment

DECLARE @MTM AS INT; SET @MTM = 0
DECLARE @Realized_PnL AS INT; SET @Realized_PnL = 12
DECLARE @FX_PnL_Unrealized AS INT;SET @FX_PnL_Unrealized = 13
DECLARE @Base_MTM AS INT;SET @Base_MTM = 27
DECLARE @Base_MTM_ITAU AS INT;	SET @Base_MTM_ITAU = 32
DECLARE @NV_Total AS INT;	SET @NV_Total = 39

--CATALOGO OPCIONES	-- SIID
DECLARE @RT_Delta AS INT; SET @RT_Delta = 1;   --Para opciones	
DECLARE @RT_Gamma AS INT; SET @RT_Gamma = 2;   --Para opciones	
DECLARE @RT_Delta_by_Trans AS INT; SET @RT_Delta_by_Trans = 3;   --Para opciones	
DECLARE @RT_Gamma_by_Trans AS INT; SET @RT_Gamma_by_Trans = 4;   --Para opciones	
DECLARE @RT_Vega AS INT; SET @RT_Vega = 5;   --Para opciones	
DECLARE @RT_Vega_By_Trans AS INT; SET @RT_Vega_By_Trans = 6;   --Para opciones	
DECLARE @RT_Theta AS INT; SET @RT_Theta = 7;   --Para opciones	
DECLARE @RT_Gamma_By_Leg_Result AS INT; SET @RT_Gamma_By_Leg_Result = 17;   --Para opciones	
DECLARE @RT_Vega_By_Leg_Result AS INT; SET @RT_Vega_By_Leg_Result = 20;   --Para opciones	
DECLARE @RT_Theta_By_Leg_Result AS INT; SET @RT_Theta_By_Leg_Result = 21;   --Para opciones	
DECLARE @RT_Vol_By_Leg_Result AS INT; SET @RT_Vol_By_Leg_Result = 22;   --Para opciones	
DECLARE @RT_Price_By_Leg_Result AS INT; SET @RT_Price_By_Leg_Result = 23;   --Para opciones	
DECLARE @RT_Delta_Spot AS INT; SET @RT_Delta_Spot = 33;   --Para opciones	
DECLARE @RT_Delta_Forward AS INT; SET @RT_Delta_Forward = 34;   --Para opciones	
DECLARE @RT_Vanna AS INT; SET @RT_Vanna = 35;   --Para opciones	
DECLARE @RT_Rhodomestic AS INT; SET @RT_Rhodomestic = 36;   --Para opciones	
DECLARE @RT_Rhoforeing AS INT; SET @RT_Rhoforeing = 37;   --Para opciones	
DECLARE @RT_Charm AS INT; SET @RT_Charm = 38;   --Para opciones	


	CREATE TABLE #VM_BAC_RESULT_TRAN_VALUES
               ( RTV_ID      INT
               , TRAN_ID     INT
               , RC_ID       INT
               , SD_ID       INT
               , CRVND_ID    INT
               , RTV_DATE    VARCHAR(20)
               , RTV_VALUE   NUMERIC(20,5))


	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512
	
	CREATE TABLE #VM_BAC_RESULT_TRAN_VALUES_SALIDA
	(
	RTV_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	TRAN_ID				INT,		--PARA COMPATIBILIDAD DE SALIDA
	SD_ID					INT,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512




	-- ================================================
	-- SWAPS - RECIBIMOS
	-- ================================================

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @MTM              -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @MTM					 --0 -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO         -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   = ISNULL(CASE WHEN  CAB.modalidad_pago = 'C' THEN    
							CASE WHEN C.clpais <> 6 THEN  CONVERT(VARCHAR,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(CAB.numero_operacion,1),13),N'#0.########################'))   
								ELSE CONVERT(VARCHAR,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(CAB.numero_operacion,1),999),N'#0.########################'))   END  
							ELSE       
							  CONVERT(VARCHAR,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(CAB.numero_operacion,1),CAB.recibimos_moneda),N'#0.########################'))   
							END , 0)
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacParamSuda.dbo.cliente AS C with(nolock) ON 
		C.clrut  = CAB.rut_cliente AND 
		C.clcodigo = CAB.codigo_cliente  
	WHERE 
		CAB.TIPO_FLUJO =1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @Realized_PnL         -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @Realized_PnL         -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO        -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   =  ISNULL((SELECT (ISNULL(a.compra_amortiza, 0) + ISNULL(a.compra_interes, 0))  
								FROM BacSwapSuda.dbo.CarteraHis a 
								WHERE numero_operacion IN (CAB.numero_operacion)  
								 AND a.fecha_vence_flujo = (SELECT MAX (fecha_vence_flujo) FROM BacSwapSuda.dbo.CarteraHis h WHERE h.numero_operacion = CAB.numero_operacion and tipo_flujo = CAB.TIPO_FLUJO)  
								 AND a.tipo_flujo = CAB.TIPO_FLUJO)  
								 , 0)
		
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO =1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @FX_PnL_Unrealized     -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @FX_PnL_Unrealized     -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO         -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   = ISNULL((SELECT (ISNULL(compra.compra_valor_presente,0)-ISNULL(venta.venta_valor_presente ,0))  
									  FROM   bacswapsuda.dbo.Cartera compra  
									  LEFT  JOIN (  
													  SELECT numero_operacion, fecha_vence_flujo, venta_valor_presente --*  
													  FROM   bacswapsuda.dbo.Cartera  
													  WHERE  tipo_flujo = 2  
											  )     AS Venta  
											  ON  venta.numero_operacion = compra.numero_operacion  
											  AND  venta.fecha_vence_flujo = compra.fecha_vence_flujo  
									  WHERE  compra.tipo_flujo = 1  
									  AND COMPRA.NUMERO_OPERACION IN (CAB.numero_operacion)  
									  AND compra.numero_flujo = CAB.numero_flujo),0)  
		
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO =1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @Base_MTM              -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @Base_MTM					 --0 -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO         -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   =  ISNULL(COMPRA_MERCADO_CLP, 0)
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO =1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @Base_MTM_ITAU         -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @Base_MTM_ITAU         -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO         -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   =  ISNULL(COMPRA_MERCADO_CLP, 0)
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO =1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @NV_Total         -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @NV_Total					-->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO        -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                    -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   =  ISNULL(CAB.Activo_MO_C08, 0)
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO =1 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

                         
   -- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @MTM              -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @MTM					 --0 -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO         -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
--		, RTV_VALUE   =  COMPRA_MERCADO
--pricing_mtm
		, RTV_VALUE   = ISNULL(CASE WHEN  CAB.modalidad_pago = 'C' THEN    
						CASE WHEN C.clpais <> 6 THEN  CONVERT(VARCHAR,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(CAB.numero_operacion,2)*-1,13),N'#0.########################'))   
							ELSE CONVERT(VARCHAR,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(CAB.numero_operacion,2)*-1,999),N'#0.########################'))   END  
						ELSE       
						  CONVERT(VARCHAR,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(CAB.numero_operacion,2)*-1,CAB.recibimos_moneda),N'#0.########################'))   
						END,0)  
	FROM BACSWAPSUDA..CARTERA AS CAB INNER JOIN BacParamSuda.dbo.cliente AS C with(nolock) ON 
		C.clrut  = CAB.rut_cliente AND 
		C.clcodigo = CAB.codigo_cliente  
	WHERE 
		CAB.TIPO_FLUJO =2 AND CAB.ESTADO_FLUJO = 1 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones


	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @Realized_PnL         -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @Realized_PnL         -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO        -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                    -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   =  ISNULL((SELECT (ISNULL(a.venta_amortiza, 0) + ISNULL(a.venta_interes, 0)) 
								FROM BacSwapSuda.dbo.CarteraHis a 
								WHERE numero_operacion IN (CAB.numero_operacion)  
								 AND a.fecha_vence_flujo = (SELECT MAX (fecha_vence_flujo) FROM BacSwapSuda.dbo.CarteraHis h WHERE h.numero_operacion = CAB.numero_operacion and tipo_flujo = CAB.TIPO_FLUJO)  
								 AND a.tipo_flujo = CAB.TIPO_FLUJO), 0)
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO =2 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones



	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID    =  @FX_PnL_Unrealized     -->> MTM
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, RC_ID       =  @FX_PnL_Unrealized     -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       =  CAB.TIPO_FLUJO         -->> 0-FIXED/1-FLOAT
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		--, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
		, RTV_VALUE   = ISNULL((SELECT (ISNULL(compra.compra_valor_presente,0)-ISNULL(venta.venta_valor_presente ,0))  
									  FROM   bacswapsuda.dbo.Cartera compra  
									  LEFT  JOIN (  
													  SELECT numero_operacion, fecha_vence_flujo, venta_valor_presente --*  
													  FROM   bacswapsuda.dbo.Cartera  
													  WHERE  tipo_flujo = 2  
											  )     AS Venta  
											  ON  venta.numero_operacion = compra.numero_operacion  
											  AND  venta.fecha_vence_flujo = compra.fecha_vence_flujo  
									  WHERE  compra.tipo_flujo = 1  
									  AND COMPRA.NUMERO_OPERACION IN (CAB.numero_operacion)  
									  AND compra.numero_flujo = CAB.numero_flujo),0)  
		
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO = 2 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

			
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID      =  @Base_MTM					-->> MTM
         , TRAN_ID     =  CAB.NUMERO_OPERACION
         , RC_ID       =  @Base_MTM					-->> *** PENDIENTE DE DEFINICION ****
         , SD_ID       =  CAB.TIPO_FLUJO				-->> 0-FIXED/1-FLOAT
         , CRVND_ID    =  -1							-->> FIJO (-1)
         --, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
         , RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
         , RTV_VALUE   =  ISNULL(VENTA_MERCADO_CLP, 0) * -1
	FROM BACSWAPSUDA..CARTERA AS CAB      
	WHERE CAB.TIPO_FLUJO =2 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones


	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID      =  @Base_MTM_ITAU			-->> MTM
         , TRAN_ID     =  CAB.NUMERO_OPERACION
         , RC_ID       =  @Base_MTM_ITAU			-->> *** PENDIENTE DE DEFINICION ****
         , SD_ID       =  CAB.TIPO_FLUJO				-->> 0-FIXED/1-FLOAT
         , CRVND_ID    =  -1							-->> FIJO (-1)
         --, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
         , RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
         , RTV_VALUE   =  ISNULL(VENTA_MERCADO_CLP, 0) * -1
	FROM BACSWAPSUDA..CARTERA AS CAB      
	WHERE CAB.TIPO_FLUJO =2 AND CAB.ESTADO_FLUJO = 1 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID      =  @NV_Total			-->> MTM
         , TRAN_ID     =  CAB.NUMERO_OPERACION
         , RC_ID       =  @NV_Total			-->> *** PENDIENTE DE DEFINICION ****
         , SD_ID       =  CAB.TIPO_FLUJO	-->> 0-FIXED/1-FLOAT
         , CRVND_ID    =  -1					-->> FIJO (-1)
         --, RTV_DATE    =  CONVERT(CHAR(10),fecha_valoriza,120)  
         , RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),fecha_valoriza,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),fecha_valoriza,108))
         , RTV_VALUE   =  ISNULL(CAB.Pasivo_MO_C08, 0) * -1
	FROM BACSWAPSUDA..CARTERA AS CAB      
	WHERE CAB.TIPO_FLUJO =2 AND CAB.ESTADO_FLUJO = 1 
   and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones




	-- ================================================
	-- FORWARD - RECIBIMOS (COMPRAS)
	-- ================================================
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
	--		"@MTM" = '@MTM_FWD_C_1',
			RTV_ID     =  @MTM
		, TRAN_ID     =  CAB.CANUMOPER
		, RC_ID       =  @MTM                      -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRA/1-VENTAS
		, SD_ID       =  1	-->> 1-RECIBIMOS/2-PAGAMOS
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
		, RTV_VALUE   =  --CASE WHEN  catipmoda = 'C' THEN    
									CASE WHEN CLIE.PaisCliente <> 6 THEN  
										convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################'))   
									ELSE 
										convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   
									END  
								--ELSE       
								--	convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################'))   
								--END  
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'C' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
--		"@MTM" = '@MTM_FWD_C_2',
			RTV_ID     =  @MTM
		, TRAN_ID     =  CAB.CANUMOPER
		, RC_ID       =  @MTM                      -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRA/1-VENTAS
		, SD_ID       =  2	-->> 1-RECIBIMOS/2-PAGAMOS
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
		, RTV_VALUE   =  --CASE WHEN  catipmoda = 'C' THEN    
								--	CASE WHEN CLIE.PaisCliente <> 6 THEN  
								--		convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################'))   
								--	ELSE 
								--		convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   
								--	END  
								--ELSE       
									convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo,cacodmon2),N'#0.########################'))   
								--END  
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'C' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4


	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
--			"@Base_MTM" = '@Base_MTM_FWD_C_1',
			RTV_ID     =  @Base_MTM
		, TRAN_ID     =  CAB.CANUMOPER
		, RC_ID       =  @Base_MTM                      -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRA/1-VENTA
		, SD_ID       =  1	--1=Pata Recibimos/2=Pagamos
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
		, RTV_VALUE   =  convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))  
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'C' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
--			"@Base_MTM" = '@Base_MTM_FWD_C_2',
			RTV_ID     =  @Base_MTM
		, TRAN_ID     =  CAB.CANUMOPER
		, RC_ID       =  @Base_MTM                      -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRA/1-VENTA
		, SD_ID       =  2	--1=Pata Recibimos/2=Pagamos
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
--		, RTV_VALUE   =  convert(varchar,format((valorrazonablePasivo) ,N'#0.########################'))  
		, RTV_VALUE   =  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################'))   

	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'C' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4


	--INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	--SELECT --"@Base_MTM_ITAU" = '@Base_MTM_ITAU_FWD_C',
	--		RTV_ID     =  @Base_MTM_ITAU
	--	, TRAN_ID     =  CAB.CANUMOPER
	--	, RC_ID       =  0                      -->> *** PENDIENTE DE DEFINICION ****
	--	, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRAS/1-VENTAS
	--	, CRVND_ID    =  -1                     -->> FIJO (-1)
	--	, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
	--	, RTV_VALUE   =  convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))  
	--FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
	--	(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
	--	FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
	--		CLIE.clrut  =cacodigo AND 
	--		CLIE.clcodigo = cacodcli  
	--WHERE 
	--	CATIPOPER = 'C' AND
	--	NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	-- ================================================
	-- FORWARD - RECIBIMOS (VENTAS)
	-- ================================================
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
--			"@MTM" = '@MTM_FWD_V_2',  
			RTV_ID      = @MTM  -->> MTM
		, TRAN_ID     = CAB.CANUMOPER
		, RC_ID       = @MTM   -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       = CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRAS/1-VENTAS
		, SD_ID       = 2	-->> 1-RECIBIMOS/2-PAGAMOS
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
--		, RTV_VALUE   = ValorRazonableActivo 
		, RTV_VALUE   = 	--CASE WHEN  catipmoda = 'C' THEN    
									CASE WHEN Clie.PaisCliente <> 6 THEN 
										convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,13),N'#0.########################'))     
									ELSE 
										convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,999),N'#0.########################'))   
									END  
								--ELSE       
								--	convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,cacodmon1),N'#0.########################'))  
  								--END  
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'V' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4		  

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
--		"@MTM" = '@MTM_FWD_V_1',  
			RTV_ID      = @MTM  -->> MTM
		, TRAN_ID     = CAB.CANUMOPER
		, RC_ID       = @MTM   -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       = CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRAS/1-VENTAS
		, SD_ID       = 1	-->> 1-RECIBIMOS/2-PAGAMOS
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
--		, RTV_VALUE   = ValorRazonableActivo 
		, RTV_VALUE   = 	--CASE WHEN  catipmoda = 'C' THEN    
									--CASE WHEN Clie.PaisCliente <> 6 THEN 
									--	convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,13),N'#0.########################'))     
									--ELSE 
									--	convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,999),N'#0.########################'))   
									--END  
								--ELSE       
									convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo*-1,cacodmon1),N'#0.########################'))  
  								--END  
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'V' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4	
	
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT
--			"@Base_MTM" = '@Base_MTM_FWD_V_1',
			RTV_ID     =  @Base_MTM
		, TRAN_ID     =  CAB.CANUMOPER
		, RC_ID       =  @Base_MTM                      -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRAS/1-VENTAS
		, SD_ID       =  1		--1=Pata Recibbimos/2=Pagamos
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
		--, RTV_VALUE   =  convert(varchar,format((valorrazonableACTIVO) ,N'#0.########################')) 
--		, RTV_VALUE   =  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,cacodmon1),N'#0.########################'))  
		, RTV_VALUE   =  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo*-1,cacodmon1),N'#0.########################'))  
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'V' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4
	
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT 
--			"@Base_MTM" = '@Base_MTM_FWD_V_2',
			RTV_ID     =  @Base_MTM
		, TRAN_ID     =  CAB.CANUMOPER
		, RC_ID       =  @Base_MTM                      -->> *** PENDIENTE DE DEFINICION ****
		--, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRAS/1-VENTAS
		, SD_ID       =  2		--1=Pata Recibimos/2=Pagamos
		, CRVND_ID    =  -1                     -->> FIJO (-1)
		, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
--		, RTV_VALUE   =  convert(varchar,format((valorrazonableactivo *-1) ,N'#0.########################')) 
		, RTV_VALUE   =  CASE WHEN Clie.PaisCliente <> 6 THEN 
									convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,13),N'#0.########################'))     
								ELSE 
									convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,999),N'#0.########################'))   
								END  

	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
		(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
		FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
			CLIE.clrut  =cacodigo AND 
			CLIE.clcodigo = cacodcli  
	WHERE 
		CATIPOPER = 'V' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
--AND CAB.CANUMOPER = 616227 ORDER BY 2, 1, 4
	
	--INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	--SELECT --"@Base_MTM_ITAU" = '@Base_MTM_ITAU_FWD_V',
	--		RTV_ID     =  @Base_MTM_ITAU
	--	, TRAN_ID     =  CAB.CANUMOPER
	--	, RC_ID       =  @Base_MTM_ITAU                      -->> *** PENDIENTE DE DEFINICION ****
	--	, SD_ID       =  CASE WHEN CATIPOPER = 'C' THEN 1 ELSE 2 END      -->> 0-COMPRAS/1-VENTAS
	--	, CRVND_ID    =  -1                     -->> FIJO (-1)
	--	, RTV_DATE    =  LTRIM(CONVERT(VARCHAR(20),@Fecha_Proceso,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),@Fecha_Proceso,108))
	--	, RTV_VALUE   =  convert(varchar,format((valorrazonablepasivo *-1  ) ,N'#0.########################')) 
	--FROM BACFWDSUDA..MFCA AS CAB INNER JOIN 
	--	(SELECT clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais   
	--	FROM BacParamSuda.dbo.cliente WITH(NOLOCK)) AS CLIE ON 
	--		CLIE.clrut  =cacodigo AND 
	--		CLIE.clcodigo = cacodcli  
	--WHERE 
	--	CATIPOPER = 'V' AND
	--	NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

		  
		  
	-- ================================================
	-- OPCIONES
	-- ================================================
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0
--			"@MTM" = '@MTM', 
			RTV_ID      = @MTM
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, RC_ID       = @MTM   -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       = DET.CaNumEstructura
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
		, RTV_VALUE   = case when DET.CaModalidad = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,DET.CaVrDet,DET.CaMdaCompensacion),N'#0.########################')) ELSE   
						 convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,DET.CaVrDet, DET.CaCodMon1),N'#0.########################')) END  		
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 
--			"@Realized_PnL" = '@Realized_PnL', 
			RTV_ID      = @Realized_PnL
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, RC_ID       = @Realized_PnL   -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       = DET.CaNumEstructura
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
		, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(ISNULL((DET.CaPrimaInicialDetML 
															+ ISNULL((SELECT sum(CaMTMImplicito)  
																		FROM CbMdbOpc.dbo.CaResCaja   
																		WHERE CaNumContrato = DET.CaNumContrato    
																				AND CaCajOrigen = 'PV' 
																		GROUP BY CaNumContrato),0)), 0),N'#0.########################'))  

	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 
--			"@FX_PnL_Unrealized" = '@FX_PnL_Unrealized', 
			RTV_ID      = @FX_PnL_Unrealized
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, RC_ID       = @FX_PnL_Unrealized   -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       = DET.CaNumEstructura
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
		, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(DET.CaVrDet,N'#0.########################')) 
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 
--			"@Base_MTM" = '@Base_MTM', 
			RTV_ID      = @Base_MTM
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, RC_ID       = @Base_MTM   -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       = DET.CaNumEstructura
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
		, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(DET.CaVrDet,N'#0.########################'))  
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 
--			"@Base_MTM_ITAU" = '@Base_MTM_ITAU', 
			RTV_ID      = @Base_MTM_ITAU
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, RC_ID       = @Base_MTM_ITAU   -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       = DET.CaNumEstructura
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
		, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(DET.CaVrDet,N'#0.########################'))
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 
--			"@NV_Total" = '@NV_Total', 
			RTV_ID      = @NV_Total
		, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, RC_ID       = @NV_Total   -->> *** PENDIENTE DE DEFINICION ****
		, SD_ID       = DET.CaNumEstructura
		, CRVND_ID    = -1 -->> FIJO (-1)
		, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),DET.CaFechaPagMon1,103))
		, RTV_VALUE   = 0
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887


	--DELTAS
	--DECLARE @RT_Delta_by_Trans AS INT; SET @RT_Delta_by_Trans = 3;   --Para opciones	

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0
--				"@RT_Delta" = '@RT_Delta',
				RTV_ID      = @RT_Delta  -->> MTM
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Delta   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(CAB.CaDeltaForwardCont,N'#0.########################'))  				
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	--			LEFT JOIN BACPARAMSUDA..USUARIO AS U   ON U.USUARIO = CAB.CAOPERADOR 		
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  


	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0--"@RT_Delta_Spot" = '@RT_Delta_Spot',
				RTV_ID      = @RT_Delta_Spot
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Delta_Spot   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(DET.CaDelta_spot,N'#0.########################')) 
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	--			LEFT JOIN BACPARAMSUDA..USUARIO AS U   ON U.USUARIO = CAB.CAOPERADOR 		
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 --"@RT_Delta_Forward" = '@RT_Delta_Forward',
				RTV_ID      = @RT_Delta_Forward
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Delta_Forward   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(DET.CaDelta_fwd,N'#0.########################')) 
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	--			LEFT JOIN BACPARAMSUDA..USUARIO AS U   ON U.USUARIO = CAB.CAOPERADOR 		
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  


	--GAMMAS
	--DECLARE @RT_Gamma_by_Trans AS INT; SET @RT_Gamma_by_Trans = 4;   --Para opciones	
	--DECLARE @RT_Gamma_By_Leg_Result AS INT; SET @RT_Gamma_By_Leg_Result = 17;   --Para opciones	

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 
--				"@RT_Gamma" = '@RT_Gamma',
				RTV_ID      = @RT_Gamma
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Gamma   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(CAB.CaGammaSpotCont,N'#0.########################'))  
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
--AND CAST(CAB.CanumContrato AS VARCHAR(10)) = 5887

			
	--VEGAS
	--DECLARE @RT_Vega_By_Trans AS INT; SET @RT_Vega_By_Trans = 6;   --Para opciones	
	--DECLARE @RT_Vega_By_Leg_Result AS INT; SET @RT_Vega_By_Leg_Result = 20;   --Para opciones	

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 --"@RT_Vega" = '@RT_Vega',
				RTV_ID      = @RT_Vega
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Vega   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(CAB.CaVegaCont,N'#0.########################')) 
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  


	--THETAS
	--DECLARE @RT_Theta_By_Leg_Result AS INT; SET @RT_Theta_By_Leg_Result = 21;   --Para opciones	

	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0--"@RT_Theta" = '@RT_Theta',
				RTV_ID     = @RT_Theta
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Theta   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(CAB.CaThetaCont,N'#0.########################'))  
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  

	--	RHOS
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 --"@RT_Rhodomestic" = '@RT_Rhodomestic',
				RTV_ID     = @RT_Rhodomestic
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Rhodomestic   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = 0
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
			
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT --TOP 0 --"@RT_Rhoforeing" = '@RT_Rhoforeing',
				RTV_ID     = @RT_Rhoforeing
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Rhoforeing   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(CAB.CaRhoForCont,N'#0.########################')) 
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  
			
	
	
	-->>@RT_Vol_By_Leg_Result  Volatibilidad 20210802
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES
	SELECT RTV_ID     = @RT_Vol_By_Leg_Result
			, TRAN_ID     = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
			, RC_ID       = @RT_Vol_By_Leg_Result   -->> *** PENDIENTE DE DEFINICION ****
			, SD_ID       = DET.CaNumEstructura
			, CRVND_ID    = -1 -->> FIJO (-1)
			, RTV_DATE    = LTRIM(CONVERT(VARCHAR(20),CaFecValorizacion,103))
			, RTV_VALUE   = CONVERT(VARCHAR,FORMAT(DET.CaVol,N'#0.##########')) 
	FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha_Proceso AND 
			CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones 
	-->>@RT_Vol_By_Leg_Result 20210802
  
  --, pricing_volga         = convert(varchar,format(EnContrato.CaVolgaCont,N'#0.########################'))  

--DECLARE @RT_Vol_By_Leg_Result AS INT; SET @RT_Vol_By_Leg_Result = 22;   --Para opciones	
--DECLARE @RT_Price_By_Leg_Result AS INT; SET @RT_Price_By_Leg_Result = 23;   --Para opciones	
--DECLARE @RT_Vanna AS INT; SET @RT_Vanna = 35;   --Para opciones	
--DECLARE @RT_Charm AS INT; SET @RT_Charm = 38;   --Para opciones	
		  
--	END	--solo swap

		
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
--Se asigna correlativo de salida a campo RTV_ID -- PLL-20200625- INI
			"RTV_ID" = RTV_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512		
--			"RTV_ID" = ROW_NUMBER() OVER(ORDER BY TRAN_ID ASC, SD_ID ASC), 
--Se asigna correlativo de salida a campo RTV_ID -- PLL-20200625- FIN		
			"TRAN_ID" = TRAN_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"SD_ID" = SD_ID,			--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
--Se asigna correlativo de salida a campo RTV_ID -- PLL-20200625- INI			
			LTRIM(RTV_ID)          + @SEP
--			LTRIM(ROW_NUMBER() OVER(ORDER BY TRAN_ID ASC, SD_ID ASC)) + @SEP		--RTV_ID
--Se asigna correlativo de salida a campo RTV_ID -- PLL-20200625- FIN
          + LTRIM(TRAN_ID)         + @SEP
          + LTRIM(RC_ID)           + @SEP
          + LTRIM(SD_ID)           + @SEP
          + LTRIM(CRVND_ID)        + @SEP
          + LTRIM(RTV_DATE)        + @SEP
          + LTRIM(RTV_VALUE)		AS REG_SALIDA 
		FROM #VM_BAC_RESULT_TRAN_VALUES
      ORDER BY TRAN_ID, SD_ID 		-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_RESULT_TRAN_VALUES_SALIDA
		SELECT 
			"RTV_ID" = -999,
			"TRAN_ID" = -999,
			"SD_ID" = -999,
			"REG_SALIDA" = 'RTV_ID'	+ @SEP
          + 'TRAN_ID'         + @SEP
          + 'RC_ID'           + @SEP
          + 'SD_ID'           + @SEP
          + 'CRVND_ID'        + @SEP
          + 'RTV_DATE'        + @SEP
          + 'RTV_VALUE' 
		WHERE 
			@Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA 
	FROM #VM_BAC_RESULT_TRAN_VALUES_SALIDA 
	ORDER BY RTV_ID, TRAN_ID, SD_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

		
--SELECT * FROM #VM_BAC_RESULT_TRAN_VALUES WHERE TRAN_ID like('5887%') ORDER BY 2, 1, 4

DROP TABLE #VM_BAC_RESULT_TRAN_VALUES
DROP TABLE #VM_BAC_RESULT_TRAN_VALUES_SALIDA

END
--ROLLBACK TRAN
GO
