USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_BUSCA_CODIGO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacRiePais_Busca_Codigo    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_BacRiePais_Busca_Codigo    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_BUSCA_CODIGO] ( @codigo   NUMERIC (5))
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT nombre FROM PAIS WHERE codigo_pais = @codigo) BEGIN
  
  SELECT nombre FROM PAIS WHERE codigo_pais = @codigo
 END
 ELSE BEGIN
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
END
GO
