USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_Interfaz_Lineas_Itau]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Interfaz_Lineas_Itau] 
	(	@nRut	numeric(15)	=	0	)
as
begin

		--	modificada
	set nocount on

	select	Salida.Rut
		,	Salida.Dv 
		,	Salida.Facility
		,	Salida.MonedaFacility
		,	Salida.FecAsignacion
		,	Salida.FecVencimiento
		,	Salida.PlazoOperacion
		,	Salida.IndicadorGarantia
		,	Salida.PorcentajeGarantia
		,	Salida.IndicadorAval
		,	LimiteMonedaOrigen	= round(Salida.LimiteMonedaOrigen, 0)
		,	Salida.NumeroLinea
		,	MontoOcupado		= round(Salida.MontoOcupado, 0)
	from
	(
		select	Rut					= Lineas.Rut
			,	Dv					= Lineas.Dv
			,	Facility			= Lineas.Facility
			,	MonedaFacility		= Lineas.MonedaFacility
			,	FecAsignacion		= Lineas.FecAsignacion
			,	FecVencimiento		= Lineas.FecVencimiento
			,	PlazoOperacion		= 0
			,	IndicadorGarantia	= 'N'
			,	PorcentajeGarantia	= 0.0
			,	IndicadorAval		= 'N'
			,	LimiteMonedaOrigen	= Lineas.MontoLineaGeneral
			,	NumeroLinea			= row_number() over (order by Lineas.Rut, Lineas.Facility desc)
			,	MontoOcupado		= Lineas.OcupadoFacility
		from 
		(
				select	Rut					= General.Rut				-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.Rut			))			else ' ' end
					,	Codigo				= General.Codigo			-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.Codigo			))			else ' ' end
					,	Dv					= General.DV				-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.DV				))			else ' ' end
					,	Nombre				= General.Nombre			-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.Nombre			))			else ' ' end
					,	FecAsignacion		= General.Asignacion		-->	case when Facility.IdFacilitys = 1 then convert(char(10), General.Asignacion,	 103)	else ' ' end
					,	FecVencimiento		= General.Vencimiento		-->	case when Facility.IdFacilitys = 1 then convert(char(10), General.Vencimiento, 103)		else ' ' end
					,	MonLinea			= General.MonedaLinea		-->	case when Facility.IdFacilitys = 1 then General.MonedaLinea								else ' ' end
					,	MontoLineaGeneral	= General.LineaGeneral		-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.LineaGeneral ))			else ' ' end
					,	MontoOcupadoGeneral	= General.OcupadoGeneral	-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.OcupadoGeneral ))			else ' ' end
					,	Facility			= Facility.Facility
					,	MonedaFacility		= Facility.Moneda
					,	AsignadoFacility	= case	when Facility.Asignado = 0 and Facility.Ocupado > 0 then Facility.Ocupado 
													else Facility.Asignado
												end  
					,	OcupadoFacility		= Facility.Ocupado
				from
					(
						select	Rut				= cl.clrut
							,	Codigo			= cl.Clcodigo
							,	Nombre			= cl.Clnombre
							,	DV				= cl.cldv
							,	Asignacion		= lg.FechaAsignacion
							,	Vencimiento		= BacParamsuda.dbo.FuncEesHabil( lg.FechaVencimiento )
							,	MonedaLinea		= mon.mnnemo
							,	LineaGeneral	= lg.TotalAsignado
							,	OcupadoGeneral	= lg.TotalOcupado
							,	Id				= Row_Number() over (partition by cl.clrut, cl.clcodigo order by cl.clrut, cl.clcodigo )
						from	BacLineas.dbo.Linea_general lg with(nolock)
								inner join bacparamsuda.dbo.cliente cl with(nolock) On	cl.Clrut	= lg.Rut_Cliente
																					and	cl.Clcodigo	= lg.Codigo_Cliente
								left join BacParamSuda.dbo.MONEDA mon with(nolock) On mon.mncodmon	= lg.Moneda
						where	lg.TotalAsignado > 0
			
					)	General

					inner join		

					(
						select	Rut				= lp.Rut_Cliente
							,	Codigo			= lp.Codigo_Cliente
							,	Facility		= case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
														when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
														when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
														when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
														else lp.Id_Sistema
				 									end
							,	Moneda			= mon.mnnemo
							,	Asignado		= max( lp.TotalAsignado )
							,	Ocupado			= sum( lp.TotalOcupado  ) 
							,	IdFacilitys		= Row_Number() over (partition by lp.Rut_Cliente, lp.codigo_cliente order by lp.Rut_Cliente, lp.codigo_cliente )
						from	BacLineas.dbo.Linea_Producto_por_Plazo lp with(nolock)
								inner join
								BacLineas.dbo.Linea_Sistema		   ls with(nolock) on	ls.Rut_Cliente		= lp.Rut_Cliente
																					and ls.Codigo_Cliente	= lp.Codigo_Cliente
																					and	ls.Id_Sistema		= lp.Id_Sistema
								left join BacParamSuda.dbo.Moneda mon with(nolock) On	mon.mncodmon		= convert(int, ltrim(rtrim( ls.Moneda )) )
						where	lp.Id_Sistema	= 'BTR'
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
							,	IdFacilitys		= Row_Number() over (partition by ls.Rut_Cliente, ls.codigo_cliente order by ls.Rut_Cliente, ls.codigo_cliente ) 
						from	BacLineas.dbo.Linea_Sistema ls with(nolock)
								left join BacParamSuda.dbo.Moneda mon with(nolock) On mon.mncodmon	= convert(int, ltrim(rtrim( ls.Moneda )) )
						where	ls.Id_Sistema	IN('BCC', 'PCS', 'DRV', 'BCC', 'BFW', 'BTR', 'OPT')
		
					)	Facility	on	General.Rut		= facility.Rut
									and	General.Codigo	= facility.Codigo

					union

				select	Rut					= General.Rut				-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.Rut		))			else ' ' end
					,	Codigo				= General.Codigo			-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.Codigo		))			else ' ' end
					,	Dv					= General.DV				-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.DV			))			else ' ' end
					,	Nombre				= General.Nombre			-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.Nombre		))			else ' ' end
					,	FecAsignacion		= General.Asignacion		-->	case when Facility.IdFacilitys = 1 then convert(char(10), General.Asignacion,  103)	else ' ' end
					,	FecVencimiento		= General.Vencimiento		-->	case when Facility.IdFacilitys = 1 then convert(char(10), General.Vencimiento, 103)	else ' ' end
					,	MonLinea			= General.MonedaLinea		-->	case when Facility.IdFacilitys = 1 then General.MonedaLinea							else ' ' end
					,	MontoLineaGeneral	= General.OcupadoGeneral	-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.OcupadoGeneral ))		else ' ' end	--> *
					,	MontoOcupadoGeneral	= General.OcupadoGeneral	-->	case when Facility.IdFacilitys = 1 then ltrim(rtrim( General.OcupadoGeneral ))		else ' ' end
					,	Facility			= Facility.Facility
					,	MonedaFacility		= Facility.Moneda
					,	AsignadoFacility	= case	when Facility.Asignado = 0 and Facility.Ocupado > 0 then Facility.Ocupado 
													else Facility.Asignado
												end  
					,	OcupadoFacility		= Facility.Ocupado
				from
					(
						select	Rut				= cl.clrut
							,	Codigo			= cl.Clcodigo
							,	Nombre			= cl.Clnombre
							,	DV				= cl.cldv
							,	Asignacion		= lg.FechaAsignacion
							,	Vencimiento		= BacParamsuda.dbo.FuncEesHabil( lg.FechaVencimiento )
							,	MonedaLinea		= mon.mnnemo
							,	LineaGeneral	= lg.TotalAsignado
							,	OcupadoGeneral	= lg.TotalOcupado
							,	Id				= Row_Number() over (partition by cl.clrut, cl.clcodigo order by cl.clrut, cl.clcodigo )
						from	BacLineas.dbo.Linea_general lg with(nolock)
								inner join bacparamsuda.dbo.cliente cl with(nolock) On	cl.Clrut	= lg.Rut_Cliente
																					and	cl.Clcodigo	= lg.Codigo_Cliente
								left join BacParamSuda.dbo.MONEDA mon with(nolock) On mon.mncodmon	= lg.Moneda
						where	lg.TotalAsignado = 0 and lg.TotalOcupado > 0
			
					)	General

					inner join		

					(
						select	Rut				= lp.Rut_Cliente
							,	Codigo			= lp.Codigo_Cliente
							,	Facility		= case	when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CP'	then 'BTR'
														when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'IC'	then 'BTR1'
														when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'ICOL'	then 'BTR2'
														when lp.Id_Sistema = 'BTR' and lp.codigo_producto = 'CI'	then 'BTR3'
														else lp.Id_Sistema
				 									end
							,	Moneda			= mon.mnnemo
							,	Asignado		= max( lp.TotalAsignado )
							,	Ocupado			= sum( lp.TotalOcupado  ) 
							,	IdFacilitys		= Row_Number() over (partition by lp.Rut_Cliente, lp.codigo_cliente order by lp.Rut_Cliente, lp.codigo_cliente )
						from	BacLineas.dbo.Linea_Producto_por_Plazo lp with(nolock)
								inner join
								BacLineas.dbo.Linea_Sistema		   ls with(nolock) on	ls.Rut_Cliente		= lp.Rut_Cliente
																					and ls.Codigo_Cliente	= lp.Codigo_Cliente
																					and	ls.Id_Sistema		= lp.Id_Sistema
								left join BacParamSuda.dbo.Moneda mon with(nolock) On	mon.mncodmon		= convert(int, ltrim(rtrim( ls.Moneda )) )
						where	lp.Id_Sistema	= 'BTR'
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
							,	IdFacilitys		= Row_Number() over (partition by ls.Rut_Cliente, ls.codigo_cliente order by ls.Rut_Cliente, ls.codigo_cliente ) 
						from	BacLineas.dbo.Linea_Sistema ls with(nolock)
								left join BacParamSuda.dbo.Moneda mon with(nolock) On mon.mncodmon	= convert(int, ltrim(rtrim( ls.Moneda )) )
						where	ls.Id_Sistema	IN('BCC', 'PCS', 'DRV', 'BCC', 'BFW', 'BTR', 'OPT')
		
					)	Facility	on	General.Rut		= facility.Rut
									and	General.Codigo	= facility.Codigo
		)	Lineas
--		where	Lineas.Rut	IN( 77750920, 97023000 )
		where	Lineas.Rut	NOT IN	(	select	clrut 
		     	          				from	bacparamSuda.dbo.cliente with(nolock) 
		     	          	        	where	clcodigo >= 1 
		     	          	        	group 
		     	          	        	by		clrut 
		     	          	        	having count(1) > 1 
									)
		AND		Lineas.Rut	=	@nRut 
	)	Salida

	order 
	by 		Salida.NumeroLinea desc
	 
end
GO
