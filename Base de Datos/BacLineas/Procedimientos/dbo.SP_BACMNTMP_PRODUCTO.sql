USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMNTMP_PRODUCTO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACMNTMP_PRODUCTO    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACMNTMP_PRODUCTO] 
     ( 
     @sistema CHAR(3)
     )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT 1 FROM PRODUCTO WHERE id_sistema = @sistema ) BEGIN
  SELECT  codigo_producto,
   descripcion,
   id_sistema
    
   FROM PRODUCTO
   WHERE id_sistema = @sistema
   ORDER BY descripcion 
 END
 ELSE BEGIN
  
  SELECT 'ERROR'
 END
 SET NOCOUNT ON
END
GO
