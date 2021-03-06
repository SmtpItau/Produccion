USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Con_Codigo_Grupos]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Con_Codigo_Grupos]
AS BEGIN

SET NOCOUNT ON 
SET DATEFORMAT dmy

	SELECT	DISTINCT
		A.codigo_grupo	,
                B.descripcion   ,
		A.id_sistema	,
		'S'		,
		'N'
	FROM	GRUPO_PRODUCTO_DETALLE AS A
        INNER JOIN GRUPO_PRODUCTO      AS B ON
                A.codigo_grupo = B.codigo_grupo
	ORDER BY  id_sistema
SET NOCOUNT OFF
END

GO
