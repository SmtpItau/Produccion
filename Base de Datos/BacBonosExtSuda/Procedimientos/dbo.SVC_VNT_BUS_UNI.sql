USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_VNT_BUS_UNI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




-- modificado por hernan olavarria 16/01/2001
create procedure [dbo].[SVC_VNT_BUS_UNI] 
(  
    @Unidad	char(4)	
)
as
begin

	select 	ISNULL(ofi_nom , ' ' )
	from 	ttab_ofi
	where 	ofi_cod = @unidad 

end

GO
