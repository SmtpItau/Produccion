USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_USER_TRAN_DEF_DATE]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Interfaz SP_VM_BAC_USER_TRAN_DEF_DATE: (swap ,fwd )
-- ================================================
-- UDT_ID      Tipo de User Defined Transaction. Ver catálogo tabla: USER_DEF_TYPE, se informa el ID. 
-- TRAN_ID     ID de la transacción.
-- UTDD_VALUE  Indica el Valor del User Defined Transaction en formato DATE.

/*

32	ET Date				Indica la fecha de Early Termination

*/ 
-- ================================================

--EXEC SP_VM_BAC_USER_TRAN_DEF_DATE
CREATE PROC [dbo].[SP_VM_BAC_USER_TRAN_DEF_DATE]
AS BEGIN 

--BEGIN TRAN

--*** historial de modificaciones ***
--20200903 - PLL - Se modifica formato campos date y datetime (dd/MM/aaaa y dd/MM/aaaa hh:mm) - Camilo

SET NOCOUNT ON 

CREATE TABLE #VM_BAC_USER_TRAN_DEF_DATE
            ( UDT_ID      INT
            , TRAN_ID     INT
            , UTDDA_VALUE  VARCHAR(20))		--	UTDD_VALUE --> PLL-20200512 - corrige nombre según version 11

CREATE TABLE #VM_BAC_USER_TRAN_DEF_DATE_SALIDA
	(
	TRAN_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	UDT_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

DECLARE @SEP    VARCHAR(1); SET @SEP    = ',';
DECLARE @FECHA  DATETIME ; SET @FECHA  = ISNULL((SELECT acfecproc FROM BACFWDSUDA..MFAC), '');

DECLARE @ET_Date AS INT; SET @ET_Date = 32;   --Indica la fecha de Early Termination

    
--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512
	
    
    --===================================================
    --32	ET Date				
    --===================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DATE
	SELECT DISTINCT 
		 UDT_ID      =  @ET_Date
		, TRAN_ID     =  CAB.NUMERO_OPERACION
		--, UTDDA_VALUE =  CONVERT(CHAR(10),CAB.FechaInicio,103) 
		, UTDDA_VALUE =  LTRIM(CONVERT(VARCHAR(20),CAB.FechaInicio,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FechaInicio,108)) 
	FROM BACSWAPSUDA..CARTERA AS CAB
	WHERE 
		CAB.TIPO_FLUJO = 1 AND 
		CAB.ESTADO_FLUJO = 1 AND 
	--			Fecha_Cierre=@FECHA  AND 
		bEarlyTermination=1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION
	SELECT 
       UDT_ID      =  @ET_Date
      , TRAN_ID     =  CAB.CANUMOPER
      --, UTDDA_VALUE =  CONVERT(varchar(30), FechaInicio, 103) -- CONVERT(CHAR(10),CAB.cafecvcto,103)  
      , UTDDA_VALUE =  LTRIM(CONVERT(VARCHAR(20),CAB.FechaInicio,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FechaInicio,108)) 
   FROM BACFWDSUDA..MFCA AS CAB
   WHERE bEarlyTermination = 1 --AND 
--		CAFECHA=@FECHA


	--select * from #VM_BAC_USER_TRAN_DEF_DATE
	--where TRAN_ID = 8260
     
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DATE_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"TRAN_ID" = TRAN_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"UDT_ID" = UDT_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			LTRIM(UDT_ID)          + @SEP
          + LTRIM(TRAN_ID)         + @SEP
          + LTRIM(UTDDA_VALUE)	AS REG_SALIDA 
       FROM #VM_BAC_USER_TRAN_DEF_DATE
    --ORDER BY TRAN_ID, UDT_ID	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_USER_TRAN_DEF_DATE_SALIDA
		SELECT 
			"TRAN_ID" = -999,
			"UDT_ID" = -999,
			"REG_SALIDA" = 'UDT_ID'          + @SEP
							 + 'TRAN_ID'         + @SEP
							 + 'UTDDA_VALUE' 
		WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_USER_TRAN_DEF_DATE_SALIDA 
	ORDER BY TRAN_ID, UDT_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

	DROP TABLE #VM_BAC_USER_TRAN_DEF_DATE
	DROP TABLE #VM_BAC_USER_TRAN_DEF_DATE_SALIDA

END
GO
