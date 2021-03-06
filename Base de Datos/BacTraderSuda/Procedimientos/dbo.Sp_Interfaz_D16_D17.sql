USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Interfaz_D16_D17]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Interfaz_D16_D17]
	(	@dFecha		datetime	)
AS
BEGIN
	set nocount on

	declare @dFechaBtr	datetime
		set @dFechaBtr	= (	select acfecproc from BacTraderSuda.dbo.Mdac with(nolock) )

	-->	El primer registro debe indicar el total de filas.

	select	Final.GRROCCUN
		,	Final.GRCUSNA1
		,	Final.GRROCEST
		,	Final.GRROCOF2
		,	Final.GRROCREF
		,	Final.GRROCCCY
		,	Final.GRROCFAD
		,	Final.GRROCFVG
		,	Final.GRROCMTO
		,	Final.GRROCCOB
		,	Final.GRROCCOM
		,	Final.GRTIPCRE
		,	Final.GRRUTPRO
		,	Final.GRDVPROP
		,	Final.Puntero
	from	(
				select	GRROCCUN	= Interfaz_D17.GRROCCUN
					,	GRCUSNA1	= Interfaz_D17.GRCUSNA1
					,	GRROCEST	= Interfaz_D17.GRROCEST
					,	GRROCOF2	= Interfaz_D17.GRROCOF2
					,	GRROCREF	= Interfaz_D17.GRROCREF
					,	GRROCCCY	= Interfaz_D17.GRROCCCY
					,	GRROCFAD	= case when Interfaz_D17.GRROCFAD is null then '19000101' else Interfaz_D17.GRROCFAD end
					,	GRROCFVG	= case when Interfaz_D17.GRROCFVG is null then '19000101' else Interfaz_D17.GRROCFVG end
					,	GRROCMTO	= Interfaz_D17.GRROCMTO
					,	GRROCCOB	= Interfaz_D17.GRROCCOB
					,	GRROCCOM	= Interfaz_D17.GRROCCOM
					,	GRTIPCRE	= Interfaz_D17.GRTIPCRE
					,	GRRUTPRO	= Interfaz_D17.GRRUTPRO
					,	GRDVPROP	= Interfaz_D17.GRDVPROP
					,	Puntero		= ROW_NUMBER() OVER (order by Interfaz_D17.GRROCCUN desc )
				FROM	(	-->	Garantias Puntuales
							select	GRROCCUN	= substring(ltrim(rtrim(Cliente.clrut)), 1, 9)
								,	GRCUSNA1	= substring(Cliente.clnombre, 1, 49)
								,	GRROCEST	= 'C'		--> 
								,	GRROCOF2	= '0001'
								,	GRROCREF	= substring( ltrim(rtrim(isnull(Rela.FolioBac, 0))), 1, 20)
								,	GRROCCCY	= 'CLP'	-->	MONEDA
								,	GRROCFAD	= convert(char(10), Derivados.Fecha, 112)
								,	GRROCFVG	= convert(char(10), Derivados.Termino, 112)
								,	GRROCMTO	= isnull(Derivados.MTM, 0.0)
								,	GRROCCOB	= isnull(Procentaje.Cobertura, 0.0)
								,	GRROCCOM	= 0
								,	GRTIPCRE	= 'P'
								,	GRRUTPRO	= substring(ltrim(rtrim(Cliente.clrut)), 1, 9)
								,	GRDVPROP	= substring(ltrim(rtrim(Cliente.cldv)), 1, 1)
							from	(
										select	RutCliente, CodigoCliente, Id_RelacionGarantiaOperacion
										from	bdbomesa.Garantia.TBL_CarteraGarantia with(nolock)
										where	1 = case when @dFecha = @dFechaBtr then 1 else 0 end
											union
										select	RutCliente, CodigoCliente, Id_RelacionGarantiaOperacion
										from	bdbomesa.Garantia.TBL_RespaldoCarteraGarantia  with(nolock)
										where	FechaRespaldo	= @dFecha
										and		1 = case when @dFecha <> @dFechaBtr then 1 else 0 end
									)	Cartera 

									inner join	(	select	cliente.clrut, cliente.clcodigo, cliente.clnombre, cliente.cldv											
														  , Tipo = BacTraderSuda.dbo.Fx_Consulta_Rec(cliente.clrut, cliente.clcodigo)
													from	BacParamSuda.dbo.cliente cliente with(nolock)
												)	Cliente	On	Cliente.clrut		= Cartera.RutCliente
															and Cliente.clcodigo	= Cartera.CodigoCliente

									inner join	(	select	Id			= IdCodigo
														,	Glosa		= Glosa
													from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
													where	IdCategoria = (select IdCategoria from bdbomesa.Garantia.TBL_GeneralGlobal with(nolock) where IdCategoria = 1)
												)	Clas	On Clas.Id	= cliente.Tipo

									left join	(	select	Id			= Id_RelacionGarantiaOperacion
														,	FolioBac	= NumeroOperacion
														,	OrigenBac	= IdSistema
													from	bdbomesa.Garantia.TBL_RelacionGarantiaOperacion with(nolock)
												)	Rela	On Rela.Id	= isnull(Cartera.Id_RelacionGarantiaOperacion, 0)

							--		inner join	
									left  join	(	select	Id			= Id_RelacionGarantiaOperacion
														,	Cobertura	= convert(numeric(3), round(100 / case when count(NumeroOperacion) = 0 then 1 else count(NumeroOperacion) end, 1))
													from	bdbomesa.Garantia.TBL_RelacionGarantiaOperacion with(nolock)
													group 
													by		Id_RelacionGarantiaOperacion
												)	Procentaje	On Procentaje.Id	= isnull(Cartera.Id_RelacionGarantiaOperacion, 0)

									left join	(	select	Modulo		= 'BFW'
														,	Folio		= canumoper
														,	Rut			= cacodigo
														,	Codigo		= cacodcli
														,	MTM			= round(fres_obtenido, 0)
														,	Fecha		= cafecha
														,	Termino		= cafecvcto
													from	BacFwdSuda.dbo.Mfca	with(nolock)
														union all
													select	distinct 
															Modulo		= 'PCS'
														,	Folio		= numero_operacion
														,	Rut			= rut_cliente
														,	Codigo		= codigo_cliente
														,	MTM			= round(valor_razonableclp,0)
														,	Fecha		= Fecha_Cierre
														,	Termino		= fecha_termino
													from	BacSwapSuda.dbo.Cartera  with(nolock)
													where	Estado		<> 'C'
													and		tipo_Flujo	= 1
														union all
													select	distinct 
															Modulo		= 'OPT'
														,	Folio		= enc.canumcontrato
														,	Rut			= enc.carutcliente
														,	Codigo		= enc.cacodigo
														,	MTM			= round(enc.cavr, 0)
														,	Fecha		= enc.cafechacontrato
														,	Termino		= det.CaFechaVcto
													from	LnkOpc.CbMdbOpc.dbo.CaEncContrato enc with(nolock)
															inner join	(	select	CaNumContrato			= CaNumContrato
																				,	CaFechaVcto				= MAX(CaFechaVcto) 
																			from	LnkOpc.CbMdbOpc.dbo.cadetcontrato
																			group 
																			by		CaNumContrato
																		)	det		On Det.CaNumContrato	= enc.canumcontrato
													where	enc.caestado <> 'C'
								
												)	Derivados	On	Derivados.Folio		= Rela.FolioBac
																and Derivados.Modulo	= Rela.OrigenBac
							where	Clas.Glosa	= 'Puntual'

							union all

							-->	Garantias Globales
							select	GRROCCUN	= substring(ltrim(rtrim(Cliente.clrut)), 1, 9)
								,	GRCUSNA1	= substring(Cliente.clnombre, 1, 49)
								,	GRROCEST	= 'C'		
								,	GRROCOF2	= '0001'
								,	GRROCREF	= substring( ltrim(rtrim( Derivados.Folio )), 1, 20)
								,	GRROCCCY	= 'CLP'	-->	MONEDA
								,	GRROCFAD	= convert(char(10), Derivados.Fecha, 112)
								,	GRROCFVG	= convert(char(10), Derivados.Termino, 112)
								,	GRROCMTO	= isnull(Derivados.MTM, 0.0)
								,	GRROCCOB	= 100
								,	GRROCCOM	= 0
								,	GRTIPCRE	= 'P'
								,	GRRUTPRO	= substring(ltrim(rtrim(Cliente.clrut)), 1, 9)
								,	GRDVPROP	= substring(ltrim(rtrim(Cliente.cldv)), 1, 1)
							from	(
										select	RutCliente, CodigoCliente, Id_RelacionGarantiaOperacion
										from	bdbomesa.Garantia.TBL_CarteraGarantia with(nolock)
										where	1 = case when @dFecha = @dFechaBtr then 1 else 0 end
											union
										select	RutCliente, CodigoCliente, Id_RelacionGarantiaOperacion
										from	bdbomesa.Garantia.TBL_RespaldoCarteraGarantia with(nolock)
										where	FechaRespaldo	= @dFecha
										and		1 = case when @dFecha <> @dFechaBtr then 1 else 0 end
									)	Cartera 

									inner join	(	select	cliente.clrut, cliente.clcodigo, cliente.clnombre, cliente.cldv
														,   Tipo = BacTraderSuda.dbo.Fx_Consulta_Rec(cliente.clrut, cliente.clcodigo)
													from	BacParamSuda.dbo.cliente cliente with(nolock)
												)	Cliente	On	Cliente.clrut		= Cartera.RutCliente
															and Cliente.clcodigo	= Cartera.CodigoCliente

									inner join	(	select	Id			= IdCodigo
														,	Glosa		= Glosa
													from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
													where	IdCategoria = (select IdCategoria from bdbomesa.Garantia.TBL_GeneralGlobal with(nolock) where IdCategoria = 1)
												)	Clas	On Clas.Id	= cliente.Tipo

									left join	(	select	Modulo		= 'BFW'
														,	Folio		= canumoper
														,	Rut			= cacodigo
														,	Codigo		= cacodcli
														,	MTM			= round(fres_obtenido ,0)
														,	Fecha		= cafecha
														,	Termino		= cafecvcto
													from	BacFwdSuda.dbo.Mfca	with(nolock)
														union all
													select	distinct 
															Modulo		= 'PCS'
														,	Folio		= numero_operacion
														,	Rut			= rut_cliente
														,	Codigo		= codigo_cliente
														,	MTM			= round(valor_razonableclp,0)
														,	Fecha		= Fecha_Cierre
														,	Termino		= fecha_termino
													from	BacSwapSuda.dbo.Cartera  with(nolock)
													where	Estado		<> 'C'
													and		tipo_Flujo	= 1
														union all
													select	distinct 
															Modulo		= 'OPT'
														,	Folio		= enc.canumcontrato
														,	Rut			= enc.carutcliente
														,	Codigo		= enc.cacodigo
														,	MTM			= round(enc.cavr, 0)
														,	Fecha		= enc.cafechacontrato
														,	Termino		= det.CaFechaVcto
													from	LnkOpc.CbMdbOpc.dbo.CaEncContrato enc with(nolock)
															inner join	(	select	CaNumContrato			= CaNumContrato
																				,	CaFechaVcto				= MAX(CaFechaVcto) 
																			from	LnkOpc.CbMdbOpc.dbo.CadetContrato
																			group
																			by		CaNumContrato
																		)	det		On Det.CaNumContrato	= enc.canumcontrato
													where	enc.caestado <> 'C'
												)	Derivados	On	Derivados.Rut		= Cliente.clrut
																and Derivados.Codigo	= Cliente.clcodigo
							where	Clas.Glosa	= 'Global'
						)	Interfaz_D17
			)	Final
	order 
	by		Final.Puntero desc
	
END
GO
