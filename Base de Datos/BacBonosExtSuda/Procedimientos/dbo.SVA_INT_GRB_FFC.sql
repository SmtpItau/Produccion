USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_INT_GRB_FFC]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[SVA_INT_GRB_FFC] 
( 	
        @rut		numeric(9)	,
	@codigo_cli	numeric(9)	,
	@ide		char(30)	
)

as

begin
	set nocount on

--		update 	VIEW_CLIENTE
--		set CLCOD_FFC  = @ide
--		where CLRUT = @rut 
--		and   CLCODIGO 	= @codigo_cli

	set nocount off
end

GO
