USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LisTEmisores]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_LisTEmisores]
 AS
 BEGIN

	DECLARE @ACNOMPROP 	CHAR(40)
	DECLARE @ACFECPROC 	CHAR(10)
	DECLARE @ACRUTPROP	NUMERIC (9)
	DECLARE @ACDIGPROP      CHAR(1)

	SELECT 
		@ACNOMPROP = acnomprop,
		@ACFECPROC = acfecproc,
		@ACRUTPROP = acrutprop,
		@ACDIGPROP = acdigprop
	 FROM VIEW_MDAC	               


	SELECT 
		'nomemp'	= @ACNOMPROP ,
		'rutemp' 	= ISNULL( ( RTRIM (CONVERT( CHAR(9),@ACRUTPROP)) + "-" + @ACDIGPROP ),""),
		'fecpro' 	= CONVERT(CHAR(10),@ACFECPROC,103),
               	'Rutemisor'  	= ISNULL( ( RTRIM (CONVERT( CHAR(9), EMISOR.emrut ) ) + "-" + EMISOR.emdv ),"" ),
	       	'Codemisor'  	= ISNULL( EMISOR.emcodigo,0),
               	'Nomemisor'  	= ISNULL( EMISOR.emnombre,''),
               	'Genemisor'  	= ISNULL( EMISOR.emgeneric,''), 
	       	'Tipemisor'  	= ISNULL( TABLA_GENERAL_DETALLE.tbglosa,''),
               	'Direccion'   	= ISNULL( EMISOR.emdirecc,''),
		'hora'       	= CONVERT( CHAR(30),GETDATE(),108)        
	FROM  EMISOR 			,
              TABLA_GENERAL_DETALLE	
        WHERE EMISOR.emrut>0
        AND   ( TABLA_GENERAL_DETALLE.tbcateg =210 AND ( CONVERT(INTEGER,EMISOR.emtipo ) = CONVERT(INTEGER, TABLA_GENERAL_DETALLE.tbcodigo1) ) )


 END

--
-- select * from EMISOR
-- select * from TABLA_GENERAL_DETALLE WHERE TBCATEG=210
--SELECT *  FROM CIUDAD_COMUNA

--- SP_HELP VIEW_MDAC












GO
