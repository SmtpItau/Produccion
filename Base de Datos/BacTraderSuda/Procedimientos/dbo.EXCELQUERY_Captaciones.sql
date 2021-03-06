USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[EXCELQUERY_Captaciones]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EXCELQUERY_Captaciones](@iOpcion smallint, @dfecha datetime=null)
AS 
BEGIN

	IF @iOpcion = 1 
	BEGIN
			SELECT	fecha_operacion,
					fecha_origen, 
					fecha_vencimiento,
					fecha_origen,
					case when tipo_deposito ='R' then 'SI' else 'NO' end as 'RENOVABLE', 
					'IC'												 as CodigoProducto,   
					numero_certificado_dcv,  
					MONEDA, 
					monto_inicio, 
					monto_inicio_pesos, 
					interes_acumulado, 
					reajuste_acumulado, 
					rut_cliente, 
					b.Clnombre, 
					tasa, 
					tasa_tran, 
					estado,
					numero_operacion,
					correla_operacion,
					'' AS Vehiculo, 
					'' as Cuenta_Interna 
			  FROM  BacTraderSuda.dbo.gen_captacion a 
			 inner 
			  join  bacparamsuda.dbo.cliente b 
			    on a.rut_cliente = b.Clrut 
			   and a.codigo_rut = b.Clcodigo 
			     , bactradersuda.dbo.mdac 
		     where fecha_vencimiento > acfecproc
	END 

	IF @iOpcion = 2 
	BEGIN
			SELECT	fecha_operacion,
					fecha_origen, 
					fecha_vencimiento,
					fecha_origen,
					case when tipo_deposito ='R' then 'SI' else 'NO' end as 'RENOVABLE', 
					'IC'												 as CodigoProducto,   
					numero_certificado_dcv,  
					MONEDA, 
					monto_inicio, 
					monto_inicio_pesos, 
					interes_acumulado, 
					reajuste_acumulado, 
					rut_cliente, 
					b.Clnombre, 
					tasa, 
					tasa_tran, 
					estado,
					numero_operacion,
					correla_operacion,
					'' AS Vehiculo, 
					'' as Cuenta_Interna 
			  FROM  BacTraderSuda.dbo.gen_captacion a 
			 inner 
			  join  bacparamsuda.dbo.cliente b 
			    on a.rut_cliente = b.Clrut 
			   and a.codigo_rut = b.Clcodigo 
			     , bactradersuda.dbo.mdac 
			 where fecha_operacion = @dfecha
	END 

END
GO
