USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INLEERFAMILIAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INLEERFAMILIAS]
AS
BEGIN  
        SELECT incodigo  ,
               inserie   , 
               inglosa   ,
               inrutemi  ,
               inmonemi  ,
               inbasemi  ,
               inprog    ,
               inrefnomi ,
               inMDSE    ,
               inmdtd    ,
               inMDPR    ,
               intipfec  ,
               intasest  ,
               intipo    ,
               inemision ,
               ineleg     
         FROM
               VIEW_INSTRUMENTO
  
         RETURN
END


GO
