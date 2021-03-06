USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERCUENTACORRIENTE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERCUENTACORRIENTE]
AS
BEGIN
SET NOCOUNT ON
   DECLARE @dfecproc    DATETIME
   DECLARE @cnomprop    CHAR(40)
   DECLARE @cdirprop    CHAR(40)
   SELECT @dfecproc = acfecproc  ,
          @cnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @cdirprop = (Select rcdirecc from VIEW_ENTIDAD)
     FROM MFAC
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT 'TipoOperacion'= a.catipoper                             ,  -- 1       
          'NomCliente'   = b.clnombre                              ,  -- 2
   'RutCliente'  = '000000000'       ,  -- 3
   'FechaProceso' = CONVERT(CHAR(10),@dfecproc, 103 )       ,  -- 4
      'Hora'  = a.cahora       ,  -- 5
   'CodOfi'     = '0071'       ,  -- 6
   'CodOri'  = 'MDF'       ,  -- 7    
          'CodigoTran'  = CASE WHEN a.catipoper = 'C'
    THEN '024003'
    ELSE '024007'
      END         ,  -- 8
   'Moneda'  = '0000'                  ,  -- 9
   'MontoCompensa'= CASE WHEN a.caantici  = 'A' THEN ABS(a.camtoliq)
    WHEN a.catipmoda = 'C' THEN ABS(a.camtocomp)
    WHEN a.catipmoda = 'E' AND a.cacodpos1 = 2 THEN a.camtomon2 
    ELSE a.caclpmoneda2 
      END            ,  -- 10     
   'NroDocu' = a.canumoper                                 ,  -- 11
   'Codabo'  = ( CASE WHEN a.caantici  = 'A' AND a.camtoliq  < 0 THEN '2' 
    WHEN a.caantici  = 'A' AND a.camtoliq  > 0 THEN '1' 
    WHEN a.catipmoda = 'C' AND a.camtocomp < 0 THEN '2' 
    WHEN a.catipmoda = 'C' AND a.camtocomp > 0 THEN '1' 
    WHEN a.catipmoda = 'E' AND a.cacodpos1 = 2 THEN '1'
    ELSE '1'
       END  )       , -- 12
          'Idcon'  = '2'        , -- 13 
   'NroOper'      = a.canumoper                             , -- 14    ,  -- 11
   'CorOpe'  = '0000'       , -- 15
   'NumCaj'  = '0000'       , -- 16
          'Glosa'   = CASE WHEN (a.catipoper = 'C' OR a.catipoper = 'O')
    THEN 'LIQ. DE CONTR. A FUTURO COMPRA'
    ELSE 'LIQ. DE CONTRA. A FUTURO VENTA'
      END         ,  -- 17
   'CuentCorrient'= b.clctacte       ,  -- 18
   'Indavi'  = 'N'        ,  -- 19
   'Filler'  = '000000000000000000'      ,  -- 20
   'Producto'  = '00000'       ,  -- 21
   'Correl'  = '00'        ,  -- 22
   'Cartera'      = a.cacodpos1                             ,  -- 23
   'Modalidad'  = a.catipmoda       ,  -- 24              
          'FechaVcto'    = CONVERT( CHAR(10), a.cafecvcto, 103 )   ,  -- 25          
          'NombrePropie' = @cnomprop                               ,  -- 26
          'DireccPropie' = @cdirprop         -- 27        
     FROM MFCA                    a,
          VIEW_CLIENTE b,
          VIEW_MONEDA  c,
          VIEW_MONEDA  f,
   VIEW_FORMA_DE_PAGO g
    WHERE ( a.cacodigo  = b.clrut 
      AND a.cacodcli  = b.clcodigo)
      AND a.cacodmon2 = c.mncodmon
      AND a.cacodmon1 = f.mncodmon
      AND( a.cafpagomn = 114 or a.cafpagomn = 115 or a.cafpagomn = 116 )
      AND a.cafpagomn = g.codigo
      AND a.cafecvcto <= @dfecproc 
    ORDER BY a.canumoper
END

GO
