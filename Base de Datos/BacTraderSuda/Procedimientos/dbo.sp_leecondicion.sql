USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_leecondicion]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[sp_leecondicion]
as
begin

	select	codigo
		,	descripcion
	from	dbo.Condicion_de_Captacion with(nolock)
	order
	by		descripcion

end
GO
