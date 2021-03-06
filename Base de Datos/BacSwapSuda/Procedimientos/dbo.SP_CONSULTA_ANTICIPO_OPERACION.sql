USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_ANTICIPO_OPERACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CONSULTA_ANTICIPO_OPERACION]
(
	@nContrato	numeric(10)
)
as
begin

	if object_id('tempdb..#TablaAnticipo') is not null BEGIN
		drop table #TablaAnticipo
	end

	set nocount on 

	select distinct 
	FechaAnticipo			= FechaAnticipo,
	Estado					= Estado,
	Tipo_Flujo				= tipo_flujo,
	Numero_Operacion		= Numero_Operacion,
	Modalidad				=(case modalidad_pago
								when 'C' then 'COMPENSACION'
								else 'ENTREGA FISICA'
							end)				 				

	,GlosaMoneda_Compra		= isnull(dbo.ObtenerNombreMonedaByFlujo(numero_operacion,numero_flujo,1), ' ')
	,GlosaMoneda_Venta		= isnull(dbo.ObtenerNombreMonedaByFlujo(numero_operacion,numero_flujo,2), ' ')
	,CodFormaPago_Activo	= recibimos_documento
	,CodFormaPago_Pasivo	= pagamos_documento
	,CodMoneda_Compra		= compra_moneda
	,CodMoneda_Venta		= venta_moneda
	,MontoAnticipo_Activo	= recibimos_monto
	,MontoAnticipo_Pasivo	= pagamos_monto

	,Anticipo_Transferencia	= isnull(Principal_Mda_Val,0)
	,Resultado_Venta		= isnull(Devengo_Recibido_Mda_Val,0)
	,Resultado_Trading		= isnull(Devengo_Pagar_Mda_Val,0)
	
	INTO #TablaAnticipo
	FROM BacSwapSuda.dbo.CARTERA_UNWIND 
	WHERE numero_operacion = @nContrato
	GROUP BY
	FechaAnticipo,
	Estado,
	tipo_flujo,
	Numero_Operacion,modalidad_pago,compra_capital,compra_amortiza,
	venta_capital,venta_amortiza,recibimos_documento,pagamos_documento,compra_moneda,venta_moneda,
	recibimos_monto,pagamos_monto,numero_flujo

	,Principal_Mda_Val,Devengo_Recibido_Mda_Val,Devengo_Pagar_Mda_Val

	select distinct
		FechaAnticipo
		,Estado
		,Tipo_Flujo
		,Numero_Operacion
		,Modalidad
		,GlosaMoneda_Compra
		,GlosaMoneda_Venta
		,CodFormaPago_Activo
		,CodFormaPago_Pasivo
		,CodMoneda_Compra
		,CodMoneda_Venta
		,MontoAnticipo_Activo
		,MontoAnticipo_Pasivo
		,Anticipo_Transferencia
		,Resultado_Venta
		,Resultado_Trading 
	from #TablaAnticipo
end
GO
