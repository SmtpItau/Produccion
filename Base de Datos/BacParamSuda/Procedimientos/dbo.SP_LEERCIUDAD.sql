USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCIUDAD]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCiudad    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
CREATE PROCEDURE [dbo].[SP_LEERCIUDAD] (
   @tbcodigo1  char(05)
   
    )
AS
BEGIN
set nocount on
    SELECT nom_ciu, cod_ciu, tbglosa  
    FROM   CIUDAD_COMUNA c, TABLA_GENERAL_DETALLE t 
    WHERE c.cod_com                  = 0
      AND t.tbcateg                  = 180 
      AND t.tbcodigo1=@tbcodigo1 
      and convert(char(05),cod_pai) = t.tbcodigo1
    ORDER BY nom_ciu
    RETURN
set nocount off
END

GO
