USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_TABLADESARROLLO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Limpia_TablaDesarrollo    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Limpia_TablaDesarrollo    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[SP_LIMPIA_TABLADESARROLLO]
               (@xMascara CHAR(12))
AS
BEGIN
   
      SET NOCOUNT ON
      DELETE TABLA_DESARROLLO WHERE tdmascara = @xMascara
      SELECT 'OK'
      SET NOCOUNT OFF
END

GO
