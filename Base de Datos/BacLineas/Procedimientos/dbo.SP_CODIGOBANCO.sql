USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODIGOBANCO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CODIGOBANCO    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CODIGOBANCO]
  (@moneda NUMERIC(10)
   
  )
   
AS 
BEGIN
 SET NOCOUNT ON
 SELECT mncodbanco
 FROM MONEDA
 WHERE mncodmon=@moneda
 SET NOCOUNT OFF
END

GO
