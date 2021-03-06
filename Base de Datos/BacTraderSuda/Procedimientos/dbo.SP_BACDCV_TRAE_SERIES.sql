USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDCV_TRAE_SERIES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDCV_TRAE_SERIES] 
                                          (
                                                @incodigo      NUMERIC(5)
                                          )
AS
BEGIN
      SET NOCOUNT ON
            SELECT 
                  secodigo,
                  semascara,
                  seserie
            FROM  VIEW_SERIE
            WHERE @incodigo = secodigo
            ORDER BY secodigo
      SET NOCOUNT OFF
END

GO
