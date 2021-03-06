USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LisTEmisores]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_LisTEmisores]
 AS
 BEGIN

   SET DATEFORMAT dmy

	SELECT DISTINCT
               'nomemp'      = ISNULL( AC.nombre_entidad, ""),
               'rutemp'      = ISNULL( ( RTRIM (CONVERT( CHAR(9), AC.rut_entidad ) ) + "-" + AC.digito_entidad ),"" ),
               'fecpro'      = CONVERT(CHAR(10), AC.fecha_proceso, 103),
               'Rutemisor'   = ISNULL( ( RTRIM (CONVERT( CHAR(9), EMISOR.emrut ) ) + "-" + EMISOR.emdv ),"" ),
	       'Codemisor'   = ISNULL( EMISOR.emcodigo,0),
               'Nomemisor'   = ISNULL( EMISOR.emnombre,''),
               'Genemisor'   = ISNULL( EMISOR.emgeneric,''), 
	       'Tipemisor'   = ISNULL( (SELECT descripcion FROM TIPO_EMISOR WHERE codigo_tipo = EMISOR.emtipo 
                                      ),''),
               'Direccion'   = ISNULL( EMISOR.emdirecc,''),
               'Comuna'      = ' ', --CIUDAD_COMUNA.nom_ciu ,
               'hora'        = CONVERT( CHAR(30),GETDATE(),108),
               'fecha_emi'   = convert (char(10) , getdate() , 103 ),   
               'afecta_linea' = CASE WHEN emGlosa = "S" THEN "SI" ELSE "NO" END
	FROM  EMISOR, 
              DATOS_GENERALES AC
        WHERE EMISOR.emrut>0
	AND estado <> "A"

 END



GO
