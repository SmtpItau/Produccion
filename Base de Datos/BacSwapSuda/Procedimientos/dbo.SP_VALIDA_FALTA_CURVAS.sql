USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_FALTA_CURVAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_FALTA_CURVAS]
AS
BEGIN
-- Swap: Guardar Como
   SET NOCOUNT ON

   SELECT Producto  = CASE WHEN Producto = 'ST' THEN 1
                           WHEN Producto = 'SM' THEN 2
                           WHEN Producto = 'FR' THEN 3
                           WHEN Producto = 'SP' THEN 4
                      END
   ,      Moneda    = Moneda
   ,      Tasa      = Indicador
   ,      Curva     = CodigoCurva
   INTO   #TMP_PROD_SWAP
   FROM   BacParamSuda..CURVAS_PRODUCTO
   WHERE  Modulo    = 'PCS'
   AND    Indicador > -1
   ORDER BY Modulo, Producto, Moneda, Instrumento, Emisor, TasaDesde, TasaHasta

   CREATE TABLE #CURVAS_FALTANTES
   (   Pata         VARCHAR(15)   NOT NULL DEFAULT('')
   ,   Producto     VARCHAR(25)   NOT NULL DEFAULT('')
   ,   Moneda       VARCHAR(3)    NOT NULL DEFAULT('')
   ,   Indicador    VARCHAR(20)   NOT NULL DEFAULT('')
   )
   CREATE INDEX #ixt_CURVAS_FALTANTES ON #CURVAS_FALTANTES (Pata, Producto, Moneda, Indicador)

   INSERT INTO #CURVAS_FALTANTES
   SELECT DISTINCT Pata               = 'Entregamos'
                 , Producto           = CASE WHEN tipo_swap = 1 THEN 'Swap de Tasas'
                                             WHEN tipo_swap = 2 THEN 'Swap de Monedas'
                                             WHEN tipo_swap = 3 THEN 'Forward Rate Agreement'
                                             WHEN tipo_swap = 4 THEN 'Swap Promedio Camara'   
                                        END
                 , Moneda             = (SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda)
                 , Indicador          = (SELECT DISTINCT tbglosa FROM BacparamSuda..TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 and tbcodigo1 = compra_codigo_tasa)
     FROM BacSwapSuda..CARTERA 
     WHERE Tipo_Flujo = 1
       and estado <> 'C'
       and compra_codigo_tasa NOT IN( SELECT Tasa FROM #TMP_PROD_SWAP WHERE tipo_swap = Producto and compra_moneda = Moneda )

   INSERT INTO #CURVAS_FALTANTES
   SELECT DISTINCT Pata               = 'Recibimos'
                 , Producto           = CASE WHEN tipo_swap = 1 THEN 'Swap de Tasas'
                                             WHEN tipo_swap = 2 THEN 'Swap de Monedas'
                                             WHEN tipo_swap = 3 THEN 'Forward Rate Agreement'
                                             WHEN tipo_swap = 4 THEN 'Swap Promedio Camara'   
                                        END
                 , Moneda             = (SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda)
                 , Indicador          = (SELECT DISTINCT tbglosa FROM BacparamSuda..TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 and tbcodigo1 = venta_codigo_tasa)
     FROM BacSwapSuda..CARTERA 
     WHERE Tipo_Flujo = 2
       and estado <> 'C'
       and venta_codigo_tasa NOT IN( SELECT Tasa FROM #TMP_PROD_SWAP WHERE tipo_swap = Producto and venta_moneda = Moneda )

   SELECT Pata, producto, Moneda, Indicador FROM #CURVAS_FALTANTES ORDER BY Pata, producto, Moneda, Indicador 

END

GO
