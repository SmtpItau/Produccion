USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Devuelve_Productos_Usuario]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Devuelve_Productos_Usuario]
			(
			@cUsuario  CHAR(15)
			)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
	DECLARE @cUsuario_Subroga   CHAR(15)

	SELECT @cUsuario_Subroga = ISNULL(usuario_subroga, ' ' )
	FROM   EXCEPCION_USUARIO
	WHERE  usuario = @cUsuario


	SELECT	'codigo_producto'  = g.codigo_producto	,
		'sistema'	   = a.nombre_sistema + SPACE(50) +  g.id_sistema	,
		'descripcion'      = g.descripcion	,
		'usuario_subroga'  = ISNULL(@cUsuario_Subroga, ' ')	,
		'estado'           = ISNULL(e.estado, 'N')
	FROM   PRODUCTO as g
	LEFT JOIN EXCEPCION_USUARIO AS e ON
		g.Id_Sistema	  = e.id_sistema	AND
		g.Codigo_Producto = e.codigo_producto	AND
		usuario		  = @cUsuario
	INNER JOIN SISTEMA	AS a ON
		g.id_sistema	  = a.id_sistema
	WHERE	g.Contabiliza='S'
	AND	g.Gestion='N'
	order by a.nombre_sistema, g.codigo_producto


SET NOCOUNT OFF
END

-- select * from producto
-- dbo.Sp_Devuelve_Productos_Usuario 'administra'

GO
