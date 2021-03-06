USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ServicioCierre_Verifica]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_ServicioCierre_Verifica]
as
begin

	set nocount on

	select	Modulo	= ctrl.Modulo
		,	Tarea	= ctrl.Descripcion
		,	Error	= Error.Descripcion
		,	Iinicio	= ctrl.HoraInicio
		,	Termino	= ctrl.HoraTermino
	from	dbo.ServicioCierre_ControlActividades ctrl	with(nolock)
			inner join (	select	IdModulo = case when Modulo = 1 then 'BFW'
													when Modulo = 2 then 'PCS'
													when Modulo = 3 then 'BEX'
													when Modulo = 4 then 'PCS'
												end
								,	IdTarea
								,	Descripcion
							from	dbo.ServicioCierre_Errores with(nolock)
						)	Error	ON	Error.IdModulo	= ctrl.Modulo
									and Error.IdTarea	= ctrl.Id
	where	ctrl.Estado	IN(select Id from dbo.ServicioCierre_Status where Glosa = 'Cancelado')
	order 
	by		ctrl.Orden

end
GO
