USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCARTERAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTCARTERAS] 
 AS
 BEGIN
  SELECT 'nomemp'     = ISNULL( VIEW_MDAC.acnomprop, ''),
                'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + '-' + VIEW_MDAC.acdigprop ),'' ),
                'fecpro'     = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
  'rut'        = ISNULL( ( RTRIM (CONVERT( CHAR(9), ENTIDAD.rcrut ) ) + '-' + ENTIDAD.rcdv ),'' ),
                'codigo'     = ISNULL( ENTIDAD.rccodcar,0),
                'nombre'     = ISNULL( ENTIDAD.rcnombre,''),
                'numoper'    = ISNULL( ENTIDAD.rcnumoper,0),
                'telefono'   = ISNULL( ENTIDAD.rctelefono,''),
                'fax'        = ISNULL( ENTIDAD.rcfax,''),
                'direccion'  = ISNULL( ENTIDAD.rcdirecc,''),
                'Entidad'    = ISNULL( VIEW_MDAC.acnomprop, ''),
                'hora'       = CONVERT(CHAR(30),GETDATE(),108)
         FROM VIEW_MDAC, ENTIDAD
 END
GO
