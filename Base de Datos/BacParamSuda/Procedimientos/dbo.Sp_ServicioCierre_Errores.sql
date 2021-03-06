USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ServicioCierre_Errores]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_ServicioCierre_Errores]
	(	@_Accion		int
	,	@_Modulo		char(3)
	,	@_IdTarea		int
	,	@_Descripcion	varchar(255)
	)
as
begin

	set nocount on

	declare @_Fecha	datetime
		set @_Fecha	= convert(char(10), getdate(), 112)

	-->	Limpia la Tabla al Iniciar el proceso
	if @_Accion = 0
		begin
			delete from dbo.ServicioCierre_Errores 

			return
		end

	-->	Inserta Errores durante el proceso
	if @_Accion = 1
		begin
			insert into dbo.ServicioCierre_Errores
				 select Fecha		= @_Fecha
					,	Modulo		= @_Modulo
					,	IdTarea		= @_IdTarea
					,	Descripcion	= @_Descripcion

			return
		end

	-->	Lee los Errores al finalizar el proceso
	if @_Accion = 2
		begin	
			select	Fecha	= Errores.Fecha
				,	Modulo	= Errores.Modulo
				,	Tarea	= Actividades.xDescripcion
				,	Error	= Errores.Descripcion
			from	dbo.ServicioCierre_Errores Errores with(nolock)
					inner join	(	select	xId			= Id
										,	xModulo		= Modulo
										,	xDescripcion= Descripcion
									from	dbo.ServicioCierre_ControlActividades with(nolock)
								)	Actividades	On	Actividades.xModulo = Errores.Modulo
												and Actividades.xId		= Errores.IdTarea
			where	Modulo = @_Modulo

			return
		end

end

GO
