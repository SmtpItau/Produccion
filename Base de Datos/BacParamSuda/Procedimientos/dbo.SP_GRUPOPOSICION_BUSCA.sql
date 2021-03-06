USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPOPOSICION_BUSCA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_GrupoPosicion_Busca    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
CREATE PROCEDURE [dbo].[SP_GRUPOPOSICION_BUSCA]
         (@CODIGO_GRUPO VARCHAR(5))
 AS BEGIN
  SET NOCOUNT ON
  
            SELECT codigo_grupo, 
     descripcion,
                   plazo_desde,
                   plazo_hasta 
                   FROM GRUPO_POSICION
                        WHERE codigo_grupo=@CODIGO_GRUPO
 SET NOCOUNT OFF
 
END

GO
