USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMLEERRUT]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EMLEERRUT] (@emrut1 numeric (9,0))
as
begin  
       select emcodigo  ,
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
              emrut = @emrut1
                
       return
end
                                                                                                                     

GO
