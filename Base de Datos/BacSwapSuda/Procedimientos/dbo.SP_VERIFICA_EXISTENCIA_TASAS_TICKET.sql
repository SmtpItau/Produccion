USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_EXISTENCIA_TASAS_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICA_EXISTENCIA_TASAS_TICKET]
   (   @dFechaProceso   DATETIME   
   ,   @Pantalla        INTEGER = 0
   )
AS
BEGIN

   SET NOCOUNT ON
-- Swap: Guardar Como
   CREATE TABLE #TMP_ERRORES
   (   Modulo      CHAR(3)
   ,   Producto    VARCHAR(5)
   ,   Moneda      CHAR(3)
   ,   TipoCurva   CHAR(1)
   ,   Indicador   INTEGER
   ,   Origen      VARCHAR(5)
   )

   CREATE TABLE #CARTERA_SWAP
   (   cw_Contrato      NUMERIC(9)   NOT NULL CONSTRAINT [df_cs_a1] DEFAULT(0)
   ,   cw_Flujo         INTEGER      NOT NULL CONSTRAINT [df_cs_a2] DEFAULT(0)
   ,   cw_Tipo_Flujo    INTEGER      NOT NULL CONSTRAINT [df_cs_a3] DEFAULT(0)
   ,   cw_Moneda        INTEGER      NOT NULL CONSTRAINT [df_cs_a4] DEFAULT(0)
   ,   cw_Indicador     INTEGER      NOT NULL CONSTRAINT [df_cs_a5] DEFAULT(0)
   ,   cw_Base          INTEGER      NOT NULL CONSTRAINT [df_cs_a6] DEFAULT(0)
   ,   cw_Producto      CHAR(2)      NOT NULL CONSTRAINT [df_cs_a7] DEFAULT('')
   ,   cw_Tipo_Tasa     CHAR(1)      NOT NULL CONSTRAINT [df_cs_a8] DEFAULT('')
   ,   Puntero       NUMERIC(9)      Identity(1,1)
       CONSTRAINT [Primary_Key]   PRIMARY KEY NONCLUSTERED
       ( cw_Contrato, cw_Flujo, cw_Tipo_Flujo ) ON [PRIMARY]
   )

   INSERT INTO #CARTERA_SWAP
   SELECT cw_Contrato           = numero_operacion
       ,  cw_Flujo              = MIN(numero_flujo)
       ,  cw_Tipo_Flujo         = Tipo_Flujo
       ,  cw_Moneda             = CASE WHEN Tipo_Flujo = 1 THEN Compra_Moneda      ELSE Venta_Moneda      END
       ,  cw_Indicador          = CASE WHEN Tipo_Flujo = 1 THEN Compra_Codigo_Tasa ELSE Venta_Codigo_Tasa END
       ,  cw_Base               = CASE WHEN Tipo_Flujo = 1 THEN Compra_Base        ELSE Venta_Base        END
       ,  cw_Producto           = CASE WHEN Tipo_Swap  = 1 THEN 'ST'
                                       WHEN Tipo_Swap  = 2 THEN 'SM'
                                       WHEN Tipo_Swap  = 3 THEN 'FR'
                                       WHEN Tipo_Swap  = 4 THEN 'SP'
                                  END
       ,  cw_Tipo_Tasa          = CASE WHEN Tipo_Flujo = 1 THEN CASE WHEN Compra_Codigo_Tasa = 0 THEN 'F' ELSE 'V' END
                                       ELSE                     CASE WHEN Venta_Codigo_Tasa  = 0 THEN 'F' ELSE 'V' END
                                  END
   FROM   TBL_FLJTICKETSWAP
          where estado <> 'C'
   GROUP BY numero_operacion, Tipo_Flujo, Compra_Moneda, Venta_Moneda, Compra_Codigo_Tasa, Venta_Codigo_Tasa, Compra_Base, Venta_Base, Tipo_Swap
   ORDER BY numero_operacion, Tipo_Flujo

   DECLARE @iMax   NUMERIC(9)
       SET @iMax   = (SELECT MAX(Puntero) FROM #CARTERA_SWAP)

   DECLARE @iMin   NUMERIC(9)
       SET @iMin   = (SELECT MIN(Puntero) FROM #CARTERA_SWAP)

   DECLARE @CodigoCurva  VARCHAR(20)
   DECLARE @cw_Producto  CHAR(2)
   DECLARE @cw_Moneda    INTEGER
   DECLARE @cw_Tipo_Tasa CHAR(1)
   DECLARE @cw_Indicador INTEGER

   WHILE @iMax >= @iMin
   BEGIN
      SELECT @cw_Producto  = cw_Producto
           , @cw_Moneda    = cw_Moneda
           , @cw_Tipo_Tasa = cw_Tipo_Tasa
           , @cw_Indicador = cw_Indicador
      FROM   #CARTERA_SWAP
       WHERE Puntero       = @iMin

      SELECT @CodigoCurva = CodigoCurva
        FROM BacParamSuda..CURVAS_PRODUCTO 
       WHERE Modulo       = 'PCS' 
         AND Producto     = @cw_Producto 
         AND Moneda       = @cw_Moneda 
         AND TipoTasa     = @cw_Tipo_Tasa 
         AND Indicador    = @cw_Indicador

      IF NOT EXISTS( SELECT 1 FROM BacParamSuda..CURVAS WHERE FechaGeneracion = @dFechaProceso AND CodigoCurva = @CodigoCurva AND Tipo = 'TIR')
      BEGIN
         INSERT INTO #TMP_ERRORES
         SELECT 'PCS', @cw_Producto, mnnemo, @cw_Tipo_Tasa, @cw_Indicador, 'TIR'
         FROM   BacParamSuda..MONEDA 
         WHERE  mncodmon = @cw_Moneda

      END
      IF NOT EXISTS( SELECT 1 FROM BacParamSuda..CURVAS WHERE FechaGeneracion = @dFechaProceso AND CodigoCurva = @CodigoCurva AND Tipo = 'CERO')
      BEGIN
         INSERT INTO #TMP_ERRORES
         SELECT 'PCS', @cw_Producto, mnnemo, @cw_Tipo_Tasa, @cw_Indicador, 'CERO'
         FROM   BacParamSuda..MONEDA 
         WHERE  mncodmon = @cw_Moneda
      END

      SET @iMin = @iMin + 1
   END

   IF @Pantalla = 0
   BEGIN
      SELECT 'Falta de Curva Para Origen: ' + Origen + ' Modulo: ' + Modulo + ' Producto: ' + Producto + ' en Moneda: ' + Moneda + ' Para Tipo: ' + CASE WHEN TipoCurva = 'V' THEN ' VARIABLE ' ELSE '   FIJA   ' END + ' Indicador: ' + LTRIM(RTRIM(Indicador
)) + ' - ' + tbglosa
      FROM   #TMP_ERRORES
             INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ON tbcateg  = 1042 and tbcodigo1 = Indicador
   END ELSE
   BEGIN
      SELECT DISTINCT
             Modulo 
      ,      Producto
      ,      Moneda
      ,      TipoCurva = CASE WHEN TipoCurva = 'V' THEN 'VARIABLE' ELSE 'FIJA' END 
      ,      Indicador = LTRIM(RTRIM(Indicador)) 
      ,      tbglosa
      ,      origen
      ,      FechaProceso = CONVERT(CHAR(10),@dFechaProceso,103)
      ,      FechaEmision = CONVERT(CHAR(10),GETDATE(),103)
      ,      HoraEmision  = CONVERT(CHAR(10),GETDATE(),108)
      FROM   #TMP_ERRORES
             INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ON tbcateg  = 1042 and tbcodigo1 = Indicador
   END

END
GO
