USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEGRUPO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEEGRUPO]
as
begin   
        select rut_grupo, glosa 
          from lgrupo 
         where grupo = 's' 
      order by glosa
        return 
end


GO
