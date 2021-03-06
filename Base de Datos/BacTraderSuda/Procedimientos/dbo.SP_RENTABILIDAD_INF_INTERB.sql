USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_INF_INTERB]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_INF_INTERB](@nFecha CHAR(10))
AS
BEGIN
 SET NOCOUNT ON
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
 SELECT  fecproc  ,
  tipoper  ,
  numdocu  ,
  instser  ,
  mnnemo  ,
  nominal  ,
  valcomp  ,
  valcomu  ,
  fecini  ,
  fecven  ,
  rutcli  ,
  codcli  ,
  tasa  ,
  tasaefec ,
  tasacam  ,
  basetasa ,
  resultado ,
  'FechaReport'= @pFecha ,
  'HoraReport' = @Hora ,
  clnombre,
  glosa ,
  'BANCO' = @ACNOMPROP
 INTO #PASO
 FROM renta_ib,view_cliente,view_moneda,view_forma_de_pago
 WHERE @dFecha= fecproc 
 
 AND rutcli = clrut 
 AND codcli = clcodigo
 AND mncodmon =moneda
 AND forpag = codigo
 
 IF (SELECT COUNT(*) FROM #PASO) = 0
           INSERT INTO #PASO (fecproc,FechaReport,HoraReport,clnombre,glosa,BANCO)VALUES(@dFecha,@pFecha, @Hora,'','',@ACNOMPROP)
 
 SELECT * FROM #PASO
 SET NOCOUNT OFF      
END
/*
sp_rentabilidad_inf_interb '20011123'
SELECT * FROM RENTA_IB
SELECT * FROM VIEW_MONEDA
SELECT * FROM VIEW_FORMA_DE_PAGO
SP_AUTORIZA_EJECUTAR 'BACUSER'
*/


GO
