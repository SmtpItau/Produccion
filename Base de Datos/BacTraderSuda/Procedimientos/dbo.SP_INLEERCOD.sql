USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INLEERCOD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INLEERCOD]
                (@incodigo1 NUMERIC(8,0))
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
        WHERE
               incodigo = @incodigo1
  
        RETURN
END                                                                                                                                    
         
--sp_inleercod 1


GO
