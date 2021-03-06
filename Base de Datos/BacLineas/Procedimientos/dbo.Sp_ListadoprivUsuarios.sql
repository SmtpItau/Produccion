USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListadoprivUsuarios]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





-- SP_AUTORIZA_EJECUTAR 'bacuser'
CREATE PROCEDURE [dbo].[Sp_ListadoprivUsuarios](
					@usuario         	CHAR(15),
					@cTipo_privilegio	CHAR(1),
					@vTitulo		VARCHAR(80)
					)
AS
BEGIN 

	SET NOCOUNT ON

	IF @cTipo_privilegio = 'U'
	BEGIN
		SELECT DISTINCT
			'INDICE'		= ISNULL(b.indice,' ')					,
			'usuario'		= ISNULL(a.usuario,' ')					,
			'nombre'		= ISNULL(c.nombre,' ')					,
			'tipo_usuario'		= ISNULL(c.tipo_usuario,' ')				,
			'tipo_privilegio'	= ISNULL(a.tipo_privilegio,' ')				,
			'entidad'		= d.nombre_sistema , --ISNULL(a.entidad,' ')					,
			'nombre_opcion'		= ISNULL(b.nombre_opcion,' ')				,
			'posicion'		= ISNULL(b.posicion,' ')				,
			'dias_expira'		= ISNULL(c.dias_expiracion,0)				,
			'titulo'		= @vTitulo						,
			'FECHAPROCESO'		= CONVERT (VARCHAR (10), VIEW_MDAC.acfecproc,103)	,
			'HORA'			= CONVERT(varchar(30), getdate(),108)			,
			'NombreEntidad'		= ISNULL( (SELECT rcnombre FROM entidad ) , '' )
		FROM 	usuario 	c,
			gen_privilegios a ,
			gen_menu 	b ,
			view_mdac	  ,
			sistema_cnt	d
		WHERE 	c.usuario 	  = @usuario 			AND
			a.usuario 	  = @usuario 			AND 
			a.opcion 	  = b.nombre_objeto 		AND
			a.entidad 	  = b.entidad			AND
			a.tipo_privilegio IN ('U','T') 			AND   --= @cTipo_privilegio 		AND
			a.habilitado 	  = 'S'				AND
			b.entidad	  = d.id_sistema
		ORDER BY 
			a.entidad	,
			b.indice	,
			c.tipo_usuario 
		
	END

	IF @cTipo_privilegio = 'T'
	BEGIN
		SELECT	'INDICE'		= ISNULL(b.indice,' ')					,
			'usuario'		= ISNULL(a.usuario,' ')					,
			'nombre'		= ISNULL(c.Descripcion,' ')				,
			'tipo_usuario'		= ISNULL(c.tipo_usuario,' ')				,
			'tipo_privilegio'	= ISNULL(a.tipo_privilegio,' ')				,
			'entidad'		= d.nombre_sistema , --ISNULL(a.entidad,' ')		,
			'nombre_opcion'		= ISNULL(b.nombre_opcion,' ')				,
			'posicion'		= ISNULL(b.posicion,' ')				,
	--		'fecha_expira'		= ISNULL(SELECT fecha_expiracion FROM USUARIO WHERE 
			'dias_expira'		= ISNULL(c.dias_expiracion,0)				,
			'titulo'		= @vTitulo						,
			'FECHAPROCESO'		= CONVERT (VARCHAR (10), VIEW_MDAC.acfecproc,103)	,
			'HORA'			= CONVERT(varchar(30), getdate(),108)			,
			'NombreEntidad'		= ISNULL( (SELECT rcnombre FROM entidad ) , '' )
		FROM 	gen_tipos_usuario	c,
			gen_privilegios 	a,
			gen_menu 		b,
			view_mdac		 ,
			sistema_cnt		d
		WHERE 	c.Tipo_Usuario 	  = @usuario 		AND
			a.usuario  	  = @usuario 		AND 
			a.opcion 	  = b.nombre_objeto 	AND
			a.entidad 	  = b.entidad		AND
			a.tipo_privilegio = @cTipo_privilegio 	AND
			a.habilitado 	  = 'S'			AND
			b.entidad	  = d.id_sistema
		ORDER BY 
			a.entidad	,
			b.indice	,
			c.tipo_usuario 

	END
	
	SET NOCOUNT OFF
END







GO
