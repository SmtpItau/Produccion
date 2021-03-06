USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_FLUJOS_SWAPPROMCAM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_FLUJOS_SWAPPROMCAM]  
   (   @MiFecha   DATETIME
   ,   @MiUsuario VARCHAR(15) = 'Administra'
   )
AS
BEGIN
-- Swap: Guardar Como
   SET NOCOUNT ON

   DECLARE @EstadoTasa VARCHAR(20)
   SELECT  @EstadoTasa = CASE WHEN devengo = 0 THEN 'Tasa No Actualizada'
                              WHEN devengo = 1 THEN 'Tasa Actualizada'
                         END
   FROM    SWAPGENERAL

   SELECT  @EstadoTasa     = CASE WHEN Vencimientos = 0 THEN 'Tasa ICP No Actualizada'
                                  WHEN Vencimientos = 1 THEN 'Tasa ICP Actualizada'
                             END
   FROM    SWAPGENERAL


   CREATE TABLE #TmpFlujosSwapPromCam
   (   Indice        INTEGER      NOT NULL DEFAULT(0)
   ,   Operacion     NUMERIC(9)   NOT NULL DEFAULT(0)
   ,   Flujo         NUMERIC(9)   NOT NULL DEFAULT(0)
   ,   TipoFlujo     INTEGER      NOT NULL DEFAULT(0)
   ,   FechaInicio   DATETIME     NOT NULL DEFAULT('')
   ,   FechaTermino  DATETIME     NOT NULL DEFAULT('')

   ,   Columna_001   INTEGER      NOT NULL DEFAULT(0)
   ,   Columna_002   INTEGER      NOT NULL DEFAULT(0)
   ,   Columna_003   FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_004   FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_005   FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_006   FLOAT        NOT NULL DEFAULT(0.0)

   ,   Columna_007   INTEGER      NOT NULL DEFAULT(0)
   ,   Columna_008   INTEGER      NOT NULL DEFAULT(0)
   ,   Columna_009   FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_010   FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_011   FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_012   FLOAT        NOT NULL DEFAULT(0.0)

   ,   Compensacion  FLOAT        NOT NULL DEFAULT(0.0)
   ,   Columna_013   DATETIME     NOT NULL DEFAULT('')
   ,   Columna_014   DATETIME     NOT NULL DEFAULT('')
   ,   Columna_015   INTEGER      NOT NULL DEFAULT(0)
   ,   Columna_016   INTEGER      NOT NULL DEFAULT(0)
   )

   select * into #Informe from cartera    where tipo_swap = 4 and fecha_vence_flujo >= @MiFecha and estado <> 'C'
   union
   select *               from carterahis where tipo_swap = 4 and fecha_vence_flujo >= @MiFecha and estado <> 'C'


   SELECT iOperacion       = numero_operacion
   ,      Flujo            = numero_flujo
   ,      TipoFlujo        = tipo_flujo
   ,      InicioFlujo      = fecha_inicio_flujo
   ,      VctoFlujo        = fecha_vence_flujo
   ,      Moneda           = compra_moneda
   ,      TipoTasa         = compra_codigo_tasa
   ,      ValorTasa        = compra_valor_tasa
   ,      Capital          = compra_capital
   ,      Amortizacion     = compra_amortiza
   ,      Interes          = compra_interes
   ,      Correla          = Identity(Int)
   ,      ProxVcto         = fecha_vence_flujo
   ,      TotFlujos        = numero_flujo
   into   #TipoFlujo_1
   from   #Informe
   where  tipo_swap          = 4
   and    fecha_vence_flujo  = @MiFecha
   and    tipo_flujo         = 1
   order by numero_operacion

   SELECT iOperacion      = numero_operacion
   ,      Flujo           = numero_flujo
   ,      TipoFlujo       = tipo_flujo
   ,      InicioFlujo     = fecha_inicio_flujo
   ,      VctoFlujo       = fecha_vence_flujo
   ,      Moneda          = venta_moneda
   ,      TipoTasa        = venta_codigo_tasa
   ,      ValorTasa       = venta_valor_tasa
   ,      Capital         = venta_capital
   ,      Amortizacion    = venta_amortiza
   ,      Interes         = venta_interes
   ,      Correla         = Identity(Int)
   ,      ProxVcto        = fecha_vence_flujo
   ,      TotFlujos       = numero_flujo
   into   #TipoFlujo_2
   from   #Informe
   where  tipo_swap         = 4
   and    fecha_vence_flujo = @MiFecha
   and    tipo_flujo        = 2
   order by numero_operacion
   
   UPDATE #TipoFlujo_1
   SET    TotFlujos         = numero_flujo
   FROM   #Informe
   WHERE  tipo_swap         = 4
   and    iOperacion        = numero_operacion
   and    tipo_flujo        = 1

   UPDATE #TipoFlujo_1
   SET    ProxVcto          = fecha_vence_flujo
   FROM   #Informe
   WHERE  tipo_swap         = 4
   and    iOperacion        = numero_operacion
   and    numero_flujo      = Flujo + 1
   and    tipo_flujo        = 1


   UPDATE #TipoFlujo_2
   SET    TotFlujos         = numero_flujo
   FROM   #Informe
   WHERE  tipo_swap         = 4
   and    iOperacion        = numero_operacion
   and    tipo_flujo        = 2


   UPDATE #TipoFlujo_2
   SET    ProxVcto          = fecha_vence_flujo
   FROM   #Informe
   WHERE  tipo_swap         = 4
   and    iOperacion        = numero_operacion
   and    numero_flujo      = Flujo + 1
   and    tipo_flujo        = 2

   DECLARE @FlujosEntregamos   INTEGER
   ,       @FlujosRecibimos    INTEGER

   SELECT  @FlujosEntregamos = 0
   SELECT  @FlujosRecibimos  = 0

   SELECT  @FlujosEntregamos = COUNT(1) FROM #TipoFlujo_1
   SELECT  @FlujosRecibimos  = COUNT(1) FROM #TipoFlujo_2


   IF @FlujosEntregamos >= @FlujosRecibimos
   BEGIN
      INSERT INTO #TmpFlujosSwapPromCam
      SELECT Correla
      ,      iOperacion
      ,      Flujo
      ,      TipoFlujo
      ,      InicioFlujo
      ,      VctoFlujo
      ,      Moneda
      ,      TipoTasa
      ,      ValorTasa
      ,      Capital
      ,      Amortizacion
      ,      Interes
      ,      0
      ,      0
      ,      0.0
      ,      0.0
      ,      0.0
      ,      0.0
      ,      0.0
      ,      ProxVcto
      ,      ' '
      ,      TotFlujos
      ,      0
      FROM   #TipoFlujo_1

      UPDATE #TmpFlujosSwapPromCam
      SET    Columna_007   = Moneda
      ,      Columna_008   = TipoTasa
      ,      Columna_009   = ValorTasa
      ,      Columna_010   = Capital
      ,      Columna_011   = Amortizacion
      ,      Columna_012   = Interes
      ,      Compensacion  = (Columna_006 - Interes)
      ,      Columna_014   = ProxVcto
      ,      Columna_016   = TotFlujos
      FROM   #TipoFlujo_2
      WHERE  Operacion     = iOperacion
--    WHERE  Indice        = Correla

   END ELSE
   BEGIN
      INSERT INTO #TmpFlujosSwapPromCam
      SELECT Correla
      ,      iOperacion
      ,      Flujo
      ,      TipoFlujo
      ,      InicioFlujo
      ,      VctoFlujo
      ,      Moneda
      ,      TipoTasa
      ,      ValorTasa
      ,      Capital
      ,      Amortizacion
      ,      Interes
      ,      0
      ,      0
      ,      0.0
      ,      0.0
      ,      0.0
      ,      0.0
      ,      0.0
      ,      ' '
      ,      ProxVcto
      ,      0
      ,      TotFlujos
      FROM   #TipoFlujo_2

      UPDATE #TmpFlujosSwapPromCam
      SET    Columna_007   = Moneda
      ,      Columna_008   = TipoTasa
      ,      Columna_009   = ValorTasa
      ,      Columna_010   = Capital
      ,      Columna_011   = Amortizacion
      ,      Columna_012   = Interes
      ,      Compensacion  = (Interes - Columna_006)
      ,      Columna_013   = ProxVcto
      ,      Columna_015   = TotFlujos
      FROM   #TipoFlujo_1
      WHERE  Operacion     = iOperacion
--    WHERE  Indice        = Correla
   END

   SELECT #TmpFlujosSwapPromCam.*
   ,      Recibimor.tbglosa               as Columna_002a
   ,      Entregamos.tbglosa              as Columna_008a
   ,      Recib.mnnemo                    as Columna_007a
   ,      Entre.mnnemo                    as Columna_001a
   ,      convert(char(10),@MiFecha,103)  as FechaProceso
   ,      upper(@MiUsuario)               as Usuario
   ,      convert(char(10),GETDATE(),103) as FechaEmision
   ,      convert(char(10),GETDATE(),108) as HoraEmision
   ,      @EstadoTasa                     as ActualizacionTasa
   FROM   #TmpFlujosSwapPromCam 
          LEFT JOIN bacparamsuda..tabla_general_detalle Recibimor  ON Recibimor.tbcateg  = 1042       AND Recibimor.tbcodigo1  = Columna_002
          LEFT JOIN bacparamsuda..tabla_general_detalle Entregamos ON Entregamos.tbcateg = 1042       AND Entregamos.tbcodigo1 = Columna_008
          LEFT JOIN bacparamsuda..moneda                Recib      ON Recib.mncodmon     = Columna_001
          LEFT JOIN bacparamsuda..moneda                Entre      ON Entre.mncodmon     = Columna_007
   ORDER BY Operacion

END
GO
