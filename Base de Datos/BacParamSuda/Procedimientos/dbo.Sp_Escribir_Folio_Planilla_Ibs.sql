USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Escribir_Folio_Planilla_Ibs]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Escribir_Folio_Planilla_Ibs]
	(	@FolioPlanilla		numeric(9)
	,	@FolioMemo			numeric(9)
	,	@NumeroPlanillaIbs	numeric(9)
	)
as
begin

	set nocount on

	update	BacParamSuda.dbo.Planilla_Spt
		set	NumeroPlanilla_IBS	= @NumeroPlanillaIbs
	where	fecha				= (select acfecpro from BacCamSuda.dbo.meac with(nolock) )
	and		planilla_numero		= @FolioPlanilla
	and		operacion_numero	= @FolioMemo

end
GO
