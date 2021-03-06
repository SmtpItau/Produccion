USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Interfaz_SOS_Mesofc]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Genera_Interfaz_SOS_Mesofc]
	(	@dFechaGeneracion	datetime	)
as
begin

	set nocount on


	declare @nRegistros		numeric(21)
		set	@nRegistros		=	(	SELECT	COUNT(RegistrosSos.Usuarios)
									FROM	(	select	Usuarios = case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 25)
																		else substring( sos.Operador, 1, 25)
																	end
												from	BacParamSuda.dbo.Liquidaciones_SOS sos with(nolock)
												where	FechaDeLaLiquidacion = @dFechaGeneracion
												group	
												by		case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 10)
																else substring( sos.Operador, 1, 10)
															end
													,	case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 25)
																else substring( sos.Operador, 1, 25)
															end
											)	RegistrosSos
								)
								
	select	EUPUSR			= case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 10)
									else substring( sos.Operador, 1, 10)
								end
		,	DISPONIBLE		= ''
		,	EUPOFC			= case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 25)
									else substring( sos.Operador, 1, 25)
								end
		,	EUPUBR			= '001'
		,	DISPONIBLE		= 0												 --> ''
		,	EUPNME			= substring(isnull( usr.nombre,'AUTOMATICO'), 1, 45)
		,	EUPIDN			= substring(replace(isnull(usr.RutUsuario, '0-0'),'-',''),1,15) -->  substring(usr.RutUsuario, 1, 15)
		,	'Cantidad_Fila'	= @nRegistros
	from	BacParamSuda.dbo.Liquidaciones_SOS	sos with(nolock)
			left join	(	select	usuario, nombre, RutUsuario
							from	BacParamSuda.dbo.usuario 
						)	usr		On usr.usuario	= sos.Operador
	where	sos.FechaDeLaLiquidacion	= @dFechaGeneracion
	group	
	by		case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 10)
					else substring( sos.Operador, 1, 10)
				end
		,	case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 25)
					else substring( sos.Operador, 1, 25)
				end
		,	substring(isnull( usr.nombre,'AUTOMATICO'), 1, 45)
		,	substring(replace(isnull(usr.RutUsuario, '0-0'),'-',''),1,15) -->  substring(usr.RutUsuario, 1, 15)	

	Order 
	by		case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 25)
					else substring( sos.Operador, 1, 25)
				end

end
GO
