USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAPRIV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAPRIV] ( @usuario  char(15) )
as 
begin
 select BACMENU.mnivel,BACMENU.mtexto,BACMENU.mtipo,BACMENU.mopcion
 from BACMENU ,BACPRIV 
 where BACPRIV.usuario = @usuario 
 and   BACPRIV.nivel = BACMENU.mnivel
end

GO
