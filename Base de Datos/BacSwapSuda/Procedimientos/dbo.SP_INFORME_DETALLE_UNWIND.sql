USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_DETALLE_UNWIND]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_DETALLE_UNWIND]
   (   @nContrato   NUMERIC(9)   )
AS
BEGIN

   SET NOCOUNT ON

   -->     1.0 Lee la fecha de hoy para el anticipo
   DECLARE @dFechaHoy         DATETIME
       SET @dFechaHoy         = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

   DECLARE @dFechaProceso     CHAR(10)
       SET @dFechaProceso     = CONVERT(CHAR(10), @dFechaHoy, 103)

   DECLARE @dFechaEmicion     CHAR(10)
       SET @dFechaEmicion     = CONVERT(CHAR(10), GETDATE(), 103)

   DECLARE @dHoraEmision      CHAR(10)
       SET @dHoraEmision      = CONVERT(CHAR(10), GETDATE(), 108)

   CREATE TABLE #MiTablaContrato
      	(    marca		 VARCHAR(25)
     	 ,   numero_operacion    NUMERIC(10)
    	 ,   numero_flujo        NUMERIC(10)
    	 ,   Producto            VARCHAR(40)
     	 ,   RutCliente          NUMERIC(10)
     	 ,   CodCliente          INTEGER
     	 ,   NomCliente          VARCHAR(100)
     	 ,   dvCliente           CHAR(1)
     	 ,   Modalidad           CHAR(25)
     	 ,   MonedaAvr           CHAR(10)
     	 ,   ValorRazonable      FLOAT
     	 ,   Moneda	      	 CHAR(10)
      	 ,   Monto		 FLOAT	
      	 ,   frecpago	      	 CHAR(25)
      	 ,   freccapital         CHAR(25)
      	 ,   indicador           CHAR(25)
      	 ,   valorindice	 FLOAT
      	 ,   spread	      	 FLOAT
     	 ,   conteodias	      	 CHAR(25)
      	 ,   MonPago	      	 CHAR(25)
      	 ,   MedioPago	      	 CHAR(25)
      	 ,   fechainicio	 DATETIME
      	 ,   fechatermino	 DATETIME
      	 ,   avr		 FLOAT
      	)


   INSERT INTO #MiTablaContrato
   SELECT 'Marca'	  = 'Cartera Vigente'
      ,   'NumOperacion'  = CAR.numero_operacion
      ,   'Numero_flujo'  = CAR.numero_flujo
      ,   'Producto'   	  = CASE WHEN CAR.tipo_swap = 1 THEN 'SWAP DE TASAS'
                                 WHEN CAR.tipo_swap = 2 THEN 'SWAP DE MONEDAS'
                                 WHEN CAR.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'
                                 WHEN CAR.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'
                            END
      ,   'RutCliente'    = CLI.clrut
      ,   'CodCliente'    = CLI.clcodigo
      ,   'NomCliente'    = SUBSTRING(CLI.clnombre, 1, 50)
      ,   'dvCliente '    = CLI.cldv
      ,   'Modalidad'     = CASE WHEN CAR.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FIS.' END
      ,   'MonedaAvr'     = 'CLP'
      ,   'AvrContrato'   = CAR.valor_razonableclp
      ,   'moneda'	  = mon.mnnemo
      ,   'monto'	  = CASE WHEN car.tipo_flujo = 1  THEN car.compra_capital    ELSE car.venta_capital END 
      ,   'frecpago'	  = pago.glosa
      ,   'freccapital'	  = capt.glosa
      ,   'indicador'	  = Indi.tbglosa
      ,   'valorindice'	  = CASE WHEN car.tipo_flujo = 1  THEN car.compra_valor_tasa ELSE car.venta_valor_tasa END
      ,   'spread'	  = CASE WHEN car.tipo_flujo = 1  THEN car.compra_spread     ELSE car.venta_spread     END
      ,   'conteodias'	  = baas.glosa
      ,   'MonPago'	  = monpago.mnnemo
      ,   'MedioPago'	  = docpago.glosa
      ,   'fechainicio'	  = car.fecha_inicio_flujo
      ,   'fechatermino'  = car.fecha_vence_flujo
      ,   'avr'	          = CASE WHEN car.tipo_flujo = 1  THEN car.activo_flujoclp else car.pasivo_flujoclp    END
   FROM   BacSwapSuda.dbo.CARTERA  CAR
          INNER JOIN (SELECT numero_operacion AS a, MIN(numero_flujo) AS b, tipo_flujo AS c 
                        FROM BacSwapSuda.dbo.CARTERA
		    GROUP BY numero_operacion, tipo_flujo) unwind ON unwind.a         = car.numero_operacion
							         AND unwind.b         = car.numero_flujo
							         AND unwind.c         = car.tipo_flujo
           LEFT JOIN BacParamSuda.dbo.CLIENTE CLI 	          ON CLI.clrut        = CAR.rut_cliente AND CLI.clrut = CAR.rut_cliente
           LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION   pago ON pago.Tabla       = 1044 AND pago.codigo    = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codamo_interes ELSE car.venta_codamo_interes END
           LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION   capt ON capt.Tabla       = 1043 AND capt.codigo    = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codamo_capital ELSE car.venta_codamo_capital END
           LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE  Indi ON Indi.tbcateg     = 1042 AND Indi.tbcodigo1 = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codigo_tasa    ELSE car.venta_codigo_tasa    END
           LEFT JOIN BacSwapSuda.dbo.BASE                    baas ON baas.codigo      = CASE WHEN car.tipo_flujo = 1 THEN car.compra_base         ELSE car.venta_base        END
           LEFT JOIN BacParamSuda.dbo.MONEDA              monpago ON monpago.mncodmon = CASE WHEN car.tipo_flujo = 1 THEN car.recibimos_moneda    ELSE car.pagamos_moneda    END
           LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO       docpago ON docpago.codigo   = CASE WHEN car.tipo_flujo = 1 THEN car.recibimos_documento ELSE car.pagamos_documento END
	   LEFT JOIN BacParamSuda.dbo.MONEDA                  mon ON mon.mncodmon     = CASE WHEN car.tipo_flujo = 1 THEN car.compra_moneda       ELSE car.venta_moneda      END
   WHERE   car.numero_operacion = @nContrato

   SELECT 'NumeroOpe'		= @nContrato
      ,   'Proceso' 		= @dFechaProceso
      ,   'Emision' 		= @dFechaEmicion
      ,   'Hora'    		= @dHoraEmision
      ,   'Marca' 		= 'Cartera Vigente'
      ,   'fecha_inicio_flujo' 	= ''
      ,   'fecha_vence_flujo' 	= ''
      ,   'fechaanticipo' 	= ''
      ,   'numero_flujo' 	= 0
      ,   'tipo_flujo' 		= 0
      ,   'moneda' 		= Moneda
      ,   'capital' 		= Monto
      ,   'frecpago' 		= frecpago
      ,   'freccapital' 	= freccapital
      ,   'indicador' 		= indicador
      ,   'valorindice' 	= valorindice
      ,   'spread' 		= spread
      ,   'conteodias' 		= conteodias
      ,   'MonPago' 		= MonPago
      ,   'MedioPago' 		= MedioPago
      ,   'fechainicio'		= fechainicio
      ,   'fechatermino'	= fechatermino
      ,   'avr' 		= avr
      ,   'RutCliente'          = RutCliente
      ,   'CodCliente'          = CodCliente
      ,   'NomCliente'          = NomCliente
      ,   'dvCliente'           = dvCliente
      ,   'Modalidad'           = Modalidad
      ,   'MonedaAvr'           = MonedaAvr
      ,   'Mda_Unwind' 		= 0
      ,   'CAPITAL_unwind'	= 0
      ,   'AMORTIZA_unwind'	= 0
      ,   'SALDO_unwind'	= 0
      ,   'Interes_Unwind'	= 0
      ,   'AdicionalFlujo'      = 0
      ,   'AVRFlujo'            = 0
      ,   'ValorRazonable'	= ValorRazonable
	  ,      'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
   FROM   #MiTablaContrato

      UNION ALL

   SELECT 'NumeroOpe'		= @nContrato
      ,   'Proceso' 		= @dFechaProceso
      ,   'Emision' 		= @dFechaEmicion
      ,   'Hora'    		= @dHoraEmision  
      ,   'MARCA'   		= 'Detalle Cartera'
      ,   'fecha_inicio_flujo' 	= convert(char(10),CAR.fecha_inicio_flujo,103)
      ,   'fecha_vence_flujo' 	= convert(char(10),CAR.fecha_vence_flujo,103)
      ,   'fechaanticipo' 	= convert(char(10),CAR.fechaanticipo,103)
      ,   'numero_flujo' 	= CAR.numero_flujo
      ,   'tipo_flujo'		= CAR.tipo_flujo
      ,   'moneda' 		= ''
      ,   'capital' 		= 0
      ,   'frecpago' 		= ''
      ,   'freccapital' 	= ''
      ,   'indicador' 		= ''
      ,   'valorindice' 	= 0
      ,   'spread' 		= 0
      ,   'conteodias' 		= ''
      ,   'MonPago' 		= ''
      ,   'MedioPago' 		= ''
      ,   'fechainicio'		= ''
      ,   'fechatermino'	= ''
      ,   'avr' 		= 0
      ,   'RutCliente'		= 0
      ,   'CodCliente'		= 0
      ,   'NomCliente'		= ''
      ,   'dvCliente'		= ''
      ,   'Modalidad '		= ''
      ,   'MonedaAvr'		= ''
      ,   'Mda_Unwind' 		= (CASE WHEN CAR.tipo_flujo=1 THEN CAR.compra_moneda 	      ELSE CAR.venta_moneda  	     END)   
      ,   'CAPITAL_unwind'	= (CASE WHEN CAR.tipo_flujo=1 THEN CAR.compra_capital 	      ELSE CAR.venta_capital         END)   
      , 'AMORTIZA_unwind'	= (CASE WHEN CAR.tipo_flujo=1 THEN CAR.compra_amortiza 	      ELSE CAR.venta_amortiza 	     END)
      ,   'SALDO_unwind'	= (CASE WHEN CAR.tipo_flujo=1 THEN CAR.compra_saldo 	      ELSE CAR.venta_saldo 	     END)
      ,   'Interes_Unwind'	= (CASE WHEN CAR.tipo_flujo=1 THEN CAR.compra_interes 	      ELSE CAR.venta_interes 	     END)
      ,   'AdicionalFlujo'      = (CASE WHEN car.tipo_flujo=1 THEN car.compra_flujo_adicional ELSE car.venta_flujo_adicional END)
      ,   'AVRFlujo'            = (CASE WHEN car.tipo_flujo=1 THEN car.activo_flujoclp        ELSE car.pasivo_flujoclp       END)
      ,   'ValorRazonable'	= 0
	  ,      'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
   FROM   BacSwapSuda.dbo.CARTERA_UNWIND  CAR 
          INNER JOIN (SELECT numero_operacion AS a, MIN(numero_flujo) AS b, tipo_flujo AS c 
			FROM BacSwapSuda.dbo.CARTERA_UNWIND 
                    GROUP BY numero_operacion, tipo_flujo) unwind ON unwind.a = car.numero_operacion
							         and unwind.b = car.numero_flujo
							         and unwind.c = car.tipo_flujo
   WHERE  CAR.numero_operacion  = @nContrato

END

GO
