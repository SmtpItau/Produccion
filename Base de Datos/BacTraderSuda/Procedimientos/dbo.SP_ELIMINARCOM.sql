USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARCOM]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINARCOM](@cod_pai numeric(6),
                                @cod_ciu numeric(6),
           @cod_com numeric(6))
                  
as
begin
    set nocount on
      
    delete VIEW_CIUDAD_COMUNA where cod_pai = @cod_pai and cod_ciu = @cod_ciu and cod_com = @cod_com
  
   set nocount off
   select 'OK'    
   return
end


GO
