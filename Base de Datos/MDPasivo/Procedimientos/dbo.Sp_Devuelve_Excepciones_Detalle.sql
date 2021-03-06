USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Devuelve_Excepciones_Detalle]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Devuelve_Excepciones_Detalle]
		(
		@cUsuario	 CHAR(15),
		@codigo_producto CHAR(10),
		@id_sistema	 CHAR(03)
		
		)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	SELECT	'codigo_excepcion'	= codigo_excepcion	,
		'sistema'		= id_sistema		,
		'codigo_producto'	= codigo_producto	,
		'estado'		= CASE WHEN estado = '' THEN 'N'
					       ELSE estado
					  END			,
		'monto_excepcion'	= monto_excepcion
	FROM   EXCEPCION_USUARIO_DETALLE
	WHERE	id_sistema	= @id_sistema	   AND
		codigo_producto	= @codigo_producto AND
		usuario		= @cUsuario
SET NOCOUNT OFF
END

GO
