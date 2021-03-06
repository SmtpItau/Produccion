USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_FRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CARTERA_FRA]
   (   @Param1_Regulacion   CHAR(1) = ''
   ,   @Param2_Regulacion   INTEGER = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FechaProceso        CHAR(10)
   ,       @FechaEmision        CHAR(10)
   ,       @HoraEmision         CHAR(10)
   ,       @CartFinanciera      CHAR(20)

   SELECT  @CartFinanciera      = '< TODAS >'
   
   SELECT DISTINCT
	  @CartFinanciera       = ISNULL(rcnombre,'CARTERA NO DEFINIDA')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema             = 'PCS'
   AND    rcrut                 = @Param2_Regulacion

   SELECT  @FechaProceso        = CONVERT(CHAR(10),fechaproc,103)
   ,       @FechaEmision        = CONVERT(CHAR(10),GETDATE(),103)
   ,       @HoraEmision         = CONVERT(CHAR(10),GETDATE(),108)
   FROM    SWAPGENERAL

   SELECT 'Operacion'           = car.numero_operacion
   ,      'Cliente'             = CONVERT(CHAR(25),cli.clnombre)
   ,      'FechaCierre'         = CONVERT(CHAR(10),Fecha_Cierre,103)
   ,      'FechaEfectiva'       = CONVERT(CHAR(10),FechaEfectiva,103)
   ,      'FechaLiquidacion'    = CONVERT(CHAR(10),FechaLiquidacion,103)
   ,      'FechaMadurez'        = CONVERT(CHAR(10),Madurez,103)
   ,      'PlazoDias'           = DATEDIFF(DAY,FechaEfectiva,Madurez)
   ,      'Moneda'              = mon.mnnemo
   ,      'Capital'             = CASE WHEN car.tipo_flujo = 1 THEN car.compra_capital    ELSE car.venta_capital     END
   ,      'DescripcionTasa'     = CASE WHEN car.tipo_flujo = 1 THEN 'Tasa Contrato'       ELSE 'Indice'              END

   ,      'ValorTasa'           = CASE WHEN car.tipo_flujo = 1 THEN car.compra_valor_tasa ELSE car.venta_valor_tasa  END
   ,      'vRazonableMn'        = CASE WHEN car.tipo_flujo = 1 THEN car.vRazActivoAjus_Mn ELSE car.vRazPasivoAjus_Mn END
   ,      'vRazonableNetMn'     = CASE WHEN car.tipo_flujo = 1 THEN 0                     ELSE car.vRazAjustado_Mn   END
   ,      'vRazonableDo'        = CASE WHEN car.tipo_flujo = 1 THEN car.vRazActivoAjus_Do ELSE car.vRazPasivoAjus_Do END
   ,      'vRazonableNetDo'     = CASE WHEN car.tipo_flujo = 1 THEN 0                     ELSE car.vRazAjustado_Do   END
   ,      'FechaProceso'        = @FechaProceso
   ,      'FechaEmisión'        = @FechaEmision
   ,      'HoraEmision'         = @HoraEmision
   ,      'InformeCartera'      = @CartFinanciera
   ,      'CarteraInversion'    = ISNULL(rcnombre,'No Definida')
   ,      'TipoOperacion'       = CASE WHEN car.tipo_operacion = 'T' THEN 'TOMADOR'
                                       WHEN car.tipo_operacion = 'P' THEN 'PRESTAMISTA'
                                       ELSE                               'No Definido'
                                  END
   ,      'GlosaTasa'           = tas.tbglosa
   ,      'TipoFlujo'           = car.tipo_flujo
   ,      'CarteraFinanciera'   = Financiera.tbglosa
   ,      'CarteraNormativa'    = Normativa.tbglosa
   ,      'LibroNegociacion'    = Negociacion.tbglosa
   ,      'AreaResponsalble'    = Responsable.tbglosa
   ,      'SubCarteraNormativa' = SubCartera.tbglosa
   INTO   #CarteraFra_Prestamista
   FROM   CARTERA  car
          LEFT JOIN BacParamSuda..CLIENTE               cli         ON car.Rut_cliente = cli.clrut AND car.codigo_cliente = cli.clcodigo
          LEFT JOIN BacParamSuda..MONEDA                mon         ON mon.mncodmon = CASE WHEN car.tipo_flujo = 1 THEN car.compra_moneda  ELSE car.venta_moneda END
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tas         ON tas.tbcateg = 1042 AND tas.tbcodigo1 = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codigo_tasa ELSE car.venta_codigo_tasa END
          LEFT JOIN BacParamSuda..TIPO_CARTERA          tca         ON tca.rcsistema = 'PCS' AND rccodpro = 'FR' AND tca.rcrut = car.cartera_inversion
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg  = 204  AND Financiera.tbcodigo1  = car.cartera_inversion
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg   = 1111 AND Normativa.tbcodigo1   = car.car_Cartera_Normativa
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Negociacion ON Negociacion.tbcateg = 1552 AND Negociacion.tbcodigo1 = car.car_Libro
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg = 1553 AND Responsable.tbcodigo1 = car.car_area_Responsable 
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg  = 1554 AND SubCartera.tbcodigo1  = car.car_SubCartera_Normativa 
   WHERE  car.tipo_swap      = 3
   AND    car.tipo_operacion = 'P'
   AND   (cartera_inversion  = @Param2_Regulacion OR @Param2_Regulacion = 0)
   ORDER BY car.numero_operacion , car.tipo_flujo

   SELECT 'Operacion'           = car.numero_operacion
   ,      'Cliente'             = CONVERT(CHAR(25),cli.clnombre)
   ,      'FechaCierre'         = CONVERT(CHAR(10),Fecha_Cierre,103)
   ,      'FechaEfectiva'       = CONVERT(CHAR(10),FechaEfectiva,103)
   ,      'FechaLiquidacion'    = CONVERT(CHAR(10),FechaLiquidacion,103)
   ,      'FechaMadurez'        = CONVERT(CHAR(10),Madurez,103)
   ,      'PlazoDias'           = DATEDIFF(DAY,FechaEfectiva,Madurez)
   ,      'Moneda'              = mon.mnnemo
   ,      'Capital'             = CASE WHEN car.tipo_flujo = 1 THEN car.compra_capital    ELSE car.venta_capital     END
   ,      'DescripcionTasa'     = CASE WHEN car.tipo_flujo = 2 THEN 'Tasa Contrato'       ELSE 'Indice'              END

   ,      'ValorTasa'           = CASE WHEN car.tipo_flujo = 1 THEN car.compra_valor_tasa ELSE car.venta_valor_tasa  END
   ,      'vRazonableMn'        = CASE WHEN car.tipo_flujo = 1 THEN car.vRazActivoAjus_Mn ELSE car.vRazPasivoAjus_Mn END
   ,      'vRazonableNetMn'     = CASE WHEN car.tipo_flujo = 1 THEN 0                     ELSE car.vRazAjustado_Mn   END
   ,      'vRazonableDo'        = CASE WHEN car.tipo_flujo = 1 THEN car.vRazActivoAjus_Do ELSE car.vRazPasivoAjus_Do END
   ,      'vRazonableNetDo'     = CASE WHEN car.tipo_flujo = 1 THEN 0                     ELSE car.vRazAjustado_Do   END
   ,      'FechaProceso'        = @FechaProceso
   ,      'FechaEmisión'        = @FechaEmision
   ,      'HoraEmision'         = @HoraEmision
   ,      'InformeCartera'      = @CartFinanciera
   ,      'CarteraInversion'    = ISNULL(rcnombre,'No Definida')
   ,      'TipoOperacion'       = CASE WHEN car.tipo_operacion = 'T' THEN 'TOMADOR'
                                       WHEN car.tipo_operacion = 'P' THEN 'PRESTAMISTA'
                                       ELSE                               'No Definido'
                                  END
   ,      'GlosaTasa'           = tas.tbglosa
   ,      'TipoFlujo'           = car.tipo_flujo
   ,      'CarteraFinanciera'   = Financiera.tbglosa
   ,      'CarteraNormativa'    = Normativa.tbglosa
   ,      'LibroNegociacion'    = Negociacion.tbglosa
   ,      'AreaResponsalble'    = Responsable.tbglosa
   ,      'SubCarteraNormativa' = SubCartera.tbglosa
   INTO   #CarteraFra_Tomador
   FROM   CARTERA  car
          LEFT JOIN BacParamSuda..CLIENTE               cli         ON car.Rut_cliente = cli.clrut AND car.codigo_cliente = cli.clcodigo
          LEFT JOIN BacParamSuda..MONEDA                mon         ON mon.mncodmon = CASE WHEN car.tipo_flujo = 1 THEN car.compra_moneda  ELSE car.venta_moneda END
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tas         ON tas.tbcateg = 1042 AND tas.tbcodigo1 = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codigo_tasa ELSE car.venta_codigo_tasa END
          LEFT JOIN BacParamSuda..TIPO_CARTERA          tca         ON tca.rcsistema = 'PCS' AND rccodpro = 'FR' AND tca.rcrut = car.cartera_inversion
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg  = 204  AND Financiera.tbcodigo1  = car.cartera_inversion
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg   = 1111 AND Normativa.tbcodigo1   = car.car_Cartera_Normativa
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Negociacion ON Negociacion.tbcateg = 1552 AND Negociacion.tbcodigo1 = car.car_Libro
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg = 1553 AND Responsable.tbcodigo1 = car.car_area_Responsable 
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg  = 1554 AND SubCartera.tbcodigo1  = car.car_SubCartera_Normativa 
   WHERE  car.tipo_swap      = 3
   AND    car.tipo_operacion = 'T'
   AND   (cartera_inversion  = @Param2_Regulacion OR @Param2_Regulacion = 0)
   ORDER BY car.numero_operacion , car.tipo_flujo

   SELECT * INTO #CarteraFra          FROM #CarteraFra_Prestamista
     INSERT INTO #CarteraFra SELECT * FROM #CarteraFra_Tomador

   IF NOT EXISTS(SELECT 1 FROM #CarteraFra) 
   BEGIN
      INSERT INTO #CarteraFra
      SELECT 'Operacion'           = -1
      ,      'Cliente'             = 'NO EXISTE INFORMACION'
      ,      'FechaCierre'         = ''
      ,      'FechaEfectiva'       = ''
      ,      'FechaLiquidacion'    = ''
      ,      'FechaMadurez'        = ''
      ,      'PlazoDias'           = 0
      ,      'Moneda'              = ''
      ,      'Capital'             = 0.0
      ,      'DescripcionTasa'     = ''
      ,      'ValorTasa'           = 0.0
      ,      'vRazonableMn'        = 0.0
      ,      'vRazonableNetMn'     = 0.0
      ,      'vRazonableDo'        = 0.0
      ,      'vRazonableNetDo'     = 0.0
      ,      'FechaProceso'        = @FechaProceso
      ,      'FechaEmisión'        = @FechaEmision
      ,      'HoraEmision'         = @HoraEmision
      ,      'InformeCartera'      = @CartFinanciera
      ,      'CarteraInversion'    = ''
      ,      'TipoOperacion'       = ''
      ,      'GlosaTasa'           = ''
      ,      'TipoFlujo'           = 0
      ,      'CarteraFinanciera'   = ''
      ,      'CarteraNormativa'    = ''
      ,      'LibroNegociacion'    = ''
      ,      'AreaResponsalble'    = ''
      ,      'SubCarteraNormativa' = ''
   END

   SELECT * FROM #CarteraFra  ORDER BY Operacion , TipoFlujo

END

GO
