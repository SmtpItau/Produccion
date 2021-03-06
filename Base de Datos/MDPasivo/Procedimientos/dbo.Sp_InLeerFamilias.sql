USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_InLeerFamilias]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_InLeerFamilias]
AS BEGIN  
SET DATEFORMAT dmy
SET NOCOUNT ON
        SELECT incodigo  ,
               inserie   , 
               inglosa   ,
               inrutemi  ,
               inmonemi  ,
               inbasemi  ,
               inprog    ,
               inrefnomi ,
               inmdse    ,
               inmdtd    ,
               inmdpr    ,
               intipfec  ,
               intasest  ,
               intipo    ,
               inemision ,
               ineleg    , 
	       inlargoms	,
	       inedw		,
	       incontab		,
	       intiporig	,
	       intotalemitido	,
	       insecuritytype	,
	       insecuritytype2
         FROM
               INSTRUMENTO
  
         RETURN
SET NOCOUNT OFF
END

GO
