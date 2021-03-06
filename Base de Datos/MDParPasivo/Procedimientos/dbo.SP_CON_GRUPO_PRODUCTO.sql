USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_GRUPO_PRODUCTO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_GRUPO_PRODUCTO](@SW INT = 0)
AS
BEGIN

    SET NOCOUNT ON
    SET DATEFORMAT dmy

        SELECT codigo_grupo
              ,descripcion
		,riesgo
        FROM GRUPO_PRODUCTO
        WHERE (codigo_grupo <> 'SETTLE' OR @SW = 1)
        ORDER BY descripcion

    SET NOCOUNT OFF

END



GO
