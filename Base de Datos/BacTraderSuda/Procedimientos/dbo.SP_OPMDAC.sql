USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPMDAC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_OPMDAC]
 AS 
 BEGIN
 SET NOCOUNT ON
            
    DECLARE @acnumoper NUMERIC (10,0)
         
    SELECT @acnumoper=acnumoper FROM MDAC
         
    INSERT INTO MDPA VALUES(0,@acnumoper,0,0)
    UPDATE MDAC
    SET acnumoper = acnumoper + 1
    SELECT @acnumoper
 SET NOCOUNT OFF
 RETURN        
 END
--  SELECT * FROM MDAC 
-- select name from sysobjects where name = 'mdac' and type ='U'


GO
