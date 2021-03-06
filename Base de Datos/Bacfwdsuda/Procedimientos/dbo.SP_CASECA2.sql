USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CASECA2]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CASECA2]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nvaluf     FLOAT  
   DECLARE @nvalob     FLOAT
   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   DATETIME
   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD)  ,
               @cdirprop = a.acdirprop                          ,
               @dfecproc = a.acfecproc                          ,
               @cfecproc = CONVERT( CHAR(10), a.acfecproc, 103 ),
               @nvaluf   = b.vmvalor                            ,
               @nvalob   = c.vmvalor 
   FROM        MFAC a             ,
               VIEW_VALOR_MONEDA b, 
               VIEW_VALOR_MONEDA c
   WHERE       b.vmcodigo = a.accodmonuf     AND
               b.vmfecha  = a.acfecproc      AND
               c.vmcodigo = a.accodmondolobs AND
               c.vmfecha  = a.acfecproc 
   SELECT 'Numero'               = a.canumoper                      ,
          'Operacion'            = a.catipoper                      ,
          'Cliente'              = ISNULL(clnombre,' ')             ,
          'Fecha Inicio'         = CONVERT(CHAR(10),a.cafecha,103)  ,
          'Fecha Termino'        = CONVERT(CHAR(10),a.cafecvcto,103),
          'M/X'                  = ISNULL(d.mnnemo,'N/D')           ,
          'Mto M/X Comprado'     = a.camtomon1                      ,
          'Moneda'               = ISNULL(c.mnnemo,'N/D' )          ,
          'T/C Obs Ini'          = a.capremon1                      ,  --En Realidad es el TCR de Entrada
          'Mto CLP Inicial T/C'  = a.caequmon1                      ,
          'M/N CNV'              = ISNULL(e.mnnemo,'N/D')           ,
          'T/C Inicial'          = CASE a.cacodmon2 WHEN 998 THEN
                                      a.capremon2
                                   ELSE
                                      a.catipcam
                                   END                              ,
          'Monto CNV'            = a.camtomon2                      ,
          'Monto CNV En Pesos'   = a.caequmon2                      ,
          'Valor a Diferir'      = a.cautildiferir + a.caperddiferir,
          'Devengo Acumulado'    = a.cautilacum + a.caperdacum      ,
          'Ajuste Variacion UF'  = a.carevuf                        ,
          'Valorizacion'         = a.carevtot                       ,
          'Modalidad'            = a.catipmoda                      ,
          'Tasa'                 = a.caprecal                       ,
          'Dias'                 = a.caplazo                        ,
          'Dias residuales'      = a.caplazovto                     ,
          'Precio Equilibrio'    = 0                                ,
          'Fecha Proceso'        = @cfecproc                        ,
          'Nombre Empresa'       = @cnomprop                        ,
          'Direccion Empresa'    = @cdirprop                        ,
          'Valor UF'             = @nvaluf                          ,
          'Valor Observado'      = @nvalob                          ,
          'Entidad'              = ( SELECT rcnombre
                                     FROM   VIEW_ENTIDAD
                                     WHERE  rccodcar = a.cacodsuc1 ),
          'Hora'                 = CONVERT(CHAR(5),getdate(),108 )
   FROM    MFCA              a,
           VIEW_CLIENTE      b,
           VIEW_MONEDA       c,
           VIEW_MONEDA       d,
           VIEW_MONEDA       e
   WHERE  (a.cacodpos1  = 1            OR
           a.cacodpos1  = 7          ) AND
           a.catipoper  = 'V'          AND
          (a.cacodigo   = b.clrut      AND
           a.cacodcli   = b.clcodigo ) AND
           a.camdausd   = c.mncodmon   AND   
           a.cacodmon1  = d.mncodmon   AND
           a.cacodmon2  = e.mncodmon   AND
           a.cafecvcto <> @dfecproc
   SET NOCOUNT OFF
END

GO
