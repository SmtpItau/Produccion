USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_APERTURAMESA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_APERTURAMESA]
AS 
BEGIN
      SELECT acsw_mesa 
        FROM MDAC
END 


GO
