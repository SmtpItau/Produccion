USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPER_SWAP_PASO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_OPER_SWAP_PASO]
   (
      @nFolio as numeric(10)
   )
AS
BEGIN 

	   -->    Control de Existencia de la Operación
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nFolio)
   BEGIN
		SELECT -1, 'N° Operación No se encuentra en Cartera de Swap'
		RETURN
   END

	-->    Muestra Flujos Activos
   SELECT TOP 1 clnombre, compra_capital, compra_moneda = mnnemo, Indicador = tbglosa, compra_valor_tasa as RESUMEN
     FROM BacSwapSuda.dbo.CARTERA 
          INNER JOIN BacParamSuda.dbo.CLIENTE				ON clrut = rut_cliente and clcodigo = codigo_cliente
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 204 and CONVERT(INT, tbcodigo1) = cartera_inversion 
		  LEFT  JOIN BacParamSuda.dbo.MONEDA				ON mncodmon = compra_moneda
    WHERE numero_operacion  = @nFolio and tipo_flujo = 1 --order by numero_flujo
	UNION
   -->    Muestra Flujos Pasivos
   SELECT TOP 1 clnombre,  venta_capital, venta_moneda= mnnemo, Indicador = tbglosa, venta_valor_tasa 
     FROM BacSwapSuda.dbo.CARTERA 
          INNER JOIN BacParamSuda.dbo.CLIENTE				ON clrut = rut_cliente and clcodigo = codigo_cliente
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 204 and CONVERT(INT, tbcodigo1) = cartera_inversion 
		  LEFT  JOIN BacParamSuda.dbo.MONEDA				ON mncodmon = venta_moneda
   WHERE numero_operacion  = @nFolio and tipo_flujo = 2--order by numero_flujo
ORDER BY resumen DESC

END


GO
