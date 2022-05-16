USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_APLEERNOMBRES1]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_APLEERNOMBRES1] 
               (@clnombre1 CHAR(40))
AS
BEGIN
       SET ROWCOUNT 50
       SELECT  aprutcli  ,
               apdvcli   ,
               apcodcli  , 
               apnombre  ,
               apcargo   ,
               apfono 
        FROM
             VIEW_MDAP
        ORDER BY
                 apnombre
        SET ROWCOUNT 50
        RETURN
END


GO
