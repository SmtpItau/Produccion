USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCiudad]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_LeerCiudad] (
			@tbcodigo1  char(05)
			
				)
AS
BEGIN


   	SET DATEFORMAT DMY
	SET NOCOUNT ON



    SELECT nom_ciu, cod_ciu, nombre

    FROM   CIUDAD_COMUNA c, PAIS t 

    WHERE c.cod_com                  = 0
      AND t.codigo_pais=@tbcodigo1	
      and convert(char(05),cod_pai) = t.codigo_pais
    ORDER BY nom_ciu
    RETURN
set nocount off
END

GO
