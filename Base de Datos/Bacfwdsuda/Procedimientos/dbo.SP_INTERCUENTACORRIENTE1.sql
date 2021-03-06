USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERCUENTACORRIENTE1]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERCUENTACORRIENTE1]
AS
BEGIN
SET NOCOUNT ON
 DECLARE @dfecproc    DATETIME
 DECLARE @fecproc     CHAR(8)
 DECLARE @cnomprop    CHAR(40)
 DECLARE @cdirprop    CHAR(40)
 SELECT  @dfecproc = acfecproc      ,
  @cnomprop = (Select rcnombre from view_entidad) ,
  @cdirprop = (Select rcdirecc from view_entidad)
 FROM mfac
 SELECT @fecproc = SUBSTRING(CONVERT(CHAR(8),@dfecproc, 112),3,2) + SUBSTRING(CONVERT(CHAR(8),@dfecproc, 112),5,2) + SUBSTRING(CONVERT(CHAR(8),@dfecproc, 112),7,2)
 SELECT  'TipoOperacion'= CASE  
     WHEN a.caantici  = 'A' AND a.camtoliq >= 0  THEN '06'  
     WHEN a.caantici  = 'A' AND a.camtoliq < 0  THEN '04' 
     WHEN a.catipmoda = 'C' AND a.camtocomp >= 0 THEN '06'
     WHEN a.catipmoda = 'C' AND a.camtocomp < 0 THEN '04'
     WHEN a.catipmoda = 'E' AND a.cacodpos1 = 2  THEN '04'
     ELSE '04'
        END         ,
  'FechaProceso' = @fecproc        ,
  'MontoCompensa'= CASE  
     WHEN a.caantici  = 'A'    THEN ABS(a.camtoliq)
     WHEN a.catipmoda = 'C'    THEN ABS(a.camtocomp)
     WHEN a.catipmoda = 'E' AND a.cacodpos1 = 2  THEN a.camtomon2 
     ELSE a.caclpmoneda2 
        END         ,
  'CuentCorrient'= CASE  WHEN b.clctacte = '0' OR b.clctacte = '' THEN '000000000' ELSE RTRIM(b.clctacte) END ,
  'NombrePropie' = @cnomprop        ,
  'DireccPropie' = @cdirprop
 FROM  mfca  a,
  view_cliente b
 WHERE  ( a.cacodigo  = b.clrut 
  AND a.cacodcli  = b.clcodigo)
  AND a.cafecvcto <= @dfecproc 
         AND( a.cafpagomn = 114 or a.cafpagomn = 115 or a.cafpagomn = 116 )
 ORDER BY a.canumoper
END
/*
 select camtocomp,camtoliq,camtomon2,catipmoda
 FROM  mfca  ,
  view_cliente 
 WHERE  ( cacodigo  = clrut 
  AND cacodcli  = clcodigo)
  AND cafecvcto <= '20010904'
*/

GO
