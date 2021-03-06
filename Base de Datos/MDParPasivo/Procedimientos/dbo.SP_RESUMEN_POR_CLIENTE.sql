USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESUMEN_POR_CLIENTE]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RESUMEN_POR_CLIENTE]
   (   @Cliente          NUMERIC(10) = 0
   ,   @Codigo_Cliente   NUMERIC(10) = 0
   )
AS
BEGIN

 	SET DATEFORMAT dmy
 	SET NOCOUNT ON

   DECLARE @MonedaControl  NUMERIC(03)
   DECLARE @FechaProceso   DATETIME

   SELECT @MonedaControl = moneda_control
      ,   @FechaProceso  = fecha_proceso
   FROM DATOS_GENERALES

   IF EXISTS(SELECT 1 FROM LINEA_SISTEMA
             WHERE  (rut_cliente    = @Cliente        OR @Cliente        = 0)
               AND  (codigo_cliente = @Codigo_Cliente OR @Codigo_Cliente = 0))
   BEGIN

      SELECT DISTINCT 'TITULO' = 'RESUMEN POR CLIENTE AL ' + CONVERT(CHAR(10),@FechaProceso,103)
         ,   'RUT_CLIENTE'     = LS.rut_cliente
         ,   'NOMBRE_CLIENTE'  = C.clnombre
         ,   'DV_CLIENTE'      = '- ' + C.cldv
         ,   'CODIGO_GRUPO'    = LS.codigo_grupo
         ,   'ASIGNADO'        = ISNULL((SELECT SUM(montooriginal) FROM LINEA_TRANSACCION LT, LINEA_TRANSACCION_DETALLE LTD
                                        WHERE  LT.rut_cliente     = LS.rut_cliente
                                        AND  LT.codigo_cliente  = LS.codigo_cliente
                                        AND  LT.codigo_grupo    = LS.codigo_grupo
                                        AND  LT.codigo_grupo    = LTD.codigo_grupo
                                        AND  LT.numerooperacion = LTD.numerooperacion
					AND  LT.FechaVencimiento   > @FechaProceso
                                        AND  LT.numerocorrelativo = ltd.numerocorrelativo
                                        AND  LTD.Tipo_Detalle= 'L'
                                        AND  LTD.Tipo_Movimiento = 'S'
                                        AND  LTD.linea_transsaccion = 'LINSIS'),0)

         ,   'OCUPADO'         = SUM(totalocupado)
         ,   'LIMITE'          = SUM(totalasignado)
         ,   'DISPONIBLE'      = SUM(totaldisponible)
         ,   'MONEDA_CONTROL'  = @MonedaControl
         ,   'NOMBRE_MONEDA'   = (SELECT mnnemo FROM MONEDA WHERE mncodmon = @MonedaControl)
      FROM   LINEA_SISTEMA LS, 
             CLIENTE C 
      WHERE  (LS.rut_cliente    = @Cliente        OR @Cliente        = 0)
        AND  (LS.codigo_cliente = @Codigo_Cliente OR @Codigo_Cliente = 0)
        AND  LS.rut_cliente = C.clrut AND LS.codigo_cliente = C.clcodigo

     GROUP BY LS.rut_cliente
         ,    LS.codigo_grupo
         ,    C.cldv
         ,    C.clnombre
         ,    LS.codigo_cliente

   END ELSE BEGIN

      SELECT 'TITULO'          = 'RESUMEN POR CLIENTE AL ' + CONVERT(CHAR(10),@FechaProceso,103)
         ,   'RUT_CLIENTE'     = ' '
         ,   'NOMBRE_CLIENTE'  = ' '
         ,   'DV_CLIENTE'      = ' '
         ,   'CODIGO_GRUPO'    = ' '
         ,   'ASIGNADO'        = 0.0
         ,   'OCUPADO'         = 0.0
         ,   'LIMITE'          = 0.0
         ,   'DISPONIBLE'      = 0.0
         ,   'MONEDA_CONTROL'  = @MonedaControl
         ,   'NOMBRE_MONEDA'   = (SELECT mnnemo FROM MONEDA WHERE mncodmon = @MonedaControl)

   END

END
GO
