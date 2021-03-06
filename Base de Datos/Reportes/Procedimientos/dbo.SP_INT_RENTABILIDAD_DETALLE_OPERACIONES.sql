USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_INT_RENTABILIDAD_DETALLE_OPERACIONES]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_INT_RENTABILIDAD_DETALLE_OPERACIONES 1,'20181228'
CREATE PROCEDURE [dbo].[SP_INT_RENTABILIDAD_DETALLE_OPERACIONES]
(
		@OPCION INT		= 1 --9 BTR; 2 OPC; 3 SWAP; 4 FWD; 5 BONEX; 6 PSV
	,	@FECHA	DATE	= NULL
)
AS
BEGIN
SET NOCOUNT ON
SET CONCAT_NULL_YIELDS_NULL OFF

/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 27-03-2017
*/
--	SONDA		: RENTABILIDAD
--	DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
--	MODIFICACION: 27-06-2018	CAMPOS TASA, IND_CAN_ANT
--	MODIFICACION: 01-10-2018	agregar PSV
--	MODIFICACION: 11-03-2019	completar con ceros el nro de operacion

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

--DECLARE @OPCION INT			= NULL
--DECLARE @FECHA DATE			= NULL
--SET @FECHA='2017-07-31'

/*******************************************************
		GENERACION DE ENCABEZADO (PARTE 1)
********************************************************/
-- OBTENCION DE FECHAS: PROCESO, CONTABLE E INICIO --
SELECT 
	 @FECHA_PROCESO		= CONVERT(VARCHAR(10),acfecproc,105)	-- 
	,@FECHA_CONTABLE	= CONVERT(VARCHAR(10),acfecproc,105)	-- EQUIVALENTE A FECHA PROCESO
	,@FECHA_INICIO		= CONVERT(VARCHAR(10),GETDATE(),105) 
FROM BacFwdSuda.dbo.MFAC with(nolock)

-- HORA DE INICIO --
SET @HORA_INICIO = CONVERT(VARCHAR(8),GETDATE(),108)

/*******************************************************
		EXTRACCION DE DATOS 
********************************************************/
CREATE TABLE #TMP_DETALLE
(
 ID_REG					INT IDENTITY(0,1)
,NRO_DOCUMENTO			NUMERIC(20)
,NRO_OPERACION			NUMERIC(20)
,NRO_CORRELATIVO		NUMERIC(20)
,FEC_DATA				DATE--NUMERIC(8)
,COD_ENTIDAD			VARCHAR(4)
,COD_PRODUCTO			VARCHAR(4)
,COD_SUBPRODU			VARCHAR(4)
,NUM_CUENTA				VARCHAR(12)
--,NUM_SECUENCIA_CTO		VARCHAR(4)
,NUM_SECUENCIA_CTO		NUMERIC(4) DEFAULT 1
,COD_DIVISA				VARCHAR(4)
,COD_REAJUSTE			VARCHAR(3)
,IDF_PERS_ODS			VARCHAR(25)
,COD_CENTRO_CONT		VARCHAR(4)
,COD_OFI_COMERCIAL		VARCHAR(5)
,COD_GESTOR_PROD		VARCHAR(15)
,COD_BASE_TAS_INT		VARCHAR(3)
,COD_BCA_INT			VARCHAR(3)
,COD_COMPOS_INT			CHAR(1)
,COD_MOD_PAGO			CHAR(1)
,COD_MET_AMRT			VARCHAR(4)
,COD_CUR_REF			VARCHAR(5)
,COD_TIP_TAS			VARCHAR(2)
,TAS_INT				NUMERIC(8,5)
,TAS_DIF_INC_REF		NUMERIC(8,5)
,FEC_ALTA_CTO			DATE --NUMERIC(8)
,FEC_INI_GEST			DATE --NUMERIC(8)
,FEC_CAN_ANT			DATE --NUMERIC(8)
,FEC_ULT_LIQ			DATE --NUMERIC(8)
,FEC_PRX_LIQ			DATE --NUMERIC(8)
,FEC_ULT_REV			DATE --NUMERIC(8)
,FEC_PRX_REV			DATE --NUMERIC(8)
,FEC_VEN				DATE --NUMERIC(8)
,FRE_PAGO_INT			NUMERIC(5)
,COD_UNI_FRE_PAGO_INT	CHAR(1)
,FRE_REV_INT			NUMERIC(5)
,COD_UNI_FRE_REV_INT	CHAR(1)
,PLZ_CONTRACTUAL		NUMERIC(5)
,PLZ_AMRT				NUMERIC(5)
,COD_UNI_PLZ_AMRT		CHAR(1)
,IMP_INI_MO				NUMERIC(20,4)
,IMP_CUO_MO				NUMERIC(20,2)
,IMP_CUO_INI_MO			NUMERIC(20,2)
,NUM_CUO_PAC			NUMERIC(5)
,NUM_CUO_PEND			NUMERIC(5)
,IMP_PAGO_ML			NUMERIC(20,4)
,IMP_PAGO_MO			NUMERIC(20,4)
,IND_CAN_ANT			CHAR(1)
,IND_TAS_PREDEF			CHAR(1)
,TAS_PREDEF				NUMERIC(8,5)
,IMP_INI_ML				NUMERIC(20,4)
,TAS_INT_ORIGEN			NUMERIC(8,5)
,COD_PORTAFOLIO			VARCHAR(10)
,DES_PORTAFOLIO			VARCHAR(20)
,COD_NEMOTECNICO		VARCHAR(20)
,COD_CARTERA_FINANCI	CHAR(8)
,COD_TIP_LIBRO			VARCHAR(1)
,NUM_DOC				VARCHAR(12)
,NUM_OPE_ANT			VARCHAR(12)
,T_FLUJO				INT DEFAULT 0
)

CREATE NONCLUSTERED INDEX IDX_001 ON #TMP_DETALLE(ID_REG)


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
-- PRINT 'EXTRAYENDO DATA (RENTA FIJA): ' + CONVERT(VARCHAR,GETDATE(),114)
-- DATOS DE RECOMPRAS, REVENTAS, ICAP-ICOL, RECOMPRAS AUTOMATICAS Y REVENTAS AUTOMATICAS.

IF @OPCION = 9 OR @OPCION=1
begin 
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF @FECHA=@FECHA_PROC_FILTRO

---- CARTERAS DE RENTA FIJA (SERIADAS Y NO SERIEADAS)
-- VENTAS DEFINITIVAS ?
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF_VP_SERIADO @FECHA=@FECHA_PROC_FILTRO

	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF_VP_NSERIADO @FECHA=@FECHA_PROC_FILTRO

-- VENTAS CON PACTO
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF_VI_SERIADO @FECHA=@FECHA_PROC_FILTRO

	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF_VI_NSERIADO @FECHA=@FECHA_PROC_FILTRO

-- COMPRA CON PACTO
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF_CI_SERIADO @FECHA=@FECHA_PROC_FILTRO

	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_RF_CI_NSERIADO @FECHA=@FECHA_PROC_FILTRO


-- CARTERA PROPIA
	INSERT INTO #TMP_DETALLE
	EXEC SP_DETALLE_OPERACIONES_RF_CP_SERIADO @FECHA=@FECHA_PROC_FILTRO

	INSERT INTO #TMP_DETALLE
	EXEC SP_DETALLE_OPERACIONES_RF_CP_NSERIADO @FECHA=@FECHA_PROC_FILTRO
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
-- PRINT 'EXTRAYENDO DATA (OPCIONES): ' + CONVERT(VARCHAR,GETDATE(),114)
IF @OPCION = 2 OR @OPCION=1
begin 
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_OPC @FECHA=@FECHA_PROC_FILTRO
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
-- PRINT 'EXTRAYENDO DATA (SWAP): ' + CONVERT(VARCHAR,GETDATE(),114)
IF @OPCION = 3 OR @OPCION=1
begin 
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_SWAP @FECHA=@FECHA_PROC_FILTRO
end

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
 -- PRINT 'EXTRAYENDO DATA (FORWARD): ' + CONVERT(VARCHAR,GETDATE(),114)
IF @OPCION = 4 OR @OPCION=1
begin 
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_FWD @FECHA=@FECHA_PROC_FILTRO
end
 /********************************************************
 	DATOS DE BONEX
 ********************************************************/
  -- LECTURA DE FECHA DE PROCESO DE SISTEMA: BONEX
  IF @FECHA IS NULL BEGIN
 	  SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACFWDSUDA.DBO.MFAC WITH(NOLOCK)) 
--    SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACBONOSEXTSUDA.DBO.TEXT_ARC_CTL_DRI WITH(NOLOCK))
--    SET @FECHA_PROC_FILTRO = (select top 1 acfecante from BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock))
  END ELSE BEGIN
  	SET @FECHA_PROC_FILTRO = @FECHA
  END
  
  -- LLENADO TABLA TEMPORAL: CON DATOS DE BONEX
  -- PRINT 'EXTRAYENDO DATA (BONEX): ' + CONVERT(VARCHAR,GETDATE(),114)
IF @OPCION = 5 OR @OPCION=1
begin 
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_BONEX @FECHA=@FECHA_PROC_FILTRO
end
 /********************************************************
 	DATOS DE PASIVO
 ********************************************************/
  -- LECTURA DE FECHA DE PROCESO DE SISTEMA: PASIVO
  IF @FECHA IS NULL BEGIN
  	SET @FECHA_PROC_FILTRO = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
  END ELSE BEGIN
  	SET @FECHA_PROC_FILTRO = @FECHA
  END
  
IF @OPCION = 6 OR @OPCION=1
begin 
	INSERT INTO #TMP_DETALLE 
	EXEC SP_DETALLE_OPERACIONES_PSV @FECHA=@FECHA_PROC_FILTRO
end

/********************************************************
	DATOS DE BONEX NY
********************************************************/
/* 
 -- FUERA DE ALCANCE DE LOS DATOS...
 -- LECTURA DE FECHA DE PROCESO DE SISTEMA: BONEX
 IF @FECHA IS NULL BEGIN
 	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BacBonosExtNY.DBO.TEXT_ARC_CTL_DRI WITH(NOLOCK))
 END ELSE BEGIN
 	SET @FECHA_PROC_FILTRO = @FECHA
 END

 -- LLENADO TABLA TEMPORAL: CON DATOS DE RENTA FIJA
 -- PRINT 'EXTRAYENDO DATA (BONEX NY): ' + CONVERT(VARCHAR,GETDATE(),114)
 INSERT INTO #TMP_DETALLE 
 EXEC SP_DETALLE_OPERACIONES_BONEX_NY @FECHA=@FECHA_PROC_FILTRO
*/

WAITFOR DELAY '00:00:03'

/* TMP1 */
;WITH CTE_TMP1
AS
(
SELECT 
 ID_REG									=		T1.ID_REG
--,IDF_CTO_ODS                 			=		dbo.FX_RNT_IDF_CTO_ODS(T1.NRO_DOCUMENTO,T1.NRO_OPERACION,T1.NRO_CORRELATIVO,T1.COD_PRODUCTO,T1.T_FLUJO)
,IDF_CTO_ODS                   			=		SPACE(32)
,COD_CONTENIDO                 			=		SPACE(4)            		 
,FEC_DATA                      			=		REPLACE(T1.FEC_DATA,'-','')														--REPLICATE('0',8)    		-- LLENAR 
,COD_PAIS                      			=		REPLICATE('0',2)    		 
,COD_ENTIDAD                   			=		RIGHT(SPACE(4)+LTRIM(RTRIM(UPPER(T1.COD_ENTIDAD))),4)            				-- LLENAR 
,COD_CENTRO                    			=		SPACE(4)            		 
,COD_PRODUCTO                  			=		RIGHT(SPACE(4) +LTRIM(RTRIM(UPPER(T1.COD_PRODUCTO))),4)          				-- LLENAR 
,COD_SUBPRODU                  			=		RIGHT(SPACE(4) +LTRIM(RTRIM(UPPER(T1.COD_SUBPRODU))),4)          				-- LLENAR 
--,NUM_CUENTA                    		=		RIGHT(SPACE(12)+LTRIM(RTRIM(UPPER(T1.NUM_CUENTA))),12)          				-- LLENAR 
,NUM_CUENTA                    			=		right(replicate('0',12)+convert(varchar(12),T1.NRO_OPERACION),12)	--+++FMO 20190311
,NUM_SECUENCIA_CTO						=		(CASE LTRIM(RTRIM(T1.COD_PRODUCTO))
													WHEN 'PCS' THEN CONVERT(VARCHAR(4),(CASE T1.T_FLUJO WHEN 1 THEN 1000 + T1.NUM_SECUENCIA_CTO WHEN 2 THEN 2000 + T1.NUM_SECUENCIA_CTO END))
													WHEN 'BFW' THEN CONVERT(VARCHAR(4),(CASE T1.T_FLUJO WHEN 1 THEN 1000 + T1.NUM_SECUENCIA_CTO WHEN 2 THEN 2000 + T1.NUM_SECUENCIA_CTO END))
													WHEN 'OPT' THEN RIGHT(REPLICATE('0',4)+CONVERT(VARCHAR,T1.NRO_CORRELATIVO),4)
--													ELSE RIGHT(SPACE(4)+ CONVERT(VARCHAR,T1.NUM_SECUENCIA_CTO),4)
													ELSE right(replicate('0',4)+convert(varchar(4),T1.NUM_SECUENCIA_CTO),4)	--+++FMO 20190311
												 END)
,COD_DIVISA                    			=		RIGHT(SPACE(4) +LTRIM(RTRIM(UPPER(T1.COD_DIVISA))),4)          				-- LLENAR 
,COD_REAJUSTE                  			=		RIGHT(SPACE(3) +LTRIM(RTRIM(UPPER(T1.COD_REAJUSTE))),3)          				-- LLENAR 
,IDF_PERS_ODS                  			=		RIGHT(SPACE(25)+LTRIM(RTRIM(UPPER(T1.IDF_PERS_ODS))),25)          				-- LLENAR 
,COD_CENTRO_CONT               			=		'2230' --RIGHT(SPACE(4) +LTRIM(RTRIM(UPPER(COD_CENTRO_CONT))),4)          			-- LLENAR 
,COD_OFI_COMERCIAL             			=		RIGHT(SPACE(5) +LTRIM(RTRIM(UPPER(T1.COD_OFI_COMERCIAL))),5)          			-- LLENAR 
,COD_GESTOR_PROD						=		(select dbo.Fx_RNT_COD_GESTOR(T1.COD_GESTOR_PROD))
,COD_PROPUESTA                 			=		SPACE(20)           		 
,COD_COMBO                     			=		SPACE(4)            		 
,IDF_ELEM                      			=		SPACE(12)           		 
,COD_BASE_TAS_INT              			=		RIGHT(SPACE(3)+LTRIM(RTRIM(UPPER(T1.COD_BASE_TAS_INT))),3)            			-- LLENAR 
,COD_BCA_INT                   			=		RIGHT(SPACE(3)+LTRIM(RTRIM(UPPER(T1.COD_BCA_INT     ))),3)            			-- LLENAR 
,COD_COMPOS_INT                			=		RIGHT(SPACE(1)+LTRIM(RTRIM(UPPER(T1.COD_COMPOS_INT  ))),1)            			-- LLENAR 
,COD_MOD_PAGO                  			=		RIGHT(SPACE(1)+LTRIM(RTRIM(UPPER(T1.COD_MOD_PAGO    ))),1)            			-- LLENAR 
,COD_MET_AMRT                  			=		RIGHT(SPACE(4)+LTRIM(RTRIM(UPPER(T1.COD_MET_AMRT    ))),4)            			-- LLENAR 
,COD_CUR_REF                   			=		RIGHT(SPACE(5)+LTRIM(RTRIM(UPPER(T1.COD_CUR_REF     ))),5) --RIGHT(SPACE(5),5) -- LLENAR 
,COD_TIP_TAS                   			=		RIGHT(SPACE(2)+LTRIM(RTRIM(UPPER(T1.COD_TIP_TAS     ))),2)            			-- LLENAR 
--,TAS_INT                       		=		(select dbo.Fx_RNT_Formato_Decimales(TAS_INT,8,5,1))						-- REPLICATE('0',8)    		-- LLENAR 
-- MGM Cambio en el tratamiento de la Tasa
,TAS_INT								=		CASE
													WHEN LTRIM(RTRIM(T1.COD_PRODUCTO)) in ('PCS','OPT','BFW','SWAP') THEN 
														REPLICATE('0',8) 
													ELSE 
														CASE 
															WHEN T1.TAS_INT <= 999.99999 AND T1.TAS_INT >= 0.0 THEN 
																(SELECT dbo.Fx_RNT_Formato_Decimales(T1.TAS_INT,8,5,1)) 
															WHEN T1.TAS_INT > 999.99999 THEN 
																(SELECT dbo.Fx_RNT_Formato_Decimales((T1.TAS_INT/10),8,5,1))
															WHEN T1.TAS_INT < 0 THEN 
															(SELECT dbo.Fx_RNT_Formato_Decimales((T1.TAS_INT/100),8,5,1)) 
													END
												END
-- MGM 30-07-2018
,TAS_INT_MIN                   			=		REPLICATE('0',8)    		 
,TAS_INT_MAX                   			=		REPLICATE('0',8)    		 
,COD_BASE_TAS_INT_EXC          			=		SPACE(3)            		 
,TAS_INT_EXC                   			=		REPLICATE('0',8)    		 
--,TAS_DIF_INC_REF               		=		(select dbo.Fx_RNT_Formato_Decimales(TAS_DIF_INC_REF,8,5,1))				-- REPLICATE('0',8)    		-- LLENAR 
-- MGM Cambio en el tratamiento de la Tasa
,TAS_DIF_INC_REF               			=		CASE
												WHEN LTRIM(RTRIM(T1.COD_PRODUCTO)) in ('PCS','OPT','BFW','SWAP') THEN 
													REPLICATE('0',8) 
												ELSE 
													CASE 
														WHEN T1.TAS_DIF_INC_REF <= 999.99999 AND T1.TAS_DIF_INC_REF >= 0 THEN 
															(SELECT dbo.Fx_RNT_Formato_Decimales(T1.TAS_DIF_INC_REF,8,5,1)) 
														WHEN T1.TAS_DIF_INC_REF > 999.99999 THEN 
															(SELECT dbo.Fx_RNT_Formato_Decimales((T1.TAS_DIF_INC_REF/10),8,5,1))
														WHEN T1.TAS_DIF_INC_REF < 0 THEN 
														(SELECT dbo.Fx_RNT_Formato_Decimales((T1.TAS_DIF_INC_REF/100),8,5,1)) 
												END
											END
-- MGM 30-07-2018
,TAS_DIF_CUR_COSTE             			=		REPLICATE('0',8)    		 
,COD_SIT_DEVENGO               			=		SPACE(1)            		 
,COD_PEOR_SIT_CTO              			=		SPACE(15)           		 
,COD_PEOR_SIT_CTO_BIS          			=		SPACE(2)            		 
,FEC_ALTA_CTO                  			=		REPLACE(T1.FEC_ALTA_CTO,'-','')												-- REPLICATE('0',8)    		-- LLENAR 
,FEC_INI_GEST                  			=		REPLACE(T1.FEC_INI_GEST,'-','')												-- REPLICATE('0',8)    		-- LLENAR 
,FEC_INI_ELEM                  			=		'19000101' --REPLICATE('0',8)    														 
,FEC_INI_ELEM_GEST             			=		'19000101' --REPLICATE('0',8)    														 
,FEC_CAN_ANT							=		(CASE
													WHEN ISNULL(T1.FEC_CAN_ANT,'1900-01-01') = '1900-01-01' THEN '19000101'	--REPLICATE('0',8)
													ELSE REPLACE(T1.FEC_CAN_ANT,'-','')
												 END)													
--,FEC_CAN_ANT                   		=		REPLACE(FEC_CAN_ANT,'-','')													-- REPLICATE('0',8)    		-- LLENAR 

,FEC_DESCUBIERTO               			=		'19000101' --REPLICATE('0',8)    														 
,FEC_PRIMER_IMPAGO_VIGENTE     			=		'19000101' --REPLICATE('0',8)    														 
,FEC_FIN_ENGANCHE              			=		'19000101' --REPLICATE('0',8)    														 
,FEC_ULT_LIQ                   			=		REPLACE(T1.FEC_ULT_LIQ,'-','')													-- REPLICATE('0',8)    		-- LLENAR 
,FEC_PRX_LIQ                   			=		REPLACE(T1.FEC_PRX_LIQ,'-','')													-- REPLICATE('0',8)    		-- LLENAR 
,FEC_ULT_REV                   			=		REPLACE(T1.FEC_ULT_REV,'-','')													-- REPLICATE('0',8)    		-- LLENAR 
,FEC_PRX_REV                   			=		REPLACE(T1.FEC_PRX_REV,'-','')													-- REPLICATE('0',8)    		-- LLENAR 
,FEC_VEN                       			=		REPLACE(T1.FEC_VEN    ,'-','')													-- REPLICATE('0',8)    		-- LLENAR 
,FEC_VEN_ORIGINAL              			=		'19000101' --REPLICATE('0',8)    		 
--,FRE_PAGO_INT                  		=		RIGHT(REPLICATE('0',5)+CONVERT(VARCHAR(5),ISNULL(FRE_PAGO_INT,0)),5)		-- REPLICATE('0',5)    		-- LLENAR 
,FRE_PAGO_INT							=		RIGHT(REPLICATE('0',5)
												+CONVERT(VARCHAR(5),(CASE 
													WHEN T1.FRE_PAGO_INT = 0 THEN 1
													WHEN ISNULL(T1.FRE_PAGO_INT,0) = 0 THEN 1
													ELSE T1.FRE_PAGO_INT
												END)),5)
,COD_UNI_FRE_PAGO_INT          			=		RIGHT(SPACE(1)        +LTRIM(RTRIM(UPPER(T1.COD_UNI_FRE_PAGO_INT))),1)    									-- LLENAR 
,FRE_REV_INT                   			=		RIGHT(REPLICATE('0',5)+CONVERT(VARCHAR(5),ISNULL(T1.FRE_REV_INT,0)),5)    											-- LLENAR 
,COD_UNI_FRE_REV_INT           			=		RIGHT(SPACE(1)        +LTRIM(RTRIM(UPPER(T1.COD_UNI_FRE_REV_INT))),1)    											-- LLENAR 
,PLZ_CONTRACTUAL               			=		RIGHT(REPLICATE('0',5)+CONVERT(VARCHAR(5),ISNULL(T1.PLZ_CONTRACTUAL,0)),5)    													-- LLENAR 
,PLZ_AMRT                      			=		RIGHT(REPLICATE('0',5)+CONVERT(VARCHAR(5),ISNULL(T1.PLZ_AMRT		,0)),5)    													-- LLENAR 
,COD_UNI_PLZ_AMRT              			=		RIGHT(SPACE(1)		  +LTRIM(RTRIM(UPPER(T1.COD_UNI_PLZ_AMRT))),1)     													-- LLENAR 
,PLZ_PER_PEND                  			=		REPLICATE('0',5)    		 
,PLZ_MED_VEN                   			=		REPLICATE('0',5)    		 
,COD_UNI_PLZ_MED_VEN           			=		SPACE(1)            		 
,PER_LAG                       			=		REPLICATE('0',5)    		 
,COD_UNI_PER_LAG               			=		SPACE(1)            		 
,NUM_REPRECIOS                 			=		REPLICATE('0',5)    		 
,IMP_INI_MO                    			=		(select dbo.Fx_RNT_Formato_Decimales(T1.IMP_INI_MO,20,4,1))					--REPLICATE('0',20)   		-- LLENAR 
,IMP_CUO_MO                    			=		(select dbo.Fx_RNT_Formato_Decimales(T1.IMP_CUO_MO,20,2,1))					--REPLICATE('0',20)   		-- LLENAR 
,IMP_CUO_INI_MO                			=		(select dbo.Fx_RNT_Formato_Decimales(T1.IMP_CUO_INI_MO,20,2,1))				--REPLICATE('0',20)   		-- LLENAR 
--,NUM_CUO_PAC                   		=		RIGHT(REPLICATE('0',5) + CONVERT(VARCHAR(5),ISNULL(NUM_CUO_PAC ,1)),5)    		-- LLENAR 
,NUM_CUO_PAC							=		CASE 
													WHEN T1.NUM_CUO_PAC = 0 THEN REPLICATE('0',4) + '1'
													ELSE RIGHT(REPLICATE('0',5) + CONVERT(VARCHAR(5),ISNULL(T1.NUM_CUO_PAC ,1)),5)
												END
--,NUM_CUO_PEND                  		=		RIGHT(REPLICATE('0',5) + CONVERT(VARCHAR(5),ISNULL(NUM_CUO_PEND,1)),5)    		-- LLENAR 
,NUM_CUO_PEND                  			=		CASE 
													WHEN T1.NUM_CUO_PAC = 0 THEN REPLICATE('0',4) + '1' 
													ELSE RIGHT(REPLICATE('0',5) + CONVERT(VARCHAR(5),ISNULL(T1.NUM_CUO_PEND,0)),5)    		-- LLENAR 
												END
,IMP_AMRT_PRI_ML               			=		REPLICATE('0',20)   		 
,IMP_AMRT_PRI_MO               			=		REPLICATE('0',20)   		 
,IMP_LIM_CRE_TOT               			=		REPLICATE('0',20)   		 
,IMP_LIM_CREDITO_ML            			=		REPLICATE('0',20)   		 
,IMP_LIM_CREDITO_MO            			=		REPLICATE('0',20)   		 
,IMP_LIM_MED_MES_ML            			=		REPLICATE('0',20)   		 
,IMP_LIM_MED_MES_MO            			=		REPLICATE('0',20)   		 
,NUM_DIA_DEMORA                			=		REPLICATE('0',5)    		 
,IMP_MORA1_ML                  			=		REPLICATE('0',20)   		 
,IMP_MORA2_ML                  			=		REPLICATE('0',20)   		 
,IMP_MORA3_ML                  			=		REPLICATE('0',20)   		 
,IMP_MORA4_ML                  			=		REPLICATE('0',20)   		 
,IMP_MORA5_ML                  			=		REPLICATE('0',20)   		 
,IMP_PAGO_ML                   			=		(select dbo.Fx_RNT_Formato_Decimales(T1.IMP_PAGO_ML,20,4,1))		 --REPLICATE('0',20)   		-- LLENAR 
,IMP_PAGO_MO                   			=		(select dbo.Fx_RNT_Formato_Decimales(T1.IMP_PAGO_MO,20,4,1))		 --REPLICATE('0',20)   		-- LLENAR 
,IMP_SAL_CAS_ML                			=		REPLICATE('0',20)   		 
,IMP_SAL_CAS_MO                			=		REPLICATE('0',20)   		 
,IMP_SDO_FALL_ML               			=		REPLICATE('0',20)   		 
,IMP_SDO_FALL_MO               			=		REPLICATE('0',20)   		 
,IMP_SDO_VEN_ML                			=		REPLICATE('0',20)   		 
,IMP_SDO_VEN_MO                			=		REPLICATE('0',20)   		 
,IND_CAN_ANT                   			=		RIGHT(SPACE(1)+LTRIM(RTRIM(UPPER(T1.IND_CAN_ANT))),1)            		-- LLENAR 
,SDO_CAN_ANT_ML                			=		REPLICATE('0',20)   		 
,SDO_CAN_ANT_MO                			=		REPLICATE('0',20)   		 
,IND_FUERA_BLCE                			=		SPACE(1)            		 
,IND_REFINANCIACION            			=		SPACE(1)            		 
,IND_TITULIZADO                			=		SPACE(1)            		 
,IND_CAMB_COND                 			=		SPACE(1)            		 
,IND_LIM_CANCELABLE            			=		SPACE(1)            		 
,IND_CTO_CASADO                			=		SPACE(1)            		 
,COD_PRO_CTO_CASADO            			=		SPACE(4)            		 
,COD_SUBPRODU_CTO_CASADO       			=		SPACE(4)            		 
,IDF_CTO_PAS_CASADO            			=		SPACE(32)           		 
,IND_CTO_INCENTIVADO           			=		SPACE(1)            		 
,IND_CTO_RENOVADO              			=		SPACE(1)            		 
,IND_CTO_SING_TESORERIA        			=		SPACE(1)            		 
,IND_CTO_SUBVEN                			=		SPACE(5)            		 
,IDF_CTO_DERIVADO              			=		SPACE(32)           		 
,TIP_ORIGEN_FONDO_ACT          			=		SPACE(1)            		 
,COD_FONDO_AJENO_ACT           			=		SPACE(3)            		 
,IND_INT_ML                    			=		SPACE(1)            		 
,INT_DIFER_ML                  			=		REPLICATE('0',20)   		 
,INT_DIFER_MO                  			=		REPLICATE('0',20)   		 
,INT_MED_DIFER_ML              			=		REPLICATE('0',20)   		 
,INT_MED_DIFER_MO              			=		REPLICATE('0',20)   		 
,INT_COB_PAG_ML                			=		REPLICATE('0',20)   		 
,INT_COB_PAG_MO                			=		REPLICATE('0',20)   		 
,INT_EXC_ML                    			=		REPLICATE('0',20)   		 
,INT_EXC_MO                    			=		REPLICATE('0',20)   		 
,NUM_EFECTOS                   			=		REPLICATE('0',5)    		 
,NUM_DISP                      			=		REPLICATE('0',5)    		 
,SDO_PRECIO_ML                 			=		REPLICATE('0',20)   		 
,SDO_PRECIO_MO                 			=		REPLICATE('0',20)   		 
,SDO_EXC_LIM_ML                			=		REPLICATE('0',20)   		 
,SDO_EXC_LIM_MO                			=		REPLICATE('0',20)   		 
,SDO_MED_EXC_LIM_ML            			=		REPLICATE('0',20)   		 
,SDO_MED_EXC_LIM_MO            			=		REPLICATE('0',20)   		 
,SDO_DISP_ML                   			=		REPLICATE('0',20)   		 
,SDO_DISP_MO                   			=		REPLICATE('0',20)   		 
,SDO_MED_NDISP_LC_ML           			=		REPLICATE('0',20)   		 
,SDO_MED_NDISP_LC_MO           			=		REPLICATE('0',20)   		 
,SDO_NDISP_LC_ML               			=		REPLICATE('0',20)   		 
,SDO_NDISP_LC_MO               			=		REPLICATE('0',20)   		 
,POR_COM_NO_DISP               			=		REPLICATE('0',8)    		 
,POR_MED_DISP_MES              			=		REPLICATE('0',8)    		 
,SDO_MED_ANT_REP_MO            			=		REPLICATE('0',20)   		 
,SDO_MED_PEND_AMRT_MO          			=		REPLICATE('0',20)   		 
,SDO_ULT_REV_MO                			=		REPLICATE('0',20)   		 
,IND_TAS_PREDEF                			=		RIGHT(SPACE(1) + LTRIM(RTRIM(UPPER(T1.IND_TAS_PREDEF))),1)            		-- LLENAR 
--,TAS_PREDEF                    			=		case when T1.TAS_PREDEF <= 999.99999 then (select dbo.Fx_RNT_Formato_Decimales(T1.TAS_PREDEF,8,5,1)) else '99999999' end
-- MGM Cambio en el tratamiento de la Tasa
,TAS_PREDEF                    			=		CASE
													WHEN T1.TAS_PREDEF <= 999.99999 AND T1.TAS_PREDEF >= 0 THEN 
														(SELECT dbo.Fx_RNT_Formato_Decimales(T1.TAS_PREDEF,8,5,1)) 
													WHEN T1.TAS_PREDEF > 999.99999 THEN 
														(SELECT dbo.Fx_RNT_Formato_Decimales((T1.TAS_PREDEF/10),8,5,1))
													WHEN T1.TAS_PREDEF < 0 THEN 
													(SELECT dbo.Fx_RNT_Formato_Decimales((T1.TAS_PREDEF/100),8,5,1)) 
												END
-- MGM 30-07-2018
,TAS_SPR_PREDEF                			=		REPLICATE('0',8)    		 
,COD_RESPONS_TAS_PREDEF        			=		SPACE(2)            		 
,VAL_IND_REAJUSTE_INI          			=		REPLICATE('0',20)   		 
,VAL_IND_REAJUSTE              			=		REPLICATE('0',20)   		 
,FEC_REESTRUC                  			=		'19000101' -- REPLICATE('0',8)    		 
,FEC_REFINAN                   			=		'19000101' -- REPLICATE('0',8)    		 
,FEC_NOVACION                  			=		'19000101' -- REPLICATE('0',8)    		 
,IND_AVAL_EJECUTADO            			=		SPACE(1)            		 
,IND_DEUDA_PUBLICA             			=		SPACE(1)            		 
,IND_DEUDA_SUBORDINADA         			=		SPACE(1)            		 
,TIP_IDF_EMISION               			=		SPACE(1)            		 
,COD_IDF_EMISION               			=		SPACE(2)            		 
,COD_SIT_CONTABLE              			=		SPACE(4)            		 
,TAS_TAE                       			=		REPLICATE('0',8)    		 
,IND_INVERSION                 			=		SPACE(1)            		 
,COD_SIS_ORIGEN                			=		SPACE(4)            		 
,COD_PROCESO                   			=		SPACE(20)           		 
,USERID_UMO                    			=		SPACE(10)           		 
,TIMEST_UMO                    			=		'19000101' ---REPLICATE('0',8)    		 
,COD_SIT_GESTION               			=		SPACE(4)            		 
,COD_SIT_EXPEDIENTE            			=		SPACE(3)            		 
,COD_FINALIDAD                 			=		SPACE(5)            		 
,COD_DESTINO_FONDOS            			=		SPACE(5)            		 
,FEC_CAMB_COND                 			=		'19000101' --REPLICATE('0',8)    		 
,COD_CARTERA_GEST              			=		SPACE(8)            		 
,COD_COMPLEMENTO               			=		SPACE(6)            		 
,ROWID_FILA                    			=		SPACE(64)           		 
,POR_UTIL_IND                  			=		REPLICATE('0',8)    		 
,POR_CUPON                     			=		REPLICATE('0',8)    		 
,TAS_COM                       			=		REPLICATE('0',8)    		 
,COD_CTO_RENOVADO              			=		SPACE(4)            		 
,COD_CANAL                     			=		SPACE(4)            		 
,FRE_CARENCIA                  			=		REPLICATE('0',5)    		 
,COD_UNI_FRE_CARENCIA          			=		SPACE(1)            		 
,COD_ORI_OPE                   			=		SPACE(4)            		 
,FEC_CAN_CTO                   			=		'19000101' --REPLICATE('0',8)    		 
,FRE_PAGO_CAP                  			=		REPLICATE('0',8)    		 
,COD_UNI_FRE_PAGO_CAP          			=		SPACE(1)            		 
,IND_EXCEPCIONADO              			=		SPACE(1)            		 
,PLZ_CARENCIA                  			=		REPLICATE('0',5)    		 
,COD_SIT_IRR_CTO               			=		SPACE(5)            		 
,FEC_CARENCIA_CAP              			=		'19000101' --REPLICATE('0',8)    		 
,IND_BOOKEO                    			=		SPACE(1)            		 
,IMP_INI_ML                    			=		(select dbo.Fx_RNT_Formato_Decimales(T1.IMP_INI_ML,20,4,1))			--REPLICATE('0',20)   		-- LLENAR 
,IMP_AVAL_CTO                  			=		REPLICATE('0',20)   		 
,IND_DANO_CREDITICIO           			=		SPACE(1)            		 
,IND_EST_RIESGO_CRE            			=		SPACE(1)            		 
,FEC_CARENCIA_INT              			=		'19000101' --REPLICATE('0',8)    		 
,COD_PLAN_GEST_CRE             			=		SPACE(8)            		 
,COD_FIDEICOMISO               			=		SPACE(8)            		 
,COD_CARTERA_CRE               			=		SPACE(8)            		 
,COD_CANAL_CONTR               			=		SPACE(3)            		 
,COD_ENTIDAD_ORI               			=		SPACE(20)           		 
,COD_CENTRO_CART               			=		SPACE(4)            		 
,COD_TIENDA                    			=		SPACE(6)            		 
,COD_BLQ                       			=		REPLICATE('0',2)    		 
,IND_COBZA_JUDICIAL            			=		SPACE(1)            		 
,IMP_COM_PERIOD                			=		REPLICATE('0',20)   		 
,IMP_INT_PERIOD_RESULT         			=		REPLICATE('0',20)   		 
,IMP_INT_PERIOD_FUERA_BLCE     			=		REPLICATE('0',20)   		 
,TIPO_COLOCACION               			=		SPACE(4)            		 
,COD_TIPO_MOVIMIENTO           			=		SPACE(4)            		 
FROM #TMP_DETALLE AS T1
)
SELECT * 
INTO #TMP_DETALLE_OPERACIONES_1
FROM CTE_TMP1 


/* TMP2 */
;WITH CTE_TMP2
AS
(
SELECT 
ID_REG									=		T1.ID_REG
,IDF_SUBCTO_ODS                			=		SPACE(30)           		 
,IND_CTO_SUBRROGACION          			=		SPACE(1)            		 
,COD_TIP_FRE_TAS_REF           			=		SPACE(4)            		 
,COD_NAT_ACT_SUBY              			=		SPACE(4)            		 
,COD_CUENTA_ASC                			=		SPACE(30)           		 
,COD_ENT_CUENTA_ASC            			=		SPACE(4)            		 
,NUM_PLZ_TAS_REF               			=		REPLICATE('0',5)    		 
,NUM_PER_REV                   			=		REPLICATE('0',5)    		 
,NUM_AMT                       			=		REPLICATE('0',5)    		 
,NUM_LIQ                       			=		REPLICATE('0',5)    		 
,POR_DIF                       			=		REPLICATE('0',20)   		 
,POR_TAS_REF                   			=		REPLICATE('0',8)    		 
,POR_INT_DEMORA                			=		REPLICATE('0',8)    		 
,IMP_COM_NO_PERIOD             			=		REPLICATE('0',20)   		 
,IMP_INT_NO_PERIOD             			=		REPLICATE('0',20)   		 
,COD_CLAS_RIESGO               			=		SPACE(8)            		 
,COD_CLAS_RIESGO_MAT           			=		SPACE(4)            		 
,COD_CICLO_PROV                			=		SPACE(4)            		 
,COD_ENT_ORIGEN                			=		SPACE(4)            		 
,IND_RIESGO_SUB                			=		SPACE(1)            		 
,POR_PON_CTO                   			=		REPLICATE('0',20)   		 
,NUM_PER_AMT_REP_INC           			=		REPLICATE('0',5)    		 
,IMP_PRE_VIVIENDA              			=		REPLICATE('0',20)   		 
,COD_SUCURSAL_CTA_ASOCIADA     			=		SPACE(10)           		 
,COD_EST_REF                   			=		SPACE(8)            		 
,COD_PRELACION_DEU_PUB         			=		SPACE(4)            		 
,COD_UNI_FRE_TAS_REF           			=		SPACE(1)            		 
,FEC_BAJA                      			=		'19000101' --REPLICATE('0',8)    		 
,NUM_FRE_TAS_REF               			=		REPLICATE('0',5)    		 
,COD_NATURALEZA_CTO            			=		SPACE(4)            		 
,IND_MOD_PROP_ESTI_RIESGO_CRED 			=		SPACE(1)            		 
,FEC_PRIM_SIT_IRRE_PRIMER_CICLO			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRIM_SIT_IRRE_CICLO_ACTUAL			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ULT_SIT_IRRE_CICLO_ACTUAL 			=		'19000101' --REPLICATE('0',8)    		 
,FEC_RIESGO_SUBESTANDAR        			=		'19000101' --REPLICATE('0',8)    		 
,IMP_LIM_NO_COMPROMETIDO_CTO   			=		REPLICATE('0',20)   		 
,IMP_CTES_TRANSACCION          			=		REPLICATE('0',20)   		 
,IMP_PRIMAS_DCTO_ADQUISICION   			=		REPLICATE('0',20)   		 
,IMP_VALOR_RESI_LEASING        			=		REPLICATE('0',20)   		 
,IMP_PERI_GARAN_FINANCIERAS    			=		REPLICATE('0',20)   		 
,COD_SIT_AMORTIZACION          			=		SPACE(4)            		 
,COD_TIP_FRE_LIQ               			=		SPACE(3)            		 
,NUM_PLZ_LIQ                   			=		REPLICATE('0',11)   		 
,COD_RIES_SUBESTANDAR          			=		SPACE(40)           		 
,COD_INTRAGRUPO                			=		SPACE(4)            		 
,PROV_ESPEC_MATRIZ             			=		REPLICATE('0',23)   		 
,DIST_VENC_MED_PONDERADO       			=		REPLICATE('0',17)   		 
,LIM_LINEA_PARALELA            			=		REPLICATE('0',20)   		 
,LIM_LINEA_EXPRESS             			=		REPLICATE('0',20)   		 
,LIM_LINEA_CUOTAS              			=		REPLICATE('0',20)   		 
,COD_PROGDESCTO                			=		SPACE(1)            		 
,TIP_DIAS                      			=		SPACE(1)            		 
,TIP_COBRO                     			=		SPACE(1)            		 
,FEC_PERI_GRACIA_MORATORIOS    			=		'19000101' --REPLICATE('0',8)    		 
,IND_PAPERLESS                 			=		SPACE(1)            		 
,IND_PREEMBOZADOS              			=		SPACE(1)            		 
,COD_BLOQUEO_MAYOR_PRIORIDAD   			=		REPLICATE('0',2)    		 
,FEC_BLOQUEO                   			=		'19000101' --REPLICATE('0',8)    		 
,IND_DISP_LINEA_PARALELA       			=		SPACE(2)            		 
,FEC_ASIG_LINEA                			=		'19000101' --REPLICATE('0',8)    		 
,FEC_DISP_LINEA_EXPRESS        			=		'19000101' --REPLICATE('0',8)    		 
,COD_TIP_IMP                   			=		SPACE(4)            		 
,IDF_PERS_ODS_BENEF            			=		SPACE(25)           		 
,IND_LIM_CANC_ENTIDAD          			=		SPACE(1)            		 
,IND_INTERNEG                  			=		SPACE(1)            		 
,COD_MOT_CANCE_CTO             			=		SPACE(40)           		 
,IMP_PRIM_SIT_IRRE_CICLO_ACT   			=		REPLICATE('0',23)   		 
,IMP_PRIM_SIT_IRRE_CICLO       			=		REPLICATE('0',23)   		 
,IND_EXC_CAL_IRB               			=		SPACE(1)            		 
,COD_MOT_ALTA_EXPOS            			=		SPACE(40)           		 
,FEC_INI_CARE_CAPITAL          			=		'19000101' --REPLICATE('0',8)    		 
,FEC_INI_CARE_INT              			=		'19000101' --REPLICATE('0',8)    		 
,IND_SUBROGACION               			=		SPACE(1)            		 
,IDF_CTA_CORRENTE              			=		SPACE(20)           		 
,TIP_ORIGEN_FON_BACEN          			=		SPACE(4)            		 
,IND_BLQ_TAR                   			=		REPLICATE('0',2)    		 
,IND_SIT_TAR                   			=		REPLICATE('0',2)    		 
,BLOQUE_ACT                    			=		REPLICATE('0',2)    		 
,EST_CRED                      			=		SPACE(1)            		 
,MORA_ESPANA                   			=		SPACE(1)            		 
,REESTRUCTURADO                			=		SPACE(1)            		 
--,TAS_INT_ORIGEN                			=		(select dbo.Fx_RNT_Formato_Decimales(TAS_INT_ORIGEN,8,5,1))				--REPLICATE('0',8)    		-- LLENAR 
-- MGM Cambio en el tratamiento de la Tasa
,TAS_INT_ORIGEN                			=		CASE
													WHEN LTRIM(RTRIM(T1.COD_PRODUCTO)) in ('PCS','OPT','BFW','SWAP') THEN 
														REPLICATE('0',8) 
													ELSE 
														CASE 
															WHEN isnull(T1.TAS_INT_ORIGEN,0) <= 999.99999 AND isnull(T1.TAS_INT_ORIGEN,0) >= 0 THEN 
																(SELECT dbo.Fx_RNT_Formato_Decimales(isnull(T1.TAS_INT_ORIGEN,0),8,5,1)) 
															WHEN isnull(T1.TAS_INT_ORIGEN,0) > 999.99999 THEN 
																(SELECT dbo.Fx_RNT_Formato_Decimales((isnull(T1.TAS_INT_ORIGEN,0)/10),8,5,1))
															WHEN isnull(T1.TAS_INT_ORIGEN,0) < 0 THEN 
															(SELECT dbo.Fx_RNT_Formato_Decimales((isnull(T1.TAS_INT_ORIGEN,0)/100),8,5,1)) 
													END
												END
-- MGM 30-07-2018
,IMP_PRIM_IMPAGO_NO_REGU       			=		REPLICATE('0',23)   		 
,IND_AMORT_ANTI                			=		SPACE(1)            		 
,NUM_PLAZO_CARE_INTE           			=		SPACE(4)            		 
,COD_EMISION                   			=		SPACE(70)           		 
,COD_TIP_IDF_EMISION           			=		SPACE(4)            		 
,SPRD_TRANSFE                  			=		REPLICATE('0',8)    		 
,TAS_CAM_REAL                  			=		REPLICATE('0',8)    		 
,COD_SIT_CTO                   			=		SPACE(4)            		 
,TT_IN_CAM_PROM                			=		REPLICATE('0',8)    		 
,COD_PROD_SBIF                 			=		SPACE(4)            		 
,USER_TABLA                    			=		SPACE(11)           		 
,IND_OPERACION                 			=		SPACE(1)            		 
,CON_GRADO_REE                 			=		REPLICATE('0',7)    		 
,IMP_DEUD_VENC_NOREP           			=		REPLICATE('0',20)   		 
,IMP_SUBSD_FNG                 			=		REPLICATE('0',20)   		 
,ID_OPER_ENT                   			=		SPACE(12)           		 
,TIP_RIES_ENT_MO               			=		SPACE(4)            		 
,TIP_RIES_ENT_ML               			=		SPACE(4)            		 
,IMP_CUO_ML                    			=		REPLICATE('0',20)   		 
,PORC_REAJUST                  			=		REPLICATE('0',20)   		 
,COD_CREDI_CIFIN               			=		REPLICATE('0',19)   		 
,TIP_EXT_DEUD                  			=		SPACE(120)          		 
,NUM_COU_MOR                   			=		REPLICATE('0',4)    		 
,NUM_CAMB                      			=		SPACE(5)            		 
,IMP_BASE_IMPUESTO_MO          			=		REPLICATE('0',20)   		 
,TIP_SOBR                      			=		SPACE(1)            		 
,FEC_OTORG_OP                  			=		'19000101' --REPLICATE('0',8)    		 
,FEC_COMP_DES                  			=		'19000101' --REPLICATE('0',8)    		 
,PORC_FIN_VIV                  			=		REPLICATE('0',20)   		 
,PORC_DEFAULT                  			=		REPLICATE('0',20)   		 
,COD_SWIFT                     			=		SPACE(10)           		 
,IMP_PAG_FEC                   			=		REPLICATE('0',20)   		 
,TAR_ICA                       			=		SPACE(3)            		 
,NUM_REST                      			=		REPLICATE('0',3)    		 
,NUM_RNEGC                     			=		REPLICATE('0',3)    		 
,TIP_FACT_REEST                			=		SPACE(1)            		 
,IND_CUO_ANTICIPADAS           			=		SPACE(1)            		 
,IMP_CUO_FUERA_BLCE            			=		REPLICATE('0',20)   		 
,COD_OFI_DEV                   			=		SPACE(20)           		 
,COD_OFI_RETROCESION           			=		SPACE(20)           		 
,DES_COD_CONVENIO_ASC_CTO      			=		SPACE(20)           		 
,COD_EST_EMBARGO               			=		SPACE(20)           		 
,FEC_ULT_PROVISION             			=		'19000101' --REPLICATE('0',8)    		 
,FEC_FIN_CUSTODIA              			=		'19000101' --REPLICATE('0',8)    		 
,FEC_INI_CUSTODIA              			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRX_PROPAGANDA            			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRX_ENVIO_CUPONERA        			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ULT_ENVIO_CUPONERA        			=		'19000101' --REPLICATE('0',8)    		 
,IMP_RECUP_RECIBO_ML           			=		REPLICATE('0',20)   		 
,IND_CAMB_PERIODIF             			=		SPACE(1)            		 
,IND_REDUCCION_CUO_PREP        			=		SPACE(1)            		 
,IND_RETROCESION               			=		SPACE(1)            		 
,NUM_MIN_FIADORES              			=		REPLICATE('0',2)    		 
,IMP_CAP_ACELERADO             			=		REPLICATE('0',20)   		 
,IMP_SOL_ML                    			=		REPLICATE('0',20)   		 
,FREQ_LIQ_INT_CAR              			=		REPLICATE('0',3)    		 
,COD_TRAT_SEGURO_CAR           			=		SPACE(20)           		 
,COD_INT_CARENCIA              			=		SPACE(20)           		 
,NUM_DIA_PAGO                  			=		SPACE(2)            		 
,FEC_CASTIGO                   			=		'19000101' --REPLICATE('0',8)    		 
,FEC_EMI_RECIBO                			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PAGO_ORIG                 			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRIM_FACTURACION          			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRX_COM_IMPG              			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRX_SEG_CAR               			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PRX_EXTRACTO              			=		'19000101' --REPLICATE('0',8)    		 
,FEC_VENTA                     			=		'19000101' --REPLICATE('0',8)    		 
,FEC_LIM_PLZ_ADICIONALES       			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ULT_FACTURACION           			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ULT_CALC_MORA             			=		'19000101' --REPLICATE('0',8)    		 
,COD_PAGO_OBLIGACION           			=		SPACE(20)           		 
,IMP_ACREEDOR                  			=		REPLICATE('0',20)   		 
,IMP_OPC_COMPRA                			=		REPLICATE('0',20)   		 
,IMP_FACTURADO_ML              			=		REPLICATE('0',20)   		 
,IMP_MAX_DISPOSIC_ML           			=		REPLICATE('0',20)   		 
,IMP_MIN_LIQUIDACION           			=		REPLICATE('0',20)   		 
,IMP_MIN_DISPOSIC_ML           			=		REPLICATE('0',20)   		 
,IND_TIP_AJUSTE_CUO            			=		SPACE(1)            		 
,IND_COMUN_IMPAGADOS           			=		SPACE(1)            		 
,IND_ACELERADO                 			=		SPACE(1)            		 
,IND_AJUS_HABIL                			=		SPACE(1)            		 
,IND_AJUS_CUO_CAREN            			=		SPACE(1)            		 
,FEC_MORATORIOS                			=		'19000101' --REPLICATE('0',8)    		 
,IND_CUO_CASTIGADA             			=		SPACE(1)            		 
,IND_TIP_CUO_EXTRA             			=		SPACE(1)            		 
,COD_FRE_EXTRACTO              			=		SPACE(20)           		 
,UNI_FRE_EXTRACTO              			=		SPACE(20)           		 
,IND_PRORROGA_CUOTA            			=		SPACE(1)            		 
,IND_CAMB_TAS_INT              			=		SPACE(1)            		 
,IND_RECALCULO_CUO             			=		SPACE(1)            		 
,MESES_CUO_EXTRAORDINARIA      			=		REPLICATE('0',3)    		 
,IND_NUEVO_ESTADO_CTA          			=		SPACE(1)            		 
,NUM_TRAMO                     			=		REPLICATE('0',3)    		 
,PLZ_MIN_CANCELACION           			=		REPLICATE('0',3)    		 
,POR_REFINAN_CUO               			=		REPLICATE('0',7)    		 
,POR_MAX_CAPITALIZACION        			=		REPLICATE('0',7)    		 
,PRM_MES_DOS_CUO               			=		REPLICATE('0',2)    		 
,SDO_PRORROGA_CUO              			=		REPLICATE('0',20)   		 
,IMP_TOT_HIPOT_VIS             			=		REPLICATE('0',20)   		 
,COD_ENTIDAD_CONVENIO          			=		SPACE(20)           		 
,COD_UNI_FRE_DEB_AUTOM         			=		SPACE(20)           		 
,UNI_FRE_DEB_AUTOM             			=		SPACE(20)           		 
,IND_TIP_LIQ                   			=		SPACE(1)            		 
,COD_CONVENIO_ASC_CTO          			=		SPACE(20)           		 
,COD_SUBVENCION_ORIG           			=		SPACE(20)           		 
,IND_CONDIC_ADMINISTRAT        			=		SPACE(1)            		 
,COD_SUBVENCION                			=		SPACE(20)           		 
,COD_TIP_REVISION              			=		SPACE(20)           		 
,COD_ENTI_SUBVEN_ORI           			=		SPACE(20)           		 
,IND_ESTADO_REVISION           			=		SPACE(1)            		 
,FEC_APROB_PROP                			=		'19000101' --REPLICATE('0',8)    		 
,FEC_VEN_SUBVENCION            			=		'19000101' --REPLICATE('0',8)    		 
,FEC_AVI_PRX_REVI              			=		'19000101' --REPLICATE('0',8)    		 
,FEC_SIT_CTO                   			=		'19000101' --REPLICATE('0',8)    		 
,TIP_CALENDARIO                			=		SPACE(1)            		 
,IND_AJUSTE_VEN_INHABILES      			=		SPACE(1)            		 
,IND_AJUSTE_REV_INHABILES      			=		SPACE(1)            		 
,IND_ACTU_PROV                 			=		SPACE(1)            		 
FROM #TMP_DETALLE AS T1
)
SELECT * 
INTO #TMP_DETALLE_OPERACIONES_2
FROM CTE_TMP2


/* TMP3 */
;WITH CTE_TMP3
AS
(
SELECT 
 ID_REG									=		T1.ID_REG
,IND_AVISO_VTO                 			=		SPACE(1)            		 
,IND_CAP_AUTOMATICA            			=		SPACE(1)            		 
,IND_CARTERA_VENDIDA           			=		SPACE(1)            		 
,IND_PAGARE                    			=		SPACE(1)            		 
,IND_ESTADO_RECIBO             			=		SPACE(1)            		 
,IND_FINANCIACION_IVA          			=		SPACE(1)            		 
,IND_CTO_GARANTIA              			=		SPACE(1)            		 
,IND_INT_COB_ACELERACION       			=		SPACE(1)            		 
,IND_MORA_CONDONADA            			=		SPACE(1)            		 
,IND_NO_FACTURA_CARENCIA       			=		SPACE(1)            		 
,IND_OPE_PAGARE                			=		SPACE(1)            		 
,IND_NO_PAGO                   			=		SPACE(1)            		 
,IND_SEGURO                    			=		SPACE(1)            		 
,IND_CUADRO_MANUAL             			=		SPACE(1)            		 
,IND_CTA_MANCOMUNADA           			=		SPACE(1)            		 
,DES_MOT_CUPO                  			=		SPACE(20)           		 
,NOM_PORTAFOLIO                			=		SPACE(20)           		 
,FEC_PRIM_AMRT                 			=		'19000101' --REPLICATE('0',8)    		 
,NUM_IMPAGOS                   			=		REPLICATE('0',20)   		 
,NUM_AUTORIZACION_RENOV        			=		REPLICATE('0',20)   		 
,NUM_CUO_EXTR                  			=		REPLICATE('0',3)    		 
,NUM_CUO_VENC                  			=		REPLICATE('0',3)    		 
,NUM_CUO_PRORROGA              			=		REPLICATE('0',3)    		 
,NUM_RECIBOS_EMITIDOS          			=		REPLICATE('0',20)   		 
,NUM_RENOVACIONES              			=		REPLICATE('0',3)    		 
,NUM_DIAS_MAX_RENOVACION       			=		REPLICATE('0',3)    		 
,NUM_MAX_RENOVACIONES          			=		REPLICATE('0',3)    		 
,NUM_SECUENCIA_EXC             			=		SPACE(20)           		 
,COD_UNI_FRE_DIF_INT           			=		SPACE(20)           		 
,UNI_FRE_DIF_INT               			=		SPACE(20)           		 
,FRE_UNI_RENOV                 			=		SPACE(20)           		 
,COD_UNI_FRE_RENOV             			=		SPACE(20)           		 
,PORC_INT_SUBVEN               			=		REPLICATE('0',7)    		 
,IMP_RETENIDO_AFC              			=		REPLICATE('0',20)   		 
,IMP_SDO_INSOLUTO              			=		REPLICATE('0',20)   		 
,IMP_SDO_REAJUSTABLE           			=		REPLICATE('0',20)   		 
,SEG_MES_DOS_CUO               			=		REPLICATE('0',2)    		 
,IND_ESTADO_TARIFA             			=		SPACE(1)            		 
,COD_OFI_FIN_CUSTODIA          			=		SPACE(20)           		 
,COD_TIP_CUO_EXTRAORDINARIA    			=		SPACE(20)           		 
,COD_TIP_REDONDEO              			=		SPACE(20)           		 
,COD_TIP_REDUCCION             			=		SPACE(20)           		 
,ACC_SUSP_CARENCIA             			=		SPACE(1)            		 
,NUM_SEC_TITULARIZACION        			=		SPACE(20)           		 
,IMP_INI_ANTIC_ML              			=		REPLICATE('0',20)   		 
,FEC_ACELERACION               			=		'19000101' --REPLICATE('0',8)    		 
,FEC_DESACELERACION            			=		'19000101' --REPLICATE('0',8)    		 
,FEC_INI_VALIDEZ               			=		'19000101' --REPLICATE('0',8)    		 
,IND_CONCEPTO_NEG              			=		SPACE(1)            		 
,COD_REDONDEO_TARIFA           			=		SPACE(20)           		 
,IND_LIM_NEGOCIABLE            			=		SPACE(1)            		 
,IND_INT_PREPAGO               			=		SPACE(1)            		 
,COD_FRE_REV_TAS               			=		SPACE(20)           		 
,PLZ_MAX_TARIFA                			=		REPLICATE('0',3)    		 
,SDO_FIN_VAL_INT               			=		REPLICATE('0',20)   		 
,SDO_INI_VAL_INT               			=		REPLICATE('0',20)   		 
,COD_PLAN_COMISION             			=		SPACE(20)           		 
,FEC_FIN_VALIDEZ               			=		'19000101' --REPLICATE('0',8)    		 
,POR_DESC_COM                  			=		REPLICATE('0',8)    		 
,IND_MOV_AMRT                  			=		SPACE(1)            		 
,IND_CONDONA_INT_PRIMER_MES    			=		SPACE(1)            		 
,VAL_TAS_REF_MORA              			=		REPLICATE('0',20)   		 
,COD_FORMA_PAGO                			=		SPACE(20)           		 
,IND_TARJETA                   			=		SPACE(1)            		 
,IND_PAGO_TOTAL                			=		SPACE(1)            		 
,COD_BLOQ_TIP_TRANS            			=		SPACE(20)           		 
,NUM_CUO_REVOLVENTES           			=		REPLICATE('0',22)   		 
,COD_INTERNO_TARJETA           			=		SPACE(20)           		 
,COD_MARCA_TARJETA             			=		SPACE(20)           		 
,COD_BLOQUEO                   			=		SPACE(10)           		 
,FEC_CORTE_MAX                 			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ESTAMPACION               			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ACT_TARJETA               			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ENTREGA_TARJETA           			=		'19000101' --REPLICATE('0',8)    		 
,NUM_DIAS_INT_CORR             			=		SPACE(1)            		 
,PORC_EXON_CUOTA_MENEJO        			=		SPACE(1)            		 
,COD_TIP_CTO_TARJETA           			=		SPACE(20)           		 
,NUM_TARJETA_ADICIONALES       			=		SPACE(1)            		 
,NUM_TARJETA_RENOV             			=		SPACE(1)            		 
,IND_CHIP                      			=		SPACE(1)            		 
,IND_TIPO_CTA_TARJETA          			=		SPACE(1)            		 
,IMP_MIN_DIFERIR               			=		REPLICATE('0',20)   		 
,COD_BLOQUEO_REES              			=		SPACE(20)           		 
,COD_BLOQUEO_SDO               			=		SPACE(20)           		 
,COD_BLOQUEO_EXCE              			=		SPACE(28)           		 
,FEC_BLOQUEO_SALDO             			=		'19000101' --REPLICATE('0',8)    		 
,FEC_BLOQUEO_SOBRECUPO         			=		'19000101' --REPLICATE('0',8)    		 
,FEC_ULT_USO                   			=		'19000101' --REPLICATE('0',8)    		 
,FEC_INI_COBR_INT_CORR         			=		'19000101' --REPLICATE('0',8)    		 
,FEC_PROCESO_DIAN              			=		'19000101' --REPLICATE('0',8)    		 
,IMP_PAGO_MIN_ESP_ML           			=		REPLICATE('0',20)   		 
,IND_COBRO_IMP                 			=		SPACE(1)            		 
,IND_FIN_INTERES_CORRIENTE     			=		SPACE(1)            		 
,TAS_INT_MORA                  			=		REPLICATE('0',8)    		 
,NUM_CHQ                       			=		SPACE(28)           		 
,COD_PREEXPED_CHQ              			=		SPACE(20)           		 
,FEC_COBRO                     			=		'19000101' --REPLICATE('0',8)    		 
,FEC_INI_GIROS                 			=		'19000101' --REPLICATE('0',8)    		 
,NUM_MOV_EXTRACTO              			=		REPLICATE('0',22)   		 
,NUM_ORDEN_NOPAGO              			=		REPLICATE('0',20)   		 
,NUM_VCS_CHQ_MORA              			=		REPLICATE('0',20)   		 
,TIPO_TALONARIO                			=		SPACE(20)           		 
,NUM_CHQ_FISICOS_TALONARIO     			=		REPLICATE('0',3)    		 
,COD_BLQ_TALONARIO             			=		SPACE(20)           		 
,COD_BLQ_CUPO                  			=		SPACE(20)           		 
,FEC_CAP_INT                   			=		'19000101' --REPLICATE('0',8)    		 
,FEC_RENOV                     			=		'19000101' --REPLICATE('0',8)    		 
,IMP_MIN_TRANS_LCA             			=		REPLICATE('0',20)   		 
,IND_CUPON_FICTICIO            			=		SPACE(1)            		 
,IND_CAP_INT_RENOVADO          			=		SPACE(1)            		 
,IND_CTO_DOS_DIVISAS           			=		SPACE(1)            		 
,IND_LIQ_COMISIONES            			=		SPACE(1)            		 
,IND_COONDICION_ESP_CTO        			=		SPACE(1)            		 
,IND_CTA_ESPERA                			=		SPACE(1)            		 
,IND_LIBRETA_PERDIDA           			=		SPACE(1)            		 
,COD_MOT_APERTURA              			=		SPACE(20)           		 
,COD_MOT_LIBRETA               			=		SPACE(20)           		 
,NUM_LIBRETA                   			=		REPLICATE('0',20)   		 
,NUM_PRX_PAG_LIBRETA           			=		SPACE(28)           		 
,NUM_PRIMER_CHQ_TALONARIO      			=		SPACE(28)           		 
FROM #TMP_DETALLE AS T1
)
SELECT *
INTO #TMP_DETALLE_OPERACIONES_3
FROM CTE_TMP3

/* TMP 4 */
;WITH CTE_TMP4
AS
(
SELECT 
 ID_REG									=		T1.ID_REG
,SDO_MIN_CTO                   			=		REPLICATE('0',20)   		 
,STOCK_TAL_CTA                 			=		REPLICATE('0',3)    		 
,ULT_NUM_CHQ_ASIG              			=		REPLICATE('0',10)   		 
,VAL_SWAP                      			=		REPLICATE('0',20)   		 
,IND_BENEFICIO                 			=		SPACE(1)            		 
,DES_PLAN_PAQUETE              			=		SPACE(20)           		 
,FEC_CIERRE_PLAN               			=		'19000101' --REPLICATE('0',8)    		 
,FEC_FIN_DIF_INT               			=		'19000101' --REPLICATE('0',8)    		 
,FEC_VENTA_PLAN                			=		'19000101' --REPLICATE('0',8)    		 
,COD_ID_PLAN                   			=		SPACE(20)           		 
,INC_BON_EXC                   			=		REPLICATE('0',20)   		 
,INC_INT_NO_AUT                			=		REPLICATE('0',20)   		 
,IND_CTA_INMOVILIZADA          			=		SPACE(1)            		 
,INT_ABN_RENOV                 			=		REPLICATE('0',20)   		 
,IND_EMBARGO                   			=		SPACE(1)            		 
,IND_COBRANZA_EXTERNA          			=		SPACE(1)            		 
,COD_REF_CUOTA                 			=		SPACE(20)           		 
,IND_RECHAZO_CONFIRMING        			=		SPACE(1)            		 
,POR_COB_CONFIRMING            			=		REPLICATE('0',7)    		 
,COD_EVENTO_PAQUETE            			=		SPACE(20)           		 
,COD_PAQUETE                   			=		SPACE(20)           		 
,IND_FACT_CAP                  			=		SPACE(1)            		 
,NOM_AREA_REC                  			=		SPACE(20)           		 
,COD_GESTOR_RECU               			=		SPACE(8)            		 
,DES_COD_BLOQUEO               			=		SPACE(50)           		 
,DES_CAMARA                    			=		SPACE(50)           		 
,FEC_DESEMB                    			=		'19000101' --REPLICATE('0',8)    		 
,COD_PORTAFOLIO                			=		RIGHT(SPACE(10)+ LTRIM(RTRIM(UPPER(T1.COD_PORTAFOLIO))),10)           		-- LLENAR 
,NOM_COMITE_APROB              			=		SPACE(20)           		 
,IMP_ULT_CUOTA_CAP             			=		REPLICATE('0',20)   		 
,IMP_DESEMBOLSO                			=		REPLICATE('0',20)   		 
,IMP_OTRO_CUPO                 			=		REPLICATE('0',20)   		 
,COD_ESTADO_TALONARIO          			=		SPACE(20)           		 
,COD_CONC_NOVEDAD              			=		SPACE(10)           		 
,COD_AUT_REGULADOR             			=		SPACE(14)           		 
,IND_CAMB_NUM_OPER             			=		SPACE(2)            		 
,IND_DILIGEN_OBSERV            			=		SPACE(2)            		 
,VAL_INI_COMPRA_VENTA          			=		REPLICATE('0',20)   		 
,COD_CONDICION_CTO             			=		SPACE(3)            		 
,COD_OPR_REGULADOR             			=		SPACE(14)           		 
,COND_EJERCICIO                			=		SPACE(20)           		 
,FEC_CAMB_ESTADO               			=		'19000101' --REPLICATE('0',8)    		 
,IND_NAC_TARJETA               			=		SPACE(2)            		 
,IND_SUBS_CC                   			=		SPACE(2)            		 
,MOD_ENTREGA_CARTCRED          			=		SPACE(2)            		 
,NUM_TAR_ASOC                  			=		SPACE(20)           		 
,FEC_INI_CUPON                 			=		'19000101' --REPLICATE('0',8)    		 
,FEC_EMISION                   			=		'19000101' --REPLICATE('0',8)    		 
,FEC_FIN_CUPON                 			=		'19000101' --REPLICATE('0',8)    		 
,DES_PORTAFOLIO                			=		RIGHT(SPACE(20)+LTRIM(RTRIM(UPPER(T1.DES_PORTAFOLIO ))),20)            		-- LLENAR 
,COD_NEMOTECNICO               			=		RIGHT(SPACE(20)+LTRIM(RTRIM(UPPER(T1.COD_NEMOTECNICO))),20)            		-- LLENAR 
,COD_TRADER                    			=		SPACE(4)            		 
,VAL_PREC_LIMP                 			=		REPLICATE('0',20)   		 
,IMP_NOMINAL                   			=		REPLICATE('0',20)   		 
,IMP_AVR                       			=		REPLICATE('0',20)   		 
,COD_AVR_DIVISA                			=		SPACE(8)            		 
,COD_CARTERA_FINANCI           			=		RIGHT(SPACE(8)+LTRIM(RTRIM(UPPER(T1.COD_CARTERA_FINANCI))),8)            		-- LLENAR 
,COD_SUBCARTERA_NORMATIVA      			=		SPACE(8)            		 
,IND_TIP_DEVENGO               			=		SPACE(1)            		 
,COD_TIP_OPERACION             			=		SPACE(1)            		 
,COTIZ_DIVISA_ML               			=		REPLICATE('0',20)   		 
,COD_TIP_LIQUIDACION_CL        			=		SPACE(5)            		 
,IMP_FIN_ML                    			=		REPLICATE('0',20)   		 
,IMP_FIN_MO                    			=		REPLICATE('0',20)   		 
,IMP_TRX_USD                   			=		REPLICATE('0',20)   		 
,VALOR_SPOT_GAMA               			=		REPLICATE('0',20)   		 
,IMP_DELTA                     			=		REPLICATE('0',20)   		 
,VALOR_GAMMA                   			=		REPLICATE('0',20)   		 
,VALOR_VEGA                    			=		REPLICATE('0',20)   		 
,VALOR_THETA                   			=		REPLICATE('0',20)   		 
,IND_TIP_CONFIGURACION         			=		SPACE(1)            		 
,FEC_FIJACION                  			=		'19000101' --REPLICATE('0',8)    		 
,SEC_FIJACION                  			=		REPLICATE('0',8)    		 
,COD_TIP_CAMBIO_FIJACION       			=		REPLICATE('0',20)   		 
,VAL_VOLATIDAD                 			=		REPLICATE('0',20)   		 
,TIP_WEIGHT                    			=		REPLICATE('0',8)    		 
,IMP_MONTO_CONTRAVALOR         			=		REPLICATE('0',20)   		 
,COD_LIQ_DIVISA                			=		SPACE(3)            		 
,COD_TIP_LIBRO                 			=		RIGHT(SPACE(1) + LTRIM(RTRIM(UPPER(T1.COD_TIP_LIBRO))),1)            		-- LLENAR 
,TIP_OPERA_SENSE               			=		SPACE(20)           		 
FROM #TMP_DETALLE AS T1
)
SELECT * 
INTO #TMP_DETALLE_OPERACIONES_4
FROM CTE_TMP4 

/* TMP 5*/
;WITH CTE_TMP5
AS
(
SELECT
ID_REG									=		ID_REG
,COD_TIP_OPCION                			=		SPACE(20)           		 
,COD_CURV_DESC                 			=		SPACE(20)           		 
,COD_CURV_PROY                 			=		SPACE(20)           		 
,IND_EMPR_PAR_FISC             			=		SPACE(1)            		 
,COD_MODAL                     			=		SPACE(1)            		 
,TIP_TAS_FWD                   			=		REPLICATE('0',20)   		 
,TIP_TAS_SPOT                  			=		REPLICATE('0',20)   		 
,FEC_INVEN                     			=		'19000101' --REPLICATE('0',8)    		 
,VAL_TRM                       			=		REPLICATE('0',20)   		 
,COD_TIP_PATA                  			=		SPACE(3)            		 
,COD_CURV_REF_DESC             			=		SPACE(20)           		 
,COD_TIP_INV_NEGOCIACION       			=		SPACE(4)            		 
,COD_DIVISA_FIJACION           			=		SPACE(3)            		 
,NUM_COMPONENTE                			=		SPACE(20)           		 
,VAL_TIR                       			=		REPLICATE('0',8)    		 
,FACTOR_RIESGO_SUBYA           			=		SPACE(20)           		 
,DIVISA_SUBYACENTE             			=		SPACE(3)            		 
,VAR_PYG                       			=		REPLICATE('0',20)   		 
,VPN                           			=		REPLICATE('0',20)   		 
,VAL_RIESGO                    			=		REPLICATE('0',20)   		 
,VAL_VTO                       			=		REPLICATE('0',20)   		 
,VAL_ACUM                      			=		REPLICATE('0',20)   		 
,VAL_COSTO                     			=		REPLICATE('0',20)   		 
,PYG_TIR                       			=		REPLICATE('0',20)   		 
,VAL_VALORACION                			=		REPLICATE('0',20)   		 
,COTI_DIVISA                   			=		REPLICATE('0',20)   		 
,REFERENCIA                    			=		SPACE(20)           		 
,IMP_TASA_SUCIA                			=		REPLICATE('0',20)   		 
,TAS_CAMBIO                    			=		REPLICATE('0',20)   		 
,IDF_EMISOR                    			=		SPACE(25)           		 
--,NUM_DOC                       		=		RIGHT(SPACE(12)+LTRIM(RTRIM(UPPER(T1.NUM_DOC    ))),12)           		-- LLENAR 
,NUM_DOC                       			=		right(replicate('0',12)+convert(varchar(12),T1.NUM_DOC),12) --+++FMO 20190311
,NUM_OPE_ANT                   			=		RIGHT(SPACE(12)+LTRIM(RTRIM(UPPER(T1.NUM_OPE_ANT))),12)           		-- LLENAR 
,COD_MOD_LIQ                   			=		SPACE(1)            		 
FROM #TMP_DETALLE AS T1
)
SELECT *
INTO #TMP_DETALLE_OPERACIONES_5
FROM CTE_TMP5 


-- PRINT 'GENERANDO INDICES' + CONVERT(VARCHAR,GETDATE(),114)
CREATE NONCLUSTERED INDEX IDX_001 ON #TMP_DETALLE_OPERACIONES_1(ID_REG)
CREATE NONCLUSTERED INDEX IDX_001 ON #TMP_DETALLE_OPERACIONES_2(ID_REG)
CREATE NONCLUSTERED INDEX IDX_001 ON #TMP_DETALLE_OPERACIONES_3(ID_REG)
CREATE NONCLUSTERED INDEX IDX_001 ON #TMP_DETALLE_OPERACIONES_4(ID_REG)
CREATE NONCLUSTERED INDEX IDX_001 ON #TMP_DETALLE_OPERACIONES_5(ID_REG)
-- PRINT 'INDICES GENERADOS' + CONVERT(VARCHAR,GETDATE(),114)


/*******************************************************
		DESPLIEGUE DE RESULTADOS
********************************************************/
/*
-- PARA DEBUG
SELECT COUNT(*) AS TOTAL_1 FROM #TMP_DETALLE_OPERACIONES_1
SELECT COUNT(*) AS TOTAL_2 FROM #TMP_DETALLE_OPERACIONES_2
SELECT COUNT(*) AS TOTAL_3 FROM #TMP_DETALLE_OPERACIONES_3
SELECT COUNT(*) AS TOTAL_4 FROM #TMP_DETALLE_OPERACIONES_4
SELECT COUNT(*) AS TOTAL_5 FROM #TMP_DETALLE_OPERACIONES_5
RETURN 
*/

	SELECT 		
			 IDF_CTO_ODS                   		
			,COD_CONTENIDO                 			
			,FEC_DATA                      			
			,COD_PAIS                      			
			,COD_ENTIDAD                   			
			,COD_CENTRO                    			
			,COD_PRODUCTO                  			
			,COD_SUBPRODU                  			
			,NUM_CUENTA                    			
			,NUM_SECUENCIA_CTO
			,COD_DIVISA                    			
			,COD_REAJUSTE                  			
			,IDF_PERS_ODS                  			
			,COD_CENTRO_CONT               			
			,COD_OFI_COMERCIAL             			
			,COD_GESTOR_PROD               			
			,COD_PROPUESTA                 			
			,COD_COMBO                     			
			,IDF_ELEM                      			
			,COD_BASE_TAS_INT              			
			,COD_BCA_INT                   			
			,COD_COMPOS_INT                			
			,COD_MOD_PAGO                  			
			,COD_MET_AMRT                  			
			,COD_CUR_REF                   			
			,COD_TIP_TAS                   			
			,TAS_INT                       			
			,TAS_INT_MIN                   			
			,TAS_INT_MAX                   			
			,COD_BASE_TAS_INT_EXC          			
			,TAS_INT_EXC                   			
			,TAS_DIF_INC_REF               			
			,TAS_DIF_CUR_COSTE             			
			,COD_SIT_DEVENGO               			
			,COD_PEOR_SIT_CTO              			
			,COD_PEOR_SIT_CTO_BIS          			
			,FEC_ALTA_CTO                  			
			,FEC_INI_GEST                  			
			,FEC_INI_ELEM                  			
			,FEC_INI_ELEM_GEST             			
			,FEC_CAN_ANT                   			
			,FEC_DESCUBIERTO               			
			,FEC_PRIMER_IMPAGO_VIGENTE	     			
			,FEC_FIN_ENGANCHE              			
			,FEC_ULT_LIQ                   			
			,FEC_PRX_LIQ                   			
			,FEC_ULT_REV                   			
			,FEC_PRX_REV                   			
			,FEC_VEN                       			
			,FEC_VEN_ORIGINAL              			
			,FRE_PAGO_INT                  			
			,COD_UNI_FRE_PAGO_INT          			
			,FRE_REV_INT                   			
			,COD_UNI_FRE_REV_INT           			
			,PLZ_CONTRACTUAL               			
			,PLZ_AMRT                      			
			,COD_UNI_PLZ_AMRT              			
			,PLZ_PER_PEND                  			
			,PLZ_MED_VEN                   			
			,COD_UNI_PLZ_MED_VEN           			
			,PER_LAG                       			
			,COD_UNI_PER_LAG               			
			,NUM_REPRECIOS                 			
			,IMP_INI_MO                    			
			,IMP_CUO_MO                    			
			,IMP_CUO_INI_MO                			
			,NUM_CUO_PAC                   			
			,NUM_CUO_PEND                  			
			,IMP_AMRT_PRI_ML               			
			,IMP_AMRT_PRI_MO               			
			,IMP_LIM_CRE_TOT               			
			,IMP_LIM_CREDITO_ML            			
			,IMP_LIM_CREDITO_MO            			
			,IMP_LIM_MED_MES_ML            			
			,IMP_LIM_MED_MES_MO            			
			,NUM_DIA_DEMORA                			
			,IMP_MORA1_ML                  			
			,IMP_MORA2_ML                  			
			,IMP_MORA3_ML                  			
			,IMP_MORA4_ML                  			
			,IMP_MORA5_ML                  			
			,IMP_PAGO_ML                   			
			,IMP_PAGO_MO                   			
			,IMP_SAL_CAS_ML                			
			,IMP_SAL_CAS_MO                			
			,IMP_SDO_FALL_ML               			
			,IMP_SDO_FALL_MO               			
			,IMP_SDO_VEN_ML                			
			,IMP_SDO_VEN_MO                			
			,IND_CAN_ANT                   			
			,SDO_CAN_ANT_ML                			
			,SDO_CAN_ANT_MO                			
			,IND_FUERA_BLCE                			
			,IND_REFINANCIACION            			
			,IND_TITULIZADO                			
			,IND_CAMB_COND                 			
			,IND_LIM_CANCELABLE            			
			,IND_CTO_CASADO                			
			,COD_PRO_CTO_CASADO            			
			,COD_SUBPRODU_CTO_CASADO       			
			,IDF_CTO_PAS_CASADO            			
			,IND_CTO_INCENTIVADO           			
			,IND_CTO_RENOVADO              			
			,IND_CTO_SING_TESORERIA        			
			,IND_CTO_SUBVEN                			
			,IDF_CTO_DERIVADO              			
			,TIP_ORIGEN_FONDO_ACT          			
			,COD_FONDO_AJENO_ACT           			
			,IND_INT_ML                    			
			,INT_DIFER_ML                  			
			,INT_DIFER_MO                  			
			,INT_MED_DIFER_ML              			
			,INT_MED_DIFER_MO              			
			,INT_COB_PAG_ML                			
			,INT_COB_PAG_MO                			
			,INT_EXC_ML                    			
			,INT_EXC_MO                    			
			,NUM_EFECTOS                   			
			,NUM_DISP                      			
			,SDO_PRECIO_ML                 			
			,SDO_PRECIO_MO                 			
			,SDO_EXC_LIM_ML                			
			,SDO_EXC_LIM_MO                			
			,SDO_MED_EXC_LIM_ML            			
			,SDO_MED_EXC_LIM_MO            			
			,SDO_DISP_ML                   			
			,SDO_DISP_MO                   			
			,SDO_MED_NDISP_LC_ML           			
			,SDO_MED_NDISP_LC_MO           			
			,SDO_NDISP_LC_ML               			
			,SDO_NDISP_LC_MO               			
			,POR_COM_NO_DISP               			
			,POR_MED_DISP_MES              			
			,SDO_MED_ANT_REP_MO            			
			,SDO_MED_PEND_AMRT_MO          			
			,SDO_ULT_REV_MO                			
			,IND_TAS_PREDEF                			
			,TAS_PREDEF                    			
			,TAS_SPR_PREDEF                			
			,COD_RESPONS_TAS_PREDEF        			
			,VAL_IND_REAJUSTE_INI          			
			,VAL_IND_REAJUSTE              			
			,FEC_REESTRUC                  			
			,FEC_REFINAN                   			
			,FEC_NOVACION                  			
			,IND_AVAL_EJECUTADO            			
			,IND_DEUDA_PUBLICA             			
			,IND_DEUDA_SUBORDINADA         			
			,TIP_IDF_EMISION               			
			,COD_IDF_EMISION               			
			,COD_SIT_CONTABLE              			
			,TAS_TAE                       			
			,IND_INVERSION                 			
			,COD_SIS_ORIGEN                			
			,COD_PROCESO                   			
			,USERID_UMO                    			
			,TIMEST_UMO                    			
			,COD_SIT_GESTION               			
			,COD_SIT_EXPEDIENTE            			
			,COD_FINALIDAD                 			
			,COD_DESTINO_FONDOS            			
			,FEC_CAMB_COND                 			
			,COD_CARTERA_GEST              			
			,COD_COMPLEMENTO               			
			,ROWID_FILA                    			
			,POR_UTIL_IND                  			
			,POR_CUPON                     			
			,TAS_COM                       			
			,COD_CTO_RENOVADO              			
			,COD_CANAL                     			
			,FRE_CARENCIA                  			
			,COD_UNI_FRE_CARENCIA          			
			,COD_ORI_OPE                   			
			,FEC_CAN_CTO                   			
			,FRE_PAGO_CAP                  			
			,COD_UNI_FRE_PAGO_CAP          			
			,IND_EXCEPCIONADO              			
			,PLZ_CARENCIA                  			
			,COD_SIT_IRR_CTO               			
			,FEC_CARENCIA_CAP              			
			,IND_BOOKEO                    			
			,IMP_INI_ML                    			
			,IMP_AVAL_CTO                  			
			,IND_DANO_CREDITICIO           			
			,IND_EST_RIESGO_CRE            			
			,FEC_CARENCIA_INT              			
			,COD_PLAN_GEST_CRE             			
			,COD_FIDEICOMISO               			
			,COD_CARTERA_CRE               			
			,COD_CANAL_CONTR               			
			,COD_ENTIDAD_ORI               			
			,COD_CENTRO_CART               			
			,COD_TIENDA                    			
			,COD_BLQ                       			
			,IND_COBZA_JUDICIAL            			
			,IMP_COM_PERIOD                			
			,IMP_INT_PERIOD_RESULT         			
			,IMP_INT_PERIOD_FUERA_BLCE     			
			,TIPO_COLOCACION               			
			,COD_TIPO_MOVIMIENTO           			
			,IDF_SUBCTO_ODS                			
			,IND_CTO_SUBRROGACION          			
			,COD_TIP_FRE_TAS_REF           			
			,COD_NAT_ACT_SUBY              			
			,COD_CUENTA_ASC                			
			,COD_ENT_CUENTA_ASC            			
			,NUM_PLZ_TAS_REF               			
			,NUM_PER_REV                   			
			,NUM_AMT                       			
			,NUM_LIQ                       			
			,POR_DIF                       			
			,POR_TAS_REF                   			
			,POR_INT_DEMORA                			
			,IMP_COM_NO_PERIOD             			
			,IMP_INT_NO_PERIOD             			
			,COD_CLAS_RIESGO               			
			,COD_CLAS_RIESGO_MAT           			
			,COD_CICLO_PROV                			
			,COD_ENT_ORIGEN                			
			,IND_RIESGO_SUB                			
			,POR_PON_CTO                   			
			,NUM_PER_AMT_REP_INC           			
			,IMP_PRE_VIVIENDA              			
			,COD_SUCURSAL_CTA_ASOCIADA     			
			,COD_EST_REF                   			
			,COD_PRELACION_DEU_PUB         			
			,COD_UNI_FRE_TAS_REF           			
			,FEC_BAJA                      			
			,NUM_FRE_TAS_REF               			
			,COD_NATURALEZA_CTO            			
			,IND_MOD_PROP_ESTI_RIESGO_CRED 			
			,FEC_PRIM_SIT_IRRE_PRIMER_CICLO			
			,FEC_PRIM_SIT_IRRE_CICLO_ACTUAL			
			,FEC_ULT_SIT_IRRE_CICLO_ACTUAL 			
			,FEC_RIESGO_SUBESTANDAR        			
			,IMP_LIM_NO_COMPROMETIDO_CTO   			
			,IMP_CTES_TRANSACCION          			
			,IMP_PRIMAS_DCTO_ADQUISICION   			
			,IMP_VALOR_RESI_LEASING        			
			,IMP_PERI_GARAN_FINANCIERAS    			
			,COD_SIT_AMORTIZACION          			
			,COD_TIP_FRE_LIQ               			
			,NUM_PLZ_LIQ                   			
			,COD_RIES_SUBESTANDAR          			
			,COD_INTRAGRUPO                			
			,PROV_ESPEC_MATRIZ             			
			,DIST_VENC_MED_PONDERADO       			
			,LIM_LINEA_PARALELA            			
			,LIM_LINEA_EXPRESS             			
			,LIM_LINEA_CUOTAS              			
			,COD_PROGDESCTO                			
			,TIP_DIAS                      			
			,TIP_COBRO                     			
			,FEC_PERI_GRACIA_MORATORIOS    			
			,IND_PAPERLESS                 			
			,IND_PREEMBOZADOS              			
			,COD_BLOQUEO_MAYOR_PRIORIDAD   			
			,FEC_BLOQUEO                   			
			,IND_DISP_LINEA_PARALELA       			
			,FEC_ASIG_LINEA                			
			,FEC_DISP_LINEA_EXPRESS        			
			,COD_TIP_IMP                   			
			,IDF_PERS_ODS_BENEF            			
			,IND_LIM_CANC_ENTIDAD          			
			,IND_INTERNEG                  			
			,COD_MOT_CANCE_CTO             			
			,IMP_PRIM_SIT_IRRE_CICLO_ACT   			
			,IMP_PRIM_SIT_IRRE_CICLO       			
			,IND_EXC_CAL_IRB               			
			,COD_MOT_ALTA_EXPOS            			
			,FEC_INI_CARE_CAPITAL          			
			,FEC_INI_CARE_INT              			
			,IND_SUBROGACION               			
			,IDF_CTA_CORRENTE              			
			,TIP_ORIGEN_FON_BACEN          			
			,IND_BLQ_TAR                   			
			,IND_SIT_TAR                   			
			,BLOQUE_ACT                    			
			,EST_CRED                      			
			,MORA_ESPANA                   			
			,REESTRUCTURADO                			
			,TAS_INT AS TAS_INT_ORIGEN                 			--FMO 20201111
			,IMP_PRIM_IMPAGO_NO_REGU       			
			,IND_AMORT_ANTI                			
			,NUM_PLAZO_CARE_INTE           			
			,COD_EMISION                   			
			,COD_TIP_IDF_EMISION           			
			,SPRD_TRANSFE                  			
			,TAS_CAM_REAL                  			
			,COD_SIT_CTO                   			
			,TT_IN_CAM_PROM                			
			,COD_PROD_SBIF                 			
			,USER_TABLA                    			
			,IND_OPERACION                 			
			,CON_GRADO_REE                 			
			,IMP_DEUD_VENC_NOREP           			
			,IMP_SUBSD_FNG                 			
			,ID_OPER_ENT                   			
			,TIP_RIES_ENT_MO               			
			,TIP_RIES_ENT_ML               			
			,IMP_CUO_ML                    			
			,PORC_REAJUST                  			
			,COD_CREDI_CIFIN               			
			,TIP_EXT_DEUD                  			
			,NUM_COU_MOR                   			
			,NUM_CAMB                      			
			,IMP_BASE_IMPUESTO_MO          			
			,TIP_SOBR                      			
			,FEC_OTORG_OP                  			
			,FEC_COMP_DES                  			
			,PORC_FIN_VIV                  			
			,PORC_DEFAULT                  			
			,COD_SWIFT                     			
			,IMP_PAG_FEC                   			
			,TAR_ICA                       			
			,NUM_REST                      			
			,NUM_RNEGC                     			
			,TIP_FACT_REEST                			
			,IND_CUO_ANTICIPADAS           			
			,IMP_CUO_FUERA_BLCE            			
			,COD_OFI_DEV                   			
			,COD_OFI_RETROCESION           			
			,DES_COD_CONVENIO_ASC_CTO      			
			,COD_EST_EMBARGO               			
			,FEC_ULT_PROVISION             			
			,FEC_FIN_CUSTODIA              			
			,FEC_INI_CUSTODIA              			
			,FEC_PRX_PROPAGANDA            			
			,FEC_PRX_ENVIO_CUPONERA        			
			,FEC_ULT_ENVIO_CUPONERA        			
			,IMP_RECUP_RECIBO_ML           			
			,IND_CAMB_PERIODIF             			
			,IND_REDUCCION_CUO_PREP        			
			,IND_RETROCESION               			
			,NUM_MIN_FIADORES              			
			,IMP_CAP_ACELERADO             			
			,IMP_SOL_ML                    			
			,FREQ_LIQ_INT_CAR              			
			,COD_TRAT_SEGURO_CAR           			
			,COD_INT_CARENCIA              			
			,NUM_DIA_PAGO                  			
			,FEC_CASTIGO                   			
			,FEC_EMI_RECIBO                			
			,FEC_PAGO_ORIG                 			
			,FEC_PRIM_FACTURACION          			
			,FEC_PRX_COM_IMPG              			
			,FEC_PRX_SEG_CAR               			
			,FEC_PRX_EXTRACTO              			
			,FEC_VENTA                     			
			,FEC_LIM_PLZ_ADICIONALES       			
			,FEC_ULT_FACTURACION           			
			,FEC_ULT_CALC_MORA             			
			,COD_PAGO_OBLIGACION           			
			,IMP_ACREEDOR                  			
			,IMP_OPC_COMPRA                			
			,IMP_FACTURADO_ML              			
			,IMP_MAX_DISPOSIC_ML           			
			,IMP_MIN_LIQUIDACION           			
			,IMP_MIN_DISPOSIC_ML           			
			,IND_TIP_AJUSTE_CUO            			
			,IND_COMUN_IMPAGADOS           			
			,IND_ACELERADO                 			
			,IND_AJUS_HABIL                			
			,IND_AJUS_CUO_CAREN            			
			,FEC_MORATORIOS                			
			,IND_CUO_CASTIGADA             			
			,IND_TIP_CUO_EXTRA             			
			,COD_FRE_EXTRACTO              			
			,UNI_FRE_EXTRACTO              			
			,IND_PRORROGA_CUOTA            			
			,IND_CAMB_TAS_INT              			
			,IND_RECALCULO_CUO             			
			,MESES_CUO_EXTRAORDINARIA      			
			,IND_NUEVO_ESTADO_CTA          			
			,NUM_TRAMO                     			
			,PLZ_MIN_CANCELACION           			
			,POR_REFINAN_CUO               			
			,POR_MAX_CAPITALIZACION        			
			,PRM_MES_DOS_CUO               			
			,SDO_PRORROGA_CUO              			
			,IMP_TOT_HIPOT_VIS             			
			,COD_ENTIDAD_CONVENIO          			
			,COD_UNI_FRE_DEB_AUTOM         			
			,UNI_FRE_DEB_AUTOM             			
			,IND_TIP_LIQ                   			
			,COD_CONVENIO_ASC_CTO          			
			,COD_SUBVENCION_ORIG           			
			,IND_CONDIC_ADMINISTRAT        			
			,COD_SUBVENCION                			
			,COD_TIP_REVISION              			
			,COD_ENTI_SUBVEN_ORI           			
			,IND_ESTADO_REVISION           			
			,FEC_APROB_PROP                			
			,FEC_VEN_SUBVENCION            			
			,FEC_AVI_PRX_REVI              			
			,FEC_SIT_CTO                   			
			,TIP_CALENDARIO                			
			,IND_AJUSTE_VEN_INHABILES      			
			,IND_AJUSTE_REV_INHABILES      			
			,IND_ACTU_PROV                 			
			,IND_AVISO_VTO                 			
			,IND_CAP_AUTOMATICA            			
			,IND_CARTERA_VENDIDA           			
			,IND_PAGARE                    			
			,IND_ESTADO_RECIBO             			
			,IND_FINANCIACION_IVA          			
			,IND_CTO_GARANTIA              			
			,IND_INT_COB_ACELERACION       			
			,IND_MORA_CONDONADA            			
			,IND_NO_FACTURA_CARENCIA       			
			,IND_OPE_PAGARE                			
			,IND_NO_PAGO                   			
			,IND_SEGURO                    			
			,IND_CUADRO_MANUAL             			
			,IND_CTA_MANCOMUNADA           			
			,DES_MOT_CUPO                  			
			,NOM_PORTAFOLIO                			
			,FEC_PRIM_AMRT                 			
			,NUM_IMPAGOS                   			
			,NUM_AUTORIZACION_RENOV        			
			,NUM_CUO_EXTR                  			
			,NUM_CUO_VENC                  			
			,NUM_CUO_PRORROGA              			
			,NUM_RECIBOS_EMITIDOS          			
			,NUM_RENOVACIONES              			
			,NUM_DIAS_MAX_RENOVACION       			
			,NUM_MAX_RENOVACIONES          			
			,NUM_SECUENCIA_EXC             			
			,COD_UNI_FRE_DIF_INT           			
			,UNI_FRE_DIF_INT               			
			,FRE_UNI_RENOV                 			
			,COD_UNI_FRE_RENOV             			
			,PORC_INT_SUBVEN               			
			,IMP_RETENIDO_AFC              			
			,IMP_SDO_INSOLUTO              			
			,IMP_SDO_REAJUSTABLE           			
			,SEG_MES_DOS_CUO               			
			,IND_ESTADO_TARIFA             			
			,COD_OFI_FIN_CUSTODIA          			
			,COD_TIP_CUO_EXTRAORDINARIA    			
			,COD_TIP_REDONDEO              			
			,COD_TIP_REDUCCION             			
			,ACC_SUSP_CARENCIA             			
			,NUM_SEC_TITULARIZACION        			
			,IMP_INI_ANTIC_ML              			
			,FEC_ACELERACION               			
			,FEC_DESACELERACION            			
			,FEC_INI_VALIDEZ               			
			,IND_CONCEPTO_NEG              			
			,COD_REDONDEO_TARIFA           			
			,IND_LIM_NEGOCIABLE            			
			,IND_INT_PREPAGO               			
			,COD_FRE_REV_TAS               			
			,PLZ_MAX_TARIFA                			
			,SDO_FIN_VAL_INT               			
			,SDO_INI_VAL_INT               			
			,COD_PLAN_COMISION             			
			,FEC_FIN_VALIDEZ               			
			,POR_DESC_COM                  			
			,IND_MOV_AMRT                  			
			,IND_CONDONA_INT_PRIMER_MES    			
			,VAL_TAS_REF_MORA              			
			,COD_FORMA_PAGO                			
			,IND_TARJETA                   			
			,IND_PAGO_TOTAL                			
			,COD_BLOQ_TIP_TRANS            			
			,NUM_CUO_REVOLVENTES           			
			,COD_INTERNO_TARJETA           			
			,COD_MARCA_TARJETA             			
			,COD_BLOQUEO                   			
			,FEC_CORTE_MAX                 			
			,FEC_ESTAMPACION               			
			,FEC_ACT_TARJETA               			
			,FEC_ENTREGA_TARJETA           			
			,NUM_DIAS_INT_CORR             			
			,PORC_EXON_CUOTA_MENEJO        			
			,COD_TIP_CTO_TARJETA           			
			,NUM_TARJETA_ADICIONALES       			
			,NUM_TARJETA_RENOV             			
			,IND_CHIP                      			
			,IND_TIPO_CTA_TARJETA          			
			,IMP_MIN_DIFERIR               			
			,COD_BLOQUEO_REES              			
			,COD_BLOQUEO_SDO               			
			,COD_BLOQUEO_EXCE              			
			,FEC_BLOQUEO_SALDO             			
			,FEC_BLOQUEO_SOBRECUPO         			
			,FEC_ULT_USO                   			
			,FEC_INI_COBR_INT_CORR         			
			,FEC_PROCESO_DIAN              			
			,IMP_PAGO_MIN_ESP_ML           			
			,IND_COBRO_IMP                 			
			,IND_FIN_INTERES_CORRIENTE     			
			,TAS_INT_MORA                  			
			,NUM_CHQ                       			
			,COD_PREEXPED_CHQ              			
			,FEC_COBRO                     			
			,FEC_INI_GIROS                 			
			,NUM_MOV_EXTRACTO              			
			,NUM_ORDEN_NOPAGO              			
			,NUM_VCS_CHQ_MORA              			
			,TIPO_TALONARIO                			
			,NUM_CHQ_FISICOS_TALONARIO     			
			,COD_BLQ_TALONARIO             			
			,COD_BLQ_CUPO                  			
			,FEC_CAP_INT                   			
			,FEC_RENOV                     			
			,IMP_MIN_TRANS_LCA             			
			,IND_CUPON_FICTICIO            			
			,IND_CAP_INT_RENOVADO          			
			,IND_CTO_DOS_DIVISAS           			
			,IND_LIQ_COMISIONES            			
			,IND_COONDICION_ESP_CTO        			
			,IND_CTA_ESPERA                			
			,IND_LIBRETA_PERDIDA           			
			,COD_MOT_APERTURA              			
			,COD_MOT_LIBRETA               			
			,NUM_LIBRETA                   			
			,NUM_PRX_PAG_LIBRETA           			
			,NUM_PRIMER_CHQ_TALONARIO		
			,SDO_MIN_CTO                   			
			,STOCK_TAL_CTA                 			
			,ULT_NUM_CHQ_ASIG              			
			,VAL_SWAP                      			
			,IND_BENEFICIO                 			
			,DES_PLAN_PAQUETE              			
			,FEC_CIERRE_PLAN               			
			,FEC_FIN_DIF_INT               			
			,FEC_VENTA_PLAN                			
			,COD_ID_PLAN                   			
			,INC_BON_EXC                   			
			,INC_INT_NO_AUT                			
			,IND_CTA_INMOVILIZADA          			
			,INT_ABN_RENOV                 			
			,IND_EMBARGO                   			
			,IND_COBRANZA_EXTERNA          			
			,COD_REF_CUOTA                 			
			,IND_RECHAZO_CONFIRMING        			
			,POR_COB_CONFIRMING            			
			,COD_EVENTO_PAQUETE            			
			,COD_PAQUETE                   			
			,IND_FACT_CAP                  			
			,NOM_AREA_REC                  			
			,COD_GESTOR_RECU               			
			,DES_COD_BLOQUEO               			
			,DES_CAMARA                    			
			,FEC_DESEMB                    			
			,COD_PORTAFOLIO                			
			,NOM_COMITE_APROB              			
			,IMP_ULT_CUOTA_CAP             			
			,IMP_DESEMBOLSO                			
			,IMP_OTRO_CUPO                 			
			,COD_ESTADO_TALONARIO          			
			,COD_CONC_NOVEDAD              			
			,COD_AUT_REGULADOR             			
			,IND_CAMB_NUM_OPER             			
			,IND_DILIGEN_OBSERV            			
			,VAL_INI_COMPRA_VENTA          			
			,COD_CONDICION_CTO             			
			,COD_OPR_REGULADOR             			
			,COND_EJERCICIO                			
			,FEC_CAMB_ESTADO               			
			,IND_NAC_TARJETA               			
			,IND_SUBS_CC                   			
			,MOD_ENTREGA_CARTCRED          			
			,NUM_TAR_ASOC                  			
			,FEC_INI_CUPON                 			
			,FEC_EMISION                   			
			,FEC_FIN_CUPON                 			
			,DES_PORTAFOLIO                			
			,COD_NEMOTECNICO               			
			,COD_TRADER                    			
			,VAL_PREC_LIMP                 			
			,IMP_NOMINAL                   			
			,IMP_AVR                       			
			,COD_AVR_DIVISA                			
			,COD_CARTERA_FINANCI           			
			,COD_SUBCARTERA_NORMATIVA      			
			,IND_TIP_DEVENGO               			
			,COD_TIP_OPERACION             			
			,COTIZ_DIVISA_ML               			
			,COD_TIP_LIQUIDACION_CL        			
			,IMP_FIN_ML                    			
			,IMP_FIN_MO                    			
			,IMP_TRX_USD                   			
			,VALOR_SPOT_GAMA               			
			,IMP_DELTA                     			
			,VALOR_GAMMA                   			
			,VALOR_VEGA                    			
			,VALOR_THETA                   			
			,IND_TIP_CONFIGURACION         			
			,FEC_FIJACION                  			
			,SEC_FIJACION                  			
			,COD_TIP_CAMBIO_FIJACION       			
			,VAL_VOLATIDAD                 			
			,TIP_WEIGHT                    			
			,IMP_MONTO_CONTRAVALOR         			
			,COD_LIQ_DIVISA                			
			,COD_TIP_LIBRO                 			
			,TIP_OPERA_SENSE               			
			,COD_TIP_OPCION                			
			,COD_CURV_DESC                 			
			,COD_CURV_PROY                 			
			,IND_EMPR_PAR_FISC             			
			,COD_MODAL                     			
			,TIP_TAS_FWD                   			
			,TIP_TAS_SPOT                  			
			,FEC_INVEN                     			
			,VAL_TRM                       			
			,COD_TIP_PATA                  			
			,COD_CURV_REF_DESC             			
			,COD_TIP_INV_NEGOCIACION       			
			,COD_DIVISA_FIJACION           			
			,NUM_COMPONENTE                			
			,VAL_TIR                       			
			,FACTOR_RIESGO_SUBYA           			
			,DIVISA_SUBYACENTE             			
			,VAR_PYG                       			
			,VPN                           			
			,VAL_RIESGO                    			
			,VAL_VTO                       			
			,VAL_ACUM                      			
			,VAL_COSTO                     			
			,PYG_TIR                       			
			,VAL_VALORACION                			
			,COTI_DIVISA                   			
			,REFERENCIA                    			
			,IMP_TASA_SUCIA                			
			,TAS_CAMBIO                    			
			,IDF_EMISOR                    			
			,NUM_DOC                       			
			,NUM_OPE_ANT                   			
			,COD_MOD_LIQ
	FROM 
				#TMP_DETALLE_OPERACIONES_1	AS T1	WITH(NOLOCK)
	INNER JOIN  #TMP_DETALLE_OPERACIONES_2	AS T2	WITH(NOLOCK)
				ON			T1.ID_REG = T2.ID_REG
	INNER JOIN  #TMP_DETALLE_OPERACIONES_3	AS T3	WITH(NOLOCK)
				ON			T2.ID_REG = T3.ID_REG
	INNER JOIN  #TMP_DETALLE_OPERACIONES_4	AS T4	WITH(NOLOCK)
				ON			T3.ID_REG = T4.ID_REG
	INNER JOIN  #TMP_DETALLE_OPERACIONES_5	AS T5	WITH(NOLOCK)
				ON			T4.ID_REG = T5.ID_REG	

--	where IDF_CTO_ODS like '%210306%'
		

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



DROP TABLE #TMP_DETALLE
DROP TABLE #TMP_DETALLE_OPERACIONES_1
DROP TABLE #TMP_DETALLE_OPERACIONES_2
DROP TABLE #TMP_DETALLE_OPERACIONES_3
DROP TABLE #TMP_DETALLE_OPERACIONES_4
DROP TABLE #TMP_DETALLE_OPERACIONES_5



-- REGEXP PARA REMPLAZO DE FECHAS..
-- (^,FEC_\w*(\x20|\t)*=\t*)(REPLICATE\('0',8\))
-- $1'19000101' --REPLICATE\('0',8\)

END
GO
