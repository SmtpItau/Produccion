USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MFCCLEERCALCES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MFCCLEERCALCES]
AS
BEGIN
SET NOCOUNT ON
  /*=======================================================================*/
  /*=======================================================================*/
  SELECT       'FechaVencimiento'   = CONVERT( CHAR(10),ccfecven, 103 )     ,
               'fechaorden'         = CONVERT( CHAR(8),ccfecven, 112 )     ,
               'NumeroOperacionCMP' = cacompra.canumoper                    ,
               'NumeroOperacionVTA' = caventa.canumoper                     , 
               'RUTClienteCMP'      = cacompra.cacodigo                     ,
               'RUTClienteVTA'      = caventa.cacodigo                      ,
               'NombreClienteCMP'   = SPACE(40)                             ,
               'NombreClienteVTA'   = SPACE(40)                             ,    
               'PosicionCalceCMP'   = ccposcmp                              ,
               'PosicionCalceVTA'   = ccposvta                              ,
               'TipoCalcesCMP'      = SPACE(25)                             ,
               'TipoCalcesVTA'      = SPACE(25)                             ,
               'Futuros'            = ccmonto                               ,
               'PrecioCMP'          = cacompra.catipcam                     ,
               'PrecioVTA'          = caventa.catipcam                      ,
               'TipoOperacionCompra'= cacompra.catipoper                    ,
               'TipoOperacionVenta' = caventa.catipoper                     ,   
               'ValorizacionCompra' = (cacompra.cavalordia * ( ccmonto / cacompra.camtomon1 ) ) ,
               'ValorizacionVenta'  = (caventa.cavalordia * ( ccmonto / caventa.camtomon1 ) )   ,
               'NombreEmpresa'      = UPPER(acnomprop)       ,
               'DireccionEmpresa'   = UPPER(acdirprop)       ,
               'FechaProceso'       = CONVERT( CHAR(10),acfecproc, 103 )    ,
               'Fechacompra'        = CONVERT( CHAR(10),cacompra.cafecha, 103 )    ,
               'FechaVenta'         = CONVERT( CHAR(10),caventa.cafecha, 103  )    ,
               'Codigo'             = cacompra.cacodpos1,
               'Codigo2'            = caventa.cacodpos1,
               'CodigoClienteCMP'   = cacompra.cacodcli                     ,
               'CodigoClienteVTA'   = caventa.cacodcli                     ,
               'Hora'               = CONVERT( CHAR(10),getdate(), 108 )       
  INTO  #tmpcalces
         FROM  MFCC,
               MFCA cacompra ,
               MFCA caventa ,
               MFAC
         WHERE ccopecmp             = cacompra.canumoper    AND
               ccopevta             = caventa.canumoper     AND
               cacompra.cacodpos1   = 3                     AND
               caventa.cacodpos1    = 3                    
  /*=======================================================================*/
  /*=======================================================================*/
   UPDATE       #tmpcalces
        SET   NombreClienteCMP = clnombre 
  FROM  VIEW_CLIENTE
        WHERE RUTClienteCMP = clrut  AND  CodigoClienteCMP = clcodigo
  /*=======================================================================*/
  /*=======================================================================*/
   UPDATE       #tmpcalces
        SET   NombreClienteVTA  = clnombre
        FROM  VIEW_CLIENTE  
       WHERE RUTClienteVTA  = clrut  AND  CodigoClienteVTA = clcodigo
  /*=======================================================================*/
  /*=======================================================================*/
   UPDATE       #tmpcalces
        SET   TipoCalcesCMP  = tbglosa
        FROM  VIEW_TABLA_GENERAL_DETALLE
        WHERE tbcateg  = 213      AND
              convert(numeric(6),tbcodigo1)  = PosicionCalceCMP
  /*=======================================================================*/
  /*=======================================================================*/
   UPDATE       #tmpcalces
        SET   TipoCalcesVTA  = tbglosa
        FROM  VIEW_TABLA_GENERAL_DETALLE
        WHERE tbcateg  = 213        AND
              convert(numeric(6),tbcodigo1)  = PosicionCalceVTA
   /*=======================================================================*/
   /*=======================================================================*/
 IF EXISTS( SELECT * FROM #tmpcalces )
    BEGIN
    SELECT FechaVencimiento ,
               NumeroOperacionCMP ,
                   NumeroOperacionVTA , 
            NombreClienteCMP ,
                  NombreClienteVTA ,                                                                                                                                                         
                   TipoCalcesCMP  ,
                   TipoCalcesVTA  ,
                   Futuros  ,
                   PrecioCMP  ,
                   PrecioVTA  ,
                   TipoOperacionCompra ,
                   TipoOperacionVenta ,
       NombreEmpresa  ,
                   DireccionEmpresa ,
                   FechaProceso  ,
                   FechaCompra  ,
                   FechaVenta   ,
                   Codigo       ,
                   Codigo2
     ValorizacionCompra  ,
     ValorizacionVenta  ,
     Hora
          FROM     #tmpcalces 
          ORDER BY Fechaorden
  END
 ELSE
  BEGIN
     SELECT       'FechaVencimiento'   = '',
                  'fechaorden'         = '',
                  'NumeroOperacionCMP' = 0,
                  'NumeroOperacionVTA' = 0, 
                  'RUTClienteCMP'      = 0,
                  'RUTClienteVTA'      = 0,
                  'NombreClienteCMP'   = SPACE(40)                             ,
                  'NombreClienteVTA'   = SPACE(40)                             ,    
                  'PosicionCalceCMP'   = 0,
                  'PosicionCalceVTA'   = 0,
                  'TipoCalcesCMP'      = SPACE(25)                             ,
                  'TipoCalcesVTA'      = SPACE(25)                             ,
                  'Futuros'            = 0,
                  'PrecioCMP'          = 0,
                  'PrecioVTA'          = 0,
                  'TipoOperacionCompra'= '',
                  'TipoOperacionVenta' = '' ,
                  'ValorizacionCompra' = 0,
                  'ValorizacionVenta'  = 0,
                  'NombreEmpresa'      = UPPER(acnomprop)       ,
                  'DireccionEmpresa'   = UPPER(acdirprop)       ,
                  'FechaProceso'       = CONVERT( CHAR(10),acfecproc, 103 )    ,
                  'Fechacompra'        = '',
                  'FechaVenta'         = '',
                  'Codigo'             = 0,
                  'Codigo2'            = 0,
                  'CodigoClienteCMP'   = 0,
                  'CodigoClienteVTA'   = 0,
                  'Hora'               = CONVERT( CHAR(10),getdate(), 108 )       
   FROM mfac
  END
   /*=======================================================================*/
   /*=======================================================================*/
SET NOCOUNT OFF
END

GO
