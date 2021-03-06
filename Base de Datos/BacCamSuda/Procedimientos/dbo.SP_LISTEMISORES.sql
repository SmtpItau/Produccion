USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTEMISORES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTEMISORES]
 AS
 BEGIN
 SELECT 'nomemp'     = ISNULL( VIEW_MDAC.acnomprop, ''),
        'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + '-' + VIEW_MDAC.acdigprop ),'' ),
        'fecpro'     = CONVERT(CHAR(10), view_MDAC.acfecproc, 103),
        'Rutemisor'  = ISNULL( ( RTRIM (CONVERT( CHAR(9), view_EMISOR.emrut ) ) + '-' + view_EMISOR.emdv ),'' ),
        'Codemisor'  = ISNULL( view_EMISOR.emcodigo,0),
        'Nomemisor'  = ISNULL( view_EMISOR.emnombre,''),
        'Genemisor'  = ISNULL( view_EMISOR.emgeneric,''), 
        'Tipemisor'  = ISNULL( VIEW_TABLA_GENERAL_DETALLE.tbglosa,''),
        'Direccion'  = ISNULL( view_EMISOR.emdirecc,''),
        'Comuna'     = VIEW_CIUDAD_COMUNA.nom_ciu,
		'hora'       = CONVERT( CHAR(30),GETDATE(),108)
		FROM VIEW_EMISOR LEFT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE ON CONVERT(INTEGER,view_EMISOR.emtipo) = CONVERT(INTEGER, VIEW_TABLA_GENERAL_DETALLE.tbcodigo1) 
			AND VIEW_TABLA_GENERAL_DETALLE.tbcateg = 210,
        	    VIEW_CIUDAD_COMUNA, 
                VIEW_MDAC
        WHERE VIEW_EMISOR.emrut > 0
		AND VIEW_EMISOR.emcomuna = VIEW_CIUDAD_COMUNA.cod_com AND VIEW_CIUDAD_COMUNA.cod_ciu = 1

 /* REQ. 7619 CASS         
 FROM  view_EMISOR, 
              VIEW_TABLA_GENERAL_DETALLE, 
              VIEW_CIUDAD_COMUNA, 
              VIEW_MDAC
        WHERE view_EMISOR.emrut>0
        AND   VIEW_TABLA_GENERAL_DETALLE.tbcateg =210 AND CONVERT(INTEGER,view_EMISOR.emtipo ) *= CONVERT(INTEGER, VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
 AND   view_EMISOR.emcomuna = VIEW_CIUDAD_COMUNA.cod_com  AND VIEW_CIUDAD_COMUNA.cod_ciu = 1
 */

 END

GO
