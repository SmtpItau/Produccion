USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ISMENU]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ISMENU]
            (@xmenu char(40),
             @xentidad char(3))
as
begin
     select posicion 
       from GEN_MENU 
      where nombre_opcion = @xmenu 
        and entidad = @xentidad
end


GO
