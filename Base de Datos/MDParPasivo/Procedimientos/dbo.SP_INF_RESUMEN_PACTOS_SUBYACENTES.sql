USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RESUMEN_PACTOS_SUBYACENTES]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INF_RESUMEN_PACTOS_SUBYACENTES]
   (   @cFecha_Proceso_Rpt   CHAR(10)
   )
AS
BEGIN

   SET DATEFORMAT dmy

   DECLARE @dFecha_Proceso      DATETIME
   DECLARE @dFecha_Proceso_Rpt  DATETIME
   DECLARE @cMoneda_Control	CHAR(5)

	 SELECT @cMoneda_Control = ISNULL(mnnemo, ' ')
	 FROM   DATOS_GENERALES
         LEFT JOIN MONEDA ON moneda_control = mncodmon


   SELECT @dFecha_Proceso_Rpt = CONVERT(DATETIME, @cFecha_Proceso_Rpt)

   SELECT @dFecha_Proceso = fecha_proceso FROM DATOS_GENERALES

   SET NOCOUNT ON

   CREATE TABLE #PACTO_TEMP
      (   numero_fila      INTEGER  IDENTITY(1,1)
      ,   nombre_cliente   CHAR(40)
      ,   nombre_papel     CHAR(12)
      ,   monto_pacto      NUMERIC(19,02)
      )

   IF @dFecha_Proceso_Rpt = @dFecha_Proceso
   BEGIN

      INSERT INTO #PACTO_TEMP( nombre_cliente, nombre_papel, monto_pacto)
      SELECT 'nombre_cliente' = ISNULL(c.clnombre, 'SIN CLASIFICACION')
         ,   'nombre_papel'   = p.ciinstser
         ,   'monto_pacto'    = SUM(p.civalinip)
      FROM   VIEW_CARTERA_COMPRA_PACTO p ,CLIENTE c,LINEA_TRANSACCION LT,LINEA_TRANSACCION_DETALLE LTD
      WHERE  p.cirutcli = c.clrut 
        AND p.cicodcli = c.clcodigo
        AND  LT.codigo_grupo    = LTD.codigo_grupo
        AND  LT.numerooperacion = LTD.numerooperacion
        AND  LT.numerocorrelativo = ltd.numerocorrelativo
        AND  LTD.Tipo_Detalle= 'L'
        AND  LTD.Tipo_Movimiento = 'S'
        AND  LTD.linea_transsaccion = 'LINSIS'
        AND  LT.numerooperacion  = cinumdocu
      GROUP BY p.ciinstser, c.clnombre
      ORDER BY p.ciinstser, c.clnombre

   END ELSE BEGIN

      INSERT INTO #PACTO_TEMP( nombre_cliente, nombre_papel, monto_pacto)
      SELECT 'nombre_cliente' = ISNULL(c.clnombre, 'SIN CLASIFICACION')
         ,   'nombre_papel'   = p.instser
         ,   'monto_pacto'    = SUM(p.valinip)
      FROM   VIEW_CARTERA_HISTORICA_TRADER p ,CLIENTE c,LINEA_TRANSACCION LT,LINEA_TRANSACCION_DETALLE LTD
      WHERE  p.rutcli = c.clrut 
        AND p.codcli = c.clcodigo
        AND  LT.codigo_grupo    = LTD.codigo_grupo
        AND  LT.numerooperacion = LTD.numerooperacion
        AND  LT.numerocorrelativo = ltd.numerocorrelativo
        AND  LTD.Tipo_Detalle= 'L'
        AND  LTD.Tipo_Movimiento = 'S'
        AND  LTD.linea_transsaccion = 'LINSIS'
        AND  LT.numerooperacion  = numdocu
        AND  fecha_proceso = @dfecha_proceso_rpt AND codigo_cartera = 'CI'
      GROUP BY p.instser, c.clnombre

   END

   IF EXISTS(SELECT 1 FROM #PACTO_TEMP)
   BEGIN

      SELECT 'nombre_cliente' = SUBSTRING(nombre_cliente, 1, 30)
         ,   'nombre_papel'   = nombre_papel
         ,   'monto_pacto'    = monto_pacto
         ,   'numero_fila'    = numero_fila
         ,   'existen_datos'  = 'S'
         ,   'fecha_reporte'  = CONVERT(CHAR(10), @dFecha_Proceso_Rpt, 103)
	 ,   'Moneda_Control' = @cMoneda_Control
      FROM #PACTO_TEMP
      ORDER BY  nombre_cliente, nombre_papel

   END ELSE BEGIN

      SELECT 'nombre_cliente' = CONVERT(CHAR(70),' ')
         ,   'nombre_papel'   = CONVERT(CHAR(12),' ')
         ,   'monto_pacto'    = 0.0
         ,   'numero_fila'    = 0
         ,   'existen_datos'  = 'N'
         ,   'fecha_reporte'  = CONVERT(CHAR(10), @dFecha_Proceso_Rpt, 103)
	 ,   'Moneda_Control' = @cMoneda_Control
   END

   SET NOCOUNT OFF

END

GO
