USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Planillas_Sin_Folio_Ibs]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Leer_Planillas_Sin_Folio_Ibs]
as
begin

	set nocount on

	declare @iFound		int

	--	Valida el Inicio de Día
		set @iFound		= (	select	Id = substring( aclogdig, 1, 1) from BacCamSuda.dbo.meac with(nolock) )

	if ( @iFound = 0 )
	begin
		return	
	end

	--	Valida la Apertura de Mesa de Dinero
		set @iFound		= (	select	CM = substring( aclogdig, 6, 1) from BacCamSuda.dbo.meac with(nolock) )

	if ( @iFound = 1 )
	begin
		return	
	end

	--	Valida el Fin de Día
		set @iFound		= (	select	FD = substring( aclogdig, 9, 1) from BacCamSuda.dbo.meac with(nolock) )

	if ( @iFound = 1 )
	begin
		return	
	end

	select	FolioPlanilla		= planilla_numero
		,	FolioMemo			= operacion_numero
		,	NumeroPlanillaIbs	= convert(numeric(9), 0)
	from	BacParamSuda.dbo.Planilla_Spt with(nolock)
	where	fecha				= (select acfecpro from BacCamSuda.dbo.meac with(nolock) )
	and		NumeroPlanilla_IBS = 0
	order 
	by		operacion_numero
		,	planilla_numero

end
GO
