USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CRED_RELACIONADOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_CRED_RELACIONADOS]
AS
BEGIN

   SET NOCOUNT ON

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
   ,      FechaRelacion       = rel.Fecha_Relacion
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
   ,      FechaRelacion       = rel.Fecha_Relacion
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


   UNION

   SELECT	    NumCredito          = rel.Numero_Credito     
        ,       NumDerivado         = Det.CaNumContrato		    
        ,       Producto            = CONVERT(CHAR(25), 'OPCIONES')
        ,       Fecha               = Enc.CaFechaContrato
        ,       RutCliente          = Enc.CaRutCliente
        ,       CodCliente          = Enc.CaCodigo
        ,       Cliente             = cli.clnombre
        ,       TOperacion          = CASE WHEN Det.CaCVOpc = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END      
        ,       Modalidad           = CASE WHEN Det.CaModalidad = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END  
        ,       Moneda              = mon.mnnemo
        ,       TipoCambio          = 0.0
        ,       MontoOrigen         = CONVERT(NUMERIC(21,4), Det.CaMontoMon1 )
        ,       MontoConversion     = CONVERT(NUMERIC(21,4), Det.CaMontoMon2 )
        ,       Vencimiento         = Det.CaFechaVcto
        ,       vRazonable          = CONVERT(NUMERIC(21,4), Det.CaVrDet )
        ,       Origen              = 'OPCIONES'     
        ,       FechaRelacion       = rel.Fecha_Relacion   
		FROM	Lnkopc.CbmdbOpc.dbo.cadetcontrato Det
				INNER JOIN Lnkopc.CbmdbOpc.dbo.CaEncContrato Enc ON	Enc.CaNumContrato = Det.CaNumContrato 
				INNER JOIN Lnkopc.CbmdbOpc.dbo.OpcionEstructura Est ON	Est.OpcEstCod = Enc.CaCodEstructura 
				INNER JOIN Bacparamsuda..Cliente  Cl ON	Enc.CaRutCliente = Cl.Clrut 
												   AND  Enc.CaCodigo     = Cl.Clcodigo
                INNER JOIN BacParamSuda.dbo.RELACION_CREDITO_DERIVADO rel with(nolock) ON rel.Numero_Derivado = Enc.CaNumContrato
				LEFT  JOIN BacParamSuda.dbo.CLIENTE                   cli with(nolock) ON cli.clrut = Enc.CaRutCliente AND cli.clcodigo = Enc.CaCodigo
                LEFT  JOIN BacParamSuda.dbo.MONEDA                    mon with(nolock) ON mon.mncodmon   = Det.CaCodMon1
--                LEFT  JOIN BacParamSuda.dbo.PRODUCTO                  pro with(nolock) ON pro.id_sistema = rel.Modulo_Derivado and pro.codigo_producto = car.cacodpos1
         WHERE  rel.Modulo_Derivado = 'OPC' 

         ORDER BY FechaRelacion, Producto




END
GO
