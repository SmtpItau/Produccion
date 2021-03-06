USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_leer_productos_excepcion]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_leer_productos_excepcion]
			(
			@Usuario CHAR(15)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	SELECT	E.id_sistema	,	--P.codigo_producto
		P.descripcion		,
		E.usuario_subroga,
                E.codigo_producto
	FROM	EXCEPCION_USUARIO AS E  WITH (NOLOCK)
	INNER JOIN producto AS P  WITH (NOLOCK) ON
		(usuario	 = @Usuario	OR
		 usuario_subroga = @Usuario)	AND
		 estado		 = 'S'		AND
		P.Id_Sistema 	 = E.Id_Sistema and
		P.Codigo_Producto= E.Codigo_Producto

END


GO
