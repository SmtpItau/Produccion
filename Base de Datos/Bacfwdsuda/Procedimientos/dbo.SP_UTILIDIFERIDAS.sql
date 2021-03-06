USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UTILIDIFERIDAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_UTILIDIFERIDAS] 
AS
BEGIN 
   SET NOCOUNT ON
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME
   DECLARE @observado  NUMERIC(12,04) ,
    @uf   NUMERIC(12,04) ,
    @fecha_observado CHAR(10) ,
    @fecha_uf  CHAR(10) 
   EXECUTE sp_parametros_reporte @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT
   
   SELECT @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @ndirprop = (Select rcdirecc from VIEW_ENTIDAD),
          @nfecproc = acfecproc
   FROM   MFAC   
   IF EXISTS(  SELECT  * 
  FROM  MFCA         a,
            VIEW_CLIENTE b,
   VIEW_MONEDA  c,
   VIEW_MONEDA  d 
  WHERE  (b.clrut      = a.cacodigo   AND
   a.cacodcli   = b.clcodigo ) AND
   a.cacodmon1  = c.mncodmon   AND
   a.cacodmon2  = d.mncodmon   AND
   (a.cacodpos1  = 1 or a.cacodpos1 = 3 or a.cacodpos1 = 7  or
   a.cacodpos1  = 4 or a.cacodpos1 = 5 or a.cacodpos1 = 6)  AND
   a.cafecvcto  > @nfecproc
   )
 BEGIN
 
    SELECT 'cartera'    = a.cacodpos1         ,
    'Tipo Operacion'               = a.catipoper                        ,
           'Numero Operacion'             = a.canumoper                        ,
           'Nombre Cliente'               = b.clnombre                         ,
           'Fecha Inicio'                 = CONVERT(CHAR(10), a.cafecha, 103)  ,
           'Fecha Termino'                = CONVERT(CHAR(10), a.cafecvcto, 103),
    'MX'                           = c.mnnemo                           ,
    'Mto M/X Comprada'             = a.camtomon1                        ,
    'Mon CNV'                = d.mnnemo                           ,
    'Equivalencia Inicial'  = CASE WHEN a.cacodpos1 = 4 or a.cacodpos1 = 5 or a.cacodpos1 = 6 
       THEN 0
       ELSE a.caequmon2       
         END,
    'Monto a Diferir'   = a.cautildiferir + a.caperddiferir  ,
    'Monto Devengado'   = CASE WHEN a.cacodpos1 = 4 or a.cacodpos1 = 5 or a.cacodpos1 = 6 
       THEN a.pesos_devengo_acum_usd
       ELSE a.cautilacum + a.caperdacum      
         END,
    'M'     = a.catipmoda         ,
    'Dias Ope'    = a.caplazoope         ,
    'Dias Vcto'    = a.caplazovto         ,
    'Dias Tran'    = a.caplazocal         ,
    'Moneda2'                      = d.mnnemo                           ,            
           'Nombre Empresa'               = @nnomprop                          ,
           'Direccion Empresa'            = @ndirprop                          ,
           'Fecha Proceso'                = CONVERT(CHAR(10), @nfecproc, 103 ) ,
           'Observado'                    = @observado                         ,
           'valor UF'                     = @uf          , 
           'Entidad'                      = ( SELECT rcnombre
                                              from   VIEW_ENTIDAD
                                              where  rccodcar = a.cacodsuc1 )  ,
           'Hora'                         =  CONVERT(CHAR(5), getdate(),108)   ,
    'fecha_observado'   = @fecha_observado        ,
     'fecha_uf'           = @fecha_uf         
    FROM   MFCA         a,
           VIEW_CLIENTE b,
           VIEW_MONEDA  c,
           VIEW_MONEDA  d 
    WHERE (b.clrut      = a.cacodigo   AND
           a.cacodcli   = b.clcodigo ) AND
           a.cacodmon1  = c.mncodmon   AND
           a.cacodmon2  = d.mncodmon   AND
          (a.cacodpos1  = 1 or a.cacodpos1 = 3 or a.cacodpos1 = 7  or
    a.cacodpos1  = 4 or a.cacodpos1 = 5 or a.cacodpos1 = 6)  AND
           a.cafecvcto  > @nfecproc
    ORDER BY canumoper 
 END
   ELSE
 BEGIN
    SELECT 'cartera'    =0,
    'Tipo Operacion'               ='',
           'Numero Operacion'             = 0,
	'Nombre Cliente'               = '',
	'Fecha Inicio'                 = '',
	'Fecha Termino'                = '',
    'MX'                           = '',
    'Mto M/X Comprada'             = 0,
    'Mon CNV'					   = '',
    'Equivalencia Inicial'  = 0,
    'Monto a Diferir'   = 0,
    'Monto Devengado'   = 0,
    'M'							   = '',
    'Dias Ope'    = 0,
    'Dias Vcto'    = 0,
    'Dias Tran'    = 0,
    'Moneda2'                      = '',            
	'Nombre Empresa'               = '',
	'Direccion Empresa'            = '',
           'Fecha Proceso'                = CONVERT(CHAR(10), @nfecproc, 103 ) ,
           'Observado'                    = @observado                         ,
           'valor UF'                     = @uf          , 
	'Entidad'                      = '',
           'Hora'                         =  CONVERT(CHAR(5), getdate(),108)   ,
    'fecha_observado'   = @fecha_observado        ,
     'fecha_uf'           = @fecha_uf         
 END
 
   SET NOCOUNT OFF
END

GO
