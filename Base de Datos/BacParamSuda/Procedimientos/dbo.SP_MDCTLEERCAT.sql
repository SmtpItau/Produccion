USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCTLEERCAT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDCTLeerCat    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDCTLeerCat    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[SP_MDCTLEERCAT] (@ctcateg NUMERIC(4))
AS
BEGIN   
set nocount on
 SELECT  ctcateg ,
         ctdescrip,  
                ctindcod,
  ctindtasa,
  ctindfech,
  ctindvalor,
  ctindglosa
  
        FROM
         TABLA_GENERAL_GLOBAL
      WHERE
         ctcateg = @ctcateg
      
 ORDER BY ctdescrip
   RETURN
set nocount off
END  

GO
