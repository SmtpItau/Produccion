USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_Interfaz_Lineas_Itau_II]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--	sp_Interfaz_Lineas_Itau_II 77526480

create procedure [dbo].[sp_Interfaz_Lineas_Itau_II] 
	(	@nRut	numeric(15)	= 0 )
as
begin

	set nocount on 

	select 	Final.Rut
		,	Final.DV
		,	Final.Facility
		,	Final.Moneda
		,	Final.Asignacion
		,	Final.Vencimeinto
		,	Final.PlazoOperacion
		,	Final.IndicadorGarantia
		,	Final.PorcentajeGarantia
		,	Final.IndicadorAval
--		,	AsignadoGeneral
--		,	OcupadoGeneral
		,	Final.AsignadoFacility
		,	Final.Fila  
		,	Final.OcupadoFacility
	from
	(       	 	
		select	Rut
			,	DV
			,	Facility
			,	Moneda
			,	Asignacion
			,	Vencimeinto
			,	PlazoOperacion		= 0
			,	IndicadorGarantia	= 'N'
			,	PorcentajeGarantia	= 0.0
			,	IndicadorAval		= 'N'
	--		,	AsignadoGeneral
	--		,	OcupadoGeneral
			,	AsignadoFacility
			,	Fila = row_number() over ( order by Rut, Facility desc )  
			,	OcupadoFacility
		from
		(	
			select	General.Rut
				,	General.DV
				,	Producto.Facility
				,	Producto.Moneda
				,	General.Asignacion
				,	General.Vencimeinto
				,	AsignadoGeneral		= General.AsignadoGral
				,	OcupadoGeneral		= General.OcupadoGral
				,	AsignadoFacility	= Producto.Asignado
				,	OcupadoFacility		= Producto.Ocupado
			from	
				(	select	Rut			= gral.Rut_Cliente
						,	Codigo		= gral.Codigo_Cliente
						,	Asignacion	= gral.FechaAsignacion
						,	Vencimeinto	= BacParamsuda.dbo.FuncEesHabil( gral.FechaVencimiento )
						,	AsignadoGral= gral.TotalAsignado
						,	OcupadoGral = gral.TotalOcupado
						,	DV			= cli.Cldv
						,	Nombre		= cli.Clnombre
					from	BacLineas.dbo.Linea_general gral with(nolock)
							left join BacParamSuda.dbo.cliente cli with(nolock) on	cli.Clrut		= gral.Rut_Cliente
																				and	cli.Clcodigo	= gral.Codigo_Cliente
				)	General

				left  join
				(	
					select	Rut				= lp.Rut_Cliente
						,	Codigo			= lp.Codigo_Cliente
						,	Facility		= case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
													else lp.Id_Sistema
				 	        				end
						,	Moneda			= mon.mnnemo --> ls.Moneda
						,	Asignado		= max( lp.TotalAsignado )
						,	Ocupado			= sum( lp.TotalOcupado  ) 
					from	BacLineas.dbo.Linea_Producto_por_Plazo lp with(nolock)
							inner join 
							BacLineas.dbo.Linea_Sistema		   ls with(nolock) on	ls.Rut_Cliente		= lp.Rut_Cliente
																				and ls.Codigo_Cliente	= lp.Codigo_Cliente
																				and	ls.Id_Sistema		= lp.Id_Sistema
							left join BacParamSuda.dbo.Moneda mon with(nolock) On	mon.mncodmon		= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	lp.Id_Sistema = 'BTR'
					group 
					by		lp.Rut_Cliente
						,	lp.Codigo_Cliente
						,	ls.Moneda
						,	mon.mnnemo
						,	case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
									else lp.Id_Sistema
				 			end
		
						union 
		
					select	Rut				= ls.Rut_Cliente
						,	Codigo			= ls.Codigo_Cliente
						,	Facility		= ls.Id_Sistema
						,	Moneda			= mon.mnnemo
						,	Asignado		= ls.TotalAsignado
						,	Ocupado			= ls.TotalOcupado 
					from	BacLineas.dbo.Linea_Sistema ls with(nolock)
							left join BacParamSuda.dbo.Moneda mon with(nolock) On mon.mncodmon	= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	ls.Id_Sistema	IN('BCC', 'PCS', 'DRV', 'BCC', 'BFW', 'BTR', 'OPT') 

				)	Producto	On	Producto.Rut	= General.Rut
								and Producto.Codigo	= General.Codigo
			where	General.AsignadoGral	>  0

				union

			select	General.Rut
				,	General.DV
				,	Producto.Facility
				,	Producto.Moneda
				,	General.Asignacion
				,	General.Vencimeinto
				,	AsignadoGeneral		= case when General.AsignadoGral = 0 then Producto.Asignado else General.AsignadoGral end
				,	OcupadoGeneral		= General.OcupadoGral
				,	AsignadoFacility	= Producto.Asignado
				,	OcupadoFacility		= Producto.Ocupado
			from	
				(	select	Rut			= gral.Rut_Cliente
						,	Codigo		= gral.Codigo_Cliente
						,	Asignacion	= gral.FechaAsignacion
						,	Vencimeinto	= BacParamsuda.dbo.FuncEesHabil( gral.FechaVencimiento )
						,	AsignadoGral= gral.TotalAsignado
						,	OcupadoGral = gral.TotalOcupado
						,	DV			= cli.Cldv
						,	Nombre		= cli.Clnombre
					from	BacLineas.dbo.Linea_general gral with(nolock)
							inner join BacParamSuda.dbo.cliente cli with(nolock) on	cli.Clrut		= gral.Rut_Cliente
																				and	cli.Clcodigo	= gral.Codigo_Cliente
				)	General

				left  join
				(	
					select	Rut				= lp.Rut_Cliente
						,	Codigo			= lp.Codigo_Cliente
						,	Facility		= case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
													else lp.Id_Sistema
				 	        				end
						,	Moneda			= mon.mnnemo --> ls.Moneda
						,	Asignado		= max( lp.TotalAsignado )
						,	Ocupado			= sum( lp.TotalOcupado  ) 
					from	BacLineas.dbo.Linea_Producto_por_Plazo lp with(nolock)
							inner join 
							BacLineas.dbo.Linea_Sistema		   ls with(nolock) on	ls.Rut_Cliente		= lp.Rut_Cliente
																				and ls.Codigo_Cliente	= lp.Codigo_Cliente
																				and	ls.Id_Sistema		= lp.Id_Sistema
							left join BacParamSuda.dbo.Moneda mon with(nolock) On	mon.mncodmon		= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	lp.Id_Sistema = 'BTR'
					group 
					by		lp.Rut_Cliente
						,	lp.Codigo_Cliente
						,	ls.Moneda
						,	mon.mnnemo
						,	case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
									else lp.Id_Sistema
				 			end
		
						union 
		
					select	Rut				= ls.Rut_Cliente
						,	Codigo			= ls.Codigo_Cliente
						,	Facility		= ls.Id_Sistema
						,	Moneda			= mon.mnnemo
						,	Asignado		= ls.TotalAsignado
						,	Ocupado			= ls.TotalOcupado 
					from	BacLineas.dbo.Linea_Sistema ls with(nolock)
							left join BacParamSuda.dbo.Moneda mon with(nolock) On mon.mncodmon	= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	ls.Id_Sistema	IN('BCC', 'PCS', 'DRV', 'BCC', 'BFW', 'BTR', 'OPT') 

				)	Producto	On	Producto.Rut	= General.Rut
								and Producto.Codigo	= General.Codigo

			where	General.AsignadoGral	=  0
			and		producto.Asignado		>  0
			and		General.OcupadoGral		=  0

				union

			select	General.Rut
				,	General.DV
				,	Producto.Facility
				,	Producto.Moneda
				,	General.Asignacion
				,	General.Vencimeinto
				,	AsignadoGeneral		= case when General.AsignadoGral = 0 then Producto.Asignado else General.AsignadoGral end
				,	OcupadoGeneral		= General.OcupadoGral
				,	AsignadoFacility	= Producto.Asignado
				,	OcupadoFacility		= Producto.Ocupado
			from	
				(	select	Rut			= gral.Rut_Cliente
						,	Codigo		= gral.Codigo_Cliente
						,	Asignacion	= gral.FechaAsignacion
						,	Vencimeinto	= BacParamsuda.dbo.FuncEesHabil( gral.FechaVencimiento )
						,	AsignadoGral= gral.TotalAsignado
						,	OcupadoGral = gral.TotalOcupado
						,	DV			= cli.Cldv
						,	Nombre		= cli.Clnombre
					from	BacLineas.dbo.Linea_general gral with(nolock)
							inner join BacParamSuda.dbo.cliente cli with(nolock) on	cli.Clrut		= gral.Rut_Cliente
																				and	cli.Clcodigo	= gral.Codigo_Cliente
				)	General

				left  join
				(	
					select	Rut				= lp.Rut_Cliente
						,	Codigo			= lp.Codigo_Cliente
						,	Facility		= case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
													else lp.Id_Sistema
				 	        				end
						,	Moneda			= mon.mnnemo --> ls.Moneda
						,	Asignado		= max( lp.TotalAsignado )
						,	Ocupado			= sum( lp.TotalOcupado  ) 
					from	BacLineas.dbo.Linea_Producto_por_Plazo lp with(nolock)
							inner join 
							BacLineas.dbo.Linea_Sistema		   ls with(nolock) on	ls.Rut_Cliente		= lp.Rut_Cliente
																				and ls.Codigo_Cliente	= lp.Codigo_Cliente
																				and	ls.Id_Sistema		= lp.Id_Sistema
							left join BacParamSuda.dbo.Moneda mon with(nolock) On	mon.mncodmon		= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	lp.Id_Sistema = 'BTR'
					group 
					by		lp.Rut_Cliente
						,	lp.Codigo_Cliente
						,	ls.Moneda
						,	mon.mnnemo
						,	case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
									else lp.Id_Sistema
				 			end
		
						union 
		
					select	Rut				= ls.Rut_Cliente
						,	Codigo			= ls.Codigo_Cliente
						,	Facility		= ls.Id_Sistema
						,	Moneda			= mon.mnnemo
						,	Asignado		= ls.TotalAsignado
						,	Ocupado			= ls.TotalOcupado 
					from	BacLineas.dbo.Linea_Sistema ls with(nolock)
							left join BacParamSuda.dbo.Moneda mon with(nolock) On mon.mncodmon	= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	ls.Id_Sistema	IN('BCC', 'PCS', 'DRV', 'BCC', 'BFW', 'BTR', 'OPT') 

				)	Producto	On	Producto.Rut	= General.Rut
								and Producto.Codigo	= General.Codigo

			where	General.AsignadoGral	=  0
			and		producto.Asignado		>  0
			and		General.OcupadoGral		>  0

			union

			select	General.Rut
				,	General.DV
				,	Producto.Facility
				,	Producto.Moneda
				,	General.Asignacion
				,	General.Vencimeinto
				,	AsignadoGeneral		= General.OcupadoGral
				,	OcupadoGeneral		= General.OcupadoGral
				,	AsignadoFacility	= Producto.Asignado
				,	OcupadoFacility		= Producto.Ocupado
			from	
				(	select	Rut			= gral.Rut_Cliente
						,	Codigo		= gral.Codigo_Cliente
						,	Asignacion	= gral.FechaAsignacion
						,	Vencimeinto	= BacParamsuda.dbo.FuncEesHabil( gral.FechaVencimiento )
						,	AsignadoGral= gral.TotalAsignado
						,	OcupadoGral = gral.TotalOcupado
						,	DV			= cli.Cldv
						,	Nombre		= cli.Clnombre
					from	BacLineas.dbo.Linea_general gral with(nolock)
							inner join BacParamSuda.dbo.cliente cli with(nolock) on	cli.Clrut		= gral.Rut_Cliente
																				and	cli.Clcodigo	= gral.Codigo_Cliente
				)	General

				left  join
				(	
					select	Rut				= lp.Rut_Cliente
						,	Codigo			= lp.Codigo_Cliente
						,	Facility		= case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
													when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
													else lp.Id_Sistema
				 	        				end
						,	Moneda			= mon.mnnemo --> ls.Moneda
						,	Asignado		= max( lp.TotalAsignado )
						,	Ocupado			= sum( lp.TotalOcupado  ) 
					from	BacLineas.dbo.Linea_Producto_por_Plazo lp with(nolock)
							inner join 
							BacLineas.dbo.Linea_Sistema		   ls with(nolock) on	ls.Rut_Cliente		= lp.Rut_Cliente
																				and ls.Codigo_Cliente	= lp.Codigo_Cliente
																				and	ls.Id_Sistema		= lp.Id_Sistema
							left join BacParamSuda.dbo.Moneda mon with(nolock) On	mon.mncodmon		= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	lp.Id_Sistema = 'BTR'
					group 
					by		lp.Rut_Cliente
						,	lp.Codigo_Cliente
						,	ls.Moneda
						,	mon.mnnemo
						,	case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
									when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
									else lp.Id_Sistema
				 			end
		
						union 
		
					select	Rut				= ls.Rut_Cliente
						,	Codigo			= ls.Codigo_Cliente
						,	Facility		= ls.Id_Sistema
						,	Moneda			= mon.mnnemo
						,	Asignado		= ls.TotalAsignado
						,	Ocupado			= ls.TotalOcupado 
					from	BacLineas.dbo.Linea_Sistema ls with(nolock)
							left join BacParamSuda.dbo.Moneda mon with(nolock) On mon.mncodmon	= convert(int, ltrim(rtrim( ls.Moneda )) )
					where	ls.Id_Sistema	IN('BCC', 'PCS', 'DRV', 'BCC', 'BFW', 'BTR', 'OPT') 

				)	Producto	On	Producto.Rut	= General.Rut
								and Producto.Codigo	= General.Codigo

			where	General.AsignadoGral	=  0
			and		producto.Asignado		=  0
			and		General.OcupadoGral		>  0
		)	Limites
		where	Limites.DV			is not null 
		and		Limites.Facility	is not null 
		and		Limites.Moneda		is not null
	)Final
	where Final.rut = @nRut or @nRut = 0
	order 
	by		Final.Fila desc

			
end
GO
