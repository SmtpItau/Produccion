USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CMP_PAI_CLI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_CMP_PAI_CLI]
(
        @rut		numeric(9)	,
	@cod_cli	numeric(9)	
)
as
begin
set nocount on
	declare @pais	numeric(3)
	select @pais = CLPAIS from VIEW_CLIENTE where clrut = @rut and clcodigo = @cod_cli
	
	if exists(select * from view_pais where  codigo_pais = @pais) begin
		select 'SI', nombre from view_pais where  codigo_pais = @pais
	end
	else  begin
		select 'NO', 'País No Definido'
	end
set nocount off
end



GO
