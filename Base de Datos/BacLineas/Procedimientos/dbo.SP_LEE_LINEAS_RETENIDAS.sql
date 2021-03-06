USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_LINEAS_RETENIDAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_LINEAS_RETENIDAS]
   (   @dFecha      DATETIME   
   ,   @cSistema    CHAR(3)    = ''
   ,   @cProducto   VARCHAR(5) = ''
   ,   @iEstadfo    CHAR(1)    = ''
   ,   @iRutCliente NUMERIC(9) = 0
   ,   @iCodCliente NUMERIC(9) = 0
   ,   @iFPago      NUMERIC(3) = 0
   ,   @Usuario     VARCHAR(15)= ''
   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT /*001*/ 'Fecha'     = lin.fecha_pago
   ,      /*002*/ 'Sistema'   = ltrim(rtrim(lin.id_Sistema))      + ' - ' + ltrim(rtrim(cnt.nombre_sistema))
   ,      /*003*/ 'Producto'  = ltrim(rtrim(lin.codigo_producto)) + ' - ' + CASE WHEN tipo_operacion                    = 'ICOL' THEN 'VENCIMIENTO INTERBANCARIO' 
                                                                                 WHEN tipo_operacion                    = 'ICAP' THEN 'VENCIMIENTO INTERBANCARIO' 
                                                                                 WHEN ltrim(rtrim(lin.codigo_producto)) = 'VC'   THEN 'VENCIMIENTO CUPON' 
                                                                                 ELSE                                                 ltrim(rtrim(pro.descripcion)) 
                                                                            END
   ,      /*004*/ 'Operacion' = CASE WHEN lin.id_Sistema = 'BCC' THEN CASE WHEN lin.tipo_operacion = 'C' THEN 'COMPRA' ELSE 'VENTA' END
                                     ELSE CASE WHEN lin.tipo_operacion = 'VC' THEN 'VENCIMIENTO' ELSE ISNULL(LTRIM(RTRIM( tip.descripcion)),'') END
                                END
   ,      /*005*/ 'Cliente'   = ltrim(rtrim(cli.clnombre))
   ,      /*006*/ 'Rut'       = lin.rut_cliente
   ,      /*007*/ 'NumOper'   = lin.numero_operacion
   ,      /*008*/ 'Monto'     = lin.monto_linea
   ,      /*009*/ 'Tir'       = lin.tir
   ,      /*010*/ 'FPago'     = case when lin.forma_pago        = 0   then 'NO DEFINIDA' else upper(pag.glosa) end
   ,      /*011*/ 'Estado'    = case when lin.estado_liberacion = 'N' then 'RETENIDA'    else 'LIBERADA'       end
   ,      /*012*/ 'Modulo'    = lin.id_Sistema
   ,      /*013*/ 'Mercado'   = CASE WHEN tipo_operacion = 'ICOL' THEN 'ICOL'
                                     WHEN tipo_operacion = 'ICAP' THEN 'ICAP'
                                     ELSE                              lin.codigo_producto
                                END
   ,      /*014*/ 'TipCli'    = cltipcli
   ,      /*015*/ 'EstadoLib' = lin.estado_liberacion
   INTO   #TMP_RETORNO
   FROM   LINEAS_RETENIDAS lin  
          LEFT JOIN bacparamsuda..SISTEMA_CNT   cnt ON lin.id_sistema       = cnt.id_sistema
          LEFT JOIN bacparamsuda..PRODUCTO      pro ON lin.id_sistema       = pro.id_sistema AND pro.codigo_producto = CASE WHEN lin.id_sistema = 'BEX' THEN lin.codigo_producto ELSE lin.codigo_Producto END 
          LEFT JOIN bacparamsuda..PRODUCTO      tip ON lin.id_sistema       = tip.id_sistema AND tip.codigo_producto = CASE WHEN lin.id_sistema = 'BTR' THEN lin.tipo_operacion  ELSE lin.tipo_operacion  END
                                LEFT JOIN bacparamsuda..CLIENTE       cli ON lin.rut_cliente      = cli.clrut      AND lin.cod_cliente     = cli.clcodigo
                                LEFT JOIN bacparamsuda..FORMA_DE_PAGO pag ON lin.forma_pago       = pag.codigo
-- WHERE  lin.fecha_pago       <= @dFecha    
   WHERE  lin.Fecha            <= @dFecha
   and   (lin.estado_liberacion = @iEstadfo    OR @iEstadfo    = '')
   and   (lin.id_sistema        = @cSistema    OR @cSistema    = '')
   and   (lin.codigo_producto   = @cProducto   OR @cProducto   = '')
   and   (lin.rut_cliente       = @iRutCliente OR @iRutCliente = 0)
   and   (Lin.cod_cliente       = @iCodCliente OR @iCodCliente = 0)
   and   (Lin.forma_pago        = @iFPago      OR @iFPago      = 0)
   ORDER BY lin.id_sistema , lin.Fecha , lin.rut_cliente , lin.cod_cliente , lin.numero_operacion , lin.monto_linea

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = ( SELECT acfecant FROM BacCamSuda.dbo.MEAC )

   DELETE FROM #TMP_RETORNO
         WHERE EstadoLib  = 'S'
           and Fecha      < @dFechaProceso

   DELETE FROM #TMP_RETORNO
         WHERE Modulo NOT IN( SELECT DISTINCT sistema FROM BacLineas.dbo.PERFIL_USUARIO_LINEAS WHERE usuario = @Usuario AND activado = 1 )
   
   SELECT /*001*/ 'Fecha'     = tmp.Fecha
   ,      /*002*/ 'Sistema'   = tmp.Sistema
   ,      /*003*/ 'Producto'  = tmp.Producto
   ,      /*004*/ 'Operacion' = tmp.Operacion
   ,      /*005*/ 'Cliente'   = tmp.Cliente
   ,      /*006*/ 'Rut'       = tmp.Rut
   ,      /*007*/ 'NumOper'   = tmp.NumOper
   ,      /*008*/ 'Monto'     = tmp.Monto
   ,      /*009*/ 'Tir'       = tmp.Tir
   ,      /*010*/ 'FPago'     = tmp.FPago
   ,      /*011*/ 'Estado'    = tmp.Estado
   ,      /*012*/ 'Modulo'    = tmp.Modulo
   ,      /*013*/ 'Mercado'   = tmp.Mercado
   ,      /*013*/ 'TipCli'    = tmp.TipCli
   FROM   #TMP_RETORNO tmp
          INNER JOIN BacLineas.dbo.PERFIL_USUARIO_LINEAS usr with(nolock) ON usr.Usuario      = @Usuario
                                                                         and usr.Sistema      = tmp.Modulo
                                                                         and usr.Producto     = tmp.Mercado
                                                                         and usr.Tipo_Cliente = tmp.TipCli
                                                                         and usr.Activado     = 1
   ORDER BY tmp.Modulo, tmp.Fecha, tmp.Rut, tmp.NumOper, tmp.Monto
   
END


GO
