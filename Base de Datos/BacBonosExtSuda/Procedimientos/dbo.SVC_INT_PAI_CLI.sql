USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INT_PAI_CLI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INT_PAI_CLI] 
( 
   @rut numeric(9), 
   @cod numeric(9) 
)
as
begin

set nocount on

/*
	select	CLPAIS 
	from 	VIEW_CLIENTE 
	where 	@rut = clrut 
	and 	@cod = clcodigo
*/


SELECT codigo_pais FROM BACPARAMSUDA..PAIS WHERE cod_swift = 'US'

set nocount off
end

GO
