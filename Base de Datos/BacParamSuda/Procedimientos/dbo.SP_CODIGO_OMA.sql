USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODIGO_OMA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Codigo_OMA    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CODIGO_OMA]
  (@codigo CHAR(10)
  )
AS
BEGIN 
 SET NOCOUNT OFF
 SELECT codigo_numerico,codigo_caracter,glosa
 FROM TBCODIGOSOMA
 WHERE  codigo_numerico =@codigo
 SET NOCOUNT ON
END
GO
