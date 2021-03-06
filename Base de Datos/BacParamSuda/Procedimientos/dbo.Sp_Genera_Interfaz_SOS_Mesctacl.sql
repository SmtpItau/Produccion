USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Interfaz_SOS_Mesctacl]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Genera_Interfaz_SOS_Mesctacl]
	(	@dFechaGeneracion	datetime	)
as
begin

	set nocount on

	declare @nRegistros		numeric(21)
		set	@nRegistros		=	(	select	count(1)
									from	(	select	TipoCta
													,	Tip = substring(TipoCta, 1, 4)
													,	IdentificacionCliente
													,	IdentificadorClienteNumero
												from	BacParamSuda.dbo.Liquidaciones_SOS with(nolock)
												where	FechaDeLaLiquidacion = @dFechaGeneracion
												group
												by		TipoCta
													,	substring(TipoCta, 1, 4)
													,	IdentificacionCliente
													,	IdentificadorClienteNumero
											)	Reg
								)

	select	TIPOCUENTA						= sos.TipoCta
		,	FAMILIAPRODUCTO					= substring(sos.TipoCta, 1, 4)	-->	sos.TipoOperacion	
		,	NUMEROCUENTA					= ''
		,	TIPORELACION					= 'T'
		,	IDENTIFICACIONDELCLIENTETIPO	= sos.IdentificacionCliente
		,	IDENTIFICACIONDELCLIENTENUMERO	= sos.IdentificadorClienteNumero
		,	DISPONIBLE						= ''
		,	ORDENRELACION					= 0
		,	FECHAALTA						= CONVERT(DATETIME, '19000101')
		,	FECHABAJA						= CONVERT(DATETIME, '19000101')
		,	ESTADO							= 1
		,	NIBS							= 0
		,	EMPRESA							= '0050'
		,	'Cantidad_Fila'					= @nRegistros
	from	BacParamSuda.dbo.Liquidaciones_SOS	sos with(nolock)
	where	sos.FechaDeLaLiquidacion		= @dFechaGeneracion
	group
	by		TipoCta
		,	substring(TipoCta, 1, 4)
		,	IdentificacionCliente
		,	IdentificadorClienteNumero
end
GO
