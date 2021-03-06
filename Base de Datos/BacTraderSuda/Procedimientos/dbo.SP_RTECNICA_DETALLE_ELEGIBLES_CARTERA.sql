USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_DETALLE_ELEGIBLES_CARTERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_DETALLE_ELEGIBLES_CARTERA]
AS
BEGIN
 SET NOCOUNT ON
 
 --declaracion de variables locales 
 DECLARE @uf  FLOAT,
  @fecproc DATETIME
 
 --recupero el valor de la uf
 SELECT  @uf = VMVALOR,
  @fecproc = acfecproc
 FROM  view_valor_moneda, mdac
 WHERE  vmcodigo = 998 AND vmfecha = acfecproc
 
 SELECT  cpcodigo,
  cpinstser,
  cpvalvenc,
  cpfeccomp,
  cpfecpcup,
  CONVERT( NUMERIC ( 19 ), ISNULL( CASE WHEN cpcodigo = 6 THEN cpvalvenc
   ELSE ROUND(CPVALVENC * @uf,0)
   END, 0 ) ) AS MONTO,
  cpnumdocu
 FROM mdcp
 WHERE ( cpcodigo = 4
 OR cpcodigo = 6
 OR cpcodigo = 7
 OR cpcodigo = 300 )
 AND  DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91
 AND  cpnominal > 0
 AND  cpvalvenc > 0
 ORDER BY cpcodigo 
 SET NOCOUNT OFF
END

GO
