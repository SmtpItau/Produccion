USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Svc_Query_Derivados]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Svc_Query_Derivados]
	(	
		@nFolio		char(10)	= '0'
	)
as
begin

	set nocount on
	
	select	Folio			= convert(char(20), Carteras.Folio)
		,	Documento		= convert(char(20), Documento)
		,	Correlativo		= convert(char(20), Correlativo)
		,	Modulo			= convert(char(15), Carteras.Modulo)
		,	Rut				= convert(char(15), Cli.RutDv)
		,	Nombre			= convert(char(50), Cli.clnombre)
		,	Libro			= convert(char(35), lib.xGlosa)
		,	Financiera		= convert(char(35), Fin.xGlosa)
		,	Normativa		= convert(char(35), Nor.xGlosa)
		,	SubCartera		= convert(char(35), Sub.xGlosa)
	from	(	
				select	distinct
						Folio			= convert(char(20), canumoper)
					,	Documento		= 0
					,	Correlativo		= 0
					,	Modulo			= 'Forward'
					,	Rut				= cacodigo
					,	Codigo			= cacodcli
					,	Libro			= calibro 
					,	Financiera		= cacodcart
					,	Normativa		= cacartera_normativa 
					,	SubCartera		= casubcartera_normativa
				from	BacFwdSuda.dbo.mfca with(nolock)
				where	(
						canumoper		= @nFolio or @nFolio = 0
						)
					union
				select	distinct
						Folio			= convert(char(20), numero_operacion)
					,	Documento		= 0
					,	Correlativo		= 0
					,	Modulo			= 'Swap'
					,	Rut				= Rut_Cliente
					,	Codigo			= codigo_cliente
					,	Libro			= car_Libro
					,	Financiera		= cartera_inversion
					,	Normativa		= car_Cartera_Normativa
					,	SubCartera		= car_SubCartera_Normativa
				from	BacSwapSuda.dbo.Cartera with(nolock)
				where	estado			<> 'C'
				and		(
						numero_operacion= @nFolio or @nFolio = 0
						)
					union
				select	Folio			= cpnumdocu
					,	Documento		= cpnumdocu
					,	Correlativo		= cpcorrela
					,	Modulo			= 'Renta Fija - CP'
					,	Rut				= cprutcli
					,	Codigo			= cpcodcli
					,	Libro			= id_libro
					,	Financiera		= case when len(Tipo_Cartera_Financiera)=0 then 0 else Tipo_Cartera_Financiera end
					,	Normativa		= codigo_carterasuper
					,	SubCartera		= 0
				from	BacTraderSuda.dbo.Mdcp with(nolock)
				where	cpnominal	> 0
				and	(
						cpnumdocu		= @nFolio or @nFolio = 0
					)
					union
				select	Folio			= cinumdocu
					,	Documento		= cinumdocu 
					,	Correlativo		= cicorrela
					,	Modulo			= 'Renta Fija - CI'
					,	Rut				= cirutcli
					,	Codigo			= cicodcli
					,	Libro			= id_libro
					,	Financiera		= case when len(Tipo_Cartera_Financiera)=0 then 0 else Tipo_Cartera_Financiera end  
					,	Normativa		= codigo_carterasuper
					,	SubCartera		= 0
				from	BacTraderSuda.dbo.Mdci with(nolock)
				where	cinominal	> 0
				and	(
						cinumdocu		= @nFolio or @nFolio = 0
					)
					union
				select	Folio			= vinumoper
					,	Documento		= vinumdocu
					,	Correlativo		= vicorrela
					,	Modulo			= 'Renta Fija - VI'
					,	Rut				= virutcli
					,	Codigo			= vicodcli
					,	Libro			= id_libro
					,	Financiera		= case when len(Tipo_Cartera_Financiera) = 0 then 0 else Tipo_Cartera_Financiera end
					,	Normativa		= codigo_carterasuper
					,	SubCartera		= 0
				from	BacTraderSuda.dbo.Mdvi with(nolock)
				where	vinominal	> 0
				and	(
						vinumoper		= @nFolio or @nFolio = 0
					)
					union
				select	Folio			= cpnumdocu
					,	Documento		= cpnumdocu
					,	Correlativo		= cpcorrelativo
					,	Modulo			= 'Bonex - CP'
					,	Rut				= cprutcli
					,	Codigo			= cpcodcli
					,	Libro			= id_libro
					,	Financiera		= case when len(tipo_cartera_financiera)=0 then 0 else tipo_cartera_financiera end
					,	Normativa		= codigo_carterasuper
					,	SubCartera		= 0
				from	BacBonosextSuda.dbo.text_ctr_inv with(nolock)
				where	cpnominal		> 0 
				and		cpfecven		> (select acfecproc from BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock) )
				and	(
						cpnumdocu		= @nFolio or @nFolio = 0
					)
					union
				select	Folio			= car.CaNumContrato
					,	Documento		= 0
					,	Correlativo		= 0
					,	Modulo			= 'Opciones'
					,	Rut				= car.CaRutCliente
					,	Codigo			= car.CaCodigo
					,	Libro			= car.CaLibro
					,	Financiera		= car.CaCarteraFinanciera
					,	Normativa		= car.CaCarNormativa
					,	subcartera		= car.CaSubCarNormativa
				from	cbmdbopc.dbo.CaEncContrato car with(nolock)
						inner join
						(	select	Contrato = canumcontrato
								,	Folio	 = max( canumfolio )
							from	cbmdbopc.dbo.CaEncContrato with(nolock)
							group 
							by		canumcontrato
						)	grp	On	grp.Contrato	= car.CaNumContrato
								and	grp.Folio		= car.CaNumFolio
				where	car.CaEstado <> 'C'
				and	(	
						car.CaNumContrato = @nFolio or @nFolio = 0
					)
					union
				select	Folio		= monumoper
					,	Documento	= monumdocu 
					,	Correlativo	= mocorrela
					,	Modulo		= 'Renta Fija - VP'
					,	Rut			= morutcli
					,	Codigo		= mocodcli 
					,	Libro		= id_libro
					,	Financiera	= Tipo_Cartera_Financiera
					,	normativa	= codigo_carterasuper
					,	SubCartera	= 0
				from	BacTraderSuda.dbo.mdmo with(nolock) 
				where	motipoper	= 'vp'
				and		mostatreg	= '' or mostatreg = 'P'
				and	(	
						monumoper	= @nFolio or @nFolio = 0
					)
	
			)	Carteras

			left join	(	select	codigo			= 0
								,	glosa			= 'SIN LIBRO'
								,	xGlosa			= ltrim(rtrim( 0 )) + ' - ' + ltrim(rtrim( 'SIN LIBRO' ))
								union
							select	codigo			= tbcodigo1
								,	glosa			= tbglosa
								,	xGlosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
							from	BacParamSuda.dbo.Tabla_General_Detalle 
							where	tbcateg			= 1552
						)	Lib		On Lib.codigo	= Carteras.Libro

			left join	(	select	codigo			= tbcodigo1
								,	glosa			= tbglosa
								,	xGlosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
							from	BacParamSuda.dbo.Tabla_General_Detalle 
							where	tbcateg			= 204
						)	Fin		On Fin.codigo	= Carteras.Financiera

			left join	(	select	codigo			= tbcodigo1
								,	glosa			= tbglosa
								,	xGlosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
							from	BacParamSuda.dbo.Tabla_General_Detalle 
							where	tbcateg			= 1111
						)	Nor		On Nor.codigo	= Carteras.Normativa

			left join	(	select	codigo			= 0
								,	glosa			= 'NO APLICA'
								,	xGlosa			= ltrim(rtrim( 0 )) + ' - ' + 'NO APLICA'
								union
							select	codigo			= tbcodigo1
								,	glosa			= tbglosa
								,	xGlosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
							from	BacParamSuda.dbo.Tabla_General_Detalle 
							where	tbcateg			= 1554
						)	Sub		On Sub.codigo	= Carteras.SubCartera

			left join	(	select	clrut, clcodigo, clnombre, RutDv = ltrim(rtrim( clrut )) + '-' + ltrim(rtrim( cldv))
							from	BacParamSuda.dbo.Cliente with(nolock)
						)	Cli		On	cli.clrut	= Carteras.Rut
									and cli.clcodigo= Carteras.Codigo
	order 
		by	Carteras.Modulo
		,	Carteras.Folio

end
GO
