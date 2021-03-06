USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S007_Query_Resultado]
	(	@FechaDesde			datetime
	,	@FechaHasta			datetime
	,	@MedaDistibucion	int		= 1
	,	@RutCliente			int		= 0
	)
as
begin

	-->		Activa el Retorno de Pivotal, desde la Query de Resultados a la tabla : TBL_RESULTADOS_MESA_PIVOTAL
	declare @Pivotal	int
		set @Pivotal	= 1

	Execute dbo.QUERY_RESULTADO_MESA_ENTREFECHAS @FechaDesde, @FechaHasta, @MedaDistibucion, @Pivotal
	-->		Activa el Retorno de Pivotal, desde la Query de Resultados a la tabla : TBL_RESULTADOS_MESA_PIVOTAL

	select	Modulo
		,	Producto
		,	Numero_Operacion
		,	Relacion
		,	Correlativo
		,	Serie
		,	Rut_Cliente
		,	TipoOperacion
		,	Monto
		,	Moneda_Transada
		,	Moneda_Conversion
		,	TC_Cierre
		,	TC_Costo
		,	Paridad_Cierre
		,	Paridad_Costo
		,	Monto_Pesos
		,	Operador
		,	Monto_Dolares	= format( Monto_Dolares									, 'F2', 'es-cl')
		,	Resultado_Mesa	= format( Resultado_Mesa								, 'F2', 'es-cl')
		,	Spread			= format( isnull(Resultado_Mesa / Monto_Dolares, 0.0)	, 'F2', 'es-cl')
		,	Fecha
	    ,	Mes
		,	Negocio
		,	Segmento_IBS
		,	Jefe_Grupo_IBS
		,	Ejecutivo_IBS
		,	Gerencia_IBS
		,	Division_IBS
		,	RUT_Completo_IBS
		,	Resultados_Datos_Mesa
		,	Canal_Datos_Mesa
		,	Quien_entrega_AG_Datos_Mesa
		,	Comex_Datos_Mesa
		,	Flow
		,	Flow_Segmento
	from	(	select	'Modulo'						=	Formato.Modulo
					,	'Producto'						=	Formato.Producto
					,	'Numero_Operacion'				=	Formato.Numero_Operacion
					,	'Relacion'						=	Formato.Relacionado
					,	'Correlativo'					=	Formato.Correlativo
					,	'Serie'							=	Formato.Serie
					,	'Rut_Cliente'					=	ltrim(rtrim( Formato.RutCliente )) + ltrim(rtrim( Formato.DvCliente ))
					,	'TipoOperacion'					=	Formato.TipoOperacion
					,	'Monto'							=	format( isnull(Formato.Monto, 0.0), 'F2', 'es-cl' )
					,	'Moneda_Transada'				=	Formato.MonTransada
					,	'Moneda_Conversion'				=	Formato.MonConversion
					,	'TC_Cierre'						=	Formato.TCCierre
					,	'TC_Costo'						=	Formato.TCCosto
					,	'Paridad_Cierre'				=	Formato.ParidadCierre
					,	'Paridad_Costo'					=	Formato.ParidadCosto
					,	'Monto_Pesos'					=	isnull(format( Formato.MontoPesos, 'F2', 'es-cl'), 0)
					,	'Operador'						=	replace(isnull(usr.Rut, ''), '-', '')


					,	'Monto_Dolares'					=	case	when Formato.Modulo = 'pcs'			then isnull(BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13), 0.0)
																	when Formato.MontoDolares = 0.0		then isnull(BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13), 0.0)
																	else									 isnull(Formato.MontoDolares, 0.0)
																end
					,	'Resultado_Mesa'				=	isnull(Formato.ResultadoMesa,0.0)
					,	'Spread'						=	convert(numeric(21,4), 0.0)

					/*
					,	'Monto_Dolares'					=	case	when Formato.Modulo = 'pcs'			then format(isnull(BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13), 0.0), 'F2', 'es-cl')
																	when Formato.MontoDolares = 0.0		then format(isnull(BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13), 0.0), 'F2', 'es-cl')
																	else format(isnull(Formato.MontoDolares, 0.0), 'F2', 'es-cl')
																end

					,	'Resultado_Mesa'				=	format(isnull(Formato.ResultadoMesa,0.0), 'F2', 'es-cl')

					,	'Spread'						=	case	when Formato.Modulo = 'pcs' then
																		case	when BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13) = 0.0 then format(0.0, 'F2', 'es-cl')
																				when Formato.MontoDolares = 0.0	then format(isnull(BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13), 0.0), 'F2', 'es-cl')
																				else format(isnull(Formato.ResultadoMesa / BacParamSuda.dbo.fx_convierte_monto (Formato.Fecha, Mon.mncodmon, Formato.Monto, 13), 0.0), 'F2', 'es-cl')
																			end
																	else
																		case	when Formato.Monto = 0.0 then format(0.0, 'F2', 'es-cl')
																				else format(isnull(Formato.ResultadoMesa / Formato.Monto, 0.0), 'F2', 'es-cl')
																			end
																end
					*/
					,	'Fecha'							=	convert(varchar(10), Formato.Fecha, 126)
					,	'Mes'							=	datepart(month, Formato.Fecha)
					,	'Negocio'						=	''
					,	'Segmento_IBS'					=	isnull(pds.Segmento, ' ')
					,	'Jefe_Grupo_IBS'				=	''
					,	'Ejecutivo_IBS'					=	''
					,	'Gerencia_IBS'					=	''
					,	'Division_IBS'					=	Division_IBS
					,	'RUT_Completo_IBS'				=	LTRIM(RTRIM(STR(RutCliente))) + LTRIM(RTRIM(DvCliente))
					,	'Resultados_Datos_Mesa'			=	isnull(	prp.Resultado,	' ')
					,	'Canal_Datos_Mesa'				=	isnull( pco.Canal, ' ')
					,	'Quien_entrega_AG_Datos_Mesa'	=	isnull( ppa.AG,	' ')
					,	'Comex_Datos_Mesa'				=	isnull( coc.Estado, ' ')
					,	'Flow'							=	isnull( Flw.Estado, 'NO')
					,	'Flow_Segmento'					=	'SI'
					,	'codcliente'					=	Formato.codcliente
					,	'documento'						=	Formato.documento
				from	(
							select	'Modulo'				= Retorno.Modulo
								,	'Producto'				= Retorno.Producto
								,	'Numero_Operacion'		= Retorno.Numero_Operacion
								,	'Relacionado'			= Retorno.Relacionado
								,	'FolioRef'				= Retorno.Correlativo
								,	'Serie'					= Retorno.Serie
								,	'RutCliente'			= Retorno.RutCliente
								,	'CodCliente'			= Retorno.CodCliente
								,	'DvCliente'				= Retorno.DvCliente
								,	'NombreCliente'			= Retorno.NombreCliente
								,	'TipoOperacion'			= Retorno.TipoOperacion
								,	'Monto'					= Retorno.Monto
								,	'MonTransada'			= Retorno.MonTransada
								,	'MonConversion'			= Retorno.MonConversion
								,	'TCCierre'				= Retorno.TCCierre
								,	'TCCosto'				= Retorno.TCCosto
								,	'ParidadCierre'			= Retorno.ParidadCierre
								,	'ParidadCosto'			= Retorno.ParidadCosto
								,	'MontoPesos'			= Retorno.MontoPesos
								,	'Operador'				= Retorno.Operador
								,	'MontoDolares'			= Retorno.MontoDolares
								,	'ResultadoMesa'			= Retorno.ResultadoMesa
								,	'Fecha'					= Retorno.Fecha
								,	'Documento'				= Retorno.Documento
								,	'Correlativo'			= Retorno.Correlativo
								,	'FechaEmision'			= Retorno.FechaEmision
								,	'FechaVcto'				= Retorno.FechaVcto
								,	'Division_IBS'			= isnull( DivIBS.Division, case	when Retorno.Modulo	<> 'OPT' THEN 'Otros'
																							when Retorno.Modulo	 = 'OPT' THEN 'Altos Patrimonios'
																						end )
								,	'SegmentoComercial'		= Retorno.SegmentoComercial
							from	(	select	pivital.Modulo 
											,	pivital.Producto
											,	pivital.Numero_Operacion
											,	pivital.Documento
											,	pivital.Correlativo
											,	pivital.Serie
											,	pivital.RutCliente
											,	pivital.CodCliente
											,	pivital.DvCliente
											,	pivital.NombreCliente
											,	pivital.TipoOperacion
											,	pivital.Monto
											,	pivital.MonTransada
											,	pivital.MonConversion
											,	pivital.TCCierre
											,	pivital.TCCosto
											,	pivital.ParidadCierre
											,	pivital.ParidadCosto
											,	pivital.MontoPesos
											,	pivital.Operador
											,	pivital.MontoDolares
											,	pivital.ResultadoMesa
											,	pivital.Fecha
											,	pivital.Relacionado
											,	pivital.FolioRelacionado
											,	pivital.FechaEmision
											,	pivital.FechaVcto
											,	SegmentoComercial	= Cliente.Seg_Comercial
										from	dbo.TBL_RESULTADOS_MESA_PIVOTAL pivital
												inner join	(	select	clrut, clcodigo, seg_comercial
																from	BacParamSuda.dbo.Cliente with(nolock)
															)	Cliente	On Cliente.clrut = pivital.RutCliente and Cliente.clcodigo = pivital.CodCliente
												-->			Se agrega para determinar las fechas de emision y vencimiento
												left join	(	select	Modulo				= 'BTR'
																	,	monumoper			= monumoper
																	,	monumdocu			= monumdocu
																	,	mocorrela			= mocorrela
																	,	FechaEmision		= mofecemi
																	,	FechaVencimiento	= mofecven
																from	BacTraderSuda.dbo.mdmo with(nolock)
																where	mofecpro			BETWEEN @FechaDesde AND @Fechahasta
																and		motipoper			<> 'TM'
																	union 
																select	Modulo				= 'BTR'
																	,	monumoper			= monumoper
																	,	monumdocu			= monumdocu
																	,	mocorrela			= mocorrela
																	,	FechaEmision		= mofecemi
																	,	FechaVencimiento	= mofecven
																from	BacTraderSuda.dbo.mdmh with(nolock)
																where	mofecpro			BETWEEN	@FechaDesde AND @Fechahasta
																and		motipoper			<> 'TM'
															)	Trader	On	Trader.Modulo		= pivital.Modulo
																		and Trader.monumoper	= pivital.Numero_Operacion
																		and Trader.monumdocu	= pivital.Documento
																		and Trader.mocorrela	= pivital.Correlativo
												-->			Se agrega para determinar las fechas de emision y vencimiento
										where	pivital.Modulo		= 'BTR'
										and	(	(pivital.RutCliente	= @RutCliente) or (@RutCliente = 0)	)

											union

										select	pivital.Modulo 
											,	pivital.Producto
											,	pivital.Numero_Operacion
											,	pivital.Documento
											,	pivital.Correlativo
											,	pivital.Serie
											,	pivital.RutCliente
											,	pivital.CodCliente
											,	pivital.DvCliente
											,	pivital.NombreCliente
											,	pivital.TipoOperacion
											,	pivital.Monto
											,	pivital.MonTransada
											,	pivital.MonConversion
											,	pivital.TCCierre
											,	pivital.TCCosto
											,	pivital.ParidadCierre
											,	pivital.ParidadCosto
											,	pivital.MontoPesos
											,	pivital.Operador
											,	pivital.MontoDolares
											,	pivital.ResultadoMesa
											,	pivital.Fecha
											,	pivital.Relacionado
											,	pivital.FolioRelacionado
											,	pivital.FechaEmision
											,	pivital.FechaVcto
											,	SegmentoComercial	= Cliente.Seg_Comercial
										from	dbo.TBL_RESULTADOS_MESA_PIVOTAL pivital
												left join	(	select	clrut, clcodigo, seg_comercial
																from	BacParamSuda.dbo.Cliente with(nolock)
															)	Cliente	On Cliente.clrut = pivital.RutCliente and Cliente.clcodigo = pivital.CodCliente
										where	pivital.Modulo		<> 'BTR'
										and	(	(pivital.RutCliente	= @RutCliente) or (@RutCliente = 0)	)
									)	Retorno
										left join	(	select	Division, RutCliente
														from	BacParamSuda.dbo.PivotalDivisionCliente with(nolock) 
													)	DivIBS	On DivIBS.RutCliente	= Retorno.RutCliente
						)	Formato

							inner join
							(	select	mnnemo, mncodmon
								from	BacParamSuda.dbo.Moneda with(nolock)
							)	Mon		On Mon.mnnemo	= Formato.MonTransada

							inner join	(	select	Nick	= 'E-Bank'
												,	Nombre	= 'E-Bank'
												,	Rut		= '0'
												union
											select  Nick	= usuario
												,	Nombre	= Nombre
												,	Rut		= RutUsuario
											from	BacParamSuda.dbo.Usuario with(nolock)
										)	usr		On usr.Nick	= Formato.Operador
	
							left join	(	select	segmento, codigobac
											from	BacParamSuda.dbo.PivotalDivisionsEgmento with(nolock)
										)	pds		On pds.CodigoBAC = Formato.SegmentoComercial

							left join	(	select	distinct Resultado, Producto
											from	BacParamSuda.dbo.PivotalResultadoProducto with(nolock)
										)	prp		On prp.Producto	= Formato.Producto

							left join	(	select distinct Canal, Operador
											from   BacParamSuda.dbo.PivotalCanalOperador with(nolock)
										)	pco		On pco.Operador	= Formato.Operador

							left join	(	select	distinct Producto, AG
											from	BacParamSuda.dbo.PivotalProductoAG with(nolock)
										)	ppa		On ppa.Producto = Formato.Producto

							left join	(	select	Operador
												,	Estado		= case when Operador <> '' then 'SI' end
											from	BacParamSuda.dbo.PivotalComexOperador with(nolock)
										)	coc		On coc.Operador	= Formato.Operador
							
							left join	(	select	Familia
												,	Estado = case	when upper(Clasificacion) = 'FLOW'		then 'SI'
																	when upper(Clasificacion) = 'NO FLOW'	then 'NO'
																	else										 '-'
																end
											from	BacParamSuda.dbo.PivotalProductoFlow
										)	Flw		On Flw.Familia = Formato.Producto
			)	Pivotal
	
	order 
	by		Pivotal.modulo
		,	Pivotal.producto
		,	Pivotal.Rut_Cliente
		,	Pivotal.codcliente
		,	Pivotal.numero_operacion
		,	Pivotal.documento
		,	Pivotal.correlativo

end

GO
