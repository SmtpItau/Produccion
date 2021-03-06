USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_RESUMEN_FINAL_PRC]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_RESUMEN_FINAL_PRC]
AS
BEGIN
 --declaracion de variables locales 
 DECLARE @uf  FLOAT,
  @fecproc DATETIME
 
 --recupero el valor de la uf
 SELECT  @uf = VMVALOR,
  @fecproc = acfecproc
 FROM  view_valor_moneda , mdac
 WHERE  vmcodigo = 998 AND vmfecha = acfecproc
 
 SELECT  cpfecpcup,
  sum( cpvalvenc ) as nominal,
  sum( ROUND(cpvalvenc * @uf,0) ) as monto,
  @fecproc as fecha,
  @uf as uf
 FROM mdcp
 WHERE cpcodigo = 4
 AND  DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91
 AND  cpnominal > 0
 AND  cpvalvenc > 0
 GROUP BY cpfecpcup
 ORDER BY cpfecpcup
 SET NOCOUNT OFF
END

GO
