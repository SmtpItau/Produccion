USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_VENCIMIENTOS_XFLU]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTER_VENCIMIENTOS_XFLU]  
AS 
BEGIN 

	SET NOCOUNT ON
-- Swap: Guardar Como
	DECLARE @acfecha  CHAR(8)
	SELECT 	@acfecha = CONVERT(CHAR(8),fechaproc,112) FROM swapgeneral
--	SELECT 	@acfecha = '20030325'

	SELECT   
                'ctreg' = 2
		,'crut'  = STR(a.rut_cliente) + b.Cldv
		,'cref'  = a.numero_operacion
		,'ccope' = '00000'
		,'ccorr' = '00'
		,'cncua' = a.numero_flujo
		,'cntoc' = ISNULL((	SELECT '002'
					FROM 	cartera d 
					WHERE 	d.fecha_vence_flujo = @acfecha  AND
						d.tipo_flujo	    = 2 	AND
						a.numero_operacion  = d.numero_operacion ) ,'001')
		,'csepa' = 'M'   --
		,'cncep' = ISNULL(( SELECT meses FROM View_Periodo_Amortizacion WHERE a.compra_codamo_interes = codigo  AND sistema = 'PCS' AND tabla = 1044 ),0)
		,'cfven' = a.fecha_vence_flujo
		,'cvamo' = ROUND( ( a.compra_amortiza+a.compra_saldo )* (CASE 	WHEN a.compra_moneda = 999 
									THEN 1 
									ELSE ISNULL((SELECT vmvalor 
										     FROM   view_valor_moneda 
										     WHERE  vmfecha = @acfecha AND 
											    vmcodigo = a.compra_moneda ),1)
								END ) , 0 )
		,'cinte' = ROUND( a.compra_interes *  ( CASE 	WHEN a.compra_moneda = 999 
							THEN 1 
							ELSE ISNULL((SELECT vmvalor 
								     FROM   view_valor_moneda 
								     WHERE  vmfecha = @acfecha AND 
									    vmcodigo = a.compra_moneda ),1)
						  END )	, 0 )
		,'ccomi' = '000000000000000'
		,'cvcuo' = ROUND( ( a.compra_amortiza+a.compra_saldo+a.compra_interes ) * ( CASE WHEN a.compra_moneda = 999 
											  THEN 1 
											  ELSE ISNULL(( SELECT vmvalor 
										     			FROM   view_valor_moneda 
										     			WHERE  vmfecha = @acfecha AND 
											    			vmcodigo = a.compra_moneda ),1)
										    END ) , 0 )
		,'csvca' = ROUND( (a.compra_amortiza+a.compra_saldo) * ( CASE 	WHEN a.compra_moneda = 999 
									THEN 1 
									ELSE ISNULL((SELECT vmvalor 
										     FROM   view_valor_moneda 
										     WHERE  vmfecha = @acfecha AND 
											    vmcodigo = a.compra_moneda ),1)
								    END ) , 0 )
		,'ctasa' = a.compra_valor_tasa + a.compra_spread 		
		,'crell' = SPACE(8)
	FROM 	cartera		a ,
		view_cliente 	b 
	WHERE   a.rut_cliente  	  	= b.Clrut	AND
		a.codigo_cliente  	= b.Clcodigo 	AND
--		a.fecha_vence_flujo 	= @acfecha	AND
		a.tipo_flujo		= 1             AND
                a.Estado <> 'C'
	UNION
	SELECT   'ctreg' = 2
		,'crut'  = STR(a.rut_cliente) + b.Cldv
		,'cref'  = a.numero_operacion
		,'ccope' = '00000'
		,'ccorr' = '00'
		,'cncua' = a.numero_flujo
		,'cntoc' = ISNULL((	SELECT '002'
					FROM 	cartera d 
					WHERE 	d.fecha_vence_flujo = @acfecha 	AND
						d.tipo_flujo	    = 1 	AND
						a.numero_operacion  = d.numero_operacion ) ,'001')
		,'csepa' = 'M'   --
		,'cncep' = ISNULL(( SELECT CONVERT(CHAR(3),meses) FROM View_Periodo_Amortizacion WHERE a.venta_codamo_interes = codigo  AND sistema = 'PCS' AND tabla = 1044 ),'000')
		,'cfven' = a.fecha_vence_flujo
		,'cvamo' = ROUND( ( a.venta_amortiza+a.venta_saldo ) * ( CASE 	WHEN a.venta_moneda = 999 
									THEN 1 
									ELSE ISNULL((SELECT vmvalor 
										     FROM   view_valor_moneda 
										     WHERE  vmfecha = @acfecha AND 
											    vmcodigo = a.venta_moneda ),1)
								END ) , 0 )
		,'cinte' = ROUND( a.venta_interes * ( CASE 	WHEN a.venta_moneda = 999 
									THEN 1 
									ELSE ISNULL((SELECT vmvalor 
										     FROM   view_valor_moneda 
										     WHERE  vmfecha = @acfecha AND 
											    vmcodigo = a.venta_moneda ),1)
								END ) , 0 )
		,'ccomi' = '000000000000000'
		,'cvcuo' = ROUND( ( a.venta_amortiza+a.venta_saldo+a.venta_interes ) * ( CASE 	WHEN a.venta_moneda = 999 
											THEN 1 
											ELSE ISNULL((   SELECT vmvalor 
										     			FROM   view_valor_moneda 
										     			WHERE  vmfecha = @acfecha AND 
											    			vmcodigo = a.venta_moneda ),1)
										   END ) , 0 )
		,'csvca' = ROUND( ( a.venta_amortiza+a.venta_saldo) * ( CASE 	WHEN a.venta_moneda = 999 
									THEN 1 
									ELSE ISNULL((SELECT vmvalor 
										     FROM   view_valor_moneda 
										     WHERE  vmfecha = @acfecha AND 
											    vmcodigo = a.venta_moneda ),1)
								END ) , 0 )
		,'ctasa' = a.venta_valor_tasa + a.venta_spread 			
		,'crell' = SPACE(8)
	FROM 	cartera		a ,
		view_cliente 	b 
	WHERE   a.rut_cliente  	  	= b.Clrut	AND
		a.codigo_cliente  	= b.Clcodigo 	AND
--		a.fecha_vence_flujo 	= @acfecha	AND
		a.tipo_flujo		= 2             AND
                a.Estado <> 'C'
	ORDER BY a.numero_operacion
	SET NOCOUNT OFF	
 
END
GO
