USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LisTCarteras]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_LisTCarteras] 
 AS
 BEGIN

 SET DATEFORMAT dmy

	 SELECT 'nomemp'     = ISNULL( nombre_entidad, ""),
                'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), rut_entidad ) ) + "-" + digito_entidad ),"" ),
                'fecpro'     = CONVERT(CHAR(10), fecha_proceso, 103),
		'rut'        = ISNULL( ( RTRIM (CONVERT( CHAR(9), rut_entidad ) ) + "-" + digito_entidad ),"" ),
                'codigo'     = ISNULL( codigo_entidad,0),
                'nombre'     = ISNULL( nombre_entidad,''),
                'numoper'    = 0, --ISNULL( ENTIDAD.rcnumoper,0),
                'telefono'   = ISNULL( fono_entidad,''),
                'fax'        = ISNULL( fax_entidad,''),
                'direccion'  = ISNULL( direccion_entidad,''),
                'Entidad'    = ISNULL( nombre_entidad, ""),
                'hora'       = CONVERT(CHAR(30),GETDATE(),108)
         FROM DATOS_GENERALES

--sp_help datos_generales

/*
	 SELECT 'nomemp'     = ISNULL( AC.nombre_entidad, ""),
                'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), AC.rut_entidad ) ) + "-" + AC.digito_entidad ),"" ),
                'fecpro'     = CONVERT(CHAR(10), AC.fecha_proceso, 103),
		'rut'        = ISNULL( ( RTRIM (CONVERT( CHAR(9), ENTIDAD.rcrut ) ) + "-" + ENTIDAD.rcdv ),"" ),
                'codigo'     = ISNULL( ENTIDAD.rccodcar,0),
                'nombre'     = ISNULL( ENTIDAD.rcnombre,''),
                'numoper'    = ISNULL( ENTIDAD.rcnumoper,0),
                'telefono'   = ISNULL( ENTIDAD.rctelefono,''),
                'fax'        = ISNULL( ENTIDAD.rcfax,''),
                'direccion'  = ISNULL( ENTIDAD.rcdirecc,''),
                'Entidad'    = ISNULL( AC.nombre_entidad, ""),
                'hora'       = CONVERT(CHAR(30),GETDATE(),108)
         FROM DATOS_GENERALES AC, ENTIDAD
*/
 END




GO
