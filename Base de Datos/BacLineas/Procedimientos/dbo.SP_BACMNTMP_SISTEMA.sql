USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMNTMP_SISTEMA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACMNTMP_SISTEMA    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACMNTMP_SISTEMA]
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT 1 FROM SISTEMA_CNT WHERE operativo='S') BEGIN
  SELECT  id_sistema,
   nombre_sistema,
   operativo,
   gestion
   FROM SISTEMA_CNT 
    WHERE operativo='S' AND gestion = 'N'
    ORDER BY nombre_sistema
 END
 ELSE BEGIN
  
  SELECT 'ERROR'
 END
 SET NOCOUNT ON
END
GO
