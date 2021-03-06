USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LeeCa    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LeeCa    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_LEECA] (@emnombre1 NUMERIC(4))
AS
BEGIN   
 SELECT  
  ctcateg  ,--campo insertado
  ctdescrip ,--campo insertado
  ctindcod ,
  ctindtasa ,
  ctindfech ,
  ctindvalor ,
  ctindglosa
  
  
        FROM
         TABLA_GENERAL_GLOBAL
      WHERE
         ctcateg > @emnombre1
      ORDER BY
         ctdescrip
   RETURN
END  
GO
