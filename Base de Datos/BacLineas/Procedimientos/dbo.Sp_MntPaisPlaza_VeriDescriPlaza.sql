USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntPaisPlaza_VeriDescriPlaza]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_VeriDescriPlaza    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_MntPaisPlaza_VeriDescriPlaza] 
   ( @DESCRIPLAZA VARCHAR(50))
AS 
BEGIN
 SET NOCOUNT ON
 SELECT nombre
 FROM PLAZA where nombre = @DESCRIPLAZA 
 
 SET NOCOUNT OFF
END 
 






GO
