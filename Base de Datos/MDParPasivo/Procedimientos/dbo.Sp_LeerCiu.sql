USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCiu]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_LeerCiu]
                 	
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    SELECT DISTINCT nom_ciu, cod_ciu, nombre  ,codigo_pais

    FROM   CIUDAD_COMUNA, PAIS

    WHERE cod_com                  = 0
      AND convert(char(5),cod_pai) = codigo_pais
    ORDER BY nom_ciu
    RETURN
END


GO
