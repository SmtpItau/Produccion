USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETAFRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELETAFRA]( 
          @NumOpe NUMERIC(10) )
AS

/******************************************************************/
DECLARE        @Firma1 char(15)
DECLARE        @Firma2 char(15) 
DECLARE        @sMooper char(15)
DECLARE        @sMoterm char(15)	

   Select @Firma1 = res.Firma1,
	@Firma2 = res.Firma2,
	@sMooper = ori.mooper,
	@sMoterm = ori.moterm
	From	BacLineas..detalle_aprobaciones res
			LEFT JOIN BaccamSuda..memo ori ON ori.MONUMOPE  = res.Numero_Operacion  
	Where res.Numero_Operacion= @NumOpe
/******************************************************************/

BEGIN

SELECT 'Nro'      = car.numero_operacion    ,
       'Cartera'  = (SELECT IsNull(rcnombre,'') FROM BacParamSuda..TIPO_CARTERA WHERE rcsistema = 'PCS' and rccodpro = 'FR' And  rcrut = cartera_inversion ),	
       'Tipo'     = CASE car.Tipo_Operacion WHEN 'C' THEN 'Compra' ELSE 'Venta' END,
       'Rut'      = ISNULL(CONVERT(NUMERIC(10),car.rut_cliente), car.codigo_cliente) ,
       'DV'       = ISNULL(b.cldv ,'*') ,
       'Cliente'  = ISNULL(b.clnombre,'******')  ,
       'Cierre'   = CONVERT(CHAR(10),fecha_cierre      ,103),
       'Liquida'  = CONVERT(CHAR(10),car.fecha_termino     ,103),
       'Inicio'   = CONVERT(CHAR(10),fecha_inicio_flujo,103),
       'Termino'  = CONVERT(CHAR(10),fecha_vence_flujo ,103),
       'PlazoFwd' = DATEDIFF(day, fecha_inicio_flujo, fecha_vence_flujo),
       'CodMon'   = compra_moneda,
       'Moneda'   = ISNULL(c.mnnemo, CONVERT(CHAR(5),compra_moneda)),
       'Capital'  = compra_capital         ,
       'Tasa'     = ISNULL(SUBSTRING(d.tbglosa,1,15), '***'),
       'Periodo'  = ISNULL(SUBSTRING(e.glosa  ,1,15), '***'),
       'Contrato' = CASE car.tipo_operacion WHEN 'V' THEN compra_valor_tasa ELSE venta_valor_tasa END,
       'FPago'    = ISNULL(f.glosa2, CONVERT(CHAR(10),pagamos_documento)),
       'Trader'   = car.operador ,
       'Hora'     = SUBSTRING(CONVERT( CHAR(20), GETDATE(),100),13,8) ,
       'Estado'   = CASE WHEN estado = 'M' THEN 'Modify'
                         WHEN estado = 'A' THEN 'Deleted' ELSE '' END,
       'NomBco'     = ISNULL((SELECT Nombre FROM SwapGeneral),'***'),
       'NomOperador' = ISNULL((Op.opNombre),'No Encontrado') ,
       'RutOperador' = RTRIM(ISNULL(CONVERT(CHAR(10),Op.oprutope),'*')) + '-' + ISNULL(CONVERT(CHAR(10),op.opdvope),'*'), 
       'MonedaPago' = ISNULL((mp.MNGLOSA ),'***'),
	@Firma1 as 'Firma1',
	@Firma2 as 'Firma2',
	@sMooper as 'sMooper',
	@sMoterm as 'sMoterm'
	
  FROM 	Cartera   car 
       	LEFT JOIN view_cliente                b ON car.codigo_cliente = b.clcodigo         AND car.rut_cliente    = b.clrut
       	LEFT JOIN view_moneda                 c ON compra_moneda      = c.mncodmon
       	LEFT JOIN view_tabla_general_detalle  d ON d.TBCATEG          = 1042               AND (CASE car.tipo_operacion WHEN 'V' THEN compra_codigo_tasa ELSE venta_codigo_tasa END) = d.TBCODIGO1	-- Tasas
       	LEFT JOIN View_Periodo_Amortizacion   e ON e.tabla            = 1044               AND compra_codamo_interes = e.codigo	-- Amortizacion de Intereses
       	LEFT JOIN view_forma_de_pago          f ON pagamos_documento  = f.codigo	       -- Formas de Pago
	    LEFT JOIN View_Cliente_Operador      Op ON Op.opcodcli        = car.codigo_cliente And op.oprutope  = car.operador_cliente	-- Operadores
	    LEFT JOIN view_moneda                mp ON pagamos_moneda     = mp.mncodmon	        -- Moneda pago

 WHERE tipo_swap = 3
   AND (@NumOpe = 0 OR car.numero_operacion = @NumOpe)

END     
GO
