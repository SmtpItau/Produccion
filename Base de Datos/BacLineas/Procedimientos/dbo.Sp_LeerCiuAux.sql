USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCiuAux]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_LeerCiuAux] ( @npais NUMERIC ( 4 ) )
AS
BEGIN

	SET NOCOUNT ON

	SELECT	distinct cod_ciu, nombre
	FROM	ciudad_comuna, ciudad
	WHERE	cod_pai = @npais
	AND	cod_ciu = ciudad.codigo_ciudad

	SET NOCOUNT OFF

/*
    SELECT cod_ciu,
           nom_ciu
    FROM   ciudad_comuna
    WHERE  cod_pai = @npais
    ORDER BY nom_ciu
    RETURN
*/
END








GO
