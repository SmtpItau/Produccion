USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCLEERCODIGO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_MDRCLEERCODIGO]
	(	@ncodpro				CHAR(5)
	,	@Id_Sistema				CHAR(3)
	,	@Cat_Cartera_Financiera	CHAR(10)
	)
as
begin

	set nocount on

	select	tgd.IdCartera
		,	tgd.Glosa
	from	(	select	IdCartera	= convert(int, tgd.tbcodigo1 )
					,	Glosa		= ltrim(rtrim( tgd.tbglosa	 ))
				from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE tgd with(nolock)
				where	tgd.tbcateg		= @Cat_Cartera_Financiera
			)	tgd

			inner join
			(	select	distinct
						Id = tc.rcrut
				from	BacParamSuda.dbo.TIPO_CARTERA tc with(nolock)
				where	tc.rcsistema	= @Id_Sistema
				and	(	tc.rccodpro		= @ncodpro	OR	@ncodpro = ''	)
			)	CarteraProducto	On CarteraProducto.Id	= tgd.IdCartera
	order
	by		tgd.IdCartera

	/*
		SELECT	rcrut     
		,      	TBGLOSA
		FROM	TIPO_CARTERA
		,		TABLA_GENERAL_DETALLE
		WHERE	rcsistema	= @Id_Sistema 
		AND	(	rccodpro	= @ncodpro or @ncodpro = '')
		AND		tbcateg		= @Cat_Cartera_Financiera
		AND		tbcodigo1	= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
		ORDER 
		BY	rcrut
   */

end
GO
