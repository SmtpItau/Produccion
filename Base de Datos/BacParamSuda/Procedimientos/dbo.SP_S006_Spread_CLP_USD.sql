USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S006_Spread_CLP_USD]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S006_Spread_CLP_USD]
	(	@FechaDesde			DATETIME
	,	@FechaHasta			DATETIME
	,	@MedaDistibucion	INT				= 1
	,	@RutCliente			NUMERIC(12)		= 0
	,	@Producto 			NVARCHAR(25)	= ''
	)
as
begin

	set nocount on

	-->		Activa el Retorno de Pivotal, desde la Query de Resultados a la tabla : TBL_RESULTADOS_MESA_PIVOTAL
	declare @Pivotal	int
		set @Pivotal	= 1

	Execute dbo.QUERY_RESULTADO_MESA_ENTREFECHAS @FechaDesde, @FechaHasta, @MedaDistibucion, @Pivotal, @RutCliente
	-->		Activa el Retorno de Pivotal, desde la Query de Resultados a la tabla : TBL_RESULTADOS_MESA_PIVOTAL

	select	Rut			= Agrupado.Rut
		,	Producto	= Agrupado.Producto
		,	Minimo		= convert(numeric(21,8), Agrupado.Minimo )
		,	Ultimo		= convert(numeric(21,8), maximo.Spread )
		,	Maximo		= convert(numeric(21,8), Agrupado.Maximo )
		,	Promedio	= convert(numeric(21,8), PromedioAcum )		--	convert(numeric(21,8), Agrupado.Promedio )
	from
		(	
			select	Rut			= Spread.Rut
				,	Producto	= Spread.Producto
				,	Minimo		= min( Spread.Spread )
				,	Maximo		= max( Spread.Spread )
				,	Promedio	= avg( Spread.Spread )
				,	Puntero		= max( Spread.Contador )
				,	PromedioAcum= SUM( ResultadoAcum ) / SUM( DolaresAcum )
			from	
				(	
					select	Rut				= Query.Rut
						,	Producto		= Query.Producto
						,	Spread			= (Query.Resultado / Query.Dolares)
						,	Contador		= row_number () over (order by Query.Rut, Query.Producto, Query.Fecha, Query.Folio)
						----------------------------------------------
						,	DolaresAcum		= Query.Dolares
						,	ResultadoAcum	= Query.Resultado
					from	
						(	select	Fecha		=	pivital.Fecha
								,	Emision		=	pivital.FechaEmision
								,	Rut			=	ltrim(rtrim( pivital.RutCliente )) + ltrim(rtrim( pivital.DvCliente ))
								,	Folio		=	pivital.Numero_Operacion
								,	Producto	=	case	--	 Renta Fija Nacional
														when pivital.modulo = 'BTR' and pivital.Producto = 'COMPRA C/ PACTO'	then 'PACTOS'
														when pivital.modulo = 'BTR' and pivital.Producto = 'VENTA C/ PACTO'		then 'PACTOS'
														when pivital.modulo = 'BTR' and pivital.Producto = 'INTERBANCARIO'		then 'INTERB'
														--	 Spot ( Spot, Spor Web, Dolares Ny
														when pivital.modulo = 'BCC' and pivital.Producto = 'SPOT WEB'			then 'SPOT-WEB'
														when pivital.modulo = 'BCC' and pivital.Producto = 'US$ NEW YORK'		then 'US$ NEW YORK'
														when pivital.modulo = 'BCC'												then 'SPOT'
														--	 Forward
														when pivital.modulo = 'BFW' and substring(pivital.Producto,1,3) = 'ANT'	then 'ANT-FWD'
														when pivital.modulo = 'BFW'												then 'FWD'
														--   Swaps
														when pivital.modulo = 'PCS' and substring(pivital.Producto,1,3) = 'ANT'	then 'ANT-SWAP'
														when pivital.modulo = 'PCS'												then 'SWAP'
														--	 Opciones
														when pivital.modulo = 'OPT' and substring(pivital.Producto,1,3) = 'ANT'	then 'ANT-OPT'
														when pivital.modulo = 'OPT' and substring(pivital.Producto,1,3) = 'PAE'	then 'PAE'
														when pivital.modulo = 'OPT'												then 'OPT'
														else pivital.Producto
													end
								,	Resultado	=	pivital.ResultadoMesa
								,	Dolares		=	case	when pivital.MontoDolares = 0.0  then BacParamSuda.dbo.fx_convierte_monto( pivital.FechaEmision, Moneda.mncodmon, pivital.Monto, 13)
															else pivital.MontoDolares
														end
							from	dbo.TBL_RESULTADOS_MESA_PIVOTAL pivital with(nolock)
									left join
									(	select	mncodmon, mnnemo
										from	bacparamsuda.dbo.moneda with(nolock)
									)	Moneda	On Moneda.mnnemo = pivital.MonTransada
									left join	
									(	select	Fecha = vmfecha, DO = Round(vmvalor, 4)
										from	BacParamSuda.dbo.Valor_Moneda with(nolock)
										where	vmcodigo	= 994
									)	DO		On DO.Fecha	= pivital.FechaEmision
							where		pivital.Monto			> 0.0
							and		(	pivital.RutCliente		= @RutCliente or @RutCliente = 0	)
						)	Query
				)	Spread
			group 
			by		Spread.Rut
				,	Spread.Producto
		)	Agrupado



			inner join
			(	select	Rut			= Query.Rut
					,	Producto	= Query.Producto
					,	Spread		= (Query.Resultado / Query.Dolares)
					,	Contador	= row_number () over (order by Query.Rut, Query.Producto, Query.Fecha, Query.Folio)
				from	
					(	select	Fecha		= pivital.Fecha
							,	Emision		= pivital.FechaEmision
							,	Rut			= ltrim(rtrim( pivital.RutCliente )) + ltrim(rtrim( pivital.DvCliente ))
							,	Folio		= pivital.Numero_Operacion
							,	Producto	=	case	--	 Renta Fija Nacional
													when pivital.modulo = 'BTR' and pivital.Producto = 'COMPRA C/ PACTO'	then 'PACTOS'
													when pivital.modulo = 'BTR' and pivital.Producto = 'VENTA C/ PACTO'		then 'PACTOS'
													when pivital.modulo = 'BTR' and pivital.Producto = 'INTERBANCARIO'		then 'INTERB'
													--	 Spot ( Spot, Spor Web, Dolares Ny
													when pivital.modulo = 'BCC' and pivital.Producto = 'SPOT WEB'			then 'SPOT-WEB'
													when pivital.modulo = 'BCC' and pivital.Producto = 'US$ NEW YORK'		then 'US$ NEW YORK'
													when pivital.modulo = 'BCC'												then 'SPOT'
													--	 Forward
													when pivital.modulo = 'BFW' and substring(pivital.Producto,1,3) = 'ANT'	then 'ANT-FWD'
													when pivital.modulo = 'BFW'												then 'FWD'
													--   Swaps
													when pivital.modulo = 'PCS' and substring(pivital.Producto,1,3) = 'ANT'	then 'ANT-SWAP'
													when pivital.modulo = 'PCS'												then 'SWAP'
													--	 Opciones
													when pivital.modulo = 'OPT' and substring(pivital.Producto,1,3) = 'ANT'	then 'ANT-OPT'
													when pivital.modulo = 'OPT' and substring(pivital.Producto,1,3) = 'PAE'	then 'PAE'
													when pivital.modulo = 'OPT'												then 'OPT'
													else pivital.Producto
												end
							,	Resultado	= pivital.ResultadoMesa
							,	Dolares		= case	when pivital.MontoDolares = 0.0  then BacParamSuda.dbo.fx_convierte_monto( pivital.FechaEmision, Moneda.mncodmon, pivital.Monto, 13)
													else pivital.MontoDolares
												end
						from	dbo.TBL_RESULTADOS_MESA_PIVOTAL pivital with(nolock)
								left join
								(	select	mncodmon, mnnemo
									from	bacparamsuda.dbo.moneda with(nolock)
								)	Moneda	On Moneda.mnnemo = pivital.MonTransada
								left join	
								(	select	Fecha = vmfecha, DO = Round(vmvalor, 4)
									from	BacParamSuda.dbo.Valor_Moneda with(nolock)
									where	vmcodigo	= 994
								)	DO		On DO.Fecha	= pivital.FechaEmision
						where		pivital.Monto			> 0.0
						and		(	pivital.RutCliente		= @RutCliente or @RutCliente = 0	)
					)	Query
				)	maximo	On maximo.Contador	= Agrupado.Puntero

end

GO
