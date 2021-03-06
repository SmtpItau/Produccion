USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONESFRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_OPERACIONESFRA]( 
                   @NumOpe NUMERIC(10) = 0 )
AS
BEGIN

SELECT 'Operacion'= numero_operacion         ,						-- 1
       'codCart'  = cartera_inversion        ,						-- 2
       'Cartera'  = ISNULL(a.tbglosa, '***') ,						-- 3
       'codTipo'  = Tipo_Operacion           ,						-- 4
       'Tipo'     = CASE Tipo_Operacion WHEN 'C' THEN 'Compra' ELSE 'Venta' END,        -- 5
       'CodCli'   = codigo_cliente           ,						-- 6
       'Rut'      = rut_cliente   ,					-- 7
       'DV'       = ISNULL(b.cldv ,'*')            ,					-- 8
       'Cliente'  = ISNULL(b.clnombre,'*********') ,					-- 9
       'Cierre'   = CONVERT(CHAR(10),fecha_cierre      ,103),				-- 10
       'Inicio'   = CONVERT(CHAR(10),fecha_inicio_flujo,103),				-- 11
       'Vence'    = CONVERT(CHAR(10),fecha_vence_flujo ,103),				-- 12
       'Liquida'  = CONVERT(CHAR(10),fecha_termino     ,103),				-- 13
       'codMon'   = compra_moneda            ,				                -- 14
       'Moneda'   = ISNULL(c.mnnemo, '***')  ,				                -- 15
       'Capital'  = compra_capital           ,				                -- 16
       'codTasa'  = CASE tipo_operacion WHEN 'V' THEN compra_codigo_tasa       
						 ELSE venta_codigo_tasa END,		-- 17
       'Tasa'     = ISNULL(d.tbglosa, '***') ,				                -- 18
       'Contrato' = CASE tipo_operacion WHEN 'V' THEN compra_valor_tasa 
                                                 ELSE venta_valor_tasa  END,            -- 19
       'codPer'   = compra_codamo_interes    ,				                -- 20
       'Periodo'  = ISNULL(e.glosa, '***')   ,				                -- 21
       'dPeriodo' = ISNULL(e.dias , 0)       ,				                -- 22
       'mPeriodo' = ISNULL(e.meses, 0)       ,				                -- 23
       'codFPago' = pagamos_documento        ,				                -- 24
       'FPago'    = ISNULL(f.glosa2, '***')  ,				                -- 25
       'Trader'   = operador                 ,				                -- 26
       'codEstado'= estado                   ,				                -- 27
       'Estado'   = CASE WHEN estado = 'M' THEN 'Modify'
                         WHEN estado = 'A' THEN 'Deleted' ELSE '' END	,		-- 28
       'CodOperador'= Operador_cliente	 ,      
	'CodMonedaPago' = pagamos_moneda
       
FROM   Cartera      
       LEFT JOIN view_tabla_general_detalle a ON a.TBCATEG			= 1004		 AND cartera_inversion		= a.TBCODIGO1   -- Cartera de Inversiones  
       LEFT JOIN view_cliente				b ON codigo_cliente		= b.clcodigo AND rut_cliente			= b.clrut  
       LEFT JOIN view_moneda				c ON compra_moneda		= c.mncodmon  
       LEFT JOIN view_tabla_general_detalle d ON d.TBCATEG			= 1042		 AND (CASE tipo_operacion WHEN 'V' THEN compra_codigo_tasa ELSE venta_codigo_tasa END) = d.TBCODIGO1   -- Tasas  
       LEFT JOIN View_Periodo_Amortizacion  e ON e.tabla			= 1044		 AND compra_codamo_interes	= e.codigo   -- Amortizacion de Intereses  
       LEFT JOIN view_forma_de_pago			f ON pagamos_documento	= f.codigo   -- Formas de Pago  


 WHERE tipo_swap = 3
   AND (@NumOpe = 0 OR numero_operacion = @NumOpe)
END
GO
