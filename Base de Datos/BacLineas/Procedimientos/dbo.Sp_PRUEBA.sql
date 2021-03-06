USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PRUEBA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROC [dbo].[Sp_PRUEBA]
AS
BEGIN
 DECLARE @cpnumdocu NUMERIC(18,04),
  @cpcorrela NUMERIC(18,04),
  @cpmascara CHAR(12)
 DECLARE CORRE_MDCP CURSOR
 FOR SELECT  cpnumdocu,cpcorrela,cpmascara 
 FROM MDCP
 WHERE cpcodigo = 20
 
 OPEN CORRE_MDCP
 FETCH NEXT FROM CORRE_MDCP
 INTO @cpnumdocu ,
      @cpcorrela,
      @cpmascara
 WHILE @@FETCH_STATUS = 0 
 BEGIN
  
  PRINT @cpnumdocu 
  PRINT @cpcorrela
  PRINT @cpmascara
  PRINT '----------------'
  IF EXISTS( SELECT * FROM MDCA WHERE CANUMDOCU = @cpnumdocu 
   AND CACORRELA = @cpcorrela AND ((CAINST= 'LH-VIV') OR (CAINST ='LH-FG')))
  BEGIN
   UPDATE SERIE SET tipo_letra = ( SELECT 'TIPO'= (CASE WHEN CAINST = 'LH-VIV' THEN 'V' ELSE 'F' END) 
   FROM MDCA WHERE CANUMDOCU = @cpnumdocu 
   AND CACORRELA = @cpcorrela AND ((CAINST= 'LH-VIV') OR (CAINST ='LH-FG')))
   WHERE LTRIM(RTRIM(SEMASCARA)) = RTRIM(LTRIM(SUBSTRING(@cpmascara,1,6)))
   
  END
  FETCH NEXT FROM CORRE_MDCP
  INTO @cpnumdocu ,
       @cpcorrela,
       @cpmascara
 END 
 DEALLOCATE CORRE_MDCP
END 
-- SP_PRUEBA






GO
