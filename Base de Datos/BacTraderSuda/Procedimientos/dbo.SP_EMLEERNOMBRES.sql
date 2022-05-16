USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMLEERNOMBRES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EMLEERNOMBRES] 
            (@emnombre1 char (30))
as
begin   
 set rowcount 50
 select  emcodigo  ,
         emrut     ,
         emdv      ,
         emnombre  ,
         emgeneric ,
         emdirecc  ,
         emcomuna  ,
         emtipo
      from
         VIEW_EMISOR
      where
         emnombre  > @emnombre1
      order by
         emnombre
 set rowcount 0
   return
end  


GO
