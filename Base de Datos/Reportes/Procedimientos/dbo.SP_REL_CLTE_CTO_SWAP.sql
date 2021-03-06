USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REL_CLTE_CTO_SWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REL_CLTE_CTO_SWAP]
(
	@FECHA		 DATE = NULL
)
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT YMD
/* 
	PROYECTO		: RENTABILIDAD
	DESCRIPCION	: INTERFAZ RELACION CLIENTE CONTRATO, SWAP
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 17-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE
	--DECLARE @FECHA DATE
	--SET @FECHA=NULL

IF @FECHA IS NULL BEGIN
    SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 
END ELSE BEGIN
    SET @FECHA_PROC_FILTRO = @FECHA --(SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 
END	
	
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')



/*******************************************************
		EXTRACCION DE DATOS
********************************************************/

;WITH CARTERA_SWAP
(
	 NRO_DOCUMENTO
	,NRO_OPERACION
	,NRO_CORRELATIVO
	,ID_SISTEMA
	,COD_SUBPRODU
	,MONEDA
	,RUT_CLIENTE
	,COD_CLIENTE
	,FECHA_PROCESO
	,FECHA_CONTRATO
	,FECHA_VENCIMIENTO
	,STATUS_V
	,T_FLUJO
)
AS
(
SELECT DISTINCT 
     NULL							    AS NRO_DOCUMENTO
    ,NUMERO_OPERACION				    AS NRO_OPERACION
    ,NUMERO_FLUJO					    AS NRO_CORRELATIVO		
    ,'PCS'								AS ID_SISTEMA   
    ,(CASE TIPO_SWAP
	   WHEN 1 THEN 'ST'
	   WHEN 2 THEN 'SM'
	   WHEN 3 THEN 'FR'
	   WHEN 4 THEN 'SP'
    END)							    AS COD_SUBPRODU
    ,(CASE TIPO_FLUJO 
	   WHEN 1 THEN COMPRA_MONEDA
	   WHEN 2 THEN VENTA_MONEDA
    END)							    AS MONEDA
    ,RUT_CLIENTE
    ,CODIGO_CLIENTE      
    ,FECHA_PROCESO
    ,FECHA_INICIO_FLUJO
    ,FECHA_VENCE_FLUJO
    ,'VIGENTE'						    AS STATUS_V		
    ,TIPO_FLUJO
FROM BACSWAPSUDA.dbo.CARTERARES WITH(NOLOCK)
WHERE 	
        FECHA_PROCESO = @FECHA_PROC_FILTRO			-- CARTERA VIGENTE
AND ESTADO<>'C'
AND FECHA_VENCE_FLUJO > @FECHA_PROC_FILTRO			-- CON VENC. FUTUROS?
UNION
SELECT * FROM (
SELECT DISTINCT
NULL								    AS NRO_DOCUMENTO
,NUMERO_OPERACION					    AS NRO_OPERACION
,NUMERO_FLUJO						    AS NRO_CORRELATIVO
,'PCS'									AS ID_SISTEMA
,(CASE TIPO_SWAP
	   WHEN 1 THEN 'ST'
	   WHEN 2 THEN 'SM'
	   WHEN 3 THEN 'FR'
	   WHEN 4 THEN 'SP'
END)								    AS COD_SUBPRODU
,(CASE TIPO_FLUJO 
    WHEN 1 THEN COMPRA_MONEDA
    WHEN 2 THEN VENTA_MONEDA
END)								    AS MONEDA
,RUT_CLIENTE
,CODIGO_CLIENTE
,FECHA_PROCESO
,FECHA_INICIO_FLUJO
,FECHA_VENCE_FLUJO
,'VENCIDA'								AS STATUS_V				
,TIPO_FLUJO
FROM BacSwapSuda.dbo.carterares with(NOLOCK)
where Fecha_Proceso = @FECHA_PROC_FILTRO
AND fecha_vence_flujo BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
AND ESTADO<>'C'
UNION
SELECT DISTINCT 
NULL								    AS NRO_DOCUMENTO
,CH.NUMERO_OPERACION				    AS NRO_OPERACION
,CH.NUMERO_FLUJO					    AS NRO_CORRELATIVO
,'PCS'									AS ID_SISTEMA
,(CASE CH.TIPO_SWAP
    WHEN 1 THEN 'ST'
    WHEN 2 THEN 'SM'
    WHEN 3 THEN 'FR'
    WHEN 4 THEN 'SP'
END)								    AS COD_SUBPRODU
,(CASE TIPO_FLUJO 
    WHEN 1 THEN COMPRA_MONEDA
    WHEN 2 THEN VENTA_MONEDA
END)								    AS MONEDA
,CH.RUT_CLIENTE
,CH.CODIGO_CLIENTE				
,@FECHA_PROC_FILTRO					    AS FECHA_PROCESO
,CH.FECHA_INICIO_FLUJO
,CH.FECHA_VENCE_FLUJO
,'CANCELADA'						    AS STATUS_V	
,TIPO_FLUJO			
FROM BACSWAPSUDA.DBO.CARTERAHIS AS CH WITH(NOLOCK)
	   INNER JOIN 
		  ( SELECT DISTINCT numero_operacion
			 from bacswapsuda.dbo.carterahis with(nolock)
			 where fecha_vence_flujo >= @FECHA_INI_FILTRO
			 and estado<>'C'
		  ) CV ON CV.numero_operacion=CH.numero_operacion
WHERE CH.fecha_vence_flujo>=@FECHA_INI_FILTRO
AND ESTADO <> 'C'
) AS CARTERA_CANCELADA
)
SELECT * FROM CARTERA_SWAP
ORDER BY NRO_OPERACION ASC,NRO_CORRELATIVO ASC

END
GO
