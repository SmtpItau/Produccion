USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPOPOSICION_GRABA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_GrupoPosicion_Graba    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
CREATE PROCEDURE [dbo].[SP_GRUPOPOSICION_GRABA]
         (@CODIGO_GRUPO VARCHAR(5),
                 @DESCRIPCION VARCHAR(50),
          @PLAZO_DESDE NUMERIC(5),
          @PLAZO_HASTA  NUMERIC(5))
 AS BEGIN
  SET NOCOUNT ON
  
            IF EXISTS(SELECT codigo_grupo FROM GRUPO_POSICION WHERE codigo_grupo=@CODIGO_GRUPO)
                   BEGIN 
   SELECT 'EXISTE'
   UPDATE GRUPO_POSICION 
    SET codigo_grupo = @CODIGO_GRUPO,
                      descripcion  = @DESCRIPCION,
                      plazo_desde  = @PLAZO_DESDE,
                                    plazo_hasta  = @PLAZO_HASTA
    WHERE codigo_grupo = @CODIGO_GRUPO
     END
            ELSE
   
                   BEGIN 
   SELECT 'NUEVO'   
   INSERT GRUPO_POSICION
    (codigo_grupo,
                   descripcion,
                   plazo_desde,
                                 plazo_hasta)
    VALUES(@CODIGO_GRUPO,
    @DESCRIPCION,
    @PLAZO_DESDE,
    @PLAZO_HASTA)
             END
 SET NOCOUNT OFF
 
END

GO
