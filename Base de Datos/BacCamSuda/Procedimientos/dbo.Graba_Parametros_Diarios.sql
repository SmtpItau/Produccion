USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Graba_Parametros_Diarios]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Graba_Parametros_Diarios]
as
begin

	set nocount on

	create table #nError
		(	id	int		)

	declare @Entidad		CHAR(2)
	declare @Valor			NUMERIC(18,5)
	declare @Camara			NUMERIC(19,4)
	declare @Over			NUMERIC(19,4)
	declare @dCamara		NUMERIC(2)
	declare @dOver			NUMERIC(2)
	declare @cbanda			NUMERIC(19,4)
	declare @vbanda			NUMERIC(19,4)
	declare @hedgespot		NUMERIC(19,4)
	declare @hedgefutu		NUMERIC(19,4)
	declare @precioini		NUMERIC(15,4)
	declare @preciocierre	NUMERIC(15,4)

	select	@Entidad		= 'ME'
		,	@Valor			= ( 1.0 + ((Par.TasaCamara * Par.DiasCamara) / 3000)
									+ ((Par.TasaOver   * Par.DiasOver)   / 36000)
							  )
		,	@Camara			= Par.TasaCamara
		,	@Over			= Par.TasaOver
		,	@dCamara		= Par.DiasCamara
		,	@dOver			= Par.DiasOver
		,	@cbanda			= (Par.Observado - (Par.Observado * Par.Porcentaje) /100.0)
		,	@vbanda			= (Par.Observado + (Par.Observado * Par.Porcentaje) /100.0)
		,	@hedgespot		= Par.HedgeSpot
		,	@hedgefutu		= Par.HedgeForward
		,	@precioini		= Par.PrecioHedge
		,	@preciocierre	= Par.PrecioCierre
	from	(	select  Observado		= obs.vmvalor
					,	UF				= Ufs.vmvalor
					,	Acuerdo			= Acdo.vmvalor
					,	Porcentaje		= convert(numeric(10,6),	
											((	(	((acCband + acVband) / 2.0) - acCband)
												/  case	when ((acCband + acVband) / 2.0) = 0.0 then 1.0 else ((acCband + acVband) / 2.0) end
												) * 100.0)
											)
					,	TasaCamara		= AcTCamar
					,	TasaOver		= AcTOvern
					,	DiasCamara		= AcDCamar
					,	DiasOver		= AcDOvern
					,	PosInicial		= PosIni.vmposini
					,	TCMinimo		= obs.vmvalor
					,	TCMaximo		= obs.vmvalor
					,	HedgeSpot		= info_utili
					,	HedgeForward	= achedgeinicialfuturo
					,	PrecioHedge		= achedgeprecioinicial
					,	PrecioCierre	= acprecie
				from	MEAC		with(nolock)
						inner join	(	select	vmvalor, vmfecha from BacParamSuda.dbo.Valor_Moneda with(nolock)
										where	vmcodigo = 994
									)	obs		On obs.vmfecha = meac.acfecpro
							
						inner join	(	select	vmvalor, vmfecha from BacParamSuda.dbo.Valor_Moneda with(nolock)
										where	vmcodigo = 998
									)	Ufs		On Ufs.vmfecha = meac.acfecpro
							
						inner join	(	select	vmvalor, vmfecha from BacParamSuda.dbo.Valor_Moneda with(nolock)
										where	vmcodigo = 995
									)	Acdo	On Acdo.vmfecha = meac.acfecpro
									
						inner join	(	select	vmposini = ISNULL(vmposini,0.0), vmfecha
										from	VIEW_POSICION_SPT	with(nolock)
										where	vmcodigo = 'USD'
									)	PosIni	On PosIni.vmfecha = meac.acfecpro
			)	Par

		insert into #nError
		Execute dbo.SP_GRABAPARAMETROS	@Entidad
									,	@Valor
									,	@Camara
									,	@Over
									,	@dCamara
									,	@dOver
									,	@cbanda
									,	@vbanda
									,	@hedgespot
									,	@hedgefutu
									,	@precioini
									,	@preciocierre

		---	Son todos los paramtros de la Pantalla-
			/*
		,	Observado		= Par.Observado
		,	UF				= Par.UF
		,	Acuerdo			= Par.Acuerdo
		,	Porcentaje		= Par.Porcentaje
		,	TasaCamara		= Par.TasaCamara
		,	TasaOver		= Par.TasaOver
		,	DiasCamara		= Par.DiasCamara
		,	DiasOver		= Par.DiasOver
		,	PosInicial		= Par.PosInicial
		,	TCMinimo		= (Par.Observado - (Par.Observado * Par.Porcentaje) /100.0)
		,	TCMaximo		= (Par.Observado + (Par.Observado * Par.Porcentaje) /100.0)
		,	HedgeInicialSpt	= Par.HedgeSpot
		,	HedgeInicialFwd	= Par.HedgeForward
		,	PrecioHedge		= Par.PrecioHedge
		,	PrecioCierre	= Par.PrecioCierre
			*/
		---	Son todos los paramtros de la Pantalla-

end
GO
