USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MFCCLEERCALCESPRO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MFCCLEERCALCESPRO]
AS
BEGIN
SET NOCOUNT ON
  /*=======================================================================*/
  /*=======================================================================*/
 SELECT			'FechaVencimiento'   = CONVERT( CHAR(10),ccfecven, 103 )    ,
				'fechaorden'      = CONVERT( CHAR(8),ccfecven, 112 )     ,
				'NumeroOperacionCMP' = cacompra.canumoper                        ,
                'NumeroOperacionVTA' = caventa.canumoper                         ,
                'RUTClienteCMP'      = cacompra.cacodigo                         ,
                'RUTClienteVTA'      = caventa.cacodigo                          ,
                'NombreClienteCMP'   = SPACE(100)                                 ,
                'NombreClienteVTA'   = SPACE(100)                                 ,
                'PosicionCalceCMP'   = ccposcmp                                  ,
                'PosicionCalceVTA'   = ccposvta                                  ,
                'TipoCalcesCMP'      = SPACE(50)                                 ,
                'TipoCalcesVTA'      = SPACE(50)                                 ,
                'Futuros'            = ccmonto                                   ,
                'PrecioCMP'          =  CASE 
     WHEN cacompra.cacodpos1 = 1 
     THEN cacompra.catipcam 
     WHEN cacompra.cacodpos1 = 5 
     THEN 0
     ELSE cacompra.caprecal 
     END        ,
                'PrecioVTA'          =  CASE 
     WHEN caventa.cacodpos1 = 1
     THEN caventa.catipcam
     WHEN caventa.cacodpos1 = 1
     THEN 0
     ELSE caventa.caprecal
     END,
                'TipoOperacionCompra'= cacompra.catipoper                        ,
                'TipoOperacionVenta' = caventa.catipoper                         ,
				'ValorizacionCompra' = (cacompra.cavalordia * ( ccmonto / cacompra.camtomon1 ) ) ,
				'ValorizacionVenta'  = (caventa.cavalordia * ( ccmonto / caventa.camtomon1 ) )   ,
                'NombreEmpresa'      = UPPER(acnomprop)       ,
                'DireccionEmpresa'   = UPPER(acdirprop)                            ,
                'FechaProceso'       = CONVERT( CHAR(10),acfecproc, 103 )        ,
                'Fechacompra'        = CONVERT( CHAR(10),cacompra.cafecha, 103 )    ,
                'FechaVenta'         = CONVERT( CHAR(10),caventa.cafecha, 103  )    ,
                'Codigo'             = cacompra.cacodpos1      ,
                'Codigo2'            = caventa.cacodpos1      ,
				'MonActivo'      = e.mnnemo        ,
				'MonPasivo'      = f.mnnemo                   ,
                'CodigoClienteCMP'   = cacompra.cacodcli                         ,
                'CodigoClienteVTA'   = caventa.cacodcli                          ,
				'Hora'         = CONVERT( CHAR(10),getdate(), 108 )       
         INTO  #tmpcalces
         FROM  MFCC  ,
               MFCA cacompra ,
               MFCA caventa ,
               MFAC  ,
        VIEW_MONEDA e ,
        VIEW_MONEDA f 
         WHERE ccopecmp             = cacompra.canumoper     AND
               ccopevta             = caventa.canumoper      AND
               ( cacompra.cacodpos1 = 1                    OR
                 cacompra.cacodpos1 = 4                    OR
                 cacompra.cacodpos1 = 5                   OR
                 cacompra.cacodpos1 = 6                    OR
                 cacompra.cacodpos1 = 7                   )  AND
               (caventa.cacodpos1   = 1                      OR
                caventa.cacodpos1   = 4                      OR
                caventa.cacodpos1   = 5                         OR
  caventa.cacodpos1   = 6                    OR
                caventa.cacodpos1   = 7                   )  AND
  cacompra.cacodmon2 = e.mncodmon           AND
                caventa.cacodmon2  = f.mncodmon                 
  /*=======================================================================*/
  /*=======================================================================*/
 UPDATE  #tmpcalces
 SET    NombreClienteCMP = clnombre
 FROM   VIEW_CLIENTE
 WHERE  RUTClienteCMP  = clrut  AND  
  CodigoClienteCMP = clcodigo
  /*=======================================================================*/
  /*=======================================================================*/
 UPDATE #tmpcalces
 SET    NombreClienteVTA        = clnombre     
 FROM   VIEW_CLIENTE
 WHERE  RUTClienteVTA  = clrut  AND  
  CodigoClienteVTA = clcodigo
  /*=======================================================================*/
  /*=======================================================================*/
 UPDATE  #tmpcalces
 SET    TipoCalcesCMP           = tbglosa
 FROM   VIEW_TABLA_GENERAL_DETALLE
 WHERE  tbcateg    = 213   AND
                CONVERT(NUMERIC(6),tbcodigo1) = PosicionCalceCMP
  /*=======================================================================*/
  /*=======================================================================*/
 UPDATE  #tmpcalces
 SET    TipoCalcesVTA           = tbglosa
 FROM   VIEW_TABLA_GENERAL_DETALLE
 WHERE  tbcateg                  = 213   AND
  CONVERT(NUMERIC(6),tbcodigo1)   = PosicionCalceVTA
   /*=======================================================================*/
   /*=======================================================================*/
 SELECT  FechaVencimiento  ,
  NumeroOperacionCMP  ,
  NumeroOperacionVTA  , 
   NombreClienteCMP  ,
  NombreClienteVTA  ,    
  TipoCalcesCMP   ,
  TipoCalcesVTA   ,
  Futuros    ,
  PrecioCMP   ,
  PrecioVTA   ,
  TipoOperacionCompra  ,
  TipoOperacionVenta  ,
  NombreEmpresa   ,
  DireccionEmpresa  ,
  FechaProceso   ,
  FechaCompra   ,
  FechaVenta   ,
  Codigo    ,
  Codigo2    ,
  MonActivo   ,
  MonPasivo     ,
  Hora                     ,
  ValorizacionCompra  ,
  ValorizacionVenta  
 FROM #tmpcalces 
 ORDER BY Fechaorden
   /*=======================================================================*/
   /*=======================================================================*/
   SET NOCOUNT OFF
END

GO
