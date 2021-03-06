USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_UTILIZACION_HISTORICA_PRODUCTO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INF_UTILIZACION_HISTORICA_PRODUCTO]
   (   @nRut_Cliente     NUMERIC(10)
   ,   @nCodigo_Cliente  NUMERIC(10)
   ,   @cCodigo_Grupo    CHAR   (10) = 'X'
   )
AS
BEGIN

   SET DATEFORMAT dmy

   DECLARE @cNombre_Cliente  CHAR(40)
   DECLARE @cDig_Cliente     CHAR(01)
   DECLARE @cMoneda_Control  CHAR(10)
   DECLARE @dFecha_Proceso   DATETIME
   DECLARE @dFecha_Aux_1     DATETIME
   DECLARE @dFecha_Aux_2     DATETIME
   DECLARE @nContador_Mes    INTEGER
   SET NOCOUNT ON
   
   SELECT @dFecha_Proceso = fecha_proceso
   FROM   DATOS_GENERALES

   SELECT @cNombre_Cliente = ISNULL(clnombre, ' ')
      ,   @cDig_Cliente    = ISNULL(cldv, ' ')
   FROM   CLIENTE
   WHERE  clrut    = @nRut_Cliente
     AND  clcodigo = @nCodigo_Cliente

   SELECT @cMoneda_Control = ISNULL(mnnemo, ' ')
   FROM   DATOS_GENERALES
          LEFT JOIN MONEDA ON moneda_control = mncodmon

   CREATE TABLE #PERIODO_TEMP
      (   numero_fila      INTEGER  IDENTITY(1,1)
      ,   nombre_periodo   CHAR(13) 
      ,   fecha_desde      DATETIME
      ,   fecha_hasta      DATETIME
      )

   SELECT @dFecha_Aux_1 = STR(YEAR(@dFecha_Proceso) - 2, 4) + '0101'
   SELECT @dFecha_Aux_2 = STR(YEAR(@dFecha_Proceso) - 2, 4) + '1231'

   INSERT INTO #PERIODO_TEMP SELECT 'PROMEDIO ' + STR(YEAR(@dFecha_Proceso) - 2, 4), @dFecha_Aux_1, @dFecha_Aux_2

   SELECT @dFecha_Aux_1 = STR(YEAR(@dFecha_Proceso) - 1, 4) + '0101'
   SELECT @dFecha_Aux_2 = STR(YEAR(@dFecha_Proceso) - 1, 4) + '1231'

   INSERT INTO #PERIODO_TEMP SELECT 'PROMEDIO ' + STR(YEAR(@dFecha_Proceso) - 1, 4), @dFecha_Aux_1, @dFecha_Aux_2

   SELECT @nContador_Mes = 1

   WHILE (@nContador_Mes <= 12)
   BEGIN

      SELECT @dFecha_Aux_1 = CASE WHEN @nContador_Mes < 10 THEN STR(YEAR(@dFecha_Proceso), 4) + '0' + STR(@nContador_Mes, 1) + '01'
                                  ELSE STR(YEAR(@dFecha_Proceso), 4) + STR(@nContador_Mes, 2) + '01'
                             END

      SELECT @dFecha_Aux_2 = DATEADD(MONTH, 1, @dFecha_Aux_1)
      SELECT @dFecha_Aux_2 = DATEADD(DAY, - DATEPART(DAY, @dFecha_Aux_2), @dFecha_Aux_2)

      INSERT INTO #PERIODO_TEMP SELECT UPPER(DATENAME(MONTH, @dFecha_Aux_2)), @dFecha_Aux_1, @dFecha_Aux_2

      SELECT @nContador_Mes = @nContador_Mes + 1
           
   END

   SELECT 'nombre_cliente' = @cNombre_Cliente
      ,   'rut_cliente'    = @nRut_Cliente
      ,   'codigo_cliente' = @nCodigo_Cliente
      ,   'dig_cliente'    = @cDig_Cliente
      ,   'moneda_control' = @cMoneda_Control
      ,   'nombre_periodo' = p.nombre_periodo
      ,   'nombre_grupo'   = g.codigo_grupo
      ,   'monto_x_millon' = CONVERT(NUMERIC(19, 02), 0.00)
      ,   'fecha_desde'    = p.fecha_desde
      ,   'fecha_hasta'    = p.fecha_hasta
      ,   'numero_fila'    = numero_fila
   INTO   #RESULTADO_FINAL
   FROM   GRUPO_PRODUCTO    g
      ,   #PERIODO_TEMP     p
   WHERE  g.codigo_grupo = @cCodigo_Grupo OR @cCodigo_Grupo = 'X'

   IF EXISTS(SELECT 1 FROM LINEA_TRANSACCION t, #PERIODO_TEMP p, LINEA_TRANSACCION_DETALLE LTD 
             WHERE  t.fechainicio BETWEEN p.fecha_desde AND p.fecha_hasta
               AND  t.rut_cliente    = @nRut_Cliente
               AND  t.codigo_cliente = @nCodigo_Cliente
               AND (t.codigo_grupo = @cCodigo_Grupo OR @cCodigo_Grupo = 'X')
               AND  t.numerooperacion = ltd.numerooperacion
               AND  t.numerocorrelativo = ltd.numerocorrelativo
               AND  ltd.tipo_detalle       = 'L'
               AND  ltd.tipo_movimiento    = 'S'
               AND  ltd.Linea_Transsaccion  = 'LINSIS')
   BEGIN

      UPDATE #RESULTADO_FINAL SET monto_x_millon = CASE WHEN YEAR(#RESULTADO_FINAL.fecha_desde) < YEAR(@dFecha_Proceso) THEN
                                                   (SELECT ISNULL(ROUND(AVG(t.MontoTransaccion) / 1000000, 2), 0) FROM LINEA_TRANSACCION t,LINEA_TRANSACCION_DETALLE LTD 
                                                    WHERE t.fechainicio BETWEEN #RESULTADO_FINAL.fecha_desde AND #RESULTADO_FINAL.fecha_hasta
                                                      AND t.rut_cliente    = #RESULTADO_FINAL.rut_cliente
                                                      AND t.codigo_cliente = #RESULTADO_FINAL.codigo_cliente
                                                      AND t.codigo_grupo   = #RESULTADO_FINAL.nombre_grupo
                                                      AND (t.codigo_grupo = @cCodigo_Grupo OR @cCodigo_Grupo = 'X')
                                                      AND  t.numerooperacion = ltd.numerooperacion
                                                      AND  t.numerocorrelativo = ltd.numerocorrelativo
                                                      AND  ltd.tipo_detalle       = 'L'
                                                      AND  ltd.tipo_movimiento    = 'S'
                                                      AND  ltd.Linea_Transsaccion  = 'LINSIS'  )
                                                   ELSE
                                                   (SELECT ISNULL(ROUND(SUM(t.MontoTransaccion) / 1000000, 2), 0) FROM LINEA_TRANSACCION t,LINEA_TRANSACCION_DETALLE LTD 
                                                    WHERE t.fechainicio BETWEEN #RESULTADO_FINAL.fecha_desde AND #RESULTADO_FINAL.fecha_hasta
                                                      AND t.rut_cliente    = #RESULTADO_FINAL.rut_cliente
                                                      AND t.codigo_cliente = #RESULTADO_FINAL.codigo_cliente
                                                      AND t.codigo_grupo   = #RESULTADO_FINAL.nombre_grupo
                                                      AND (t.codigo_grupo = @cCodigo_Grupo OR @cCodigo_Grupo = 'X')
                                                      AND  t.numerooperacion = ltd.numerooperacion
                                                      AND  t.numerocorrelativo = ltd.numerocorrelativo
                                                      AND  ltd.tipo_detalle       = 'L'
                                                      AND  ltd.tipo_movimiento    = 'S'
                                                      AND  ltd.Linea_Transsaccion  = 'LINSIS' )
                                                   END

   END

   SELECT 'nombre_cliente' = nombre_cliente
      ,   'rut_cliente'    = rut_cliente
      ,   'dig_cliente'    = dig_cliente
      ,   'moneda_control' = moneda_control
      ,   'nombre_periodo' = nombre_periodo
      ,   'nombre_grupo'   = nombre_grupo
      ,   'monto_x_millon' = monto_x_millon
      ,   'numero_fila'    = numero_fila
   FROM #RESULTADO_FINAL

   SET NOCOUNT OFF

END

GO
