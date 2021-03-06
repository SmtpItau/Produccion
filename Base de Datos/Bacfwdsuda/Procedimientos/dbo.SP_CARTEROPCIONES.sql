USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTEROPCIONES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARTEROPCIONES]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME
   SELECT @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @ndirprop = acdirprop                          ,
          @nfecproc = acfecproc
   FROM   MFAC
 IF EXISTS( SELECT * 
     FROM   MFCA  a,
            VIEW_CLIENTE  b,
            VIEW_MONEDA   d,
            VIEW_MONEDA   e 
     WHERE (b.clrut      = a.cacodigo   AND
            a.cacodcli   = b.clcodigo ) AND
            a.cacodmon2  = d.mncodmon   AND
            a.cacodmon1  = e.mncodmon   AND
            a.cacodpos1  = 9            AND
            a.cafecvcto <> @nfecproc
  )
  BEGIN
 
     SELECT 'Tipo Operacion'         = a.catipoper                         ,
            'Numero Operacion'       = a.canumoper                         ,
            'Nombre Cliente'         = b.clnombre                          ,
            'Fecha Inicio'           = CONVERT(CHAR(10), a.cafecha, 103)   ,
            'Fecha Termino'          = CONVERT(CHAR(10), a.cafecvcto, 103) ,
            'Dias Cnt'               = a.caplazo                           ,
     'Spot'     = a.caparmon1    ,
     'Strike'      = a.catipcam     ,
     'Costo inicial'    = a.caparmon2    ,
     'Prima'     = a.capremio     ,
     'Costo Actual Valorizacon'= a.tc_calculo_mes_actual    ,
     'Prima Valorización'    = a.cadiftipcam    ,
            'PRM'                    = E.mnnemo                            ,
            'TipoCambioInicio'       = a.capremon2                         ,
            'ParidadFutura'          = a.catipcam                          ,
            'TipoCambioValorizacion' = ( SELECT vmvalor
                                         FROM   VIEW_VALOR_MONEDA
                                         WHERE  vmcodigo = 994 AND
                                                vmfecha  = @nfecproc )     , 
            'ParidadValorizacion'    = a.catipcamval                       ,
            'M/X ope'                = e.mnnemo                            ,
            'Monto Operacion'        = a.camtomon1                         ,
            'M/X CNV'                = d.mnnemo                            ,
            'MontoConversion'        = a.camtomon2                         ,
            'Valorizacion'           = a.cavalordia                        ,
            'M'                      = a.catipmoda                         ,
            'Nombre Empresa'         = @nnomprop                           ,
            'Direccion Empresa'      = @ndirprop                           ,
            'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,
            'Observado'              = ( SELECT vmvalor
                                         FROM   VIEW_VALOR_MONEDA
                                         WHERE  vmcodigo = 994 AND
                                                vmfecha  = @nfecproc )     , 
            'Entidad'                = ( SELECT rcnombre
                                         from   VIEW_ENTIDAD
                                         where  rccodcar = a.cacodsuc1 )   ,
            'Hora'                   = CONVERT(CHAR(5), getdate(),108) 
     FROM   MFCA  a,
            VIEW_CLIENTE  b,
            VIEW_MONEDA   d,
            VIEW_MONEDA   e 
     WHERE (b.clrut      = a.cacodigo   AND
            a.cacodcli   = b.clcodigo ) AND
            a.cacodmon2  = d.mncodmon   AND
            a.cacodmon1  = e.mncodmon   AND
            a.cacodpos1  = 9            AND
            a.cafecvcto <> @nfecproc
  END
 ELSE
  BEGIN
     SELECT 'Tipo Operacion'         ='',
            'Numero Operacion'       = 0,
            'Nombre Cliente'         = '',
            'Fecha Inicio'           = '',
            'Fecha Termino'          = '',
            'Dias Cnt'               = 0,
     'Spot'     = 0,
     'Strike'      = 0,
     'Costo inicial'    = 0,
     'Prima'     = 0,
     'Costo Actual Valorizacon'= 0,
     'Prima Valorización'    = 0,
            'PRM'                    = 0,
            'TipoCambioInicio'       = 0,
            'ParidadFutura'          = 0,
            'TipoCambioValorizacion' = 0, 
            'ParidadValorizacion'    = 0,
            'M/X ope'                = '',
            'Monto Operacion'        = 0,
            'M/X CNV'                = '',
            'MontoConversion'        = 0,
            'Valorizacion'           = 0,
            'M'                      = 0,
            'Nombre Empresa'         = @nnomprop                           ,
            'Direccion Empresa'      = @ndirprop                           ,
            'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,
            'Observado'              = ( SELECT vmvalor
                                         FROM   VIEW_VALOR_MONEDA
                                         WHERE  vmcodigo = 994 AND
                                                vmfecha  = @nfecproc )     , 
            'Entidad'                = 0,
            'Hora'                   = CONVERT(CHAR(5), getdate(),108) 
  END
   SET NOCOUNT OFF    
END

GO
