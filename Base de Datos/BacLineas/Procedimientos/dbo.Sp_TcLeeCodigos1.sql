USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TcLeeCodigos1]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TcLeeCodigos1    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_TcLeeCodigos1    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[Sp_TcLeeCodigos1] (
     @tccodtab1 NUMERIC (03,0)
     )
AS
BEGIN
set nocount on
 IF @tccodtab1=1
  SELECT tbcateg  --campo insertado
   tbcodigo1 ,
   tbtasa  ,--campo insertado
   tbfecha  ,--campo insertado
   tbvalor  ,--campo insertado
   tbglosa  ,
   nemo   --campo insertado
   --tcSistema ,--campo insertado
   --Tbcateg ,--campo insertado
   --tbcodigo1 ,--campo insertado
   --tcglosa  --campo insertado
   
   
  FROM TABLA_GENERAL_DETALLE
  WHERE tbcateg=@tccodtab1
  ORDER BY tbglosa,tbcodigo1
 ELSE
  SELECT tbcodigo1 ,
   tbglosa
  FROM TABLA_GENERAL_DETALLE
  WHERE tbcateg=@tccodtab1
  ORDER BY tbcodigo1
 
       RETURN
set nocount off
END
                                                                                                                                                                           






GO
