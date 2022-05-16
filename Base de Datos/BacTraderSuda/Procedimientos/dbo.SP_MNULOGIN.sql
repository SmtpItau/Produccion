USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNULOGIN]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNULOGIN]
               ( @cusuario char(15) )
as
begin
    select mnivel,mtexto,mtipo,mopcion
                 from  BACPRIV, BACMENU
                 where BACPRIV.usuario = @cusuario and
                       BACMENU.mnivel  = BACPRIV.nivel
                 order by BACMENU.mnivel
    return
end
                                                                                                                                                                                                

GO
