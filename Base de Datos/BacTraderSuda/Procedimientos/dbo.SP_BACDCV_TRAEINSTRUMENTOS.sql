USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDCV_TRAEINSTRUMENTOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDCV_TRAEINSTRUMENTOS]
AS 
BEGIN
      SET NOCOUNT ON
            SELECT 
                        incodigo,
                        inserie,
                        inglosa 
            
            FROM view_instrumento 
            ORDER BY inglosa            
      SET NOCOUNT OFF
END


GO
