USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRASINACOFIMDCL]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BORRASINACOFIMDCL    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BORRASINACOFIMDCL    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRASINACOFIMDCL]( @clrut         NUMERIC(10) ,
                                       @clcodigo      NUMERIC(10) )
AS 
BEGIN
     IF EXISTS (SELECT
  clrut ,
  clcodigo, 
  clnumSinacofi,
  clnomSinacofi
  FROM SINACOFI 
  WHERE clrut = @clrut AND clcodigo = @clcodigo)
      DELETE FROM SINACOFI 
              WHERE clrut = @clrut AND clcodigo = @clcodigo
END

GO
