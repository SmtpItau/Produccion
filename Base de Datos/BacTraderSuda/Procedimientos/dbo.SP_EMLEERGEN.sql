USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMLEERGEN]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EMLEERGEN] (@emgeneric1 char (10))
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
             emgeneric    =  @emgeneric1
      return
end

GO
