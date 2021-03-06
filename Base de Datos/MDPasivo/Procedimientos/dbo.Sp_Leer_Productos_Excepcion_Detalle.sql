USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Productos_Excepcion_Detalle]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Leer_Productos_Excepcion_Detalle]
			(
			@Usuario   CHAR(15)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

		SELECT	D.id_sistema		,
			E.descripcion		,
			D.estado		,
			D.monto_excepcion,
                        D.codigo_producto
		FROM	EXCEPCION_USUARIO_DETALLE AS D  WITH (NOLOCK)
		INNER JOIN EXCEPCION		  AS E  WITH (NOLOCK) ON 
			E.codigo_excepcion = D.codigo_excepcion	AND
			D.usuario          = @Usuario 		AND
			estado='S'

END


GO
