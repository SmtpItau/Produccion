USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_visualiza_contrato_swap]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_visualiza_contrato_swap]
	(	@nFolio	numeric(9)	)
as
begin

set nocount on

	select	distinct 
			folio				= convert(int, car.numero_operacion)
	,		Producto            = convert(char(30), substring(prod.glosa,		1, 30))
	,		LibroNegociacion    = convert(char(30), substring(Lib.Glosa,		1, 30))     --> car.car_Libro
	,		CarteraFinanciera   = convert(char(30), substring(CartFin.Glosa,	1, 30))     --> car.cartera_inversion
	,		CarteraNormativa    = convert(char(30), substring(CartNor.Glosa,	1, 30))     --> car.car_Cartera_Normativa
	,		SubCarteraNormativa = convert(char(30), substring(SubNor.Glosa,		1, 30))     --> car.car_SubCartera_Normativa
	from	bacswapsuda.dbo.cartera car with(nolock)
			inner join
			(	select	Prod			= case	when codigo_producto = 'st' then 1
												when codigo_producto = 'sm' then 2
												when codigo_producto = 'fr' then 3
												when codigo_producto = 'sp' then 4
											end
				,		Glosa			= descripcion
				from	bacparamsuda.dbo.producto with(nolock)
				where	id_sistema		= 'pcs'
			)	prod	On prod.Prod		= car.tipo_swap
			left join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 1552
			)	Lib		On Lib.Id		= car.car_Libro

			left join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 204
			)	CartFin On CartFin.Id	= car.cartera_inversion

			left  join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 1111
			)	CartNor	On CartNor.Id	= car.car_Cartera_Normativa

			left  join
			(	select	Id				= tbcodigo1
				,		Glosa			= ltrim(rtrim( tbcodigo1 )) + ' - ' + ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg			= 1554
			)   SubNor	On SubNor.Id	= car.car_SubCartera_Normativa

	where	numero_operacion	= @nFolio

end
GO
