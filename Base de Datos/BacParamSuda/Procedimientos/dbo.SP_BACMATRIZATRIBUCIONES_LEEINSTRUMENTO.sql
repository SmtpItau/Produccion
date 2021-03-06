USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_LEEINSTRUMENTO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_LEEINSTRUMENTO]
AS BEGIN
   SET NOCOUNT ON
 SELECT 
  incodigo, 
  inserie, 
  inglosa, 
  inrutemi,
         inmonemi, 
  inbasemi, 
  inprog, 
  inrefnomi,
         inmdse, 
  inmdtd, 
  inmdpr, 
  intipfec,
         intasest, 
  intipo, 
  inemision, 
  ineleg,
         inlargoms, 
  inedw, 
  incontab, 
  intiporig,
         intotalemitido, 
  insecuritytype, 
  insecuritytype2 
        FROM INSTRUMENTO
 ORDER BY inserie
   SET NOCOUNT OFF
END
GO
