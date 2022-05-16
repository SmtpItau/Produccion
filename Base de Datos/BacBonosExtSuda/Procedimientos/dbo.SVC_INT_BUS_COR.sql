USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INT_BUS_COR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INT_BUS_COR]	
			( @rut			numeric(9)	,
			  @codigo_cli		numeric(9)	)

as
begin
	set nocount on


	select 	CLCODIGO   
	from	VIEW_CLIENTE 
	where	CLRUT    = @rut
	and 	CLCODIGO = @codigo_cli

	set nocount off

end

GO
