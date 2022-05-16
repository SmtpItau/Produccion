USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDACIONCODIGO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_VALIDACIONCODIGO    fecha de la secuencia de comandos: 03/04/2001 15:18:13 ******/
CREATE PROCEDURE [dbo].[SP_VALIDACIONCODIGO]
  ( @clrut  numeric(9)=0)
   
   
AS   
BEGIN
 SELECT  CLIENTE.clcodigo
               
 FROM    CLIENTE
 WHERE   (CLIENTE.clrut= @clrut)
 
END 
GO
