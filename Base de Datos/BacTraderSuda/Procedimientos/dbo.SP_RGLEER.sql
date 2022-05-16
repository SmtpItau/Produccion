USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RGLEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RGLEER]
AS
BEGIN  
SET NOCOUNT ON
    SELECT distinct ISNULL(rgvaldes, 0.0),
           ISNULL(rgvalhas, 0.0)
    FROM MDRG 
    RETURN
SET NOCOUNT OFF
END

GO
