USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADO_POSICION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE  PROCEDURE [dbo].[SP_RESULTADO_POSICION]
   (   @dFecha   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   -->     Lee la fecha de Proceso
   DECLARE @dFechaProceso  DATETIME
       SET @dFechaProceso  = (SELECT acfecpro FROM BacCamSuda.dbo.MEAC with(nolock))

   -->     crea Tabla de retorno
   CREATE TABLE #TMP_RETORNO_SPOT
   (   Moneda         CHAR(3)
   ,   Origen         INTEGER
   ,   MontoCompras   FLOAT   DEFAULT(0.0)
   ,   TCPromedioComp FLOAT   DEFAULT(0.0)
   ,   MontoVentas    FLOAT   DEFAULT(0.0)
   ,   TCPromedioVtas FLOAT   DEFAULT(0.0)
   )

   -->     Inserta las compras del DÃ­a
   INSERT INTO #TMP_RETORNO_SPOT
   SELECT Moneda          = comp.mocodmon
   ,      Origen          = ori.tbcodigo1
   ,      MontoCompras    = SUM(comp.momonmo)
   ,      TCPromedioComp  = CASE WHEN ori.tbcodigo1 = 8 THEN SUM(comp.cmx_tc_costo_trad * comp.momonmo) / SUM(comp.momonmo)
                                 ELSE                        SUM(comp.moticam           * comp.momonmo) / SUM(comp.momonmo)
                            END
   ,      MontoVentas     = 0.0
   ,      TCPromedioVtas  = 0.0
   FROM   BacCamSuda.dbo.MEMO comp
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ori ON ori.tbcateg = 2700 AND LTRIM(RTRIM( ori.nemo )) = LTRIM(RTRIM( comp.moterm ))
   WHERE  comp.moestatus <> 'A'
   AND    comp.motipope   = 'C'
   GROUP BY comp.mocodmon, ori.tbcodigo1

   -->     Inserta las Ventas del DÃ­a
   SELECT Moneda          = vtas.mocodmon
   ,      Origen          = ori.tbcodigo1
   ,      MontoVenta      = SUM(vtas.momonmo)
   ,      TCVenta         = CASE WHEN ori.tbcodigo1 = 8 THEN SUM(vtas.cmx_tc_costo_trad * vtas.momonmo) / SUM(vtas.momonmo)
                                 ELSE                       SUM(vtas.moticam           * vtas.momonmo) / SUM(vtas.momonmo)
                            END
   ,      iPuntero        = identity(INT)
   INTO   #TMP_VENTAS
   FROM   BacCamSuda.dbo.MEMO vtas
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ori ON ori.tbcateg = 2700 AND LTRIM(RTRIM( ori.nemo )) = LTRIM(RTRIM( vtas.moterm ))
   WHERE  vtas.moestatus <> 'A'
   AND    vtas.motipope   = 'V'
   GROUP BY vtas.mocodmon, ori.tbcodigo1

   --> Si la fecha de consulta es anterior a hoy
   IF @dFecha < @dFechaProceso
   BEGIN
      --> Elimina tabla de Retorno
      TRUNCATE TABLE #TMP_RETORNO_SPOT
      --> Elimina tablas temporales
      TRUNCATE TABLE #TMP_VENTAS

      --> Inserto compras historicas
      INSERT INTO #TMP_RETORNO_SPOT
      SELECT Moneda          = comp.mocodmon
      ,      Origen          = ori.tbcodigo1
      ,      MontoCompras    = SUM(comp.momonmo)
      ,      TCPromedioComp  = CASE WHEN ori.tbcodigo1 = 8 THEN SUM(comp.cmx_tc_costo_trad * comp.momonmo) / SUM(comp.momonmo)
                                    ELSE                        SUM(comp.moticam           * comp.momonmo) / SUM(comp.momonmo)
                               END
      ,      MontoVentas     = 0.0
      ,      TCPromedioVtas  = 0.0
      FROM   BacCamSuda.dbo.MEMOH comp
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ori ON ori.tbcateg = 2700 AND LTRIM(RTRIM( ori.nemo )) = LTRIM(RTRIM( comp.moterm ))
      WHERE  comp.mofech     = @dFecha
      AND    comp.moestatus <> 'A'
      AND    comp.motipope   = 'C'
      GROUP BY comp.mocodmon, ori.tbcodigo1

      --> Inserto Ventas historicas
      INSERT INTO #TMP_VENTAS
      SELECT Moneda          = vtas.mocodmon
      ,      Origen          = ori.tbcodigo1
      ,      MontoVenta      = SUM(vtas.momonmo)
      ,      TCVenta         = CASE WHEN ori.tbcodigo1 = 8 THEN SUM(vtas.cmx_tc_costo_trad * vtas.momonmo) / SUM(vtas.momonmo)
                                    ELSE                        SUM(vtas.moticam           * vtas.momonmo) / SUM(vtas.momonmo)
                               END
      FROM   BacCamSuda.dbo.MEMOH vtas
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ori ON ori.tbcateg = 2700 AND LTRIM(RTRIM( ori.nemo )) = LTRIM(RTRIM( vtas.moterm ))
      WHERE  vtas.mofech     = @dFecha
      AND    vtas.moestatus <> 'A'
      AND    vtas.motipope   = 'V'
      GROUP BY vtas.mocodmon, ori.tbcodigo1
   END

   --> Inserto Ventas al retorno final
   DECLARE @iContador     INTEGER
       SET @iContador     = 1
   DECLARE @iRegistros    INTEGER
       SET @iRegistros    = (SELECT MAX(iPuntero) FROM #TMP_VENTAS)

   DECLARE @xMoneda       CHAR(3)
   DECLARE @nOrigen       INTEGER
   DECLARE @nMonto        FLOAT
   DECLARE @nTipCambio    FLOAT
   
   WHILE @iRegistros >= @iContador
   BEGIN
      SELECT @xMoneda   = Moneda
      ,      @nOrigen   = Origen
      ,      @nMonto    = MontoVenta
      ,      @nTipCambio= TCVenta
 FROM   #TMP_VENTAS
      WHERE  iPuntero   = @iContador

      --> Si existe la moneda 
      IF EXISTS( SELECT 1 FROM #TMP_RETORNO_SPOT WHERE Moneda = @xMoneda AND Origen = @nOrigen)
      BEGIN
         --> Actualizo
         UPDATE #TMP_RETORNO_SPOT 
            SET MontoVentas    = MontoVentas    + @nMonto
            ,   TCPromedioVtas = TCPromedioVtas + @nTipCambio
          WHERE Moneda         = @xMoneda
            AND Origen         = @nOrigen
      END ELSE
      BEGIN
         --> Inserto
         INSERT INTO #TMP_RETORNO_SPOT
         (   Moneda
         ,   Origen
         ,   MontoCompras
         ,   TCPromedioComp
         ,   MontoVentas
         ,   TCPromedioVtas
         )
         VALUES
         (   @xMoneda
         ,   @nOrigen
         ,   0.0
         ,   0.0
         ,   @nMonto
         ,   @nTipCambio
         )
      END

      SET @iContador = @iContador + 1
   END
      
   SELECT @dFecha as Fecha
   ,      Moneda
   ,      Origen
   ,      MontoCompras
   ,      TCPromedioComp
   ,      MontoVentas
   ,      TCPromedioVtas
   FROM   #TMP_RETORNO_SPOT
   ORDER BY Fecha, Moneda, Origen

END





GO
