USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeeTabla]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_LeeTabla    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LeeTabla    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[Sp_LeeTabla](@ctcateg NUMERIC(4))
                  
AS
BEGIN
 SELECT  a.tbcodigo1,
  a.tbtasa   ,
  convert(char(10),tbfecha,103),
  a.tbvalor  ,
  a.tbglosa  ,
  a.nemo     ,
  ctdescrip
 FROM TABLA_GENERAL_DETALLE a,TABLA_GENERAL_GLOBAL
 
 WHERE tbcateg = @ctcateg AND
       ctcateg = @ctcateg  
 ORDER BY tbcateg,tbcodigo1,tbtasa,tbfecha
END






GO
