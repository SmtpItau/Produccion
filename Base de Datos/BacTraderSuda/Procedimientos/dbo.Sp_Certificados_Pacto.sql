USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Certificados_Pacto]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Certificados_Pacto]
	(	@dFechaInicio		datetime
	,	@dFechaTermino		datetime
	,	@nRutContraparte	numeric(12)
	,	@nCodContraparte	numeric(5)
	)
as
begin

	set nocount on

	declare @dFechaProceso		datetime
		set @dFechaProceso		= ( select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )

	declare @cantidad int
	set @cantidad = (select count(*)
	                 from	(	------- MOVIMIENTOS DEL DÍA PARA CI Y VI -----
								select  morutcli		= Mov.morutcli
									,	mocodcli		= Mov.mocodcli
									,	monumoper		= Mov.monumoper
									,	moinstser		= Mov.moinstser
									,	mofecinip		= Mov.mofecinip
									,	mofecvenp		= Mov.mofecvenp
									,	motaspact		= Mov.motaspact
									,	movalinip		= SUM( Mov.movalinip )
									,	movalvenp		= SUM( Mov.movalvenp )
									,	mofecpro		= Mov.mofecpro
									,	mostatreg		= Mov.mostatreg
									,	motipoper		= Mov.motipoper
									,	monumdocu		= Mov.monumdocu
								from	BacTraderSuda.dbo.Mdmo	Mov
								where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
								and		Mov.mofecvenp	> @dFechaTermino --> (select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
								and		Mov.motipoper	IN( 'ci', 'vi')
								and		Mov.mostatreg	= ''
								group
								by		Mov.mofecpro
									,	Mov.morutcli
									,	Mov.mocodcli
									,	Mov.monumoper
									,	Mov.monumdocu
									,	Mov.moinstser
									,	Mov.mofecinip
									,	Mov.mofecvenp
									,	Mov.motaspact
									,	Mov.mostatreg
									,	Mov.motipoper

								union all

								------- MOVIMIENTOS DEL HISTORICO PARA CI Y VI -----
								select  morutcli		= Mov.morutcli
									,	mocodcli		= Mov.mocodcli
									,	monumoper		= Mov.monumoper
									,	moinstser		= Mov.moinstser
									,	mofecinip		= Mov.mofecinip
									,	mofecvenp		= Mov.mofecvenp
									,	motaspact		= Mov.motaspact
									,	movalinip		= SUM( Mov.movalinip )
									,	movalvenp		= SUM( Mov.movalvenp )
									,	mofecpro		= Mov.mofecpro
									,	mostatreg		= Mov.mostatreg
									,	motipoper		= Mov.motipoper
									,	monumdocu		= Mov.monumdocu
								from	BacTraderSuda.dbo.Mdmh	Mov
								where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
								and		Mov.mofecvenp	> @dFechaTermino --> (select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
								and		Mov.motipoper	IN( 'ci', 'vi')
								and		Mov.mostatreg	= ''
								group
								by		Mov.mofecpro
									,	Mov.morutcli
									,	Mov.mocodcli
									,	Mov.monumoper
									,	Mov.monumdocu
									,	Mov.moinstser
									,	Mov.mofecinip
									,	Mov.mofecvenp
									,	Mov.motaspact
									,	Mov.mostatreg
									,	Mov.motipoper

							union all

								------- MOVIMIENTOS DEL DIA PARA VCTOS DE PACTO -----
								select  morutcli		= Mov.morutcli
									,	mocodcli		= Mov.mocodcli
									,	monumoper		= Mov.monumoper
									,	moinstser		= Mov.moinstser
									,	mofecinip		= Mov.mofecinip
									,	mofecvenp		= Mov.mofecvenp
									,	motaspact		= Mov.motaspact
									,	movalinip		= SUM( Mov.movalinip )
									,	movalvenp		= SUM( Mov.movalvenp )
									,	mofecpro		= Mov.mofecpro

									,	mostatreg		= Mov.mostatreg
									,	motipoper		= Mov.motipoper
									,	monumdocu		= Mov.monumdocu
								from	BacTraderSuda.dbo.Mdmo	Mov
								where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
								and		Mov.motipoper	IN( 'rc', 'rv', 'rca', 'rva' )
								and		Mov.mostatreg	= ''
								group
								by		Mov.mofecpro
									,	Mov.morutcli
									,	Mov.mocodcli
									,	Mov.monumoper
									,	Mov.monumdocu
									,	Mov.moinstser
									,	Mov.mofecinip
									,	Mov.mofecvenp
									,	Mov.motaspact
									,	Mov.mostatreg
									,	Mov.motipoper

							union all

								------- MOVIMIENTOS DEL HISTORICOS PARA VCTOS DE PACTO -----
								select  morutcli		= Mov.morutcli
									,	mocodcli		= Mov.mocodcli
									,	monumoper		= Mov.monumoper
									,	moinstser		= Mov.moinstser
									,	mofecinip		= Mov.mofecinip
									,	mofecvenp		= Mov.mofecvenp
									,	motaspact		= Mov.motaspact
									,	movalinip		= SUM( Mov.movalinip )
									,	movalvenp		= SUM( Mov.movalvenp )
									,	mofecpro		= Mov.mofecpro

									,	mostatreg		= Mov.mostatreg
									,	motipoper		= Mov.motipoper
									,	monumdocu		= Mov.monumdocu
								from	BacTraderSuda.dbo.Mdmh	Mov
								where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
								and		Mov.motipoper	IN( 'rc', 'rv', 'rca', 'rva' )
								and		Mov.mostatreg	= ''
								group
								by		Mov.mofecpro
									,	Mov.morutcli
									,	Mov.mocodcli
									,	Mov.monumoper
									,	Mov.monumdocu
									,	Mov.moinstser
									,	Mov.mofecinip
									,	Mov.mofecvenp
									,	Mov.motaspact
									,	Mov.mostatreg
									,	Mov.motipoper
							)	Movimientos

							------	ASOCIACION CON EL CLIENTE	--------
							inner join (	select	Rut		= clrut
												,	Dv		= cldv
												,	Codigo	= clcodigo
												,	Nombre	= clnombre
												,	RutDv	= ltrim(rtrim( clrut )) + '-' + ltrim(rtrim( cldv ))
											from	BacParamSuda.dbo.Cliente
										)	Cliente	On	Cliente.Rut		= Movimientos.morutcli
													and	Cliente.codigo	= Movimientos.mocodcli

					-----	FILTRO POR CLIENTE (RUT) -------
					where		Movimientos.morutcli	= @nRutContraparte
					and			Movimientos.mocodcli	= @nCodContraparte)

    






	if @cantidad <> 0
	begin

		--------- D a t o s  D e  C a b e c e r a -----
	select	RutContraparte		= Cliente.RutDv
		,	NombreContraparte	= Cliente.Nombre
		--------- D a t o s  D e  D e t a l l e   -----
		,	Serie				= Movimientos.moinstser
		,	Documento			= Movimientos.monumoper
		,	Inicio				= convert(char(10), Movimientos.mofecinip, 103 )
		,	Termino				= convert(char(10), Movimientos.mofecvenp, 103 )
		,	Plazo				= datediff( day, Movimientos.mofecinip, Movimientos.mofecvenp )
		,	Tasa				= Movimientos.motaspact
		,	MontoInicial		= Movimientos.movalinip
		,	MontoFinal			= Movimientos.movalvenp
		--------- D a t o s  D e  G r u p o       -----
		,	SumaMtoInicial		= 0
		,	SumaMtoFinal		= 0
		--------- D a t o s  D e  V a l i d a c i o n -
		,	Estado				= Movimientos.mostatreg
		,	TipoOperacion		= Movimientos.motipoper
		,	RutInstitucion		= (	select	ltrim(rtrim( RutEntidad )) + '-' + ltrim(rtrim( DigitoVerificador )) 
									from	BacParamSuda..Contratos_ParametrosGenerales with(nolock) 
									)

		,	NombreInstitucion	= (	select	ltrim(rtrim( RazonSocial )) 
									from	BacParamSuda..Contratos_ParametrosGenerales with(nolock) 
									)


		,	FechaEmision		= 	'Santiago, ' 
								+	ltrim(rtrim( convert(char(2), @dFechaProceso, 103) ))
								+	' de' 
								+	case	when datepart(month, @dFechaProceso) = 1  then ' Enero '
											when datepart(month, @dFechaProceso) = 2  then ' Febrero '
											when datepart(month, @dFechaProceso) = 3  then ' Marzo '
											when datepart(month, @dFechaProceso) = 4  then ' Abril '
											when datepart(month, @dFechaProceso) = 5  then ' Mayo '
											when datepart(month, @dFechaProceso) = 6  then ' Junio '
											when datepart(month, @dFechaProceso) = 7  then ' Julio '
											when datepart(month, @dFechaProceso) = 8  then ' Agosto '
											when datepart(month, @dFechaProceso) = 9  then ' Septiembre '
											when datepart(month, @dFechaProceso) = 10 then ' Octubre '
											when datepart(month, @dFechaProceso) = 11 then ' Noviembre '
											when datepart(month, @dFechaProceso) = 12 then ' Diciembre '
										end
								+	'del ' 
								+	ltrim(rtrim( datename(year, @dFechaProceso) ))
		,	FechaDesde			= @dFechaInicio
		,	FechaHasta			= @dFechaTermino
		,	Periodo				= 'entre el ' + convert(char(10), @dFechaInicio, 103) + ' y el ' + convert(char(10), @dFechaTermino, 103)
		,   'Logo' = (SELECT Logo FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
		,   'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
		-----------------------------------------------
	from	(	------- MOVIMIENTOS DEL DÍA PARA CI Y VI -----
				select  morutcli		= Mov.morutcli
					,	mocodcli		= Mov.mocodcli
					,	monumoper		= Mov.monumoper
					,	moinstser		= Mov.moinstser
					,	mofecinip		= Mov.mofecinip
					,	mofecvenp		= Mov.mofecvenp
					,	motaspact		= Mov.motaspact
					,	movalinip		= SUM( Mov.movalinip )
					,	movalvenp		= SUM( Mov.movalvenp )
					,	mofecpro		= Mov.mofecpro
					,	mostatreg		= Mov.mostatreg
					,	motipoper		= Mov.motipoper
					,	monumdocu		= Mov.monumdocu
				from	BacTraderSuda.dbo.Mdmo	Mov
				where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
				and		Mov.mofecvenp	> @dFechaTermino --> (select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
				and		Mov.motipoper	IN( 'ci', 'vi')
				and		Mov.mostatreg	= ''
				group
				by		Mov.mofecpro
					,	Mov.morutcli
					,	Mov.mocodcli
					,	Mov.monumoper
					,	Mov.monumdocu
					,	Mov.moinstser
					,	Mov.mofecinip
					,	Mov.mofecvenp
					,	Mov.motaspact
					,	Mov.mostatreg
					,	Mov.motipoper

				union all

				------- MOVIMIENTOS DEL HISTORICO PARA CI Y VI -----
				select  morutcli		= Mov.morutcli
					,	mocodcli		= Mov.mocodcli
					,	monumoper		= Mov.monumoper
					,	moinstser		= Mov.moinstser
					,	mofecinip		= Mov.mofecinip
					,	mofecvenp		= Mov.mofecvenp
					,	motaspact		= Mov.motaspact
					,	movalinip		= SUM( Mov.movalinip )
					,	movalvenp		= SUM( Mov.movalvenp )
					,	mofecpro		= Mov.mofecpro
					,	mostatreg		= Mov.mostatreg
					,	motipoper		= Mov.motipoper
					,	monumdocu		= Mov.monumdocu
				from	BacTraderSuda.dbo.Mdmh	Mov
				where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
				and		Mov.mofecvenp	> @dFechaTermino --> (select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
				and		Mov.motipoper	IN( 'ci', 'vi')
				and		Mov.mostatreg	= ''
				group
				by		Mov.mofecpro
					,	Mov.morutcli
					,	Mov.mocodcli
					,	Mov.monumoper
					,	Mov.monumdocu
					,	Mov.moinstser
					,	Mov.mofecinip
					,	Mov.mofecvenp
					,	Mov.motaspact
					,	Mov.mostatreg
					,	Mov.motipoper

			union all

				------- MOVIMIENTOS DEL DIA PARA VCTOS DE PACTO -----
				select  morutcli		= Mov.morutcli
					,	mocodcli		= Mov.mocodcli
					,	monumoper		= Mov.monumoper
					,	moinstser		= Mov.moinstser
					,	mofecinip		= Mov.mofecinip
					,	mofecvenp		= Mov.mofecvenp
					,	motaspact		= Mov.motaspact
					,	movalinip		= SUM( Mov.movalinip )
					,	movalvenp		= SUM( Mov.movalvenp )
					,	mofecpro		= Mov.mofecpro

					,	mostatreg		= Mov.mostatreg
					,	motipoper		= Mov.motipoper
					,	monumdocu		= Mov.monumdocu
				from	BacTraderSuda.dbo.Mdmo	Mov
				where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
				and		Mov.motipoper	IN( 'rc', 'rv', 'rca', 'rva' )
				and		Mov.mostatreg	= ''
				group
				by		Mov.mofecpro
					,	Mov.morutcli
					,	Mov.mocodcli
					,	Mov.monumoper
					,	Mov.monumdocu
					,	Mov.moinstser
					,	Mov.mofecinip
					,	Mov.mofecvenp
					,	Mov.motaspact
					,	Mov.mostatreg
					,	Mov.motipoper

			union all

				------- MOVIMIENTOS DEL HISTORICOS PARA VCTOS DE PACTO -----
				select  morutcli		= Mov.morutcli
					,	mocodcli		= Mov.mocodcli
					,	monumoper		= Mov.monumoper
					,	moinstser		= Mov.moinstser
					,	mofecinip		= Mov.mofecinip
					,	mofecvenp		= Mov.mofecvenp
					,	motaspact		= Mov.motaspact
					,	movalinip		= SUM( Mov.movalinip )
					,	movalvenp		= SUM( Mov.movalvenp )
					,	mofecpro		= Mov.mofecpro

					,	mostatreg		= Mov.mostatreg
					,	motipoper		= Mov.motipoper
					,	monumdocu		= Mov.monumdocu
				from	BacTraderSuda.dbo.Mdmh	Mov
				where	Mov.mofecpro	between @dFechaInicio and @dFechaTermino
				and		Mov.motipoper	IN( 'rc', 'rv', 'rca', 'rva' )
				and		Mov.mostatreg	= ''
				group
				by		Mov.mofecpro
					,	Mov.morutcli
					,	Mov.mocodcli
					,	Mov.monumoper
					,	Mov.monumdocu
					,	Mov.moinstser
					,	Mov.mofecinip
					,	Mov.mofecvenp
					,	Mov.motaspact
					,	Mov.mostatreg
					,	Mov.motipoper
			)	Movimientos

			------	ASOCIACION CON EL CLIENTE	--------
			inner join (	select	Rut		= clrut
								,	Dv		= cldv
								,	Codigo	= clcodigo
								,	Nombre	= clnombre
								,	RutDv	= ltrim(rtrim( clrut )) + '-' + ltrim(rtrim( cldv ))
							from	BacParamSuda.dbo.Cliente
						)	Cliente	On	Cliente.Rut		= Movimientos.morutcli
									and	Cliente.codigo	= Movimientos.mocodcli

	-----	FILTRO POR CLIENTE (RUT) -------
	where		Movimientos.morutcli	= @nRutContraparte
	and			Movimientos.mocodcli	= @nCodContraparte
	order 
	by			Movimientos.monumoper
		,		Movimientos.monumdocu

end

else

begin

		--------- D a t o s  D e  C a b e c e r a -----
	select	RutContraparte		= ''
		,	NombreContraparte	= ''
		--------- D a t o s  D e  D e t a l l e   -----
		,	Serie				= ''
		,	Documento			= ''
		,	Inicio				= ''
		,	Termino				= ''
		,	Plazo				= ''
		,	Tasa				= 0
		,	MontoInicial		= 0
		,	MontoFinal			= 0
		--------- D a t o s  D e  G r u p o       -----
		,	SumaMtoInicial		= 0
		,	SumaMtoFinal		= 0
		--------- D a t o s  D e  V a l i d a c i o n -
		,	Estado				= ''
		,	TipoOperacion		= ''
		,	RutInstitucion		= ''

		,	NombreInstitucion	= ''


		,	FechaEmision		= 	''
		,	FechaDesde			= ''
		,	FechaHasta			= ''
		,	Periodo				= ''
		,   'Logo' = (SELECT Logo FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
		,   'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)

end


end

GO
