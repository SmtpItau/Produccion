USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_BUS_UNI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_BUS_UNI]
as
begin

	select 	ofi_cod	, 
		ofi_nom 
	from 	ttab_ofi 
	order 
	by 	ofi_nom


end

GO
