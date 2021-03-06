USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[svc_query_dwt]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[svc_query_dwt]
	(	@cTag	varchar(3)	
	,	@dFecha	datetime
	)
 as
 begin

	/*
	declare @cTag	varchar(3);	set @cTag	= 'opt'	
	declare @dFecha	datetime;	set @dFecha	= (select fechaproc from cbmdbopc.dbo.OpcionesGeneral with(nolock)) --> '20160729' --> '20170117'
	*/
	
	set nocount on

	if (@cTag = 'opt')
	begin
		select	Descripcion		= 'Opciones'
			,	Folio_DWT		= '1000003' + ltrim(rtrim( opt.CaNumContrato)) + ltrim(rtrim( opt.CaNumEstructura ))
			,	Folio_BAC		= ltrim(rtrim( opt.CaNumContrato))
			,	Tipo			= '-'
			,	MTM_CLP			= opt.CaVrDet
			,	AVR				= case when opt.CaNumEstructura = 1 then opt.CaVrDet else 0 end
			,	Activo			= CaNumEstructura
		from	
			(	
				select	CaNumContrato	= det.CaNumContrato
					,	CaNumEstructura	= det.CaNumEstructura
					,	CaVrDet			= det.CaVrDet
					,	CaVr			= enc.CaVr
		 		from	cbmdbopc.dbo.CaResDetContrato det with(nolock)
					inner join 
					(	select	CaNumContrato, CaVr
					 	from	cbmdbopc.dbo.CaResEncContrato with(nolock)
					 	where	CaEncFechaRespaldo	= @dFecha
					)	enc	on enc.CaNumContrato	= det.CaNumContrato
				where	det.CaDetFechaRespaldo		= @dFecha
				and		det.caFechaVcto			   <> @dFecha
				and		@dFecha					   <> (select fechaproc from cbmdbopc.dbo.OpcionesGeneral with(nolock))
					union
				select	CaNumContrato	= det.CaNumContrato
					,	CaNumEstructura	= det.CaNumEstructura
					,	CaVrDet			= det.CaVrDet
					,	CaVr			= enc.CaVr
		 		from	cbmdbopc.dbo.CaDetContrato det with(nolock)
					inner join 
					(	select	CaNumContrato, CaVr
					 	from	cbmdbopc.dbo.CaEncContrato with(nolock)
					)	enc	on enc.CaNumContrato	= det.CaNumContrato
				where	det.caFechaVcto			   <> @dFecha
				and		@dFecha						= (select fechaproc from cbmdbopc.dbo.OpcionesGeneral with(nolock))
			)	opt
				
		order
		by		opt.CaNumContrato
			,	opt.CaNumEstructura
	end

	if (@cTag = 'pcs')
	begin
		select	Descripcion = case when avr.TypeOff = '2011' then 'CCC-ML' else 'IRS-ML' end  
			,	Folio_DWT	= ltrim(rtrim( avr.TypeOff )) + ltrim(rtrim( Swap.Folio ))
			,	Folio_BAC	= ltrim(rtrim( Swap.Folio ))
			,	Tipo		= '-'
			,	MTM_CLP		= avr.MTMFlujo
			,	AVR			= avr.Monto
			,	Activo		= avr.Activo
		from	
			(	
				select	Folio	= res.numero_operacion
					,	Tipo	= res.tipo_flujo 
				from	
					(	select	numero_operacion, tipo_flujo 
					 	from	BacSwapsuda.dbo.CARTERARES with(nolock)
						where	Fecha_Proceso		= @dFecha
						and		@dFecha			   <> (select fechaproc from BacSwapSuda.dbo.SwapGeneral with(nolock) )
						and		estado			   <> 'C'
						and		fecha_vence_flujo  <> @dFecha
							union
						select	numero_operacion, tipo_flujo 
					 	from	BacSwapsuda.dbo.CARTERA with(nolock)
						where	@dFecha				= (select fechaproc from BacSwapSuda.dbo.SwapGeneral with(nolock) )
						and		estado			   <> 'C'
						and		fecha_vence_flujo  <> @dFecha
						
					)	res
				group
				by		res.numero_operacion
					,	res.tipo_flujo
			)	Swap
			inner join
			(	select	Contrato			= res.numero_operacion
					,	Tipo				= res.tipo_flujo
					,	Monto				= case	when res.tipo_flujo = 1 then min(res.Valor_RazonableCLP) 
													else 0
												end
					,	TypeOff				= case	when res.tipo_swap = 2 then '2011'
													when res.tipo_swap = 1 then '2009'
													when res.tipo_swap = 4 then '2009'
						 	       				end
					,	MTMFlujo			= case	when res.tipo_flujo = 1 then sum(res.Activo_FlujoCLP)
													else sum(res.Pasivo_FlujoCLP) *-1
					 	        			  end
					,	Activo				= case	when res.tipo_flujo = 1 then 'Si'
													else 'No'	
												end
				from	
					(	
						select	numero_operacion, tipo_swap, tipo_flujo, Valor_RazonableCLP, Activo_FlujoCLP, Pasivo_FlujoCLP, numero_flujo
					 	from	BacSwapsuda.dbo.CARTERARES with(nolock)
						where	Fecha_Proceso		= @dFecha
						and		@dFecha			   <> (select fechaproc from BacSwapSuda.dbo.SwapGeneral with(nolock) )
						and		estado			   <> 'C'
						and		fecha_vence_flujo  <> @dFecha
						
							union
						select	numero_operacion, tipo_swap, tipo_flujo, Valor_RazonableCLP, Activo_FlujoCLP, Pasivo_FlujoCLP, numero_flujo
					 	from	BacSwapsuda.dbo.CARTERA with(nolock)
						where	@dFecha				= (select fechaproc from BacSwapSuda.dbo.SwapGeneral with(nolock) )
						and		estado			   <> 'C'
						and		fecha_vence_flujo  <> @dFecha
						

					)	res
				group 
				by		res.numero_operacion
					,	res.tipo_flujo
					,	case	when res.tipo_swap = 2 then '2011'
								when res.tipo_swap = 1 then '2009'
								when res.tipo_swap = 4 then '2009'
							end

			)	avr		On	avr.Contrato	= Swap.Folio
						and	avr.Tipo		= Swap.Tipo
		order 
		by		avr.Contrato
			,	case when avr.Activo = 'Si' then 1 else 2 end
	end

	
	if (@cTag = 'bfw')
	begin
		select	Descripcion	= case when Forward.xType = '1000002' then 'Forward-Obs' else 'Forward' end
			,	Folio_DWT	= Forward.canumoper
			,	Folio_BAC	= substring(Forward.canumoper,8,9)
			,	Tipo		= Forward.TypeOff
			,	MTM_CLP		= Forward.MTM_CLP
			,	AVR			= case when Forward.Activo = 'Si' then Forward.AvrContrato else 0 end
			,	Activo		= Forward.Activo
		from
			(	select	canumoper		= case	when cacodpos1 = 14		then	'1000002' 
												else							'1000001' 
			 	      	         			end
										+ ltrim(rtrim( canumoper )) 
					,	MTM_CLP			= case	when catipoper = 'C'	then	(round(ValorRazonableActivo, 0) * 1)
												else							(round(ValorRazonablePasivo, 0) *-1)
											end
					,	AvrContrato		= round(fRes_Obtenido, 4)
					,	xType			= case	when cacodpos1 = 14		then	'1000002' 
												else							'1000001' 
					 	     				end
					,	Activo			= case	when catipoper = 'C'	then	'Si' 
												else							'No' 
					 	      			  end
					,	TypeOff			= catipoper
				from	
					(	select	CaFechaProceso
							,	canumoper, cacodigo, cacodcli, cacodpos1, fres_obtenido, ValorRazonableActivo, ValorRazonablePasivo, catipoper, caestado
					 	from	bacfwdsuda.dbo.mfcares with(nolock)
					 	where	CaFechaProceso	= @dFecha
					 	and		@dFecha			<> (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					 	and		caestado		<> 'A' 
					 	and		caestado		<> 'P' 
					 	and		cafecvcto		<> @dFecha 
					 	and		cacodpos1		<> 10
					 		union
					 	select	CaFechaProceso = (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					 		,	canumoper, cacodigo, cacodcli, cacodpos1, fres_obtenido, ValorRazonableActivo, ValorRazonablePasivo, catipoper, caestado
					 	from	bacfwdsuda.dbo.mfca with(nolock)
					 	where	@dFecha			= (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					 	and		caestado		<> 'A' 
					 	and		caestado		<> 'P' 
					 	and		cafecvcto		<> @dFecha 
					 	and		cacodpos1		<> 10
					)	mfcares
						inner join	
						(	select	codigo_producto, descripcion 
							from	BacParamSuda.dbo.Producto with(nolock)
							where	Id_Sistema = 'BFW'
						)	Prod	On Prod.codigo_producto = mfcares.cacodpos1
						inner join 
						(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
							from	BacParamSuda.dbo.cliente with(nolock)
						)	Clie	On	Clie.clrut		= mfcares.cacodigo
									and Clie.clcodigo	= mfcares.cacodcli
				where	mfcares.CaFechaProceso	= @dFecha

					union	
				select	canumoper		= case	when cacodpos1 = 14		then	'1000002' 
												else							'1000001' 
				      	         			end
										+ ltrim(rtrim( canumoper )) 
					,	MTM_CLP			= case	when catipoper = 'C'	then	(round(ValorRazonablePasivo, 0) *-1)
												else							(round(ValorRazonableActivo, 0) * 1)
											end
					,	AvrContrato		= round(fRes_Obtenido, 4)
					,	xType			= case	when cacodpos1 = 14		then	'1000002' 
												else							'1000001' 
					 	     				end
					,	Activo			= case	when catipoper = 'C'	then	'No' 
												else							'Si' 
					 	      				end
					,	TypeOff			= catipoper
				from	
					(	select	CaFechaProceso
							,	canumoper, cacodigo, cacodcli, cacodpos1, fres_obtenido, ValorRazonableActivo, ValorRazonablePasivo, catipoper, caestado
					 	from	bacfwdsuda.dbo.mfcares with(nolock)
					 	where	CaFechaProceso	= @dFecha
					 	and		@dFecha		<> (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					 	and		caestado	<> 'A' 
					 	and		caestado	<> 'P' 
					 	and		cafecvcto	<> @dFecha 
					 	and		cacodpos1	<> 10
					 		union
					 	select	CaFechaProceso = (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					 		,	canumoper, cacodigo, cacodcli, cacodpos1, fres_obtenido, ValorRazonableActivo, ValorRazonablePasivo, catipoper, caestado
					 	from	bacfwdsuda.dbo.mfca with(nolock)
					 	where	@dFecha		= (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					 	and		caestado	<> 'A' 
					 	and		caestado	<> 'P' 
					 	and		cafecvcto	<> @dFecha 
					 	and		cacodpos1	<> 10
					)	mfcares
					inner join	
					(	select	codigo_producto, descripcion 
						from	BacParamSuda.dbo.Producto with(nolock)
						where	Id_Sistema = 'BFW'
					)	Prod	On Prod.codigo_producto = mfcares.cacodpos1
					inner join 
					(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						from	BacParamSuda.dbo.cliente with(nolock)
					)	Clie	On	Clie.clrut		= mfcares.cacodigo
								and Clie.clcodigo	= mfcares.cacodcli
				where	mfcares.CaFechaProceso	= @dFecha
			)	Forward
		order 
		by		Forward.canumoper
			,	case when Forward.Activo = 'Si' then 1 else 2 end
	end

 end
GO
