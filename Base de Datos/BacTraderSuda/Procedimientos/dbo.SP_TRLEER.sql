USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRLEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRLEER] --'03/03/2000', 97919000
                   ( 
                     @Fecha DATETIME,
                     @Emisor NUMERIC(10)
                   )
AS
BEGIN  
SET NOCOUNT ON
      SELECT ISNULL(CONVERT(CHAR(10),trfecha, 103), '') , 
             ISNULL(trserie , '') , 
             ISNULL(trvaldes,0.0) , 
             ISNULL(trvalhas,0.0) 
, 
             ISNULL(trtasas ,0.0)  
      FROM   MDTR
      WHERE  trfecha  = @Fecha
        AND  tremisor = @Emisor
SET NOCOUNT OFF
      RETURN
END

GO
