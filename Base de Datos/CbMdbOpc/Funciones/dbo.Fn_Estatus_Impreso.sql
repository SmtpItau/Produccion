USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_Estatus_Impreso]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fn_Estatus_Impreso]
	(	@Modulo		char(5)
	,	@Folio		numeric(9)
	)	returns		int
as
begin

	declare @nEstatus	int
		set @nEstatus	=	isnull(	(	select top 1 1 from	lnkbac.bacfwdsuda.dbo.Tbl_Impresion_Fax
												where	Modulo			= upper(@Modulo)
												and		Modifica		= 0
												and		Folio			= @Folio

									), -1)

	return @nEstatus

end


GO
