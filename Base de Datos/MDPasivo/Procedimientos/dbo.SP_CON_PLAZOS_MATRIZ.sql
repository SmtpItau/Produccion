USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PLAZOS_MATRIZ]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_PLAZOS_MATRIZ]
					(	@id_sistema		CHAR(3)
					,	@cod_producto		CHAR(5)
					)
AS
BEGIN
	SET NOCOUNT ON
	SET DATEFORMAT dmy
	
	SELECT	plazos_matriz
	FROM	PRODUCTO
	WHERE	id_sistema		= @id_sistema
	AND	codigo_producto		= @cod_producto
	
	SET NOCOUNT OFF

END

-- dbo.SP_CON_PLAZOS_MATRIZ 'BCC', 'ARBI'

GO
