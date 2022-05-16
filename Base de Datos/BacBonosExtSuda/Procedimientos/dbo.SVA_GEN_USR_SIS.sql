USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GEN_USR_SIS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_GEN_USR_SIS]
		(	@nombre	char	(20)	)
as 
begin

	select	usr_cod	,
		usr_lgn	,
		usr_nom	,
		usr_ofi
	from 	btab_gen..ttab_usr 
	where 	usr_lgn = @nombre
end 

GO
