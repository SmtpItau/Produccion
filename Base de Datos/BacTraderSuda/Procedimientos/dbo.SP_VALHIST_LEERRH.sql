USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALHIST_LEERRH]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALHIST_LEERRH]
             (@fecha DATETIME )
AS
BEGIN  
 SELECT ISNULL(rhvaldes, 0.0) ,
  ISNULL(rhvalhas, 0.0)
 FROM MDRH 
 WHERE rhfecha=@fecha
END

GO
