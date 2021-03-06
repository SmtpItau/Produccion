USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[DIFERIDAS]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DIFERIDAS] @ncartera NUMERIC(2,0)
AS
BEGIN 
   SET NOCOUNT ON
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME
   SELECT @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @ndirprop = (Select rcdirecc from VIEW_ENTIDAD),
          @nfecproc = acfecproc
   FROM   MFAC   
   SELECT 'Tipo Operacion'               = a.catipoper                        ,
          'Numero Operacion'             = a.canumoper                        ,
          'Nombre Cliente'               = b.clnombre                         ,
          'Fecha Inicio'                 = CONVERT(CHAR(10), a.cafecha, 103)  ,
          'Fecha Termino'                = CONVERT(CHAR(10), a.cafecvcto, 103),
	  'MX'                           = c.mnnemo                           ,
          'Mto M/X Comprada'             = a.camtomon1                        ,
          'Monto CNV'                    = a.camtomon2                        ,
          'Equivalencia Inicial'         = a.caequmon1         ,
          'Monto a Diferir'              = a.camtodiferir        ,
          'Monto Devengado'              = a.cautildevenga + caperddevenga    ,
          'M'                            = a.catipmoda         ,
          'Dias Ope'                     = a.caplazoope         ,
          'Dias Vcto'                    = a.caplazovto         ,
          'Dias Tran'                    = a.caplazocal         ,
          'Moneda2'                      = d.mnnemo                           ,   
         
          'Nombre Empresa'               = @nnomprop                          ,
          'Direccion Empresa'            = @ndirprop                          ,
          'Fecha Proceso'                = CONVERT(CHAR(10), @nfecproc, 103 ) ,
          'Observado'                    = ( SELECT vmvalor
                                             FROM   VIEW_VALOR_MONEDA
                                             WHERE  vmcodigo = 994 AND
                                                    vmfecha  = @nfecproc )    ,
          'valor UF'                     = ( SELECT vmvalor
                                             FROM   VIEW_VALOR_MONEDA
                                             WHERE  vmcodigo = 998 AND
                                                    vmfecha  = @nfecproc )    ,
          'Entidad'                      = ( SELECT rcnombre
                                             from   VIEW_ENTIDAD
                                             where  rccodcar = a.cacodsuc1 )  ,
          'Hora'                         =  CONVERT(CHAR(5), getdate(),108)   ,
          'Tipo Cartera'                 = @ncartera   
   FROM   MFCA         a,
          VIEW_CLIENTE b,
          VIEW_MONEDA  c,
          VIEW_MONEDA  d 
   WHERE (b.clrut      = a.cacodigo   AND
          a.cacodcli   = b.clcodigo ) AND
          a.cacodmon1  = c.mncodmon   AND
          a.cacodmon2  = d.mncodmon   AND
          a.cacodpos1  = @ncartera    AND
          a.cafecvcto  > @nfecproc
   SET NOCOUNT OFF
END

GO
