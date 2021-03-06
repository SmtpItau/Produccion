USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Interfaz_SOS_Mescli]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Genera_Interfaz_SOS_Mescli]
	(	@dFechaGeneracion	datetime	)
as
begin

	set nocount on

	declare @nRegistros		numeric(21)
		set	@nRegistros		=	(	SELECT	count(Clientes.IdentificacionCliente)
									FROM	(	select	IdentificacionCliente
													,	IdentificadorClienteNumero
												from	BacParamSuda.dbo.Liquidaciones_SOS with(nolock)
												where	FechaDeLaLiquidacion = @dFechaGeneracion
												group 
												by		IdentificacionCliente
													,	IdentificadorClienteNumero
													,	RutCliente
													,	CodigoCliente
													,	case	when Operador = 'vcup' THEN substring('AUTOMATICO', 1, 12)
																else substring( Operador, 1, 12)
															end
											)	Clientes
								)

	select	IDENTIFICACIONDELCLIENTETIPO	= sos.IdentificacionCliente
		,	IDENTIFICACIONDELCLIENTENUMERO	= sos.IdentificadorClienteNumero
		,	DISPONIBLE						= ''
		,	TIPOCLIENTE						= TClie.sostipo
		,	SUCURSALAGENCIA					= '001'
		,	OFICIALCUENTA					= case	when sos.Operador = 'vcup' THEN substring('AUTOMATICO', 1, 12)
													else substring( sos.Operador, 1, 12)
												end
											--	''			--> Sin Informacion

		,	DENOMINACION					= TClie.nombre
		,	CALLE							= TClie.direccion
		,	LOCALIDAD						= TClie.ciudad
		,	CODIGOPOSTAL					= ''			--> Sin Informacion
		,	CODIGOPROVINCIA					= dbo.Fx_SOS_Pais(TClie.pais, 1)
		,	PAIS							= dbo.Fx_SOS_Pais(TClie.pais, 2)
		,	TELEFONO						= TClie.telefono
		,	FAX								= TClie.fax
		,	EMAIL							= ''			--> Sin Informacion
		,	SEXO							= ''			--> Sin Informacion
		,	ESTADOCIVIL						= ''			--> Sin Informacion
		,	CANTIDADHIJOS					= 0				--> Sin Informacion
		,	FECHANACIMIENTO					= CONVERT(DATETIME, '19000101')	--> Sin Informacion
		,	NACIONALIDAD					= TClie.Nacionalidad
		,	LUGARDENACIMIENTO				= dbo.Fx_SOS_Pais(TClie.pais, 3)
		,	UNIDADNEG						= 'MESABC'		--> Sin Informacion	( A Partir del 22-07-2014 Solicitado por Mario en Mail del 21-07-2014)
		,	SUBSEGMENTO						= ''			--> Sin Informacion
		,	ESTUDIOS						= 9999			--> Sin Informacion
		,	ULTIMOTITULO					= 9				--> Sin Informacion
		,	CATEGORIA						= ''			--> Sin Informacion
		,	RESIDENCIASECTOR				= ''			--> Sin Informacion
		,	CODIGOACTIVIDADINTERNO			= ''			--> Sin Informacion
		,	ESTADOCLIENTE					= 2				--> Activo
		,	FECHAALTA						= CONVERT(DATETIME, '19000101')	--> Sin Informacion
		,	FECHABAJA						= CONVERT(DATETIME, '19000101')	--> Sin Informacion
		,	CARGOFUNCION					= '314'			--> Sin Informacion
		,	FECHAINGRESO					= '00000000'	--> TClie.FechaIngreso (Segun Formato de Interfaz)
		,	RUBRODELAEMPRESA				= ''			--> Sin Informacion
		,	TIPOEMPRESA						= '0'			--> Sin Informacion
		,	ACTIVIDADRUBRO					= ''			--> Sin Informacion
		,	TIPOENTIDAD						= ''			--> H : Holding Company	| '' --> Sin Información
		,	TIPOSOCIEDAD					= 'C'			--> Sin Informacion
		,	FECHACONSTITUCIONSOCIEDAD		= CONVERT(DATETIME, '19000101')	--> Sin Informacion
		,	FECHAINICIOACTIVIDADES			= CONVERT(DATETIME, '19000101')	--> Sin Informacion
		,	FECHAINSCRIPCIONSOCIEDAD		= CONVERT(DATETIME, '19000101')	--> Sin Informacion
		,	COMUNA							= dbo.Fx_SOS_Comunas(TClie.comuna)
		,	SALARIO							= 0				--> Sin Informacion
		,	PATRIMONIO						= 0				--> Sin Informacion
		,	INGRESOS						= 0				--> Sin Informacion
		,	OTROSINGRESOS					= 0				--> Sin Informacion
		,	EMPLEADO						= ''			--> Sin Informacion
		,	EMPRESA							= '0050'
		,  '28_Cantidad_Fila'				= @nRegistros
	from	(	select	IdentificacionCliente		= IdentificacionCliente
					,	IdentificadorClienteNumero	= IdentificadorClienteNumero
					,	RutCliente					= RutCliente
					,	CodigoCliente				= CodigoCliente
					,	Operador					= case	when Operador = 'vcup' THEN substring('AUTOMATICO', 1, 12)
															else substring( Operador, 1, 12)
														end	
				from	BacParamSuda.dbo.Liquidaciones_SOS with(nolock)
				where	FechaDeLaLiquidacion = @dFechaGeneracion
				group 
				by		IdentificacionCliente
					,	IdentificadorClienteNumero
					,	RutCliente
					,	CodigoCliente
					,	case	when Operador = 'vcup' THEN substring('AUTOMATICO', 1, 12)
								else substring( Operador, 1, 12)
							end	
			)	Sos
			left join	(	select	rut			 = cliente.clrut
								,	codigo		 = cliente.clcodigo
								,	nombre		 = substring( cliente.clnombre, 1,45)
								,	tipo		 = cliente.cltipcli
								,	glosa		 = Tipo.Glosa
								,	sostipo		 = case when Tipo.Glosa like '%NATURAL%' then 2 else 1 end
								,	direccion	 = substring( cliente.cldirecc, 1, 35)
								,	ciudad		 = case when cliente.clciudad = 3201 then 320 else cliente.clciudad end
								,	pais		 = cliente.clpais
								,	telefono	 = substring(cliente.clfono, 1, 11)
								,	fax			 = substring(cliente.Clfax, 1, 11)
								,	Nacionalidad = case when cliente.clpais = 6 then 1 else 2 end
								,	FechaIngreso = cliente.Clfecingr
								,	comuna		 = cliente.Clcomuna
							from	BacParamSuda.dbo.cliente cliente with(nolock)
									inner join (	select	Codigo	= tbcodigo1
														,	Glosa	= tbglosa
													from	BacParamSuda.dbo.Tabla_General_Detalle
													where	tbcateg = 72
												)	Tipo	On Tipo.codigo	= cliente.cltipcli
						)	TClie	On	TClie.rut		= sos.RutCliente
									and	TClie.codigo	= sos.CodigoCliente
	
end
GO
