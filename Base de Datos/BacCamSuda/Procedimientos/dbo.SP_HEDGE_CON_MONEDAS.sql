USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_CON_MONEDAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HEDGE_CON_MONEDAS] ( @Fecha DATETIME = '')  
AS  
BEGIN  
  
 SET NOCOUNT ON   
  
 DELETE TBL_HEDGE_MONEDAS   
  
 INSERT TBL_HEDGE_MONEDAS  
 SELECT    Fecha  
  , CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END   
  , CASE WHEN Codigo_Moneda = 994 THEN 'USD' ELSE Nemo_Moneda END  
         , Tipo_Cambio  
         , SpotCompra  
  , SpotVenta  
 FROM bacparamsuda.dbo.VALOR_MONEDA_CONTABLE WITH(NOLOCK)  
 WHERE Fecha =  @Fecha   
  
 IF @@ERROR <> 0   
 BEGIN   
  DELETE TBL_HEDGE_MONEDAS   
  SELECT -1,'Error: al cargar tabla de monedas Hedge'  
  RETURN -1  
 END   
  
	SELECT 		A.Fecha
	,			A.Codigo_Moneda
	,			A.Nemo_Moneda
	,			B.ORDEN_MONEDA 
	,			A.Tipo_Cambio
	,			A.SpotCompra
	,			A.SpotVenta
	FROM BacCamSuda.dbo.TBL_HEDGE_MONEDAS A WITH(NOLOCK),TBL_HEDGE_ORDEN_MONEDAS B  WITH(NOLOCK)
	WHERE ( A.Fecha=@Fecha OR @Fecha= '')
	AND  A.CODIGO_MONEDA = B.Codigo_Moneda
	ORDER BY B.ORDEN_MONEDA
  
 SET NOCOUNT OFF  
  
END  
GO
