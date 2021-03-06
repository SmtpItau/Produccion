USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTEMISORES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTEMISORES]

AS

BEGIN

	DECLARE @COUNT       INT


    SET @COUNT       = (SELECT COUNT(*) FROM VIEW_EMISOR MDEM  
                                                 LEFT OUTER JOIN 
										     VIEW_TABLA_GENERAL_DETALLE ON CONVERT(INTEGER,MDEM.emtipo) = CONVERT(INTEGER, VIEW_TABLA_GENERAL_DETALLE.tbcodigo1),
                                             VIEW_CIUDAD_COMUNA, MDAC
                                       WHERE MDEM.emrut > 0 
									     AND VIEW_TABLA_GENERAL_DETALLE.tbcateg = 210 AND MDEM.emcomuna = VIEW_CIUDAD_COMUNA.cod_com  
		   AND VIEW_CIUDAD_COMUNA.cod_ciu = 1)



	IF @COUNT <> 0

	BEGIN

		SELECT --'nomemp'      = ISNULL( MDAC.acnomprop, ''),
		       'nomemp'      = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales),
			   'rutemp'      = ISNULL( ( RTRIM (CONVERT( CHAR(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
			   'fecpro'      = CONVERt(char(10), MDAC.acfecproc, 103),
			   'rutemisor'   = ISNULL( ( RTRIM (CONVERT( char(9), MDEM.emrut ) ) + '-' + MDEM.emdv ),'' ),
			   'codemisor'   = ISNULL( MDEM.emcodigo,0),
			   'nomemisor'   = ISNULL( MDEM.emnombre,''),
			   'genemisor'   = ISNULL( MDEM.emgeneric,''),
			   'tipemisor'   = ISNULL( VIEW_TABLA_GENERAL_DETALLE.tbglosa,''),
			   'direccion'   = ISNULL( MDEM.emdirecc,''),
			   'comuna'      = VIEW_CIUDAD_COMUNA.nom_ciu,
			   'hora'        = CONVERT( char(30),GETDATE(),108)    
		  FROM VIEW_EMISOR MDEM  LEFT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE ON CONVERT(INTEGER,MDEM.emtipo ) = CONVERT(INTEGER,VIEW_TABLA_GENERAL_DETALLE.tbcodigo1),
			   VIEW_CIUDAD_COMUNA, 
			   MDAC
		 WHERE MDEM.emrut > 0
		   AND VIEW_TABLA_GENERAL_DETALLE.tbcateg =210 
		   AND MDEM.emcomuna = VIEW_CIUDAD_COMUNA.cod_com  
		   AND VIEW_CIUDAD_COMUNA.cod_ciu = 1

	 END

	 ELSE

		BEGIN

			SELECT 'nomemp'      = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales),
				   'rutemp'      = '',
				   'fecpro'      = '',
				   'rutemisor'   = '',
				   'codemisor'   = 0,
				   'nomemisor'   = '',
				   'genemisor'   = '',
				   'tipemisor'   = '',
				   'direccion'   = '',
				   'comuna'      = '',
				   'hora'        = ''
		END


 END
GO
