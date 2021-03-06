USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_CRED_RELACIONADOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INF_CRED_RELACIONADOS]
   (   @Usuario   VARCHAR(15)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaEmision VARCHAR(10)
       SET @dFechaEmision = CONVERT(CHAR(10),GETDATE(),103)
   DECLARE @dFechaProceso VARCHAR(10)
       SET @dFechaProceso = (SELECT CONVERT(CHAR(10),acfecproc,103) FROM BacTraderSuda.dbo.MDAC with(nolock) )
   DECLARE @dHoraEmision  VARCHAR(10)
       SET @dHoraEmision  = CONVERT(CHAR(10),GETDATE(),108)

   SELECT NumCredito          = rel.Numero_Credito
   ,      NumDerivado         = car.canumoper
   ,      Producto            = CONVERT(CHAR(25), pro.descripcion) --> car.cacodpos1
   ,      Fecha               = car.cafecha
   ,      RutCliente          = car.cacodigo
   ,      CodCliente          = car.cacodcli
   ,      Cliente             = cli.clnombre
   ,      TOperacion          = CASE WHEN car.catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
   ,      Modalidad           = CASE WHEN car.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
   ,      Moneda              = mon.mnnemo
   ,      TipoCambio          = CONVERT(NUMERIC(21,4), car.catipcam  )
   ,      MontoOrigen         = CONVERT(NUMERIC(21,4), car.camtomon1 )
   ,      MontoConversion     = CONVERT(NUMERIC(21,4), car.camtomon2 )
   ,      Vencimiento         = car.cafecvcto
   ,      vRazonable          = CONVERT(NUMERIC(21,4), car.fval_obtenido )
   ,      Origen              = 'BAC-FORWARD'
   INTO   #TBL_RETORNO_CONSULTA
   FROM   BacFwdSuda.dbo.MFCA                                   car with(nolock) 
          INNER JOIN BacParamSuda.dbo.RELACION_CREDITO_DERIVADO rel with(nolock) ON rel.Numero_Derivado = car.canumoper
          LEFT  JOIN BacParamSuda.dbo.CLIENTE                   cli with(nolock) ON cli.clrut = car.cacodigo AND cli.clcodigo = car.cacodcli
          LEFT  JOIN BacParamSuda.dbo.MONEDA                    mon with(nolock) ON mon.mncodmon   = car.cacodmon1
          LEFT  JOIN BacParamSuda.dbo.PRODUCTO                  pro with(nolock) ON pro.id_sistema = rel.Modulo_Derivado and pro.codigo_producto = car.cacodpos1
   WHERE  rel.Modulo_Derivado = 'BFW'

   UNION

   SELECT NumCredito          = rel.Numero_Credito
   ,      NumDerivado         = car.numero_operacion
   ,      Producto            = CONVERT(CHAR(25), pro.descripcion)
   ,      Fecha               = car.fecha_cierre
   ,      RutCliente          = car.rut_cliente
   ,      CodCliente          = car.codigo_cliente
   ,      Cliente             = cli.clnombre
   ,      TOperacion          = CASE WHEN car.tipo_operacion = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
   ,      Modalidad           = CASE WHEN car.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
   ,      Moneda              = mon.mnnemo
   ,      TipoCambio          = CONVERT(NUMERIC(21,4), car.compra_valor_tasa )
   ,      MontoOrigen         = CONVERT(NUMERIC(21,4), car.compra_capital )
   ,      MontoConversion     = CONVERT(NUMERIC(21,4), car.compra_saldo )
   ,      Vencimiento         = car.fecha_termino
   ,      vRazonable          = CONVERT(NUMERIC(21,4), car.Activo_FlujoCLP )
   ,      Origen              = 'BAC-SWAP'
   FROM   BacSwapSuda.dbo.CARTERA car with(nolock)
          INNER JOIN (SELECT tmp.numero_operacion, Numero_Flujo = MIN(tmp.Numero_Flujo)
                        FROM BacSwapSuda.dbo.CARTERA tmp with(nolock)
                       WHERE tmp.estado    <> 'C'
                         and tmp.tipo_flujo = 1
                    GROUP BY tmp.numero_operacion) otr ON car.numero_operacion = otr.numero_operacion
                                                      and car.numero_flujo     = otr.numero_flujo
          INNER JOIN BacParamSuda.dbo.RELACION_CREDITO_DERIVADO rel with(nolock) ON rel.Numero_Derivado = car.numero_operacion
          LEFT  JOIN BacParamSuda.dbo.CLIENTE                   cli with(nolock) ON cli.clrut = car.rut_cliente AND cli.clcodigo = car.codigo_cliente
          LEFT  JOIN BacParamSuda.dbo.MONEDA                    mon with(nolock) ON mon.mncodmon = car.compra_moneda
          LEFT  JOIN BacParamSuda.dbo.PRODUCTO                  pro with(nolock) ON pro.id_sistema = rel.Modulo_Derivado 
                                                                                and pro.codigo_producto = CASE WHEN car.tipo_swap = 1 THEN 'ST'
                                                                                                               WHEN car.tipo_swap = 2 THEN 'SM'
                                                                                                               WHEN car.tipo_swap = 3 THEN 'FR'
                                                                                                               WHEN car.tipo_swap = 4 THEN 'SP'
                                                                                                          END
   WHERE rel.Modulo_Derivado = 'PCS'
     and car.estado         <> 'C'
     and car.tipo_flujo      = 1

   SELECT 'Usuario'         = @Usuario
   ,      'FechaEmision'    = @dFechaEmision
   ,      'FechaProceso'    = @dFechaProceso
   ,      'HoraEmisión'     = @dHoraEmision
   ,      'NumCredito'      = NumCredito
   ,      'NumDerivado'     = NumDerivado
   ,      'Producto'        = Producto
   ,      'Fecha'           = Fecha
   ,      'RutCliente'      = RutCliente
   ,      'CodCliente'      = CodCliente
   ,      'Cliente'         = Cliente
   ,      'TOperacion'      = TOperacion
   ,      'Modalidad'       = Modalidad
   ,      'Moneda'          = Moneda
   ,      'TipoCambio'      = TipoCambio
   ,      'MontoOrigen'     = MontoOrigen
   ,      'MontoConversion' = MontoConversion
   ,      'Vencimiento'     = Vencimiento
   ,      'vRazonable'      = vRazonable
   ,      'Origen'          = Origen
   FROM   #TBL_RETORNO_CONSULTA

END
GO
