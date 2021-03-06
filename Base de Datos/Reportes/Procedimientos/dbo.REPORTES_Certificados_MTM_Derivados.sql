USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[REPORTES_Certificados_MTM_Derivados]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--	Execute dbo.REPORTES_Certificados_MTM_Derivados 'PCS', '20131230', 5458230,  1
--	Execute dbo.REPORTES_Certificados_MTM_Derivados 'BFW', '20140228', 82982300, 1
--	Execute dbo.REPORTES_Certificados_MTM_Derivados 'OPC', '20131230', 96962540, 1


create procedure [dbo].[REPORTES_Certificados_MTM_Derivados]
	(	@Id_Derivado	char(3)
	,	@dFecha			datetime
	,	@nRut			numeric(11)
	,	@nCod			integer
	)
as
begin

	set nocount on

	--> Formato Opciones
	if @Id_Derivado = 'OPC'
	begin
		select	'Folio Contrato'	= Opc.CaNumContrato
			,	'Fecha Inicio'		= convert(char(10), Opc.CaFechaContrato, 103)
			,	'Tipo Opcion'		= Opc.cacallput
			,	'Tipo Contrato'		= case when Opc.cacvopc = 'C' then 'Compra' else 'Venta' end
			,	'Indiv estructura'  = ''
			,	'Modalidad'			= case when Opc.camodalidad = 'C' then 'Compensado' else 'Fisicio' end
			,	'Monedas'			= ltrim(rtrim( mac.mnnemo )) + '-' + ltrim(rtrim( mps.mnnemo ))
			,	'Monto Nocional'	= Opc.camontomon1
			,	'Fecha Vcto'		= convert(char(10), Opc.cafechavcto, 103)
			,	'Strike'			= Opc.castrike
			,	'Valor MTM Neto'	= Opc.CaVr
			,	'Observacion'       = case when Opc.CaVr >= 0 then 'A Favor Corpbanca' else 'A Favor Cliente' end
		from	(	
					select	enc.canumcontrato, enc.cafechacontrato,	enc.CaVr
						,	det.cacallput, det.camodalidad, det.cacodmon1, det.cacodmon2, det.camontomon1, det.cafechavcto, det.castrike, det.cacvopc
					from	CbMdbOpc.dbo.CaResEncContrato	enc with(nolock)
							inner join 	(	select	canumcontrato, cacallput, camodalidad, cacodmon1, cacodmon2, camontomon1, cafechavcto, castrike, cacvopc
											from	CbMdbOpc.dbo.CaResDetContrato with(nolock)
											where	cadetfecharespaldo	= @dFecha
										)	det  On det.CaNumContrato	= enc.CaNumContrato

					where	enc.CaEncFechaRespaldo = @dFecha
					and	(	enc.CaRutCliente = @nRut and enc.CaCodigo = @nCod)	
						union
					select	enc.canumcontrato, enc.cafechacontrato,	enc.CaVr
						,	det.cacallput, det.camodalidad, det.cacodmon1, det.cacodmon2, det.camontomon1, det.cafechavcto, det.castrike, det.cacvopc
					from	CbMdbOpc.dbo.CaEncContrato	enc with(nolock)
							inner join 	(	select	canumcontrato, cacallput, camodalidad, cacodmon1, cacodmon2, camontomon1, cafechavcto, castrike, cacvopc
											from	CbMdbOpc.dbo.CaDetContrato with(nolock)
										)	det  On det.CaNumContrato	= enc.CaNumContrato
					where	@dFecha		= (select fechaproc from CbMdbOpc.dbo.opcionesgeneral)
					and	(	enc.CaRutCliente = @nRut and enc.CaCodigo = @nCod)
					
				)	Opc
				left join BacparamSuda.dbo.Moneda mac On mac.mncodmon = Opc.cacodmon1
				left join BacparamSuda.dbo.Moneda mps On mps.mncodmon = Opc.cacodmon2
	end
	--> Formato Opciones

	--> Formato Forward
	if @Id_Derivado = 'BFW'
	begin

		select	'N° Contrato'       = Fwd.canumoper
             ,  'Fecha Inicio'      = convert(char(10), Fwd.cafecha, 103)
             ,  'Tipo Contrato'     = CASE WHEN Fwd.catipoper = 'C' THEN 'Compra' ELSE 'Venta' END
             ,  'Modalidad'         = case when Fwd.catipmoda = 'C' then 'Compensado' ELSE 'Fisico' END
             ,  'Monedas'           = ltrim(rtrim( mac.mnnemo )) + '-' + ltrim(rtrim( mps.mnnemo ))
             ,  'Monto Mx'			= Fwd.camtomon1
             ,	'Precio Fwd'		= Fwd.catipcam
             ,	'Equivalente'		= Fwd.camtomon2
             ,  'Fecha Vcto'        = convert(char(10), Fwd.cafecvcto, 103)
             ,  'Valor MTM'			= Fwd.fres_obtenido
             ,  'Observacion'       = case when Fwd.fres_obtenido >= 0 then 'A Favor Corpbanca' else 'A Favor Cliente' end
		from	(
					select	canumoper, cafecha,	catipoper, catipmoda, cacodmon1, cacodmon2,	camtomon1, catipcam, camtomon2, cafecvcto, fres_obtenido
					from	BacFwdSuda.dbo.MfcaRes with(nolock)
					where	CaFechaProceso	= @dFecha
					and		(	cacodigo	= @nRut	and	 cacodcli = @nCod	)
						union
					select	canumoper, cafecha,	catipoper, catipmoda, cacodmon1, cacodmon2,	camtomon1, catipcam, camtomon2, cafecvcto, fres_obtenido
					from	BacFwdSuda.dbo.Mfca with(nolock)
					where	@dFecha			= (select acfecproc from bacFwdSuda.dbo.Mfac with(nolock) )
					and		(	cacodigo	= @nRut	and	 cacodcli = @nCod	)
				)	Fwd		
				left join BacparamSuda.dbo.Moneda mac On mac.mncodmon = Fwd.cacodmon1
				left join BacparamSuda.dbo.Moneda mps On mps.mncodmon = Fwd.cacodmon2
	
	end
	--> Formato Forward

	--> Formato Swap
	if @Id_Derivado = 'PCS'
	begin
		select	'N° Contrato'       = act.numero_operacion
			,	'Fecha Inicio'      = convert(char(10), act.Fecha_inicio, 103)
			,	'Tipo Contrato'     = case when act.tipo_swap = 1 then 'Swap de Tasas'
											   when act.tipo_swap = 2 then 'Swap de Monedas'
											   when act.tipo_swap = 4 then 'Swap Promedio Camara'
											end
			,	'Modalidad'         = case when act.modalidad_pago = 'C' then 'Compensado' else 'Fisico' end
			,	'Monedas'           = ltrim(rtrim( mac.mnnemo )) + '-' + ltrim(rtrim( mps.mnnemo ))
			,	'Tasas'             = ltrim(rtrim( Tac.tbglosa )) + '-' + ltrim(rtrim( Tps.tbglosa ))
			,	'Monto Nocional'    = act.compra_capital 
			,	'Fecha Vcto'        = convert(char(10), act.fecha_termino, 103)
			,	'Valor MTM Activo'  = act.compra_mercado_clp
			,	'Valor MTM Pasivo'  = pas.venta_mercado_clp
			,	'Valor MTM Neto'    = act.Valor_RazonableCLP
			,	'Observacion'       = case when act.Valor_RazonableCLP >= 0 then 'A Favor Corpbanca' else 'A Favor Cliente' end
		from	
				(	select	numero_operacion,numero_flujo,compra_moneda, compra_codigo_tasa, tipo_flujo, Valor_RazonableCLP
						,	Fecha_inicio, fecha_termino, tipo_swap, modalidad_pago, compra_capital, compra_mercado_clp
					from	BacSwapSuda.dbo.CarteraRes with(nolock)
					where	Fecha_Proceso		= @dFecha
					and	(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
						union
					select	numero_operacion,numero_flujo,compra_moneda, compra_codigo_tasa, tipo_flujo, Valor_RazonableCLP
						,	Fecha_inicio, fecha_termino, tipo_swap, modalidad_pago, compra_capital, compra_mercado_clp
					from	BacSwapSuda.dbo.Cartera with(nolock)
					where(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
					and		@dFecha				= (select fechaproc from bacSwapSuda.dbo.SwapGeneral)
				)	act 

					inner join (	select	Contrato			= numero_operacion
										,   Tipo				= tipo_flujo
										,   Flujo				= min(numero_flujo)
									from	BacSwapSuda.dbo.CarteraRes with(nolock)
									where	Fecha_Proceso		= @dFecha
									and (	rut_cliente	= @nRut and codigo_cliente = @nCod	)
									group 
									by		numero_operacion, tipo_flujo
										union
									select	Contrato			= numero_operacion
										,   Tipo				= tipo_flujo
										,   Flujo				= min(numero_flujo)
									from	BacSwapSuda.dbo.Cartera with(nolock)
									where(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
									and		@dFecha				= (select fechaproc from bacSwapSuda.dbo.SwapGeneral)
									group 
									by		numero_operacion, tipo_flujo
	                                
							  )		Grp		On  Grp.Contrato	= act.numero_operacion
											and	Grp.Flujo		= act.numero_flujo
											and Grp.Tipo		= 1 --> act.tipo_flujo
	                                        
					left Join (		select	numero_operacion,		numero_flujo,	tipo_flujo
									,		venta_moneda,			compra_codigo_tasa
									,		venta_codigo_tasa,		Activo_FlujoClp
									,		venta_valor_presente,	venta_mercado_clp
									from	BacSwapSuda.dbo.CarteraRes with(nolock)
									where	Fecha_Proceso		= @dFecha
									and (	rut_cliente	= @nRut and codigo_cliente = @nCod	)
										union
									select	numero_operacion,		numero_flujo,	tipo_flujo
									,		venta_moneda,			compra_codigo_tasa
									,		venta_codigo_tasa,		Activo_FlujoClp
									,		venta_valor_presente,	venta_mercado_clp
									from	BacSwapSuda.dbo.Cartera with(nolock)
									where(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
									and		@dFecha				= (select fechaproc from bacSwapSuda.dbo.SwapGeneral)
							  )		Pas		On  Pas.numero_operacion = Grp.Contrato
											and Pas.numero_flujo     = Grp.Flujo
											and Pas.tipo_flujo       = 2 -- Grp.Tipo

					left join BacparamSuda.dbo.Moneda mac On mac.mncodmon = act.compra_moneda
					left join BacparamSuda.dbo.Moneda mps On mps.mncodmon = pas.venta_moneda
	                    
					left join (		select	tbcodigo1, tbglosa
									from	BacParamSuda.dbo.Tabla_General_Detalle
									where	tbcateg = 1042
							  )     Tac		On Tac.tbcodigo1 = act.compra_codigo_tasa
	                    
					left join (     select	tbcodigo1, tbglosa
									from	BacParamSuda.dbo.Tabla_General_Detalle
									where	tbcateg = 1042
							  )     Tps		On Tps.tbcodigo1 = pas.venta_codigo_tasa

		where	act.tipo_flujo          = 1
	end
	--> Formato Swap
	
	
end

GO
