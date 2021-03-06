USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_LEER_MARCADOS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_LEER_MARCADOS]
AS
BEGIN
 DECLARE @uf NUMERIC(18,4),
  @fecproc   DATETIME
 SET NOCOUNT ON
 
 SELECT  @uf = ISNULL( a.VMVALOR, 0 )
 FROM  view_valor_moneda a, mdac b
 WHERE  a.vmcodigo = 998 AND a.vmfecha = b.acfecproc
 SELECT  @fecproc = acfecproc
 FROM  mdac
 SELECT  cpnumdocu,
  cpcorrela,
  cpcodigo,
  cpreserva_tecnica,
  cpinstser,
  cpnominal,
  cpfeccomp,
  cpfecpcup,
  CONVERT( NUMERIC ( 19 ), ISNULL( CASE WHEN cpcodigo = 6 THEN ROUND(cpvalvenc/1000,0)
   ELSE ROUND(cpvalvenc*@uf/1000,0)
   END, 0 ) ) AS MONTO,
  cprutcart
 INTO #temporal
 FROM mdcp
 WHERE ( cpcodigo = 4
 OR cpcodigo = 6
 OR cpcodigo = 7
 OR cpcodigo = 300 )
 AND  cpnominal > 0
 AND cpvalvenc > 0
 AND  DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91
 SELECT * FROM #temporal ORDER BY cpcodigo, cpinstser, cpfecpcup, monto
 SET NOCOUNT OFF
END

GO
