USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMNTCR_BUSCAPRODUCTO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACMNTCR_BUSCAPRODUCTO    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACMNTCR_BUSCAPRODUCTO]
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM PRODUCTO) BEGIN
  SELECT  codigo_producto,
   descripcion,
   id_sistema
    FROM PRODUCTO 
    ORDER BY descripcion
 END
 ELSE BEGIN
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
 
END
GO
