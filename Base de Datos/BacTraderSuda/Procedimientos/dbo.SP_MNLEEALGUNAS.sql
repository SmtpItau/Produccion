USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNLEEALGUNAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNLEEALGUNAS]
as
begin
      set nocount on
       select  mncodmon ,
               mnnemo        ,
               mnsimbol       ,
               mnglosa        ,
               mnredondeo   ,
               mnbase         ,
               mntipmon      ,
               mnperiodo     ,
               mncodsuper
       from
               VIEW_MONEDA
       where mnmx<>'C'
                            
    
       set nocount off
       return
end

GO
