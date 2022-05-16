USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCTLeerCat]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDCTLeerCat    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDCTLeerCat    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[Sp_MDCTLeerCat] (@ctcateg NUMERIC(4))
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
