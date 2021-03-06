USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTERELA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_ClienteRela    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CLIENTERELA]
  (@rut_padre  NUMERIC(10),
   @codigo_padre  NUMERIC(10),
   @rut_hijo  NUMERIC(10),
   @codigo_hijo  NUMERIC(10))
AS 
BEGIN
 SET NOCOUNT ON
 SELECT  clrut_padre,
  clcodigo_padre,
  clrut_hijo,
  clcodigo_hijo,
  clporcentaje
 FROM CLIENTE_RELACIONADO
 WHERE clrut_padre =@rut_padre
 AND   clcodigo_padre = @codigo_padre
 AND   clrut_hijo =@rut_hijo 
 AND   clcodigo_hijo =@codigo_hijo
 SET NOCOUNT OFF
END
GO
