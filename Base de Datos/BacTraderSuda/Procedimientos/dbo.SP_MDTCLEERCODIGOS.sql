USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDTCLEERCODIGOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MDTCLEERCODIGOS]
                  (@ncodtab    numeric(03))
as
begin
set nocount on
 select tbcodigo1,tbglosa 
  from VIEW_TABLA_GENERAL_DETALLE 
   where tbcateg =  @ncodtab  
    order by tbcodigo1
set nocount off
end
/*
insert into MDTC select * from baccam..MDTC
delete MDTC
sp_MDTCleercodigos 36
select * from MDTC
sp_helptext sp_MDTCleercodigos
*/

GO
