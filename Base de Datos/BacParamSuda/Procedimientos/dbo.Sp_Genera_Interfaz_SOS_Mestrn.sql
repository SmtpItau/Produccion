USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Interfaz_SOS_Mestrn]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Genera_Interfaz_SOS_Mestrn]
	(	@dFechaGeneracion	datetime	)
as
begin

	set nocount on

	declare @nRegistros		numeric(21)
		set	@nRegistros		=	(	select	count(1) 
									from	BacParamSuda.dbo.Liquidaciones_SOS with(nolock)
									where	FechaDeLaLiquidacion = @dFechaGeneracion
								)

	SELECT	'01_IDENTIFICACIONDELCLIENTETIPO'	= Mestrn.IDENTIFICACIONDELCLIENTETIPO
		,	'02_IDENTIFICACIONDELCLIENTENUMERO'	= Mestrn.IDENTIFICACIONDELCLIENTENUMERO
		,	'03_NUMTRANSACCION'					= Mestrn.NUMTRANSACCION
		,	'04_CODIGODETRANSACCION'			= Mestrn.CODIGODETRANSACCION
		,	'05_DISPONIBLE 1'					= ''						--> Blanco
		,	'06_ORIGENDELOSFONDOS'				= Mestrn.ORIGENDELOSFONDOS
		,	'07_DISPONIBLE 1'					= ''						--> Blanco
		,	'08_TIPOOPERACION'					= Mestrn.TIPOOPERACION
		,	'09_NUMERODEOPERACION'				= Mestrn.NUMERODEOPERACION				--> NUMERICO
		,	'10_FECHADEINFORMACION'				= Mestrn.FECHADEINFORMACION	
		,	'11_MONTO'							= Mestrn.Pesos							--> NUMERICO
		,	'12_MONTOUF'						= Mestrn.Uf								--> NUMERICO
		,	'13_OFICIALCTA'						= Mestrn.OFICIALCTA
		,	'14_NUMEROCHEQUE'					= Mestrn.NUMEROCHEQUE
		,	'15_TIPOCUENTA'						= Mestrn.TIPOCUENTA
		,	'16_NUMEROCUENTA'					= '0'						--> Blanco	--> NUMERICO
		,	'17_ESPECIETRANSADACANTIDAD'		= Mestrn.ESPECIETRANSADACANTIDAD		--> NUMERICO
		,	'18_ESPECIETRANSADATIPO'			= Mestrn.ESPECIETRANSADATIPO
		,	'19_CAUSAL'							= Mestrn.CAUSAL
		,	'20_BENEFICIARIOORDENANTEDELEXTE'	= Mestrn.BENEFICIARIOORDENANTEDELEXTE
		,	'21_PAISDELBENEFICIARIOORDENANTE'	= Mestrn.PAISDELBENEFICIARIOORDENANTE
		,	'22_MEDIOPAGO'						= Mestrn.MEDIOPAGO
		,	'23_SUCURSAL'						= Mestrn.SUCURSAL
		,	'24_FECHADELAOPERACION'				= Mestrn.FECHADELAOPERACION				
		,	'25_CODUSUARIO'						= Mestrn.CODUSUARIO
		,	'26_EMPRESA'						= Mestrn.EMPRESA
		,	'27_BANCOCORRESPONSAL'				= Mestrn.BANCOCORRESPONSAL
		,	'28_Cantidad_Fila'					= @nRegistros
	FROM 
		(	
			SELECT	IDENTIFICACIONDELCLIENTETIPO,	IDENTIFICACIONDELCLIENTENUMERO, NUMTRANSACCION,					CODIGODETRANSACCION
				,	ORIGENDELOSFONDOS,				TIPOOPERACION,					NUMERODEOPERACION,				FECHADEINFORMACION
				,	OFICIALCTA,						NUMEROCHEQUE,					TIPOCUENTA,						ESPECIETRANSADACANTIDAD
				,	ESPECIETRANSADATIPO,			CAUSAL,							BENEFICIARIOORDENANTEDELEXTE,	PAISDELBENEFICIARIOORDENANTE
				,	MEDIOPAGO,						SUCURSAL,						FECHADELAOPERACION,				CODUSUARIO
				,	EMPRESA,						BANCOCORRESPONSAL
				,	Monto	= sos.Monto
				,	Moneda	= sos.Moneda
				,	Dolares	= case	when sos.Moneda = 'CLP' then round(sos.Monto / sos.Dolar, 4)
									when sos.Moneda = 'UF'	then Round((round(sos.Monto * sos.Uf,4))/ sos.Dolar,4)
									else round(case when sos.Mnrrda = 'D' then sos.Monto / sos.Paridad else sos.Monto * sos.Paridad end, 2)
								end
				
				,	Pesos	= case	when sos.Moneda = 'CLP' then Round(round(sos.Monto / sos.Dolar, 4) * sos.Dolar, 0)
									else Round(round(case when sos.Mnrrda = 'D' then sos.Monto / sos.Paridad else sos.Monto * sos.Paridad end, 2) * sos.Dolar, 0)
								end
				
				,	Uf		= case	when sos.Moneda = 'CLP' then round(sos.Monto / sos.Uf, 0)
									else Round(Round(round(case when sos.Mnrrda = 'D' then sos.Monto / sos.Paridad else sos.Monto * sos.Paridad end, 2) * sos.Dolar, 0) / sos.Uf,0)
								end
			FROM 
				(	SELECT	IDENTIFICACIONDELCLIENTETIPO	= sos.IdentificacionCliente
						,	IDENTIFICACIONDELCLIENTENUMERO	= sos.IdentificadorClienteNumero
						,	NUMTRANSACCION					= sos.NumTransaccion
						,	CODIGODETRANSACCION				= substring( sos.TipoOperacion, 1, 2)
						,	ORIGENDELOSFONDOS				= sos.OrigenDeLosFondos
						,	TIPOOPERACION					= sos.TipoOperacion
						,	NUMERODEOPERACION				= sos.NumeroDeOperacion
						,	FECHADEINFORMACION				= sos.FechaDeLaOperacion	--> Email del 06-06-2014 : Fecha de Ingreso de la Operación (Se informa el Pago)
						,	OFICIALCTA						= sos.OficialCta
						,	NUMEROCHEQUE					= sos.NumeroCheque
						,	TIPOCUENTA						= sos.TipoCta
						,	ESPECIETRANSADACANTIDAD			= sos.EspeciaTransadaCantidad
						,	ESPECIETRANSADATIPO				= sos.EspeciaTransadaTipo
						,	CAUSAL							= sos.Causal
						,	BENEFICIARIOORDENANTEDELEXTE	= sos.BeneficiarioOrdenanteDelExte
						,	PAISDELBENEFICIARIOORDENANTE	= sos.PaisDelBeneficiarioOrdenante
						,	MEDIOPAGO						= sos.MedioPago
						,	SUCURSAL						= sos.Sucursal
						,	FECHADELAOPERACION				= sos.FechaDeLaLiquidacion	--> Email del 06-06-2014 : Fecha de la Interfaz o de Liquidación (Se hace efectivo el Pago)
						,	CODUSUARIO						= ''
						,	EMPRESA							= '0050'
						,	BANCOCORRESPONSAL				= ''
						--------------------------------------------------------------------
						,	Monto							= sos.EspeciaTransadaCantidad
						,	Moneda							= sos.EspeciaTransadaTipo
						,	Codigo							= Paridad.Codigo
						,	Mnrrda							= Paridad.Mnrrda
						,	Paridad							= Paridad.Paridad
						,	Dolar							= Paridad.Dolar
						,	Uf								= Paridad.Uf
						,	Precio							= Round(Paridad.Dolar * Paridad.Paridad, 4)
					FROM	BacParamSuda.dbo.Liquidaciones_SOS	sos with(nolock)
							LEFT join	(	select 	Codigo	= vmon.vmcodigo
												,	Nemo	= vmon.mnnemo
												,	Paridad	= vmon.vmptacmp
												,	Mnrrda	= vmon.mnrrda
												,	Dolar	= Do.vmvalor
												,	Uf		= Uf.vmvalor
											from	(	select	par.vmcodigo
															,	par.vmvalor
															,	vmptacmp	= case when par.vmptacmp = 0 then 1 else par.vmptacmp end
															,	vmptavta	= case when par.vmptavta = 0 then 1 else par.vmptavta end
															,	vmparidad	= case when par.vmparidad = 0 then 1 else par.vmparidad end
															,	mon.mnrrda
															,	mon.mnnemo
														from	BacParamSuda.dbo.Valor_Moneda par
																left join	(	select	mncodmon, mnrrda, mnnemo
																				from	BacParamSuda.dbo.Moneda with(nolock)
																			)	mon		On mon.mncodmon = par.vmcodigo
														where	vmfecha = @dFechaGeneracion
															union
														select	vmcodigo = mon.mncodmon
															,	vmvalor	 = 1.0
															,	vmptacmp = 1.0
															,	vmptavta = 1.0
															,	vmparidad= 1.0
															,	mon.mnrrda
															,	mon.mnnemo
														from	BacParamSuda.dbo.Moneda mon with(nolock)
														where	mon.mncodmon = 999
															union
														select	13, par.vmvalor, vmptacmp= 1.0, vmptavta= 1.0, par.vmparidad, mon.mnrrda, mnnemo = 'USD'
														from	BacParamSuda.dbo.Valor_Moneda par
																inner join	(	select	mncodmon, mnrrda, mnnemo
																				from	BacParamSuda.dbo.Moneda with(nolock)
																				where	mncodmon	= 994
																			)	mon		On mon.mncodmon = par.vmcodigo
														where	vmfecha = @dFechaGeneracion
													)	vmon
													
												,	(	select	vmcodigo, vmvalor, vmptacmp, vmptavta, vmparidad 
														from	BacParamSuda.dbo.Valor_Moneda 
														where	vmfecha = @dFechaGeneracion and vmcodigo = 994
													)	Do
												,	(	select	vmcodigo, vmvalor, vmptacmp, vmptavta, vmparidad 
														from	BacParamSuda.dbo.Valor_Moneda 
														where	vmfecha = @dFechaGeneracion and vmcodigo = 998
													)	Uf
										)	Paridad		On	Paridad.Nemo = sos.EspeciaTransadaTipo

					WHERE	sos.FechaDeLaLiquidacion	= @dFechaGeneracion
				)	sos
		)	Mestrn

end

GO
