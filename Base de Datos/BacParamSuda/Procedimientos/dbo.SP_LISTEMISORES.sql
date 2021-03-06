USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTEMISORES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTEMISORES]
 AS
 BEGIN
 DECLARE @ACNOMPROP  CHAR(40)
 DECLARE @ACFECPROC  CHAR(10)
 DECLARE @ACRUTPROP NUMERIC (9)
 DECLARE @ACDIGPROP      CHAR(1)
 SELECT 
  @ACNOMPROP = acnomprop,
  @ACFECPROC = acfecproc,
  @ACRUTPROP = acrutprop,
  @ACDIGPROP = acdigprop
  FROM VIEW_MDAC                
 SELECT 
  'nomemp' = @ACNOMPROP ,
  'rutemp'  = ISNULL( ( RTRIM (CONVERT( CHAR(9),@ACRUTPROP)) + '-' + @ACDIGPROP ),''),
  'fecpro'  = CONVERT(CHAR(10),@ACFECPROC,103),
                'Rutemisor'   = ISNULL( ( RTRIM (CONVERT( CHAR(9), EMISOR.emrut ) ) + '-' + EMISOR.emdv ),'' ),
         'Codemisor'   = ISNULL( EMISOR.emcodigo,0),
                'Nomemisor'   = ISNULL( EMISOR.emnombre,''),
                'Genemisor'   = ISNULL( EMISOR.emgeneric,''), 
         'Tipemisor'   = ISNULL( TABLA_GENERAL_DETALLE.tbglosa,''),
                'Direccion'    = ISNULL( EMISOR.emdirecc,''),
  'hora'        = CONVERT( CHAR(30),GETDATE(),108),
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)        
 FROM  EMISOR    ,
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
