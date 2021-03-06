USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERAVENFUTURO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARTERAVENFUTURO]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME
   DECLARE @nValUf   FLOAT
   SELECT  @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
           @ndirprop = a.acdirprop                        ,
           @nfecproc = a.acfecproc                        ,              
           @nvaluf   = b.vmValor
   FROM    MFAC              a,
           VIEW_VALOR_MONEDA b
   WHERE   b.vmcodigo = a.accodmonuf AND
           b.vmfecha  = a.acfecproc          
   SELECT  'Tipo Operacion'    = a.catipoper                        ,
           'Numero Operacion'  = a.canumoper                        ,
           'Nombre Cliente'    = b.clnombre                         ,
           'Fecha Inicio'      = CONVERT(CHAR(10), a.cafecha, 103)  ,
           'Fecha Termino'     = CONVERT(CHAR(10), a.cafecvcto, 103),
           'Dias Cto'          = a.caplazo                          ,
           'Plazo Residual'    = a.caplazovto                       ,
           'Mon'               = c.mnnemo                           ,
           'Monto Uf'          = a.camtomon1                        ,
           'Valor Uf Inicial'  = a.capremon1                        ,
           'Monto Clp Inicial' = a.camtomon2                        ,
           'M/N Cnv'           = d.mnnemo                           ,
           'Valor Uf Final'    = a.catipcam                         ,
           'Monto Clp Uf Fwd'  = a.caequmon1                        ,
           'Valor a Diferir'   = a.cautildiferir + caperddiferir    ,
           'Devengo Acumulado' = a.cautilacum + caperdacum          ,
           'res var multi'     = a.carevuf                          ,
           'M'                 = a.catipmoda                        ,
           'Nombre Empresa'    = @nnomprop                          ,
           'Direccion Empresa' = @ndirprop                          ,
           'Fecha Proceso'     = CONVERT(CHAR(10), @nfecproc,103)   ,
           'UF valor dia'      = @nvaluf                            ,
           'Entidad'           = (SELECT rcnombre
                                  from   VIEW_ENTIDAD
                                  where  rccodcar = a.cacodsuc1 )   ,
           'Hora'              = CONVERT(CHAR(5), getdate(),108)
   FROM    MFCA         a,
           VIEW_CLIENTE b,
           VIEW_MONEDA  c,
           VIEW_MONEDA  d    
   WHERE  (b.clrut      = a.cacodigo   AND
           a.cacodcli   = b.clcodigo ) AND
           a.cacodmon1  = c.mncodmon   AND
           a.cacodmon2  = d.mncodmon   AND
           a.catipoper  = 'V'          AND 
           a.cacodpos1  = 3            AND
           a.cafecvcto <> @nfecproc
   SET NOCOUNT OFF
END

GO
