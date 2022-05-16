USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidacionRut]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_ValidacionRut    fecha de la secuencia de comandos: 03/04/2001 15:18:13 ******/
CREATE PROCEDURE [dbo].[Sp_ValidacionRut]
  ( @clcodigo numeric(9)=0)  
   
AS   
BEGIN
 SELECT  CLIENTE.CLrut
               
 FROM    CLIENTE
 WHERE   (CLIENTE.CLcodigo= @clcodigo)
 
END 






GO
