USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_INT_RENTABILIDAD_TRADERS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_INT_RENTABILIDAD_TRADERS
CREATE PROCEDURE [dbo].[SP_INT_RENTABILIDAD_TRADERS]
(
	@OPCION INT			= NULL	
)
AS
BEGIN
SET NOCOUNT ON

/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ DE TRADERS
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 10-03-2017
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ TRADERS
--MODIFICACION	: 02-04-2019	Quitar caracteres extranños como Ñ
--MODIFICACION	: 04-04-2019	Quitar caracteres extranños como Ñ
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



/*******************************************************
		EXTRACCION DE DATOS 
********************************************************/

SELECT 

 /*01*/ COD_GESTOR					= RIGHT(SPACE(8)+LTRIM(RTRIM(dbo.FX_RNT_COD_GESTOR(UPPER(U.USUARIO)))),8)	--VARCHAR(8)
,/*02*/ COD_PAIS					= '00'																		--NUMERIC(2) --NUMBER(2)
,/*03*/ COD_ENTIDAD					= '1769'																	--VARCHAR(4)
,/*04*/ COD_OFICIAL					= SPACE(4)																	--CHAR(4)
,/*05*/ COD_TIP_OFICIAL				= 'TRD'																		--CHAR(3)
,/*06*/ DES_GESTOR					= replace(RIGHT(SPACE(50)+LTRIM(RTRIM(UPPER(U.USUARIO))),50),'Ñ','N')						--VARCHAR(50)
,/*07*/ NOM_CARGO_GESTOR			= (CASE
											WHEN T.DESCRIPCION is null THEN SPACE(50)
											ELSE RIGHT(SPACE(50)+LTRIM(RTRIM(UPPER(T.DESCRIPCION))),50)
										END)																	--VARCHAR(50)							
,/*08*/ COD_OFI_GESTORA				= '0001'																	--CHAR(4)		--> (SELECT CODIGO_SUCURSAL,* FROM BACPARAMSUDA.dbo.SUCURSAL)  
,/*09*/ FEC_ALTA					= REPLICATE('0',8)															--NUMERIC(8)
,/*10*/ FEC_BAJA					= REPLICATE('0',8)															--NUMERIC(8)
,/*11*/ COD_PROCESO					= SPACE(20)																	--VARCHAR(20)
,/*12*/ USERID_UMO					= SPACE(10)																	--VARCHAR(10)
,/*13*/ TIMEST_UMO					= REPLICATE('0',8)															--DATETIME --DATE(8)
,/*14*/ NOM_PERSONA_GESTOR			= REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(RIGHT(SPACE(80) + LTRIM(RTRIM(UPPER(U.NOMBRE))),80),'Ñ','N'),'Á','A'),'É','E'),'Í','I'),'Ó','O'),'Ú','U')	--VARCHAR(80)
,/*15*/ IDF_PERS_ODS				= SPACE(25)																	--VARCHAR(25)
,/*16*/ TIP_BANCA					= SPACE(3)																	--CHAR(3)
,/*17*/ COD_REGION					= SPACE(8)																	--VARCHAR(8)
,/*18*/ COD_ZONA					= SPACE(2)																	--CHAR(2)
,/*19*/ COD_CENTRO_COSTO			= SPACE(4)																	--CHAR(4)
,/*20*/ COD_PUESTO					= SPACE(4)																	--CHAR(4)
,/*21*/ COD_NIV_RESPONSABILIDAD		= SPACE(2)																	--CHAR(2)
,/*22*/ COD_EST_ACTUAL				= SPACE(1)																	--CHAR(1)
,/*23*/ COD_EST_ANTERIOR			= SPACE(2)																	--CHAR(2)
,/*24*/ FEC_ESTADO					= REPLICATE('0',8)															--NUMERIC(8)
,/*25*/ COD_RANGO					= SPACE(3)																	--CHAR(3)
,/*26*/ COD_SEG_OFICIAL				= SPACE(3)																	--CHAR(3)
,/*27*/ OBS_ADICIONAL				= SPACE(240)																--VARCHAR(240)
,/*28*/ ROWID_FILA					= SPACE(64)																	--VARCHAR(64)
,/*29*/ COD_CLI_SEGMENTO			= SPACE(8)																	--VARCHAR(8)
,/*30*/ FEC_DATA					= REPLICATE('0',8)															--NUMERIC(8,0)
,/*31*/ COD_CAT_GESTOR				= SPACE(8)																	--VARCHAR(8)
,/*32*/ NUM_EMP_GESTOR				= REPLICATE('0',5)															--NUMERIC(5) --NUMBER(5)
,/*33*/ DESC_EMAIL_GEST				= SPACE(200)																--VARCHAR(200)
,/*34*/ FEC_COMPENSATORIOS			= REPLICATE('0',8)															--DATETIME --DATE(8)
,/*35*/ COD_PUESTO_SUBORD			= SPACE(20)																	--VARCHAR(20)
INTO #TMP_TRADERS
FROM 
	BACPARAMSUDA.dbo.USUARIO AS U WITH(NOLOCK)
LEFT JOIN BACPARAMSUDA.dbo.GEN_TIPOS_USUARIO AS T WITH(NOLOCK)
ON UPPER(LTRIM(RTRIM(U.tipo_usuario))) = UPPER(LTRIM(RTRIM(T.Tipo_Usuario)))

INSERT #TMP_TRADERS
SELECT 
 /*01*/ COD_GESTOR					= 'NO ASIGN'	--VARCHAR(8)
,/*02*/ COD_PAIS					= '00'																		--NUMERIC(2) --NUMBER(2)
,/*03*/ COD_ENTIDAD					= '1769'																	--VARCHAR(4)
,/*04*/ COD_OFICIAL					= SPACE(4)																	--CHAR(4)
,/*05*/ COD_TIP_OFICIAL				= 'TRD'																		--CHAR(3)
--                                     12345678901234567890123456789012345678901234567890
,/*06*/ DES_GESTOR					= 'NO ASIGNADO A NINGUN USUARIO                      '						--VARCHAR(50)
,/*07*/ NOM_CARGO_GESTOR			= 'NO ASIGNADO A NINGUN USUARIO                      '						--VARCHAR(50)
,/*08*/ COD_OFI_GESTORA				= '0001'																	--CHAR(4)		--> (SELECT CODIGO_SUCURSAL,* FROM BACPARAMSUDA.dbo.SUCURSAL)  
,/*09*/ FEC_ALTA					= REPLICATE('0',8)															--NUMERIC(8)
,/*10*/ FEC_BAJA					= REPLICATE('0',8)															--NUMERIC(8)
,/*11*/ COD_PROCESO					= SPACE(20)																	--VARCHAR(20)
,/*12*/ USERID_UMO					= SPACE(10)																	--VARCHAR(10)
,/*13*/ TIMEST_UMO					= REPLICATE('0',8)															--DATETIME --DATE(8)
--                                     12345678901234567890123456789012345678901234567890123456789012345678901234567890
,/*14*/ NOM_PERSONA_GESTOR			= 'NO ASIGNADO A NINGUN USUARIO                                                    '	--VARCHAR(80)
,/*15*/ IDF_PERS_ODS				= SPACE(25)																	--VARCHAR(25)
,/*16*/ TIP_BANCA					= SPACE(3)																	--CHAR(3)
,/*17*/ COD_REGION					= SPACE(8)																	--VARCHAR(8)
,/*18*/ COD_ZONA					= SPACE(2)																	--CHAR(2)
,/*19*/ COD_CENTRO_COSTO			= SPACE(4)																	--CHAR(4)
,/*20*/ COD_PUESTO					= SPACE(4)																	--CHAR(4)
,/*21*/ COD_NIV_RESPONSABILIDAD		= SPACE(2)																	--CHAR(2)
,/*22*/ COD_EST_ACTUAL				= SPACE(1)																	--CHAR(1)
,/*23*/ COD_EST_ANTERIOR			= SPACE(2)																	--CHAR(2)
,/*24*/ FEC_ESTADO					= REPLICATE('0',8)															--NUMERIC(8)
,/*25*/ COD_RANGO					= SPACE(3)																	--CHAR(3)
,/*26*/ COD_SEG_OFICIAL				= SPACE(3)																	--CHAR(3)
,/*27*/ OBS_ADICIONAL				= SPACE(240)																--VARCHAR(240)
,/*28*/ ROWID_FILA					= SPACE(64)																	--VARCHAR(64)
,/*29*/ COD_CLI_SEGMENTO			= SPACE(8)																	--VARCHAR(8)
,/*30*/ FEC_DATA					= REPLICATE('0',8)															--NUMERIC(8,0)
,/*31*/ COD_CAT_GESTOR				= SPACE(8)																	--VARCHAR(8)
,/*32*/ NUM_EMP_GESTOR				= REPLICATE('0',5)															--NUMERIC(5) --NUMBER(5)
,/*33*/ DESC_EMAIL_GEST				= SPACE(200)																--VARCHAR(200)
,/*34*/ FEC_COMPENSATORIOS			= REPLICATE('0',8)															--DATETIME --DATE(8)
,/*35*/ COD_PUESTO_SUBORD			= SPACE(20)																	--VARCHAR(20)

/*******************************************************
		DESPLIEGUE DE RESULTADOS
********************************************************/
IF ISNULL(@OPCION,-1)=-1 
BEGIN
		/* DESPLIEGA RESULTADOS PARA LA GENERACION AUTOMATICA DE LA INTERFACE */
		SELECT
			DATA =  
			 COD_GESTOR				
			+COD_PAIS					
			+COD_ENTIDAD				
			+COD_OFICIAL				
			+COD_TIP_OFICIAL			
			+DES_GESTOR				
			+NOM_CARGO_GESTOR			
			+COD_OFI_GESTORA			
			+FEC_ALTA					
			+FEC_BAJA					
			+COD_PROCESO				
			+USERID_UMO				
			+TIMEST_UMO				
			+NOM_PERSONA_GESTOR		
			+IDF_PERS_ODS				
			+TIP_BANCA				
			+COD_REGION				
			+COD_ZONA					
			+COD_CENTRO_COSTO			
			+COD_PUESTO				
			+COD_NIV_RESPONSABILIDAD	
			+COD_EST_ACTUAL			
			+COD_EST_ANTERIOR			
			+FEC_ESTADO				
			+COD_RANGO				
			+COD_SEG_OFICIAL			
			+OBS_ADICIONAL			
			+ROWID_FILA				
			+COD_CLI_SEGMENTO			
			+FEC_DATA					
			+COD_CAT_GESTOR			
			+NUM_EMP_GESTOR			
			+DESC_EMAIL_GEST			
			+FEC_COMPENSATORIOS		
			+COD_PUESTO_SUBORD		
		FROM #TMP_TRADERS

		SET @TOTAL_REGISTROS = RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR,@@ROWCOUNT),8)
		SET @FECHA_TERMINO	 = CONVERT(VARCHAR(10),GETDATE(),105)
		SET @HORA_TERMINO = CONVERT(VARCHAR(8),GETDATE(),108) 

		SELECT HEADER = @FECHA_PROCESO+@FECHA_CONTABLE+@FECHA_INICIO+@HORA_INICIO+@FECHA_TERMINO+@HORA_TERMINO+@TOTAL_REGISTROS
	END 
ELSE
	BEGIN
		/* DESPLIEGA RESULTADOS PARA REVISION */
		SELECT * FROM #TMP_TRADERS
		
		SET @TOTAL_REGISTROS = RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR,@@ROWCOUNT),8)
		SET @FECHA_TERMINO	 = CONVERT(VARCHAR(10),GETDATE(),105)
		SET @HORA_TERMINO = CONVERT(VARCHAR(8),GETDATE(),108) 
		
		SELECT 
			@FECHA_PROCESO		AS FECHA_PROCESO
			,@FECHA_CONTABLE	AS FECHA_CONTABLE
			,@FECHA_INICIO		AS FECHA_INICIO
			,@HORA_INICIO		AS HORA_INICIO
			,@FECHA_TERMINO	AS FECHA_TERMINO
			,@HORA_TERMINO		AS HORA_TERMINO
			,@TOTAL_REGISTROS	AS TOTAL_REGISTROS
	END

DROP TABLE #TMP_TRADERS

END
GO
