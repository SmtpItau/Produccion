USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_LINEAS_RETENIDAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_LINEAS_RETENIDAS]
   (   @dFecha      DATETIME   
   ,   @Usuario     VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @ifound   INTEGER

   SELECT  @ifound   = 0
   SELECT  @ifound   = 1
   FROM    LINEAS_RETENIDAS
   WHERE   estado_liberacion IN('S')
   
   IF @ifound = 1
   BEGIN
      SELECT /*001*/ 'Fecha'        = lin.fecha_pago
      ,      /*002*/ 'Sistema'      = ltrim(rtrim(lin.id_Sistema))      + ' - ' + ltrim(rtrim(cnt.nombre_sistema))
      ,      /*003*/ 'Producto'     = ltrim(rtrim(lin.codigo_producto)) + ' - ' + case when ltrim(rtrim(lin.codigo_producto)) = 'VC' THEN 'VENCIMIENTO CUPON' ELSE ltrim(rtrim(pro.descripcion)) END
      ,      /*004*/ 'Operacion'    = CASE WHEN lin.tipo_operacion = 'VC' THEN 'VENCIMIENTO' ELSE isnull(ltrim(rtrim(tip.descripcion)),'') END
      ,      /*005*/ 'Cliente'      = ltrim(rtrim(cli.clnombre))
      ,      /*006*/ 'Rut'          = lin.rut_cliente
      ,      /*007*/ 'NumOper'      = lin.numero_operacion
      ,      /*008*/ 'Monto'        = lin.monto_linea
      ,      /*009*/ 'Tir'          = lin.tir
      ,      /*016*/ 'CodFormaPago' = lin.forma_pago
      ,      /*010*/ 'FPago'        = case when lin.forma_pago        = 0   then 'NO DEFINIDA' else upper(pag.glosa) end
      ,      /*011*/ 'Estado'       = case when lin.estado_liberacion = 'N' then 'RETENIDA'    else 'LIBERADA'       end
      ,      /*012*/ 'FechaProceso' = CONVERT(CHAR(10),@dFecha,103)
      ,      /*013*/ 'FechaEmision' = CONVERT(CHAR(10),GETDATE(),103)
      ,      /*014*/ 'HoraEmision'  = CONVERT(CHAR(10),GETDATE(),108)
      ,      /*015*/ 'Usuario'      = UPPER(LTRIM(RTRIM(@Usuario)))
      FROM   LINEAS_RETENIDAS lin  LEFT JOIN bacparamsuda..SISTEMA_CNT   cnt ON lin.id_sistema       = cnt.id_sistema
                                   LEFT JOIN bacparamsuda..PRODUCTO      pro ON lin.id_sistema       = pro.id_sistema AND pro.codigo_producto = CASE WHEN lin.id_sistema = 'BEX' THEN lin.codigo_Producto --lin.tipo_operacion
                                                                                                                                                     ELSE                             lin.codigo_Producto
                                                                                                                                                END 
                                   LEFT JOIN bacparamsuda..PRODUCTO      tip ON lin.id_sistema       = tip.id_sistema AND tip.codigo_producto = CASE WHEN lin.id_sistema = 'BTR' THEN lin.tipo_operacion
                                                                                                                                                     ELSE                             lin.tipo_operacion
                                                                                                                                                END
                                   LEFT JOIN bacparamsuda..CLIENTE       cli ON lin.rut_cliente      = cli.clrut      AND lin.cod_cliente     = cli.clcodigo
                                   LEFT JOIN bacparamsuda..FORMA_DE_PAGO pag ON lin.forma_pago       = pag.codigo
      WHERE  lin.estado_liberacion IN('S')
      ORDER BY lin.id_sistema , lin.Fecha , lin.rut_cliente , lin.cod_cliente , lin.numero_operacion , lin.monto_linea
   END

   IF @ifound = 0
   BEGIN
      SELECT /*001*/ 'Fecha'        = @dFecha
      ,      /*002*/ 'Sistema'      = ' '
      ,      /*003*/ 'Producto'     = ' '
      ,      /*004*/ 'Operacion'    = ' '
      ,      /*005*/ 'Cliente'      = ' '
      ,      /*006*/ 'Rut'          = 0
      ,      /*007*/ 'NumOper'      = 0
      ,      /*008*/ 'Monto'        = 0.0
      ,      /*009*/ 'Tir'          = 0.0
      ,      /*016*/ 'CodFormaPago' = 0
      ,      /*010*/ 'FPago'        = ''
      ,      /*011*/ 'Estado'       = ''
      ,      /*012*/ 'FechaProceso' = CONVERT(CHAR(10),@dFecha,103)
      ,      /*013*/ 'FechaEmision' = CONVERT(CHAR(10),GETDATE(),103)
      ,      /*014*/ 'HoraEmision'  = CONVERT(CHAR(10),GETDATE(),108)
      ,      /*015*/ 'Usuario'      = UPPER(LTRIM(RTRIM(@Usuario)))
   END

END
GO
