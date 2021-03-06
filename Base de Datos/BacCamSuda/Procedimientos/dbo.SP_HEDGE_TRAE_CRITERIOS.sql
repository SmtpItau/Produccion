USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_TRAE_CRITERIOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_TRAE_CRITERIOS]
AS
BEGIN
	SELECT 	 'Origen' 		= DET.tbglosa + SPACE(50) + MANT.cod_origen 
		,'Producto' 		= PROD.descripción + SPACE(50) + PROD.codigo  
		,'Tipo Operacion' 	= CASE WHEN tipo_ope = 'C' THEN 'COMPRA' + SPACE(50) + 'C' WHEN tipo_ope = 'V' THEN  'VENTA' + SPACE(50) + 'V' ELSE '' END 
		,'Moneda' 		= ( SELECT mnnemo FROM bacparamsuda..moneda WHERE (mnmx='C' OR mncodmon='999') AND  mnnemo = MANT.Moneda ) 
		,'Cta.Contable' 	= cuenta_contable
		,'TipoValor' 		= CASE WHEN tipo_valor = 'A' THEN 'ACTIVO' + SPACE(50) + 'A' WHEN tipo_valor = 'P' THEN  'PASIVO' + SPACE(50) + 'P' END 
		,'imputacion' 		= ISNULL(CASE WHEN imputacion = 'A' THEN 'ACTIVO' + SPACE(50) + 'A' WHEN imputacion = 'P' THEN  'PASIVO' + SPACE(50) + 'P' END,'N/A')
		,Variable
		,Cod_Orden
	FROM TBL_HEDGE_MANT MANT WITH(NOLOCK)
	INNER JOIN TBL_HEDGE_PRODUCTO PROD WITH(NOLOCK) ON LTRIM(RTRIM(MANT.Cod_Producto)) = LTRIM(RTRIM(PROD.Codigo)) 
								AND LTRIM(RTRIM(MANT.Cod_Origen)) = LTRIM(RTRIM(PROD.Codigo_Origen))
	INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE DET WITH(NOLOCK) ON LTRIM(RTRIM(MANT.Cod_Origen)) = LTRIM(RTRIM(DET.tbcodigo1))
 												AND DET.tbcateg=8601 
	ORDER BY Origen, Cod_Producto, Tipo_OPE,Moneda
END
GO
