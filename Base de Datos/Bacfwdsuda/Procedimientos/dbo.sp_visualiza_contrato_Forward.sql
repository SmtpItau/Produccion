USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_visualiza_contrato_Forward]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_visualiza_contrato_Forward]
	(	@nFolio	numeric(9)	)
as
begin

set nocount on

	select	distinct 
			folio				= convert(int, car.canumoper)
	,		Producto            = convert(char(30), substring(prod.glosa,		1, 30))
	,		LibroNegociacion    = convert(char(30), substring(Lib.Glosa,		1, 30))     --> car.car_Libro
	,		CarteraFinanciera   = convert(char(30), substring(CartFin.Glosa,	1, 30))     --> car.cartera_inversion
	,		CarteraNormativa    = convert(char(30), substring(CartNor.Glosa,	1, 30))     --> car.car_Cartera_Normativa
	,		SubCarteraNormativa = convert(char(30), substring(SubNor.Glosa,		1, 30))     --> car.car_SubCartera_Normativa
	from	bacfwdsuda.dbo.mfca car with(nolock)
			inner join
			(	select	Prod			= codigo_producto
				,		Glosa			= descripcion
				from	bacparamsuda.dbo.producto with(nolock)
				where	id_sistema		= 'bfw'
			)	prod	On prod.Prod	= car.cacodpos1
			left join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 1552
			)	Lib		On Lib.Id		= car.calibro

			left join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 204
			)	CartFin On CartFin.Id	= car.cacodcart

			left  join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 1111
			)	CartNor	On CartNor.Id	= car.cacartera_normativa

			left  join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 1554
			)   SubNor	On SubNor.Id	= car.casubcartera_normativa

	where	canumoper	= @nFolio

end

GO
