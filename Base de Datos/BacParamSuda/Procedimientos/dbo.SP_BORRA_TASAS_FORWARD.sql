USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_TASAS_FORWARD]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borra_Tasas_Forward    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Borra_Tasas_Forward    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRA_TASAS_FORWARD]
AS
BEGIN
DELETE TASA_FWD
 IF @@ERROR <> 0 
     SELECT -1, 'Problemas al borrar información'
END
GO
