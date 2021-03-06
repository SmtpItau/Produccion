USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCARTERAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_LISTCARTERAS]
 as
 begin
  select 'nomemp'     = isnull( MDAC.acnomprop, ''),
         'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
         'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
         'rut'        = isnull( ( rtrim (convert( char(9), MDRC.rcrut ) ) + '-' + MDRC.rcdv ),'' ),
         'codigo'     = isnull( MDRC.rccodcar,0),
         'nombre'     = isnull( MDRC.rcnombre,''),
         'numoper'    = isnull( MDRC.rcnumoper,0),
         'telefono'   = isnull( MDRC.rctelefono,''),
         'fax'        = isnull( MDRC.rcfax,''),
         'direccion'  = isnull( MDRC.rcdirecc,''),
         'entidad'    = isnull( MDAC.acnomprop, ''),
         'hora'       = convert(char(30),getdate(),108),
		 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 
    from MDAC, 
	     VIEW_ENTIDAD MDRC
 end
GO
