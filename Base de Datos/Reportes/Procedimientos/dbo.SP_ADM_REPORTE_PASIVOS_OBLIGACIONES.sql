USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_PASIVOS_OBLIGACIONES]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[SP_ADM_REPORTE_PASIVOS_OBLIGACIONES]
	(
		@dFecha		datetime		
	
	)
as
begin

	set nocount on

	select	Partida			=	MdPasivo.DBO.FN_CUENTAS_MB1IRFS ( Cartera.nombre_serie )
		------------------------------------------------------------------------------------------------
		,	RutTenedor		=	convert(char(20), 
									(select Rut_entidad	   from MdParPasivo.dbo.DATOS_GENERALES with(nolock) )
								)
		,	DvTenedor		=	convert(char(1),
									(select Digito_Entidad from MdParPasivo.dbo.DATOS_GENERALES with(nolock) )
								)
		,	NombreTenedor	=	convert(varchar(50), 
									(select Nombre_Entidad from MdParPasivo.dbo.DATOS_GENERALES with(nolock) )
								)
		------------------------------------------------------------------------------------------------
		,	Composicioon	=	221
		,	NumeroOperacion	=	convert(varchar(20), 
								REPLICATE('0', 7 - LEN( LTRIM(RTRIM( Cartera.Folio			))) ) + LTRIM(RTRIM( Cartera.Folio			))
							+	REPLICATE('0', 4 - LEN( LTRIM(RTRIM( Cartera.Correlativo	))) ) + LTRIM(RTRIM( Cartera.Correlativo	))
								)
		,	FechaColocacion	=	convert(char(10), Cartera.FechaInicio, 105)
		,	FechaTermino	=	convert(char(10), Cartera.FechaTermino, 105)
		,	Moneda			=	convert(char(3), Moneda.Nemo )
		,	Tasa			=	Cartera.Tasa
		,	Monto			=	Cartera.MontoOriginalMl
		,	Saldo			=	Resultado.Saldo
		,	Interes			=	Resultado.Interes
		,	Reajuste		=	Resultado.Reajuste
		,	Serie			=   Cartera.nombre_serie
		,	CuentaNominal	=   (SELECT CUENTA_CONTABLE FROM REPORTES.DBO.ContabilidadBonosPasivo(Cartera.Folio,Cartera.Correlativo) WHERE CORRELATIVO =1)
	from				-->	Lee de la Cartera aquellos campos que no debieran variar, originados al momento de la colocacion
		(	select	Folio				= numero_operacion
				,	Correlativo			= numero_correlativo
				,	FechaInicio			= fecha_colocacion
				,	FechaTermino		= fecha_vencimiento
				,	Moneda				= moneda_emision
				,	MontoOriginalMl		= valor_colocacion_clp
				,	Tasa				= tasa_colocacion
				,	nombre_serie		= nombre_serie				
			from	MdPasivo.dbo.CARTERA_PASIVO	with(nolock) 
			where	codigo_instrumento	= 15
				union
			select	Folio				= numero_operacion
				,	Correlativo			= numero_correlativo
				,	FechaInicio			= fecha_emision_papel
				,	FechaTermino		= fecha_vencimiento
				,	Moneda				= moneda_emision
				,	MontoOriginalMl		= valor_emision_pesos
				,	Tasa				= tasa_emision
				,	nombre_serie		= nombre_serie
			from	MdPasivo.dbo.CARTERA_PASIVO	with(nolock) 
			where	codigo_instrumento	<> 15
		)	Cartera	
			left join	-->	Lee de Resultados, todos los campos que debieran variar dia a dia, a partir del proceso de devengamiento
			(	select	Folio				= numero_operacion
					,	Correlativo			= numero_correlativo
					,	Saldo				= valor_proximacolocacion
					,	Interes				= interes_acum_colocacion
					,	Reajuste			= reajuste_acum_colocacion
				from	MdPasivo.dbo.RESULTADO_PASIVO with(nolock) 
				where	fecha_calculo		= @dFecha
				and		codigo_instrumento	= 15
				and		tipo_operacion		= 'DEV'
					union
				select	Folio				= numero_operacion
					,	Correlativo			= numero_correlativo
					,	Saldo				= valor_proximaemision
					,	Interes				= interes_acumulado
					,	Reajuste			= reajuste_acumulado
				from	MdPasivo.dbo.RESULTADO_PASIVO with(nolock) 
				where	fecha_calculo		= @dFecha
				and		codigo_instrumento	<> 15
				and		tipo_operacion		= 'DEV'
			)	Resultado	On	Resultado.Folio			= Cartera.Folio
							and	Resultado.Correlativo	= Cartera.Correlativo
			left join
			(	select	Id		= mncodmon
					,	Nemo	= mnnemo
				from	MdParPasivo.dbo.MONEDA with(nolock) 
			)	Moneda		On	Moneda.Id = Cartera.moneda
--	where	Cartera.Folio IN( 466, 840)
	order 
	by		Resultado.Folio
		,	Resultado.Correlativo

end


GO
