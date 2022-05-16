USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARCIU]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINARCIU]
                  (@cod_pai numeric(6),
                  @cod_ciu numeric(6))
                
as
begin
    set nocount on
    delete VIEW_CIUDAD_COMUNA where cod_pai = @cod_pai and cod_ciu = @cod_ciu 
    set nocount off
    select 'OK'
    return
end
--sp_helptext sp_grabaciu
--sp_helptext sp_eliminarciu
--sp_helptext eliminarciu


GO
