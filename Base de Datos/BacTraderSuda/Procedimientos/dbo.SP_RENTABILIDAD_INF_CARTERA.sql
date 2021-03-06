USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_INF_CARTERA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_INF_CARTERA] (@nFecha CHAR(10))
AS
BEGIN
 
 DECLARE @dFecha DATETIME
 DECLARE @pFecha CHAR(10)
 DECLARE @Hora CHAR(10)
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM MDAC 
 SELECT @dFecha = CONVERT (DATETIME,@nFecha,121)
 SELECT @pFecha = CONVERT (CHAR(10),@dFecha,103)
 SELECT @Hora = CONVERT (CHAR(10),GETDATE(),108)
 SET NOCOUNT ON      
 
 SELECT  fecproc  ,
  tipoper  ,
  numdocu  ,
  numoper  ,
  correla  ,
  instser  ,
  mascara  ,
  moneda  ,
  nominal  ,
  valcomp  ,
  valcomu  ,
  vpresen  ,
  fecini  ,
  fecven  ,
  rutcli  ,
  codcli  ,
  tasa  ,
  tasaefec ,
  tasacam  ,
  basetasa ,
  resultado ,
  seriado  ,
  codigo  ,
  costo  ,
  interes  ,
  reajuste ,
  inserie  ,
  'FechaReport'= @pFecha ,
  'HoraReport' = @Hora ,
  'BANCO'      = @ACNOMPROP
 INTO #PASO
 FROM renta_cp,
  view_instrumento
 WHERE codigo = incodigo AND @dFecha= fecproc 
 IF (SELECT COUNT(*) FROM #PASO) = 0
           INSERT INTO #PASO (fecproc,FechaReport,HoraReport,inserie,BANCO)VALUES(@dFecha,@pFecha, @Hora,'',@ACNOMPROP)
 
 SELECT * FROM #PASO
 SET NOCOUNT OFF      
END
/*
SELECT * FROM RENTA_CP
sp_rentabilidad_inf_cartera '20011120'
sp_autoriza_ejecutar 'bacuser'
*/

GO
