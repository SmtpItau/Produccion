USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEPA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEPA]
            (@emnombre1 numeric(3))
as
begin   
        select  tbcateg, tbcodigo1, tbglosa 
          from VIEW_TABLA_GENERAL_DETALLE 
         where tbcateg=@emnombre1 
      order by tbglosa
      
  return 
end


GO
