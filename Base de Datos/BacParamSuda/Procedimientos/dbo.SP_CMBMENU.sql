USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBMENU]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_CmbMenu    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CMBMENU]
AS 
BEGIN
 SET NOCOUNT ON
 SELECT nombre_opcion,nombre_objeto
 from GEN_MENU  
 ORDER BY  nombre_opcion
 SET NOCOUNT OFF
END
GO
