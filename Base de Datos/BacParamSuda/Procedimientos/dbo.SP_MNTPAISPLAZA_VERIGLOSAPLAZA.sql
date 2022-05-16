USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTPAISPLAZA_VERIGLOSAPLAZA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_VeriGlosaPlaza    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MNTPAISPLAZA_VERIGLOSAPLAZA] 
   ( @Glosa VARCHAR(5))
AS 
BEGIN
 SET NOCOUNT ON
 SELEct glosa
 FROM PLAZA where glosa = @Glosa 
 
 SET NOCOUNT OFF
END 

GO
