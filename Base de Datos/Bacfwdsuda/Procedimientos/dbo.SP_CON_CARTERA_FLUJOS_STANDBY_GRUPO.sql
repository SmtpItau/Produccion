USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CARTERA_FLUJOS_STANDBY_GRUPO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_CARTERA_FLUJOS_STANDBY_GRUPO]
AS 
BEGIN


	SET NOCOUNT ON 

	SELECT	Cf_Credito						AS CREDITO
	,	COUNT(Cfs_Numero_Dividendo)				AS CANT_DIVIDENDOS
	,	CONVERT(CHAR(08),MAX(Cfs_Fecha_Vencimiento),112)	AS ULTIMO_VCTO
	,	SUM(Cfs_Monto_UF)					AS TOT_UF
	,	MIN(Cfs_Precio_Contrato)				AS PRECIO_UF_CONTRATO
	,	Cf_Rut_Cli						AS RUT_CLI
	,	Cf_Dv							AS DV
	,	Cf_Nombre						AS NOMBRE
	,	Cf_Nombre2						AS NOMBRE2
	,	Cf_ApePtn						AS APEPTN
	,	Cf_ApeMtn						AS APEMTN
	,	CASE WHEN ClRut IS NULL THEN 'NO CREADO' 
                                        ELSE 'EXISTE'	
		END							AS ESTADO_CLI
	,	CASE Cf_Condicion	WHEN 'N' THEN 'NUEVO'
					WHEN 'R' THEN 'RENEGOCIADO'
					WHEN 'P' THEN 'PREPAGO'
					ELSE 'ERROR'
		END							AS CONDICION
	FROM	TBL_CABECERA_FLUJOS_STANDBY	LEFT JOIN BACPARAMSUDA..CLIENTE
						ON	Clrut		= Cf_Rut_Cli
						AND	Cldv		= Cf_Dv
						AND	Clcodigo	= 1
	,	TBL_CARTERA_FLUJOS_STANDBY		
	WHERE	Cfs_Numero_Credito	= Cf_Credito	
	GROUP
	BY	Cf_Credito
	,	Cf_Rut_Cli
	,	Cf_Dv
	,	Cf_Nombre
	,	Cf_Nombre2
	,	Cf_ApePtn
	,	Cf_ApeMtn
	,	ClRut
	,	Cf_Condicion

	SET NOCOUNT OFF
END
GO
