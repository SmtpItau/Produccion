USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPOPOSICION_AYUDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_GrupoPosicion_Ayuda    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
CREATE PROCEDURE [dbo].[SP_GRUPOPOSICION_AYUDA]
  AS BEGIN
    SET NOCOUNT ON
 SELECT codigo_grupo,
        descripcion,
        plazo_desde,
        plazo_hasta FROM GRUPO_POSICION
    SET NOCOUNT OFF
END

GO
