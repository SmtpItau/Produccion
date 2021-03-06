USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Consulta_Rec]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_Consulta_Rec]
	(	@nRutCliente		numeric(10)
	,	@nRutAuxiliar		int
	)	Returns				int
as
begin

	declare @nRec			int
		Set @nRec			= (select 'Metodo REC' = BacLineas.dbo.FN_RIEFIN_METODO_LCR ( @nRutCliente, @nRutAuxiliar, 0, 0))

	declare @nRetorno		int
		set @nRetorno		= -1

	select	@nRetorno		= IdCodigo
		/*
    select	Id				= IdCodigo
		,	Descripcion		= Glosa
		,	Sigla			= Nemo
		,	RecId			= Rec.Id
		,	Descripcion		= Rec.Descrip
		*/
    from	bdbomesa.Garantia.TBL_GeneralDetalle Relacion with(nolock)
			inner join
			(	select	Id		= IdCodigo
					,	Sigla	= Nemo
					,	Descrip	= Glosa
				from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
				where	IdCategoria = (select IdCategoria from bdbomesa.Garantia.TBL_GeneralGlobal with(nolock) where IdCategoria = 23)
			)	Rec		On Rec.Sigla	= Relacion.Nemo
    where	IdCategoria = (select IdCategoria from bdbomesa.Garantia.TBL_GeneralGlobal with(nolock) where IdCategoria = 1)
	and		Rec.Id		= @nRec

	Return	@nRetorno


END

GO
