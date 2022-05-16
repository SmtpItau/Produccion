USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERIDPRIV]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERIDPRIV]
                (@cusuario char(15))
as
begin
      select  mopcion 
       from   BACMENU, BACPRIV
      where   BACPRIV.usuario = @cusuario
        and   BACPRIV.nivel   = BACMENU.mnivel
        and   BACMENU.mopcion > 0
      return
end


GO
