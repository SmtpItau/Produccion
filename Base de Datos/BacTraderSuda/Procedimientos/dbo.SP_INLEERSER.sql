USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INLEERSER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INLEERSER]
         (@inserie1 CHAR (10)  )
AS
BEGIN  
 SELECT incodigo ,
  inserie  ,
  inglosa  ,
  inrutemi ,
  inmonemi ,
  inbasemi ,
  inprog  ,
  inrefnomi ,
  inMDSE  ,
  inmdtd  ,
  inMDPR  ,
  intipfec ,
  intasest ,
  intipo  ,
  inemision ,
  ineleg  ,
  ISNULL(incontab,'N')
 FROM VIEW_INSTRUMENTO
 WHERE inserie=@inserie1
  
 RETURN
END


GO
