USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDCV_TRAEINSTRUMENTOSCAR]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDCV_TRAEINSTRUMENTOSCAR]
AS 
BEGIN
      SET NOCOUNT ON
/*
            SELECT 
                        incodigo,
                        inserie,
                        inglosa 
            
            FROM view_instrumento 
*/
 SELECT DISTINCT incodigo ,
   inserie  ,
   inglosa  
 FROM   view_instrumento , 
   mdcp 
 WHERE   incodigo = cpcodigo
        ORDER BY  inglosa            
      SET NOCOUNT OFF
END
-- select distinct incodigo,inserie,inglosa  from view_instrumento , mdcp where incodigo = cpcodigo

GO
