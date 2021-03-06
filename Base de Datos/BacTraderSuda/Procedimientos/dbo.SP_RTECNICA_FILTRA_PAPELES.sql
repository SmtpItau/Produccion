USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_FILTRA_PAPELES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_FILTRA_PAPELES](  @monto     NUMERIC(18), 
      @adicional NUMERIC(18), 
      @ventana   NUMERIC(18), 
      @usuario   CHAR(20) )
AS 
BEGIN
 DECLARE @cpmonto   NUMERIC, 
  @monto_aux NUMERIC(18),
  @nmonto    NUMERIC(18),
  @cprutcart NUMERIC(18),
  @cpnumdocu NUMERIC(18),
  @cpcorrela NUMERIC(18),
  @uf    NUMERIC(18,4),
  @rutcart   NUMERIC(18),
  @fecproc   DATETIME,
  @sqlcode   INTEGER,
  @contador  NUMERIC(05,00)
 SET NOCOUNT ON
 
 --recupero el valor de la uf
 SELECT  @uf = ISNULL( a.VMVALOR, 0 )
 FROM  view_valor_moneda a, mdac b
 WHERE  a.vmcodigo = 998 AND a.vmfecha = b.acfecproc
 --recupero la fecha de proceso
 SELECT  @fecproc = acfecproc,
  @rutcart = acrutprop
 FROM  mdac
 --desbloqueo papeles seleccionados
 EXECUTE @sqlcode = sp_rtecnica_seleccion_desblinst @usuario
 IF @sqlcode <> 0 
 BEGIN
  RETURN (56)
 END   
 SELECT  'numdocu' = CONVERT( NUMERIC(18), 0 ),
  'correla' = CONVERT( NUMERIC(18), 0 ),
  'monto'   = CONVERT( NUMERIC(18), 0 )
 INTO #temporal
 
 SELECT  'numdocu' = CONVERT( NUMERIC(18), 0 ),
  'correla' = CONVERT( NUMERIC(18), 0 )
 INTO #temporal_2
 DELETE FROM #temporal
 DELETE FROM #temporal_2
 
 DECLARE Cursor_1 CURSOR FOR
  SELECT  cprutcart,
   cpnumdocu,
   cpcorrela,
   CONVERT( NUMERIC ( 19 ), ISNULL( CASE WHEN cpcodigo = 6 THEN ROUND(cpvalvenc/1000,0)
    ELSE ROUND(cpvalvenc*@uf/1000,0)
    END, 0 ) ) AS MONTO
  FROM mdcp
  WHERE ( cpcodigo = 4
  OR cpcodigo = 6
  OR cpcodigo = 7
  OR cpcodigo = 300 )
  AND     cpnominal > 0
  AND     cpvalvenc > 0
  AND  DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91
  ORDER BY monto DESC
 
 OPEN cursor_1 
 FETCH NEXT FROM cursor_1 INTO @cprutcart, @cpnumdocu, @cpcorrela, @cpmonto
 
 WHILE @@FETCH_STATUS = 0
 BEGIN
  
  SELECT @monto_aux = CONVERT( NUMERIC(19), ( ISNULL( ( select SUM(monto) from #temporal ), 0 ) ) )
  
  IF ( @monto_aux + @cpmonto ) <  ( @monto + @adicional )
  BEGIN
   --bloqueo el papel
   EXECUTE sp_rtecnica_bloquea_inst @cprutcart, @cpnumdocu, @cpcorrela, @ventana, @usuario, @sqlcode output
   
   IF @sqlcode = 0 
   BEGIN
 
    INSERT INTO #temporal
     SELECT  @cpnumdocu,
      @cpcorrela,
      CONVERT( NUMERIC ( 19 ), ISNULL( CASE WHEN cpcodigo = 6 THEN ROUND(cpvalvenc/1000,0)
       ELSE ROUND(cpvalvenc*@uf/1000,0)
       END, 0 ) ) AS MONTO
     FROM mdcp
     WHERE cpnumdocu = @cpnumdocu
     AND cpcorrela = @cpcorrela
   END
  END
  ELSE 
  BEGIN
   INSERT INTO  #temporal_2
     ( numdocu,
       correla )
   VALUES   ( @cpnumdocu,
       @cpcorrela ) 
  
  END
  FETCH NEXT FROM cursor_1 INTO @cprutcart, @cpnumdocu, @cpcorrela, @cpmonto
 END
 SET ROWCOUNT 1
 
 WHILE 1 = 1
 BEGIN
  SELECT @contador = COUNT(*)  FROM #temporal_2
  IF @contador = 0 BREAK
  
  SELECT  @cprutcart = a.cprutcart,
   @cpnumdocu = a.cpnumdocu,
   @cpcorrela = a.cpcorrela,
   @nMonto    = CASE WHEN a.cpcodigo = 6 THEN ROUND(a.cpvalvenc/1000,0) ELSE ROUND(a.cpvalvenc*@uf/1000,0) END
  FROM mdcp a,  #temporal_2 b
  WHERE  a.cpnumdocu = b.numdocu
  AND a.cpcorrela = b.correla
  ORDER
  BY CASE WHEN a.cpcodigo = 6 THEN ROUND(a.cpvalvenc/1000,0) ELSE ROUND(a.cpvalvenc*@uf/1000,0) END
  
  --bloqueo el papel
  EXECUTE sp_rtecnica_bloquea_inst @cprutcart, @cpnumdocu, @cpcorrela, @ventana, @usuario, @sqlcode output
  
  IF @sqlcode = 0 
  BEGIN
   
   INSERT INTO #temporal
    SELECT  @cpnumdocu ,
     @cpcorrela ,
     @nMonto  
    
   BREAK
 
  END
  DELETE FROM #temporal_2 WHERE @cpnumdocu = numdocu and @cpcorrela = correla
 END
 SET ROWCOUNT 0
 --bloqueo documento
 
 SELECT  cpnumdocu,
  cpcorrela,
  cpcodigo,
  SPACE(1) AS MARCA,
  cpinstser,
  cpnominal,
  cpfeccomp,
  cpfecpcup,
  CONVERT( NUMERIC ( 19 ), ISNULL( CASE WHEN cpcodigo = 6 THEN ROUND(cpvalvenc/1000,0)
   ELSE ROUND(cpvalvenc*@uf/1000,0)
   END, 0 ) ) AS MONTO,
  cprutcart
 INTO #temporal_3
 FROM mdcp
 WHERE ( cpcodigo = 4
 OR cpcodigo = 6
 OR cpcodigo = 7
 OR cpcodigo = 300 )
 AND  cpnominal > 0
 AND     cpvalvenc > 0
 AND  DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91
 UPDATE #temporal_3
 SET marca = 'M'
 FROM  #temporal
 WHERE cpnumdocu = numdocu
 AND cpcorrela = correla
 CLOSE cursor_1
 
 DEALLOCATE CURSOR_1
 
 SELECT * FROM #temporal_3 ORDER BY cpcodigo, cpinstser, cpfecpcup, monto
 
END

GO
