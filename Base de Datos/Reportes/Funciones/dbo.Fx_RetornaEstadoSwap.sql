USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RetornaEstadoSwap]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Fx_RetornaEstadoSwap]
	(	@nFolio		numeric(9)		-->	folio del Contrato
	,	@nFechaD	datetime		-->	Fecha a la cual se esta realizando el control
	,	@nFechaA	datetime		-->	No se Ocupa bajo el nuevo formato.
	,	@origen   	CHAR(6)		-->  origen 'TR-' o 'TR-NY-' 
	)	returns		varchar(50)		-->	Retorno del Estado
as
begin

	declare @dFechaCorte		datetime	;	set @dFechaCorte	= @nFechaD
	declare @cEstado			varchar(50)	;	set @cEstado		= 'Sin Estado'
	declare @nEstado			int			;	set @nEstado		= -1
	declare @dFechaCierre		datetime	;	set @dFechaCierre	= @dFechaCorte

IF(@origen = 'TR-')
    BEGIN 
	    --------------------------------------------------------------------------------------------------------------------
	    select	@nEstado		= MovSwap.nEstado
		    ,	@cEstado		= case	when MovSwap.nEstado = 1 then 'Ingreso'
									    else case	when MovSwap.Cierre = @dFechaCorte then 'Ingreso'
												    else 'Ingreso'
											    end
								    end
		    ,	@dFechaCierre	= MovSwap.Cierre
	    from	(
				    select	nEstado				= 1	-->	'Ingreso Del Día'
					    ,	Cierre				= fecha_cierre
				    from	BacSwapsuda.dbo.MovDiario with(nolock)
				    where	numero_operacion	= @nFolio
				    and		tipo_flujo			= 1
					    union
				    select	nEstado				= 2	-->	'Ingreso Historico'
					    ,	Cierre				= fecha_cierre
				    from	BacSwapsuda.dbo.MovHistorico with(nolock)
				    where	numero_operacion	= @nFolio
				    and		tipo_flujo			= 1
			    )	MovSwap
	    --------------------------------------------------------------------------------------------------------------------

	    --------------------------------------------------------------------------------------------------------------------
	    select	@nEstado			= 3
		    ,	@cEstado			= 'Modificacion' 
	    from	BacSwapSuda.dbo.CarteraLog with(nolock)
	    where	numero_operacion	= @nFolio
	    and		tipo_flujo			= 1
	    and		fecha_modifica		> @dFechaCierre
	    and		fecha_modifica		= @dFechaCorte		-->	Fecha de Relacion con el Evento Buscado
	    --------------------------------------------------------------------------------------------------------------------

	    --------------------------------------------------------------------------------------------------------------------
	    select	@nEstado			= case when Cartera.Folio is null then 3	else 4 end
		    ,	@cEstado			= 'Anticipo' --+ case when Cartera.Folio is null then 'Total' else 'Parcial' end
	    from	BacSwapSuda.dbo.Cartera_Unwind AntPar with(nolock)
			    left join
			    (	select	FechaCartera		= (	select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock) )
					    ,	Folio				= numero_operacion	
				    from	BacSwapSuda.dbo.Cartera		with(nolock)
				    where	numero_operacion	= @nFolio
					    union
				    select	FechaCartera		= Fecha_Proceso
					    ,	Folio				= numero_operacion
				    from	BacSwapSuda.dbo.CarteraRes	with(nolock)
				    where	Fecha_Proceso		= @dFechaCorte
				    and		numero_operacion	= @nFolio
			    )	Cartera	On	Cartera.FechaCartera	= @dFechaCorte
						    and	Cartera.Folio			= AntPar.numero_operacion
	    where	AntPar.numero_operacion	= @nFolio
	    and		AntPar.tipo_flujo		= 1
	    and		AntPar.FechaAnticipo	= @dFechaCorte	-->	Fecha de Relacion con el Evento Buscado
	    --------------------------------------------------------------------------------------------------------------------

	    --------------------------------------------------------------------------------------------------------------------
	    declare @cMensaje	varchar(50)
		    set @cMensaje	= upper( @cEstado )
	    --------------------------------------------------------------------------------------------------------------------
	
	    	
    END
    
IF(@origen = 'TR-NY-')
    BEGIN 
	    --------------------------------------------------------------------------------------------------------------------
	    select	@nEstado		= MovSwap.nEstado
		    ,	@cEstado		= case	when MovSwap.nEstado = 1 then 'Ingreso'
									    else case	when MovSwap.Cierre = @dFechaCorte then 'Ingreso'
												    else 'Ingreso'
											    end
								    end
		    ,	@dFechaCierre	= MovSwap.Cierre
	    from	(
				    select	nEstado				= 1	-->	'Ingreso Del Día'
					    ,	Cierre				= fecha_cierre
				    from	BacSwapNY.dbo.MovDiario with(nolock)
				    where	numero_operacion	= @nFolio
				    and		tipo_flujo			= 1
					    union
				    select	nEstado				= 2	-->	'Ingreso Historico'
					    ,	Cierre				= fecha_cierre
				    from	BacSwapNY.dbo.MovHistorico with(nolock)
				    where	numero_operacion	= @nFolio
				    and		tipo_flujo			= 1
			    )	MovSwap
	    --------------------------------------------------------------------------------------------------------------------

	    --------------------------------------------------------------------------------------------------------------------
	    select	@nEstado			= 3
		    ,	@cEstado			= 'Modificacion' 
	    from	BacSwapNY.dbo.CarteraLog with(nolock)
	    where	numero_operacion	= @nFolio
	    and		tipo_flujo			= 1
	    and		fecha_modifica		> @dFechaCierre
	    and		fecha_modifica		= @dFechaCorte		-->	Fecha de Relacion con el Evento Buscado
	    --------------------------------------------------------------------------------------------------------------------

	    --------------------------------------------------------------------------------------------------------------------
	    select	@nEstado			= case when Cartera.Folio is null then 3	else 4 end
		    ,	@cEstado			= 'Anticipo' --+ case when Cartera.Folio is null then 'Total' else 'Parcial' end
	    from	BacSwapNY.dbo.Cartera_Unwind AntPar with(nolock)
			    left join
			    (	select	FechaCartera		= (	select fechaproc from BacSwapNY.dbo.swapgeneral with(nolock) )
					    ,	Folio				= numero_operacion	
				    from	BacSwapNY.dbo.Cartera		with(nolock)
				    where	numero_operacion	= @nFolio
					    union
				    select	FechaCartera		= Fecha_Proceso
					    ,	Folio				= numero_operacion
				    from	BacSwapNY.dbo.CarteraRes	with(nolock)
				    where	Fecha_Proceso		= @dFechaCorte
				    and		numero_operacion	= @nFolio
			    )	Cartera	On	Cartera.FechaCartera	= @dFechaCorte
						    and	Cartera.Folio			= AntPar.numero_operacion
	    where	AntPar.numero_operacion	= @nFolio
	    and		AntPar.tipo_flujo		= 1
	    and		AntPar.FechaAnticipo	= @dFechaCorte	-->	Fecha de Relacion con el Evento Buscado
	    --------------------------------------------------------------------------------------------------------------------

	    --------------------------------------------------------------------------------------------------------------------
	    declare @cMensajeNY	varchar(50)
		   set @cMensajeNY	= upper( @cEstado )
	    --------------------------------------------------------------------------------------------------------------------    	
    END          
    
    return @cEstado 
end

GO
