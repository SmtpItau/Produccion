USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DESBLOQUEADOC]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DESBLOQUEADOC]
            (   @rutcart   int,
                @numdocu   int,
                @user      char(20),
                @correla   int      )
as
begin
      set nocount on
      delete MDBL where (blnumdocu=@numdocu)and
                        (@rutcart=blrutcart)and 
                        (blusuario=@user) and 
                        (blcorrela=@correla)
   set nocount off
   select 'OK'
end


GO
