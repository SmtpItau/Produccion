USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_INT_RENTABILIDAD_REL_CLTE_CTO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_INT_RENTABILIDAD_REL_CLTE_CTO
CREATE PROCEDURE [dbo].[SP_INT_RENTABILIDAD_REL_CLTE_CTO]
(
	@OPCION INT		= NULL
	,@FECHA	DATE	= NULL
)
AS

BEGIN
SET NOCOUNT ON
SET CONCAT_NULL_YIELDS_NULL OFF
SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ (PLANTILLA)
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 
*/

-- TODO: REVISAR BEX (PROD: VCP,VC)

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/

--DECLARE @OPCION INT
--DECLARE @FECHA  DATE
--SET @OPCION= 1
--SET @FECHA = NULL


DECLARE @FECHA_PROCESO		VARCHAR(10)		--DATE
DECLARE @FECHA_CONTABLE		VARCHAR(10)		--DATE

DECLARE @FECHA_INICIO		VARCHAR(10)		--DATE
DECLARE @HORA_INICIO		VARCHAR(8)		--TIME

DECLARE @FECHA_TERMINO		VARCHAR(10)		--DATE
DECLARE @HORA_TERMINO		VARCHAR(8)		--TIME

DECLARE @TOTAL_REGISTROS	VARCHAR(8)


DECLARE @FECHA_PROC_FILTRO	DATE



/*******************************************************
		GENERACION DE ENCABEZADO (PARTE 1)
********************************************************/
-- OBTENCION DE FECHAS: PROCESO, CONTABLE E INICIO --
SELECT 
	 @FECHA_PROCESO		= CONVERT(VARCHAR(10),acfecproc,105)	-- 
	,@FECHA_CONTABLE		= CONVERT(VARCHAR(10),acfecproc,105)	-- EQUIVALENTE A FECHA PROCESO
	,@FECHA_INICIO			= CONVERT(VARCHAR(10),GETDATE(),105) 	
FROM BacFwdSuda.dbo.MFAC	WITH(nolock)

-- HORA DE INICIO --
SET @HORA_INICIO = CONVERT(VARCHAR(8),GETDATE(),108)

/*******************************************************
		EXTRACCION DE DATOS 
********************************************************/
CREATE TABLE #TMP_REL_CTE_CTO
(	  
	 NRO_DOCUMENTO		NUMERIC(20,0)	
	,NRO_OPERACION		NUMERIC(20,0)
	,NRO_CORRELATIVO	NUMERIC(20,0)
	,ID_SISTEMA			VARCHAR(5)
	,COD_SUBPRODU		VARCHAR(15)
	,MONEDA				NUMERIC(20,0)
	,RUTCLIENTE			NUMERIC(20,0)
	,COD_CLIENTE		NUMERIC(20,0)
	,FECHA_PROCESO	    DATE
	,FECHA_CONTRATO		DATE
	,FECHA_VENC			DATE
	,STATUS_OPE			VARCHAR(20)	
	,T_FLUJO		    NUMERIC(1) DEFAULT(0) 
)

/********************************************************
	DATOS DE FORWARD
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: FORWARD
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACFWDSUDA.DBO.MFAC WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE FORWARD
INSERT INTO #TMP_REL_CTE_CTO 
EXEC SP_REL_CLTE_CTO_FWD @FECHA=@FECHA_PROC_FILTRO


/********************************************************
	DATOS DE BONEX
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: RENTA FIJA
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACBONOSEXTSUDA.DBO.TEXT_ARC_CTL_DRI WITH(NOLOCK))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE RENTA FIJA
INSERT INTO #TMP_REL_CTE_CTO 
EXEC SP_REL_CLTE_CTO_BONEX @FECHA=@FECHA_PROC_FILTRO

/********************************************************
	DATOS DE OPCIONES
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA:OPCIONES
IF @FECHA IS NULL BEGIN
	--SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM CbMdbOpc.dbo.OpcionesGeneral WITH(NOLOCK))
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK))  
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE OPCIONES
INSERT INTO #TMP_REL_CTE_CTO 
EXEC SP_REL_CLTE_CTO_OPCIONES @FECHA=@FECHA_PROC_FILTRO


/********************************************************
	DATOS DE RENTA FIJA
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: RENTA FIJA
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM BacTraderSuda.dbo.MDAC WITH(NOLOCK))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE RENTA FIJA
INSERT INTO #TMP_REL_CTE_CTO 
EXEC SP_REL_CLTE_CTO_RF @FECHA=@FECHA_PROC_FILTRO

/********************************************************
	DATOS DE SWAP
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: SWAP
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE SWAP
INSERT INTO #TMP_REL_CTE_CTO 
EXEC SP_REL_CLTE_CTO_SWAP @FECHA=@FECHA_PROC_FILTRO

/********************************************************
	DATOS DE PASIVOS
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: SWAP
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE SWAP
INSERT INTO #TMP_REL_CTE_CTO 
EXEC SP_REL_CLTE_CTO_PSV @FECHA=@FECHA_PROC_FILTRO



WAITFOR DELAY '00:00:01'


/*
Concatenar Número de documento (12) + Número de Operación(12) +  Correlativo (4)
Estos deben ser consistentes con lo informado en el detalle de contrato
Los caracteres restantes se deben llenar con espacios. 


NUM_SECUENCIA_CTO --> CORREGIR
RF
- Informar Correlativo
Derivados
- Utilizar Secuencial para informar la pata (desde 1001 -1999 activo, desde 2001 - 2999 Pasivo)
Opciones
- Para estructuras utilizar secuencial de 4 dígitos (ej. 0001, 0002) para los distintos contratos asociados a la estructura.

*/
						
SELECT DISTINCT
 IDF_CTO_ODS							=		dbo.FX_RNT_IDF_CTO_ODS(NRO_DOCUMENTO,NRO_OPERACION,NRO_CORRELATIVO,ID_SISTEMA,T_FLUJO)
,IDF_PERS_ODS                  			=		SPACE(25)           		 
,TIP_REL_PERS_CTO              			=		SPACE(4)            		 
,COD_PAIS                      			=		REPLICATE('0',2)    		 
,COD_ENTIDAD                   			=		'1769'												-- SPACE(4)     -- LLENAR 
,COD_CENTRO                    			=		SPACE(4)            		 
,COD_PRODUCTO                  			=		RIGHT(SPACE(4)+ID_SISTEMA,4)								-- LLENAR 
,COD_SUBPRODU                  			=		RIGHT(SPACE(4)+COD_SUBPRODU,4)							-- LLENAR 
,NUM_CUENTA                    			=		RIGHT(REPLICATE('0',12) +
											(CASE NRO_OPERACION	
												WHEN NULL THEN '0'
												WHEN -1   THEN '0'
												ELSE CONVERT(VARCHAR(12),NRO_OPERACION)
											 END),12)

,NUM_SECUENCIA_CTO					     =		RIGHT('0000' + 
												(CASE 
												    WHEN ID_SISTEMA IN ('PCS','BFW') THEN
													   (
														  CASE WHEN T_FLUJO=1 THEN CONVERT(VARCHAR,NRO_CORRELATIVO + 1000)
															  WHEN T_FLUJO=2 THEN CONVERT(VARCHAR,NRO_CORRELATIVO + 2000)
														  END	  
													   )
												    ELSE CONVERT(VARCHAR,ISNULL(NRO_CORRELATIVO,0))
												    END)
											 ,4)
,COD_DIVISA                    			=		RIGHT(SPACE(4)+
												LTRIM(RTRIM((CASE
													WHEN MONEDA IN (998,997,994) THEN
														(SELECT MNNEMO FROM BACPARAMSUDA.DBO.MONEDA WHERE MNCODMON=999)
													ELSE
														(SELECT MNNEMO FROM BACPARAMSUDA.DBO.MONEDA WHERE MNCODMON=MONEDA)
												END))),4)	
,COD_ENTIDAD_PERS              			=		SPACE(4)            									 
,NUM_PERSONA                   			=		RIGHT(SPACE(12)+CONVERT(VARCHAR,RUTCLIENTE),12)			-- LLENAR 
,TIP_DOC_ID                    			=		SPACE(4)            		 
,NUM_DOC_ID                    			=		SPACE(20)           		 
,SEC_NUM_DOC                   			=		SPACE(2)            		 
,COD_EST_REL_PERS_CTO          			=		SPACE(3)            		 
,COD_TIP_RESPONSABILIDAD       			=		SPACE(4)            		 
,POR_GRADO_COBERTU             			=		REPLICATE('0',9)    		 
,IND_MATRIZ_GRUPO              			=		SPACE(1)            		 
,COD_TIP_AVAL                  			=		SPACE(4)            		 
,FEC_INI_RELACION              			=		REPLICATE('0',8)    		 
,FEC_FIN_RELACION              			=		REPLICATE('0',8)    		 
,IMP_COBERTU_MO                			=		REPLICATE('0',20)   		 
,IMP_COBERTU_ML                			=		REPLICATE('0',20)   		 
,COD_COMFORT_LETTER            			=		SPACE(3)            		 
,NUM_ORDEN_INTERVENCION        			=		REPLICATE('0',22)   		 
,COD_PROCESO                   			=		SPACE(20)           		 
,USERID_UMO                    			=		SPACE(10)           		 
,TIMEST_UMO                    			=		REPLICATE('0',8)    		 
,PORC_RESPONSABILIDAD          			=		REPLICATE('0',20)   		 
,ROWID_FILA                    			=		SPACE(64)           		 
,COD_FORM_INTERV               			=		SPACE(4)            		 
,FEC_DATA                      			=		LTRIM(RTRIM(REPLACE(@FECHA_PROC_FILTRO,'-','')))			-- REPLICATE('0',8) -- LLENAR 
,FEC_BAJA                      			=		REPLICATE('0',8)    		 
INTO #TMP_INTERFAZ
FROM #TMP_REL_CTE_CTO WITH(NOLOCK)

/*
SELECT * 
INTO ##REL_CLTE_CTO
FROM (
SELECT NRO_DOCUMENTO,NRO_OPERACION,NRO_CORRELATIVO,ID_SISTEMA,T_FLUJO,IDF_CTO_ODS,NUM_CUENTA,NUM_SECUENCIA_CTO
FROM #TMP_REL_CTE_CTO,#TMP_INTERFAZ
WHERE CONVERT(NUMERIC,NUM_CUENTA) = NRO_OPERACION
AND LTRIM(RTRIM(COD_PRODUCTO)) = LTRIM(RTRIM(ID_SISTEMA))
AND 
CONVERT(NUMERIC,NUM_SECUENCIA_CTO) = 
    (CASE T_FLUJO 
	   WHEN 1 THEN NRO_CORRELATIVO + 1000
	   WHEN 2 THEN NRO_CORRELATIVO + 2000
	   ELSE NRO_CORRELATIVO
	   END
	   )
) AS T1
*/



DROP TABLE #TMP_REL_CTE_CTO

	/*******************************************************
			DESPLIEGUE DE RESULTADOS
	********************************************************/
	
	IF ISNULL(@OPCION,-1)=-1 BEGIN
		/* DESPLIEGA RESULTADOS PARA LA GENERACION AUTOMATICA DE LA INTERFACE */
		SELECT DISTINCT
			DATA = 	
					IDF_CTO_ODS                   			
					+IDF_PERS_ODS                  			
					+TIP_REL_PERS_CTO              			
					+COD_PAIS                      			
					+COD_ENTIDAD                   			
					+COD_CENTRO                    			
					+COD_PRODUCTO                  			
					+COD_SUBPRODU                  			
					+NUM_CUENTA                    			
					+NUM_SECUENCIA_CTO             			
					+COD_DIVISA                    			
					+COD_ENTIDAD_PERS              			
					+NUM_PERSONA                   			
					+TIP_DOC_ID                    			
					+NUM_DOC_ID                    			
					+SEC_NUM_DOC                   			
					+COD_EST_REL_PERS_CTO          			
					+COD_TIP_RESPONSABILIDAD       			
					+POR_GRADO_COBERTU             			
					+IND_MATRIZ_GRUPO              			
					+COD_TIP_AVAL                  			
					+FEC_INI_RELACION              			
					+FEC_FIN_RELACION              			
					+IMP_COBERTU_MO                			
					+IMP_COBERTU_ML                			
					+COD_COMFORT_LETTER            			
					+NUM_ORDEN_INTERVENCION        			
					+COD_PROCESO                   			
					+USERID_UMO                    			
					+TIMEST_UMO                    			
					+PORC_RESPONSABILIDAD          			
					+ROWID_FILA                    			
					+COD_FORM_INTERV               			
					+FEC_DATA                      			
					+FEC_BAJA  
		FROM #TMP_INTERFAZ WITH(NOLOCK)
		SET @TOTAL_REGISTROS = RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR,@@ROWCOUNT),8)
		 
		 
		 -- FECHA DE TERMINO		
		SELECT @FECHA_TERMINO	 = CONVERT(VARCHAR(10),GETDATE(),105)
		SET @HORA_TERMINO = CONVERT(VARCHAR(8),GETDATE(),108) 	
		
		SELECT HEADER = @FECHA_PROCESO+@FECHA_CONTABLE+@FECHA_INICIO+@HORA_INICIO+@FECHA_TERMINO+@HORA_TERMINO+@TOTAL_REGISTROS
	
	END ELSE BEGIN
	
		/* DESPLIEGA RESULTADOS PARA REVISION */
		SELECT DISTINCT * FROM #TMP_INTERFAZ WITH(NOLOCK)
		SET @TOTAL_REGISTROS = RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR,@@ROWCOUNT),8)
		
		 -- FECHA DE TERMINO
		SELECT @FECHA_TERMINO	 = CONVERT(VARCHAR(10),GETDATE(),105)
		SET @HORA_TERMINO = CONVERT(VARCHAR(8),GETDATE(),108) 

		SELECT 
			@FECHA_PROCESO		AS FECHA_PROCESO
			,@FECHA_CONTABLE	AS FECHA_CONTABLE
			,@FECHA_INICIO		AS FECHA_INICIO
			,@HORA_INICIO		AS HORA_INICIO
			,@FECHA_TERMINO		AS FECHA_TERMINO
			,@HORA_TERMINO		AS HORA_TERMINO
			,@TOTAL_REGISTROS	AS TOTAL_REGISTROS
	
	END
	DROP TABLE #TMP_INTERFAZ	
END --FIN DDL
GO
