USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_USER_TRAN_DEF_DOUBLE]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IF OBJECT_ID('SP_VM_BAC_USER_TRAN_DEF_DOUBLE')>0	
--	DROP PROCEDURE DBO.SP_VM_BAC_USER_TRAN_DEF_DOUBLE
--GO

--EXEC SP_VM_BAC_USER_TRAN_DEF_DOUBLE
CREATE PROC [dbo].[SP_VM_BAC_USER_TRAN_DEF_DOUBLE]
AS BEGIN 



SET NOCOUNT ON 

CREATE TABLE #VM_BAC_USER_TRAN_DEF_DOUBLE
            ( UDT_ID      INT
            , TRAN_ID     INT
            , UTDD_VALUE  VARCHAR(100))

--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
CREATE TABLE #VM_BAC_USER_TRAN_DEF_DOUBLE_SALIDA
(
TRAN_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
UDT_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
REG_SALIDA			Varchar(1000))
--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

 
DECLARE @SEP    VARCHAR(1); SET @SEP    = ','
DECLARE @FECHA  DATETIME; SET @FECHA  = ISNULL((SELECT acfecproc FROM BACFWDSUDA..MFAC), '')
DECLARE @FechaMet5y2 DATETIME;  SELECT @FechaMet5y2 = acfecproc  FROM bactradersuda..mdac

/*
pending
2	Rentabilidad
20	TC USD/CLP Costo
21	TC USD/CLP Cliente
22	Spread USD/CLP
23	Spread USD/DIV
24	Paridad USD/DIV Costo
25	Paridad USD/DIV Cliente
38	FX Spot Cliente
39	FX Fwd Costo
40	FX Fwd Cliente
41	FX Puntos Fwd
42	FX UF Spot
43	FX UF Tasa Costo
44	FX UF Tasa Margen
45	FX UF Tasa Cliente
46	FX Spot Margen
47	FX Fwd Margen
115	WEIGHT
116	PAYOFF
117	Devengo diario de la operación
118	Efecto Reajuste
119	Duración
120	DV01
121	Caja
122	Pyl
141	Devengo Mensual
142	Efecto Reajuste Mensual
143	CAJA Mensual
144	PyL Mensual


*/
DECLARE @Costo AS INT; SET @Costo = 1;   --Corresponde a la tasa de costo para una operación de Swap.
DECLARE @Rentabilidad AS INT; SET @Rentabilidad = 2;   --Calculo exclusivo para las operaciones de mesa de clientes, aplica para todos los productos.
DECLARE @Ntnl_Ref AS INT; SET @Ntnl_Ref = 9;   --Marca el nocional en CLF, para determinar el equivalente en CLP flotante, Swap 
DECLARE @UF_Spot_FX AS INT; SET @UF_Spot_FX = 10;   --Marca la UF de inicio para una operación ICP, aplica para swap.
DECLARE @FX_Spot_Cliente AS INT; SET @FX_Spot_Cliente = 38;   --Corresponde al precio spot 
DECLARE @FX_Fwd_Costo AS INT; SET @FX_Fwd_Costo = 39;   --Corresponde al precio fwd Costo (Spot+Pts.Costo)
DECLARE @FX_Fwd_Cliente AS INT; SET @FX_Fwd_Cliente = 40;   --Corresponde al precio fwd Cliente (Spot+Pts. Costo+Margen)
DECLARE @FX_Puntos_Fwd AS INT; SET @FX_Puntos_Fwd = 41;   --Corresponde a los pts. Fwd de la operación.
DECLARE @FX_Spot_Margen AS INT; SET @FX_Spot_Margen = 46;   --Corresponde al margen entre el precio spot costo y precio spot cliente
DECLARE @FX_Fwd_Margen AS INT; SET @FX_Fwd_Margen = 47;   --Corresponde al margen entre el precio fwd costo y el precio fwd cliente.
DECLARE @Rentabilidad_FX_FWD AS INT; SET @Rentabilidad_FX_FWD = 51;   --Corresponde al resultado de la transacción para las mesas de clientes, el mismo es descontado a una tasa ingresada por el operador.

DECLARE @Devengo_diario_de_la_operacion AS INT; SET @Devengo_diario_de_la_operacion = 117;   --Devengo diario de la operación
DECLARE @Efecto_Reajuste AS INT; SET @Efecto_Reajuste = 118;   --Efecto del Cambio de la moneda no CLP en el resultado mark to market
DECLARE @Duracion AS INT; SET @Duracion = 119;   --Duracion del instrumento
DECLARE @DV01 AS INT; SET @DV01 = 120;   --Sensibilidad a un punto base 
DECLARE @Caja AS INT; SET @Caja = 121;   --monto de desembolso de cajas ya sea por un pago de cupon
DECLARE @Pyl AS INT; SET @Pyl = 122;   --Resultado Diario de la operación


DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512
	
    
    
 --   --===================================================
 --   -- Costo		
 --   --===================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
		 UDT_ID      =  @Costo
		, TRAN_ID     =  CAB.NUMERO_OPERACION
--		, UTDS_VALUE  =   CASE WHEN CAB.compra_valor_tasa > 0 THEN CAB.compra_valor_tasa ELSE - CAB.venta_valor_tasa END
		, UTDS_VALUE  =   CAB.compra_valor_tasa 
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 AND 
		(CAB.compra_valor_tasa <> 0 OR CAB.venta_valor_tasa <> 0) 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and CAB.estado			<>'N'--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
		 UDT_ID      =  @Costo
		, TRAN_ID     =  CAB.NUMERO_OPERACION
--		, UTDS_VALUE  =   CASE WHEN CAB.compra_valor_tasa > 0 THEN CAB.compra_valor_tasa ELSE - CAB.venta_valor_tasa END
		, UTDS_VALUE  =   CAB.compra_valor_tasa 
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 AND 
		(CAB.compra_valor_tasa <> 0 OR CAB.venta_valor_tasa <> 0) 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FechaAnticipo = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	--===================================================
	-- Rentabilidad	
	--===================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
		 UDT_ID      =  @Rentabilidad
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =   CASE WHEN CAB.compra_spread > 0 THEN CAB.compra_spread ELSE -CAB.venta_spread END
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 AND 
		(CAB.compra_spread <> 0 OR CAB.venta_spread <> 0) 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and CAB.estado			<>'N'--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
		 UDT_ID      =  @Rentabilidad
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		, UTDS_VALUE  =   CASE WHEN CAB.compra_spread > 0 THEN CAB.compra_spread ELSE -CAB.venta_spread END
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 AND 
		(CAB.compra_spread <> 0 OR CAB.venta_spread <> 0) 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FechaAnticipo = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	--===================================================
	-- Ntnl Ref
	--===================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
		 UDT_ID      =  @Ntnl_Ref
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		--, UTDS_VALUE  =  CASE WHEN CAB.tipo_flujo = 1 THEN CAB.compra_amortiza  ELSE -CAB.venta_amortiza END * CASE WHEN CAB.IntercPrinc = 1 THEN 1.0 ELSE 0.0 END
		, UTDS_VALUE  =  CAB.compra_capital  
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO = 1 AND 
			CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			and CAB.estado			<>'N'--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
		 UDT_ID      =  @Ntnl_Ref
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		--, UTDS_VALUE  =  CASE WHEN CAB.tipo_flujo = 1 THEN CAB.compra_amortiza  ELSE -CAB.venta_amortiza END * CASE WHEN CAB.IntercPrinc = 1 THEN 1.0 ELSE 0.0 END
		, UTDS_VALUE  =  CAB.compra_capital  
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	WHERE CAB.TIPO_FLUJO = 1 AND 
			CAB.ESTADO_FLUJO = 1 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			AND CAB.FechaAnticipo = @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

    --===================================================
    --	FX Puntos Fwd
    --===================================================
    INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
	       UDT_ID      =  @FX_Puntos_Fwd
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDD_VALUE  =  cab.CaPuntosFwdCierre-->>20210707 convert(varchar,format(abs(catipcam - case when isnull(catipcamSpot,0)=0 then '0' else catipcamSpot END),N'#0.########################'))  
     FROM bacfwdsuda..mfca AS CAB
     --WHERE    CAFECHA=@FECHA 
    
    --===================================================
    --	FX Spot Cliente 
    --===================================================
   INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
	       UDT_ID      =  @FX_Spot_Cliente
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDD_VALUE  =  convert(varchar,format(catipcamSpot,N'#0.########################'))   
	FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 
	
	-- ================================================
	-- FX Fwd Costo
-- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
	       UDT_ID      =  @FX_Fwd_Costo
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDD_VALUE  =  CASE	WHEN cacodpos1 = 1  THEN capreciopunta --catipcam
									WHEN cacodpos1 = 2  THEN convert(varchar,format(caparmon1,N'#0.########################')) --caparmon1 --capremon1
									WHEN cacodpos1 = 3  THEN convert(varchar,format(catipcam,N'#0.########################'))-- catipcam
									WHEN cacodpos1 = 13 THEN convert(varchar,format(catipcam,N'#0.########################'))--catipcam
									ELSE 0
									END 
	FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 
-- ================================================
-- 40 ) FX Fwd Cliente
-- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
	       UDT_ID      =  @FX_Fwd_Cliente
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDD_VALUE  =  case when (caprecal!=0) then convert(varchar,format(caprecal,N'#0.########################')) else convert(varchar,format(catipcam,N'#0.########################'))  end
	FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 
	-- ================================================ 
	--	UF_Spot_FX
	-- ================================================  
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
	       UDT_ID      =  @UF_Spot_FX
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDD_VALUE  =  Case  When (CACODPOS1 = 1 And CACODMON2 =998 ) then 
								convert(varchar,format(catipcamSpot,N'#0.########################')) 
							else
								 '0' 
							End
	FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 
     
	--================================================
	--	47	FX Fwd Margen	 
	-- ================================================     
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT DISTINCT 
	       UDT_ID      =  @FX_Fwd_Margen
         , TRAN_ID     =  CAB.CANUMOPER
         , UTDD_VALUE  = (case when isnull(resultado_mesa,0)='0' or resultado_mesa='' then '0' else convert(varchar,format(Resultado_Mesa,N'#0.########################')) end) 
	FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 
	
	
	--================================================
	--	117;   --Devengo diario de la operación
	--================================================   
	-->20210802  
	--INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	--SELECT 
	--	   UDT_ID    = @Devengo_diario_de_la_operacion
	--	, TRAN_ID    = CAB.CANUMOPER
	--	, UTDD_VALUE = CAST(CAB.VrDevengo AS NUMERIC(25, 10))		--Variación Devengo
	--FROM bacfwdsuda..mfca AS CAB
	----WHERE CAFECHA=@FECHA 

	
	--================================================
	--	118;   --Efecto del Cambio de la moneda no CLP en el resultado mark to market
	--================================================   
	-->>20210802  
	--INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	--SELECT 
	--	   UDT_ID    = @Efecto_Reajuste
	--	, TRAN_ID    = CAB.CANUMOPER
	--	, UTDD_VALUE = 0
	--FROM bacfwdsuda..mfca AS CAB
	----WHERE CAFECHA=@FECHA 

	
	--================================================
	--	119;   --Duracion del instrumento
	--================================================   
	-->>20210802  
	--INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	--SELECT 
	--	   UDT_ID    = @Duracion
	--	, TRAN_ID    = CAB.CANUMOPER
	--	, UTDD_VALUE = datediff( dd, @FechaMet5y2, CAB.CaFecEfectiva ) / 365.0
	--FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 

	--================================================
	--	120;   --Sensibilidad a un punto base 
	--================================================  
	-->>20210802   
	--INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	--SELECT 
	--	   UDT_ID    = @DV01
	--	, TRAN_ID    = CAB.CANUMOPER
	--	, UTDD_VALUE = 0
	--FROM bacfwdsuda..mfca AS CAB
	----WHERE CAFECHA=@FECHA 

	--================================================
	--	122;   --Resultado Diario de la operación
	--================================================     
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT 
		   UDT_ID    = @Pyl
		, TRAN_ID    = CAB.CANUMOPER
		, UTDD_VALUE = 0
	FROM bacfwdsuda..mfca AS CAB
	--WHERE CAFECHA=@FECHA 
		

	--================================================
	-- OPCIONES
	--================================================
	--	117;   --Devengo diario de la operación
	--================================================  
	-->>20210802   
	--INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	--SELECT --TOP 0 
	--	   UDT_ID    = @Devengo_diario_de_la_operacion
	--	, TRAN_ID    = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
	--	, UTDD_VALUE = 0
	--FROM CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
	--		DET.CaNumContrato = CAB.CanumContrato
	--WHERE
	--		--DET.caFechaVcto >= @Fecha_Proceso AND 
	--		CAB.CaEstado <> 'C' --Se excluyen las Cotizaciones  

	--================================================
	--	118;   --Efecto del Cambio de la moneda no CLP en el resultado mark to market
	--================================================     
	-->>20210802
--	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
--	SELECT --TOP 0 
--			UDT_ID    = @Efecto_Reajuste
--		, TRAN_ID    = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
--		, UTDD_VALUE = 0
--	FROM 
--		CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
--			DET.CaNumContrato = CAB.CanumContrato
--	WHERE
----			DET.caFechaVcto >= @Fecha AND 
--			CAB.CaEstado <> 'C'	

	--================================================
	--	119;   --Duracion del instrumento
	--================================================   
	-->>20210802  
--	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
--	SELECT --TOP 0
--			UDT_ID    = @Duracion
--		, TRAN_ID    = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
--		, UTDD_VALUE = datediff( dd, @Fecha, DET.CaFechaVcto ) / 365.0
--	FROM 
--		CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
--			DET.CaNumContrato = CAB.CanumContrato
--	WHERE
----			DET.caFechaVcto >= @Fecha AND 
--			CAB.CaEstado <> 'C' AND --Se excluyen las Cotizaciones  
--			datediff( dd, @Fecha, DET.CaFechaVcto ) / 365.0 <> 0

	--================================================
	--	120;   --Sensibilidad a un punto base 
	--================================================    
	-->20210802 
--	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
--	SELECT --TOP 0 
--			UDT_ID    = @DV01
--		, TRAN_ID    = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
--		, UTDD_VALUE = 0
--	FROM 
--		CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
--			DET.CaNumContrato = CAB.CanumContrato
--	WHERE
----			DET.caFechaVcto >= @Fecha AND 
--			CAB.CaEstado <> 'C'

	--================================================
	--	121;   --monto de desembolso de cajas ya sea por un pago de cupon"
	--================================================     
	-->>20210802
	--INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	--SELECT --TOP 0 
	--		UDT_ID    = @Caja
	--	, TRAN_ID    = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(CAB.CaNumEstructura AS VARCHAR(10))
	--	, UTDD_VALUE = CaCajMtoMon1
	--FROM CbMdbOpc..CaCaja AS CAB INNER JOIN CbMdbOpc..CaEncContrato AS EC ON
	--	EC.CaNumContrato = CAB.CanumContrato 
	--WHERE
	--	EC.CaEstado <> 'C'

	--================================================
	--	122;   --Resultado Diario de la operación
	--================================================     
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE
	SELECT --TOP 0 
			UDT_ID    = @Pyl
		, TRAN_ID    = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))
		, UTDD_VALUE = convert(varchar,format(isnull((DET.CaPrimaInicialDetML   
							+ ISNULL((SELECT SUM(CaMTMImplicito)  
										FROM CbMdbOpc.dbo.CaResCaja   
										WHERE CaNumContrato = DET.CaNumContrato    
											AND CaCajOrigen = 'PV' 
										GROUP BY CaNumContrato),0)), 0),N'#0.########################')) 
	FROM 
		CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON
			DET.CaNumContrato = CAB.CanumContrato
	WHERE
			DET.caFechaVcto >= @Fecha AND 
			CAB.CaEstado <> 'C' AND --Se excluyen las Cotizaciones  
			convert(varchar,format(isnull((DET.CaPrimaInicialDetML   
                     + ISNULL((SELECT SUM(CaMTMImplicito)  
										FROM CbMdbOpc.dbo.CaResCaja   
										WHERE CaNumContrato = DET.CaNumContrato    
											AND CaCajOrigen = 'PV' 
										GROUP BY CaNumContrato),0)), 0),N'#0.########################'))  <> 0
	

	
	-- ================================================
	-- SALIDA INTERFAZ
	-- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	SELECT 
		"TRAN_ID" = TRAN_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"UDT_ID" = UDT_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
				LTRIM(UDT_ID)          + @SEP
          + LTRIM(TRAN_ID)         + @SEP
          + LTRIM(UTDD_VALUE)	AS REG_SALIDA 
	FROM #VM_BAC_USER_TRAN_DEF_DOUBLE
    --  ORDER BY TRAN_ID, UDT_ID	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DOUBLE_SALIDA
		SELECT 
			"TRAN_ID" = -999,
			"UDT_ID" = -999,
			"REG_SALIDA" = 'UDT_ID'          + @SEP
							 + 'TRAN_ID'         + @SEP
							 + 'UTDD_VALUE' 
		WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_USER_TRAN_DEF_DOUBLE_SALIDA
	ORDER BY TRAN_ID, UDT_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512



	DROP TABLE #VM_BAC_USER_TRAN_DEF_DOUBLE
	DROP TABLE #VM_BAC_USER_TRAN_DEF_DOUBLE_SALIDA


END
--ROLLBACK TRAN
GO
