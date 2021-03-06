USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCIU]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCiu    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCiu    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEERCIU]
                  
AS
BEGIN
    SELECT DISTINCT nom_ciu, cod_ciu, tbglosa  ,tbcodigo1
    FROM   CIUDAD_COMUNA, TABLA_GENERAL_DETALLE 
    WHERE cod_com                  = 0
      AND tbcateg                  = 180 
      AND convert(char(5),cod_pai) = tbcodigo1 
    ORDER BY nom_ciu
    RETURN
END

GO
