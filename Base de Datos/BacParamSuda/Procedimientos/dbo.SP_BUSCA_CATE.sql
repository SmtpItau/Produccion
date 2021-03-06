USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CATE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Cate    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Cate    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_CATE] (@emnombre1 NUMERIC(4))
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
         ctcateg = @emnombre1
      ORDER BY
         ctdescrip
   RETURN
END  
GO
