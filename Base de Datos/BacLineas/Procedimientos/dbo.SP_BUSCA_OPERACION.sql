USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPERACION]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_OPERACION]
(
	@nFolio numeric (10)
,	@nOrigen varchar(1)
)
AS
BEGIN
	--DECLARE @nFolio   NUMERIC(9)
      -- SET @nFolio   = 1053

IF @nOrigen = 'O'
BEGIN
	   -->    Control de Existencia de la Operación
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nFolio)
   BEGIN
      SELECT -1, 'Operación No se encuentra en Cartera'
		RETURN
   END

   -->    Control de Existencia de la Operación como Operación [Si es Cotización, Avisa]
   IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nFolio AND estado = 'C')
   BEGIN
      SELECT -1, 'Número de operacion correspone a una cotizacion.'
      RETURN -1
   END
END ELSE
BEGIN
		 -->    Control de Existencia de la Cotización
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nFolio)
   BEGIN
      SELECT -1, 'Cotización No se encuentra en Ingresada'
		RETURN
   END

   -->    Control de Existencia de la Cotización como Cotización [Si NO es Cotización, Avisa]
   IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nFolio AND estado = '')
   BEGIN
      SELECT -1, 'Número de cotizacion correspone a una operación.'
      RETURN -1
   END
END
   -->    Muistra Flujos Activos
   SELECT TOP 1 estado, clnombre, compra_moneda = mnnemo, compra_capital, Indicador = convert(varchar(25), ltrim(rtrim( compra_codigo_tasa )) + ' - ' + tbglosa), compra_valor_tasa as RESUMEN
     FROM BacSwapSuda.dbo.CARTERA 
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 1042 and tbcodigo1 = compra_codigo_tasa
		  left  join BacParamSuda.dbo.MONEDA				ON mncodmon = compra_moneda
    WHERE numero_operacion  = @nFolio and tipo_flujo = 1 --order by numero_flujo
	UNION
   -->    Muistra Flujos Pasivos
   SELECT TOP 1 estado, clnombre, venta_moneda = mnnemo, venta_capital, Indicador = convert(varchar(25), ltrim(rtrim( venta_codigo_tasa )) + ' - ' + tbglosa), venta_valor_tasa 
     FROM BacSwapSuda.dbo.CARTERA 
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 1042 and tbcodigo1 = venta_codigo_tasa
		  LEFT  JOIN BacParamSuda.dbo.MONEDA				ON mncodmon = venta_moneda
   WHERE numero_operacion  = @nFolio and tipo_flujo = 2 --order by numero_flujo
	ORDER BY RESUMEN DESC

END
GO
