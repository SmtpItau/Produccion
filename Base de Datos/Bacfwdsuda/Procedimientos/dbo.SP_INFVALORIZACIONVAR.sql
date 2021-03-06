USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVALORIZACIONVAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFVALORIZACIONVAR]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   DATETIME
   DECLARE @nspotuhoy  FLOAT
   DECLARE @observado  NUMERIC(12,04) ,
       @uf   NUMERIC(12,04) ,
       @fecha_observado CHAR(10) ,
       @fecha_uf  CHAR(10) 
   EXECUTE sp_parametros_reporte @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT
   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD)  ,
               @cdirprop = a.acdirprop                          ,
               @dfecproc = a.acfecproc                          ,
               @cfecproc = CONVERT( CHAR(10), a.acfecproc, 103 )
   FROM        MFAC a             
   EXECUTE sp_div @observado, @uf, @nspotuhoy OUTPUT
   SELECT @nspotuhoy = ROUND ( @nspotuhoy, 11 )
   IF EXISTS( SELECT  *
  FROM    MFCA              a,
   VIEW_CLIENTE      b
  WHERE  (a.cacodpos1  = 1  or a.cacodpos1 = 4 or a.cacodpos1 = 5 or a.cacodpos1 = 6 or a.cacodpos1 = 7)    AND
   (a.cacodigo   = b.clrut  AND a.cacodcli   = b.clcodigo ) AND
   a.cafecvcto  > @dfecproc
     )  
 BEGIN
  SELECT 'Fecha Proceso'        = @cfecproc                        ,
   'Nombre Empresa'       = @cnomprop                        ,
   'Direccion Empresa'    = @cdirprop                        ,
   'Valor UF'             = @uf                             ,
   'Valor Observado'      = @observado                       ,
   'fecha_UF'             = @fecha_uf                     ,
   'fecha_Observado'      = @fecha_observado                 ,
   'Entidad'              = ( SELECT rcnombre  FROM VIEW_ENTIDAD  WHERE  rccodcar = a.cacodsuc1 ),
   'Hora'                 = CONVERT(CHAR(5),getdate(),108 )  ,
   'NumeroOpe'            = a.canumoper                      ,
   'Operacion'            = a.catipoper                      ,
   'Cliente'              = ISNULL(clnombre,' ')             ,
   'Fecha Inicio'         = CONVERT(CHAR(10),a.cafecha,103)  ,
   'Fecha Termino'        = CONVERT(CHAR(10),a.cafecvcto,103),
   'Codigo Mon Ope'       = isnull(( SELECT mnnemo FROM VIEW_MONEDA  WHERE  mncodmon=a.cacodmon1 ),'N/D'),    
   'Codigo Mon CNV'       = isnull(( SELECT mnnemo FROM VIEW_MONEDA  WHERE  mncodmon=a.cacodmon2 ),'N/D'),    
   'Mto M/X Comprado'     = a.camtomon1                      ,
   'Plazo Residual'       = a.caplazovto                     ,
   'TasaVar Usd'          = a.tasa_var_moneda1               ,
   'TasaVar Cnv'          = a.tasa_var_moneda2               ,
   'Monto Mtm Usd'        = a.var_moneda1                    ,
   'Monto Mtm Cnv'        = a.var_moneda2                    ,
   'Valor'                = a.var_moneda1 + a.var_moneda2    ,  
   'Producto'             = (SELECT  Descripcion from VIEW_PRODUCTO where codigo_producto=a.cacodpos1  ),
   'Cartera'              = (SELECT  rcnombre from VIEW_TIPO_CARTERA where rcrut=a.cacodcart and a.cacodpos1=rccodpro and rcsistema='BFW' )
  FROM    MFCA              a,
   VIEW_CLIENTE      b
  WHERE  (a.cacodpos1  = 1  or a.cacodpos1 = 4 or a.cacodpos1 = 5 or a.cacodpos1 = 6 or a.cacodpos1 = 7)    AND
   (a.cacodigo   = b.clrut  AND a.cacodcli   = b.clcodigo ) AND
   a.cafecvcto  > @dfecproc
  ORDER BY cafecvcto
 END
   ELSE
 BEGIN
  SELECT  'Fecha Proceso'        = @cfecproc                        ,
   'Nombre Empresa'       = @cnomprop                        ,
   'Direccion Empresa'    = @cdirprop                        ,
   'Valor UF'             = @uf                             ,
   'Valor Observado'      = @observado                       ,
   'fecha_UF'             = @fecha_uf                     ,
   'fecha_Observado'      = @fecha_observado                 ,
   'Entidad'              = '',
   'Hora'                 = CONVERT(CHAR(5),GETDATE(),108 )  ,
   'NumeroOpe'            = 0,
   'Operacion'            = '',
   'Cliente'              = '',
   'Fecha Inicio'         = '',
   'Fecha Termino'        = '',
   'Codigo Mon Ope'       = '',    
   'Codigo Mon CNV'       = '',    
   'Mto M/X Comprado'     = 0,
   'Plazo Residual'       = 0,
   'TasaVar Usd'          = 0,
   'TasaVar Cnv'          = 0,
   'Monto Mtm Usd'        = 0,
   'Monto Mtm Cnv'        = 0,
   'Valor'                = 0,  
   'Producto'             = '',
   'Cartera'              = ''
 
 END
   SET NOCOUNT OFF
END

GO
