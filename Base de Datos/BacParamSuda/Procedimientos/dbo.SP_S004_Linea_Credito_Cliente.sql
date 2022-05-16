USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S004_Linea_Credito_Cliente]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_S004_Linea_Credito_Cliente]
	(	@RutCliente			INT				= 0
	,	@Familia_Producto	NVARCHAR(25)	= ''
	)
as
begin
	
	set nocount on 

	/*
		Bajo esta metodologia, se estaria desplegando:
		Derivados    Flow	: Montos de la linea General
		Derivados No Flow 
		y Renta Fija		: Montos de la Linea Sistema
	*/

	select	Producto			= LinSis.Descripcion
		,	Moneda				= LinSis.Moneda
		,	Desde				= LinPla.Desde
		,	Hasta				= LinPla.Hasta
		,	Monto_Disponible	= Format( LinSis.Disponible, 'F2','es-cl')
		,	Monto_Threshold		= Format( LinGen.Treshold, 'F2','es-cl')
		,	Monto_Asignado		= Format( LinSis.Asignado, 'F2','es-cl')
		,	Estado				= case	when LinGen.FechaVencimiento <= LinGen.FechaProceso then 'Vencida'
										when LinGen.Bloqueado		  = 'S'					then 'Bloqueada'
										when LinSis.Ocupado			  > LinSis.Asignado		then 'Excedida'
										when LinSis.Disponible		 >= 0					then 'Vigente'
										else													 'Vigente'
									end
		,	Fecha_Vencimiento	= replace(convert(varchar,LinGen.FechaVencimiento,111),'/','-')
	from	(	select	Rut			= linsis.Rut_Cliente
					,	Modulo		= case	when linsis.id_sistema = 'bcc' then 1
											when linsis.id_sistema = 'bfw' then 2
											when linsis.id_sistema = 'opt' then 2
											when linsis.id_sistema = 'pcs' then 3
											when linsis.id_sistema = 'drv' then 4
											when linsis.id_sistema = 'btr' then 5
											when linsis.id_sistema = 'bex' then 6
										end
					,	Descripcion	= case	when linsis.id_sistema = 'bcc' then 'SPOT'
											when linsis.id_sistema = 'bfw' then 'FORWARD'
											when linsis.id_sistema = 'opt' then 'FORWARD'
											when linsis.id_sistema = 'pcs' then 'SWAP'
											when linsis.id_sistema = 'drv' then 'DRV'
											when linsis.id_sistema = 'btr' then 'RENTA FIJA'
											when linsis.id_sistema = 'bex' then 'RENTA FIJA'
										end
					,	Asignado	= sum( linsis.TotalAsignado )
					,	Ocupado		= sum( linsis.TotalOcupado )
					,	Disponible	= sum( linsis.TotalAsignado) - sum(linsis.TotalOcupado)
					,	Moneda		= mon.mnnemo
				from	baclineas.dbo.linea_sistema linsis with(nolock)
						left join
						(	select	mncodmon
								,	mnnemo
							from	bacparamsuda.dbo.moneda with(nolock)
						)	mon		On mon.mncodmon	= isnull(linsis.moneda, 999)
				where	linsis.Rut_Cliente	= @RutCliente
				group
				by		linsis.Rut_Cliente
					,	case	when linsis.id_sistema = 'bcc' then 1
								when linsis.id_sistema = 'bfw' then 2
								when linsis.id_sistema = 'opt' then 2
								when linsis.id_sistema = 'pcs' then 3
								when linsis.id_sistema = 'drv' then 4
								when linsis.id_sistema = 'btr' then 5
								when linsis.id_sistema = 'bex' then 6
							end
					,	case	when linsis.id_sistema = 'bcc' then 'SPOT'
								when linsis.id_sistema = 'bfw' then 'FORWARD'
								when linsis.id_sistema = 'opt' then 'FORWARD'
								when linsis.id_sistema = 'pcs' then 'SWAP'
								when linsis.id_sistema = 'drv' then 'DRV'
								when linsis.id_sistema = 'btr' then 'RENTA FIJA'
								when linsis.id_sistema = 'bex' then 'RENTA FIJA'
							end
					,	mon.mnnemo
			)	LinSis

			inner join
			(	select	Rut					= lg.rut_cliente
					,	Treshold			= lg.Monto_Linea_Threshold
					,	FechaProceso		= (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
					,	FechaVencimiento	= lg.FechaVencimiento
					,	Bloqueado			= lg.Bloqueado
				from	BacLineas.dbo.linea_general lg with(nolock)
				where	lg.rut_cliente		= @RutCliente
			)	LinGen	On LinGen.Rut		= LinSis.Rut

			inner join
				(	select	Rut				= lpp.rut_cliente
						,	Modulo			= case	when lpp.id_sistema = 'bcc' then 'SPOT'
													when lpp.id_sistema = 'bfw' then 'FORWARD'
													when lpp.id_sistema = 'opt' then 'FORWARD'
													when lpp.id_sistema = 'pcs' then 'SWAP'
													when lpp.id_sistema = 'drv' then 'DRV'
													when lpp.id_sistema = 'btr' then 'RENTA FIJA'
													when lpp.id_sistema = 'bex' then 'RENTA FIJA'
												end
						,	Desde			= min( lpp.plazodesde )
						,	Hasta			= max( lpp.plazohasta )
					from	baclineas.dbo.linea_producto_por_plazo lpp with(nolock)
					where	lpp.rut_cliente	= @RutCliente
					group 
					by		lpp.rut_cliente
						,	case	when lpp.id_sistema = 'bcc' then 'SPOT'
									when lpp.id_sistema = 'bfw' then 'FORWARD'
									when lpp.id_sistema = 'opt' then 'FORWARD'
									when lpp.id_sistema = 'pcs' then 'SWAP'
									when lpp.id_sistema = 'drv' then 'DRV'
									when lpp.id_sistema = 'btr' then 'RENTA FIJA'
									when lpp.id_sistema = 'bex' then 'RENTA FIJA'
								end
				)	LinPla	On	LinPla.Rut		= LinSis.Rut
							and	LinPla.Modulo	= LinSis.Descripcion

		where	( linsis.Descripcion = @Familia_Producto or @Familia_Producto = '' )
		order
		by		LinSis.Modulo
			,	LinPla.Desde
			,	LinPla.Hasta

end

GO
