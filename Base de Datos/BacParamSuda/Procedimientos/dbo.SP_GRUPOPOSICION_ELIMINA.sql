USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPOPOSICION_ELIMINA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_GrupoPosicion_Elimina    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
CREATE PROCEDURE [dbo].[SP_GRUPOPOSICION_ELIMINA]
         (@CODIGO_GRUPO VARCHAR(5))
 AS BEGIN
  SET NOCOUNT ON
  
            DELETE FROM GRUPO_POSICION
                        WHERE codigo_grupo=@CODIGO_GRUPO
 SET NOCOUNT OFF
 
END

GO
