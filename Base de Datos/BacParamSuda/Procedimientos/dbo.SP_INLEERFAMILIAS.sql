USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INLEERFAMILIAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_InLeerFamilias    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_InLeerFamilias    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_INLEERFAMILIAS]
AS
BEGIN  
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
        inlargoms ,
        inedw  ,
        incontab  ,
        intiporig ,
        intotalemitido ,
        insecuritytype ,
        insecuritytype2
         FROM
               INSTRUMENTO
  
         RETURN
SET NOCOUNT OFF
END

GO
