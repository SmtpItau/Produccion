USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_INT_RENTABILIDAD_SALDO_OPERACIONAL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_INT_RENTABILIDAD_SALDO_OPERACIONAL 0,'20190401'
CREATE PROCEDURE [dbo].[SP_INT_RENTABILIDAD_SALDO_OPERACIONAL]
(
		@OPCION INT		= NULL --1 BTR; 2 OPC; 3 SWAP; 4 FWD; 5 BONEX; 6 PSV
	,	@FECHA	DATE	= NULL
)
AS
BEGIN
SET NOCOUNT ON
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ SALDO OPERACIONAL
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 27-03-2017
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ SALDO OPERACIONES
--MODIFICACION	: 10-08-2018	en saldo y no en detalle
--MODIFICACION	: 17-04-2019	nuevo generacion del saldo

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
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
	 @FECHA_PROCESO	= CONVERT(VARCHAR(10),acfecproc,105)	-- 
	,@FECHA_CONTABLE	= CONVERT(VARCHAR(10),acfecproc,105)	-- EQUIVALENTE A FECHA PROCESO
	,@FECHA_INICIO		= CONVERT(VARCHAR(10),GETDATE(),105) 
FROM BacFwdSuda.dbo.MFAC with(nolock)

-- HORA DE INICIO --
SET @HORA_INICIO = CONVERT(VARCHAR(8),GETDATE(),108)

IF OBJECT_ID('TEMPDB..#TMP_DATOS_SALDO_OPERACIONAL') IS NOT NULL BEGIN
	DROP TABLE #TMP_DATOS_SALDO_OPERACIONAL	
END 

IF OBJECT_ID('TEMPDB..#TMP_SALDO_OPERACIONAL') IS NOT NULL BEGIN
	DROP TABLE #TMP_SALDO_OPERACIONAL
END 

/********************************************************
	GENERA CONTABILIDAD PARA RENTAFIJA DESAGRUPADA DEL DIA
********************************************************/
--EXEC SP_CNT_RF_RENTABILIDAD


/*******************************************************
		EXTRACCION DE DATOS 
********************************************************/
CREATE TABLE #TMP_DATOS_SALDO_OPERACIONAL
(
/*1*/	 NRO_OPERACION			NUMERIC(20)
/*2*/	,NRO_DOCUMENTO			NUMERIC(20)
/*3*/	,NRO_CORRELATIVO		NUMERIC(20)
/*4*/	,COD_CTA_CONT          	VARCHAR(20)		
/*5*/	,TIP_SDO               	CHAR(2)			
/*6*/	,COD_EST_SDO           	VARCHAR(4)		
/*7*/	,COD_DIVISA            	VARCHAR(4)		
/*8*/	,FEC_DATA              	DATE			
/*9*/	,CLS_SDO               	CHAR(1)			
/*10*/	,COD_ENTIDAD           	VARCHAR(4)		
/*11*/	,COD_PRODUCTO          	VARCHAR(4)		
/*12*/	,COD_SUBPRODU          	VARCHAR(4)		
/*13*/	,IMP_SDO_CONT_MO       	NUMERIC(20,4)	
/*14*/	,IMP_SDO_CONT_ML       	NUMERIC(20,4)	
/*15*/	,COD_CENTRO_CONT       	VARCHAR(4)
/*16*/	,T_FLUJO				NUMERIC		
)

CREATE TABLE #TMP_DATOS_SALDO_OPERACIONAL_paso
(
/*1*/	 NRO_OPERACION			NUMERIC(20)
/*2*/	,NRO_DOCUMENTO			NUMERIC(20)
/*3*/	,NRO_CORRELATIVO		NUMERIC(20)
/*4*/	,COD_CTA_CONT          	VARCHAR(20)		
/*5*/	,TIP_SDO               	CHAR(2)			
/*6*/	,COD_EST_SDO           	VARCHAR(4)		
/*7*/	,COD_DIVISA            	VARCHAR(4)		
/*8*/	,FEC_DATA              	DATE			
/*9*/	,CLS_SDO               	CHAR(1)			
/*10*/	,COD_ENTIDAD           	VARCHAR(4)		
/*11*/	,COD_PRODUCTO          	VARCHAR(4)		
/*12*/	,COD_SUBPRODU          	VARCHAR(4)		
/*13*/	,IMP_SDO_CONT_MO       	NUMERIC(20,4)	
/*14*/	,IMP_SDO_CONT_ML       	NUMERIC(20,4)	
/*15*/	,COD_CENTRO_CONT       	VARCHAR(4)
/*16*/	,T_FLUJO				NUMERIC		
)


--*******************************************************
--	DATOS DE FORWARD
--*******************************************************

--LECTURA DE FECHA DE PROCESO DE SISTEMA: FORWARD
 IF @FECHA IS NULL BEGIN
 	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACFWDSUDA.DBO.MFAC WITH(NOLOCK)) 
 END ELSE BEGIN
 	SET @FECHA_PROC_FILTRO = @FECHA
 END
 
 -- LLENADO TABLA TEMPORAL: CON DATOS DE FORWARD
IF @OPCION = 4 OR (@OPCION is null OR @OPCION=0)
begin
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL 
	EXEC SP_SALDOS_OPERACIONALES_FWD @FECHA=@FECHA_PROC_FILTRO
end

/********************************************************
	DATOS DE OPCIONES
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA:OPCIONES
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM CbMdbOpc.dbo.OpcionesGeneral WITH(NOLOCK))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END


-- LLENADO TABLA TEMPORAL: CON DATOS DE OPCIONES
IF @OPCION = 2 OR (@OPCION is null OR @OPCION=0)
begin
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL 
	EXEC SP_SALDOS_OPERACIONALES_OPT @FECHA=@FECHA_PROC_FILTRO
end

/********************************************************
	DATOS DE SWAP
********************************************************/
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE SWAP
IF @OPCION = 3 OR (@OPCION is null OR @OPCION=0)
begin
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL 
	EXEC SP_SALDOS_OPERACIONALES_SWAP @FECHA=@FECHA_PROC_FILTRO
end

/********************************************************
	DATOS DE RENTA FIJA
*******************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: RENTA FIJA
IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM BacTraderSuda.dbo.MDAC WITH(NOLOCK))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

-- LLENADO TABLA TEMPORAL: CON DATOS DE RENTA FIJA
IF @OPCION = 1 OR (@OPCION is null OR @OPCION=0)
begin
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL
	EXEC SP_SALDOS_OPERACIONALES_RF @FECHA=@FECHA_PROC_FILTRO
end

/********************************************************
 	DATOS DE BONEX
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: BONEX
IF @FECHA IS NULL BEGIN
  	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACBONOSEXTSUDA.DBO.TEXT_ARC_CTL_DRI WITH(NOLOCK))
--    SET @FECHA_PROC_FILTRO = (select top 1 acfecante from BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock))
END ELSE BEGIN
  	SET @FECHA_PROC_FILTRO = @FECHA
END

IF @OPCION = 5 OR (@OPCION is null OR @OPCION=0)
begin
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL
	EXEC SP_SALDOS_OPERACIONALES_BONEX @FECHA=@FECHA_PROC_FILTRO
end

/********************************************************
 	DATOS DE PASIVO
********************************************************/
-- LECTURA DE FECHA DE PROCESO DE SISTEMA: BONEX
IF @FECHA IS NULL BEGIN
  	SET @FECHA_PROC_FILTRO = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
END ELSE BEGIN
  	SET @FECHA_PROC_FILTRO = @FECHA
END

IF @OPCION = 6 OR (@OPCION is null OR @OPCION=0)
begin
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL 
	EXEC SP_SALDOS_OPERACIONALES_PSV @FECHA=@FECHA_PROC_FILTRO
end	

/*
	INSERT INTO #TMP_DATOS_SALDO_OPERACIONAL
	SELECT	NRO_OPERACION		
	,		NRO_DOCUMENTO		
	,		NRO_CORRELATIVO	
	,		COD_CTA_CONT       
	,		min(TIP_SDO)
	,		min(COD_EST_SDO)
	,		COD_DIVISA         
	,		min(FEC_DATA)           
	,		min(CLS_SDO)            
	,		min(COD_ENTIDAD)        
	,		COD_PRODUCTO       
	,		COD_SUBPRODU       
	,		min(IMP_SDO_CONT_MO)    	
	,		min(IMP_SDO_CONT_ML)    	
	,		min(COD_CENTRO_CONT)    
	,		min(T_FLUJO)			
	FROM #TMP_DATOS_SALDO_OPERACIONAL_paso
	group by NRO_OPERACION,NRO_DOCUMENTO,NRO_CORRELATIVO,COD_CTA_CONT,COD_DIVISA,COD_PRODUCTO,COD_SUBPRODU       
*/

WAITFOR DELAY '00:00:03'

SET CONCAT_NULL_YIELDS_NULL OFF

SELECT DISTINCT
IDF_CTO_ODS                   			=		dbo.FX_RNT_IDF_CTO_ODS(NRO_DOCUMENTO,NRO_OPERACION,NRO_CORRELATIVO,COD_PRODUCTO,T_FLUJO)
--IDF_CTO_ODS                   			=		dbo.FX_RNT_IDF_CTO_ODS(isnull(NRO_DOCUMENTO,0),isnull(NRO_OPERACION,0),isnull(NRO_CORRELATIVO,0),COD_PRODUCTO,T_FLUJO)
--IDF_CTO_ODS                   		=		SPACE(32)           		-- LLENAR 
,COD_CTA_CONT                  			=		RIGHT(SPACE(20)+LTRIM(RTRIM(UPPER(COD_CTA_CONT))),20)           		-- LLENAR 
,TIP_SDO                       			=		RIGHT(SPACE(2) +LTRIM(RTRIM(UPPER(TIP_SDO))),2 )          		-- LLENAR 
,COD_EST_SDO                   			=		RIGHT(SPACE(4) +LTRIM(RTRIM(UPPER(COD_EST_SDO))),4 )          		-- LLENAR 
,COD_DIVISA                    			=		RIGHT(SPACE(4) +LTRIM(RTRIM(UPPER(COD_DIVISA))),4 )          		-- LLENAR 
,TIP_DIVISA                    			=		SPACE(1)            		 
,COD_CONTENIDO                 			=		SPACE(4)            		 
,FEC_DATA                      			=		REPLACE(FEC_DATA,'-','')	--REPLICATE('0',8)    		-- LLENAR 
,COD_PAIS                      			=		REPLICATE('0',2)    		 
,CLS_SDO                       			=		RIGHT(SPACE(1)+LTRIM(RTRIM(UPPER(CLS_SDO))),1)            		-- LLENAR 
,COD_ENTIDAD                   			=		RIGHT(SPACE(4)+LTRIM(RTRIM(UPPER(COD_ENTIDAD))),4)            		-- LLENAR 
,COD_PRODUCTO                  			=		RIGHT(SPACE(4)+LTRIM(RTRIM(UPPER(COD_PRODUCTO))),4)            		-- LLENAR 
,COD_SUBPRODU                  			=		RIGHT(SPACE(4)+LTRIM(RTRIM(UPPER(COD_SUBPRODU))),4)            		-- LLENAR 
,IMP_SDO_CONT_MO               			=		(dbo.Fx_RNT_Formato_Decimales(IMP_SDO_CONT_MO,20,4,1))--REPLICATE('0',20)   		-- LLENAR 
,IMP_SDO_CONT_ML               			=		(dbo.Fx_RNT_Formato_Decimales(IMP_SDO_CONT_ML,20,4,1))--REPLICATE('0',20)   		-- LLENAR 
,IMP_SDO_MED_CONT_MO           			=		REPLICATE('0',20)   		 
,IMP_SDO_MED_CONT_ML           			=		REPLICATE('0',20)   		 
,IMP_SDO_GEST_MO               			=		REPLICATE('0',20)   		 
,IMP_SDO_GEST_ML               			=		REPLICATE('0',20)   		 
,IMP_SDO_MED_GEST_MO           			=		REPLICATE('0',20)   		 
,IMP_SDO_MED_GEST_ML           			=		REPLICATE('0',20)   		 
,COD_SIS_ORIGEN                			=		SPACE(4)            		 
,COD_PROCESO                   			=		SPACE(20)           		 
,USERID_UMO                    			=		SPACE(10)           		 
,TIMEST_UMO                    			=		REPLICATE('0',8)    		 
,COD_CENTRO_CONT               			=		'2230' --RIGHT(SPACE(4)+LTRIM(RTRIM(UPPER(COD_CENTRO_CONT))),4)            		-- LLENAR 
,ROWID_FILA                    			=		SPACE(64)           		 
,TIPO_COLOCACION               			=		SPACE(4)            		 
,COD_TIPO_MOVIMIENTO           			=		SPACE(4)            		 
,COD_TIP_IMP_CONT              			=		SPACE(4)            		 
,COD_AGRUP_CTA                 			=		SPACE(4)            		 
,FEC_BAJA                      			=		REPLICATE('0',8)    		 
,IMP_SDO_NO_INT                			=		REPLICATE('0',20)   		 
,COD_CTA_CONT_COSIF            			=		SPACE(20)           		 
INTO #TMP_SALDO_OPERACIONAL
FROM #TMP_DATOS_SALDO_OPERACIONAL



/*******************************************************
		DESPLIEGUE DE RESULTADOS
********************************************************/
IF ISNULL(@OPCION,-1)=-1 BEGIN
	/* DESPLIEGA RESULTADOS PARA LA GENERACION AUTOMATICA DE LA INTERFACE */
	SELECT
		DATA = 
		IDF_CTO_ODS           
		+COD_CTA_CONT          
		+TIP_SDO               
		+COD_EST_SDO           
		+COD_DIVISA            
		+TIP_DIVISA            
		+COD_CONTENIDO         
		+FEC_DATA              
		+COD_PAIS              
		+CLS_SDO               
		+COD_ENTIDAD           
		+COD_PRODUCTO          
		+COD_SUBPRODU          
		+IMP_SDO_CONT_MO       
		+IMP_SDO_CONT_ML       
		+IMP_SDO_MED_CONT_MO   
		+IMP_SDO_MED_CONT_ML   
		+IMP_SDO_GEST_MO       
		+IMP_SDO_GEST_ML       
		+IMP_SDO_MED_GEST_MO   
		+IMP_SDO_MED_GEST_ML   
		+COD_SIS_ORIGEN        
		+COD_PROCESO           
		+USERID_UMO            
		+TIMEST_UMO            
		+COD_CENTRO_CONT       
		+ROWID_FILA            
		+TIPO_COLOCACION       
		+COD_TIPO_MOVIMIENTO   
		+COD_TIP_IMP_CONT      
		+COD_AGRUP_CTA         
		+FEC_BAJA              
		+IMP_SDO_NO_INT        
		+COD_CTA_CONT_COSIF    
	FROM #TMP_SALDO_OPERACIONAL
	ORDER BY COD_PRODUCTO
	--WHERE COD_CTA_CONT>0
	SET @TOTAL_REGISTROS = RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR,@@ROWCOUNT),8)	   
	SET @FECHA_TERMINO	 = CONVERT(VARCHAR(10),GETDATE(),105)
	SET @HORA_TERMINO = CONVERT(VARCHAR(8),GETDATE(),108) 

	SELECT HEADER = @FECHA_PROCESO+@FECHA_CONTABLE+@FECHA_INICIO+@HORA_INICIO+@FECHA_TERMINO+@HORA_TERMINO+@TOTAL_REGISTROS
END ELSE BEGIN
	
	SELECT * FROM #TMP_SALDO_OPERACIONAL	
	SET @TOTAL_REGISTROS = RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR,@@ROWCOUNT),8)	   
	
	SET @FECHA_TERMINO	 = CONVERT(VARCHAR(10),GETDATE(),105)
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
END
GO
