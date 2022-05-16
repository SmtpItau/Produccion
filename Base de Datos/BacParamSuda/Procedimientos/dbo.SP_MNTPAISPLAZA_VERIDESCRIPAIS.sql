USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTPAISPLAZA_VERIDESCRIPAIS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_VeriDescriPais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MNTPAISPLAZA_VERIDESCRIPAIS] 
   ( @DESCRIPAIS VARCHAR(50))
AS 
BEGIN
 SET NOCOUNT ON
 SELECT nombre
 FROM PAIS where nombre = @DESCRIPAIS 
 
 SET NOCOUNT OFF
END 
 
GO
