USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_BRECHA_GRAL_RPT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_INF_BRECHA_GRAL_RPT]
AS BEGIN
 DECLARE @DIFERENCIA FLOAT
 DECLARE @BRECHA_TOT FLOAT
 DECLARE @BRECHA_CONT FLOAT
 DECLARE @NETO_INTERES FLOAT
 --Posicion de Cambio
 SELECT  'ID'      = 'POSCAM',
  'CODIGO'  = codigo,
  'GLOSA'   = glosa,
  'SALDOI'  = Saldo,
  'SALDOD'  = 0,
  'TOTAL'   = (SELECT SUM(SALDO) FROM BRECHA WHERE codigo='500COM' OR codigo='500VEN' OR codigo='CREDREC' OR codigo='SALSPOT' OR codigo='ARRPOSI')
 INTO #TABLA
 FROM BRECHA
 WHERE codigo='500COM' OR codigo='500VEN' OR codigo='CREDREC' OR codigo='SALSPOT' OR codigo='ARRPOSI'
 --Saldo Neto Conversiones Especiales
 INSERT INTO #TABLA
 SELECT  'ID'      = 'SNCE',
  'CODIGO'  = codigo,
  'GLOSA'   = glosa,
  'SALDOI'  = Saldo,
  'SALDOD'  = 0,
  'TOTAL'  = (SELECT SUM(SALDO) FROM BRECHA WHERE codigo = 'RESERVA' OR codigo = 'DEUDEXT' OR codigo = 'PTM1196' OR codigo = 'CNVESPE')
 FROM BRECHA
 WHERE codigo = 'RESERVA' OR codigo = 'DEUDEXT' OR codigo = 'PTM1196' OR codigo = 'CNVESPE'
 --Saldo Neto Forwards
 INSERT INTO #TABLA
 SELECT  'ID'      = 'SNFWD',
  'CODIGO'  = codigo,
  'GLOSA'   = glosa,
  'SALDOI'  = Saldo,
  'SALDOD'  = 0,
  'TOTAL'  = (SELECT SUM(SALDO) FROM BRECHA WHERE codigo = 'ACTFWDS' OR codigo = 'PASFWDS')
 FROM BRECHA
 WHERE codigo = 'ACTFWDS' OR codigo = 'PASFWDS'
 --NETO INTERES
 SELECT @NETO_INTERES=(SELECT SUM(SALDO) FROM BRECHA WHERE codigo = 'INTCOTC' OR codigo = 'INTPATC' )
     --------------
 INSERT INTO #TABLA
 SELECT  'ID'      = 'NETINT',
  'CODIGO'  = codigo,
  'GLOSA'   = glosa,
  'SALDOI'  = saldo,
  'SALDOD'  = 0,
  'Total'   = @NETO_INTERES +((SELECT SUM(SALDO) FROM BRECHA WHERE codigo = 'OTROS' OR codigo = 'UTILMX' ))
 FROM BRECHA
 WHERE codigo = 'INTCOTC' OR codigo = 'INTPATC'
     -----------
 INSERT INTO #TABLA
 SELECT  'ID'      = 'NETINT',
  'CODIGO'  = 'NETINT',
  'GLOSA'   = 'Neto Interes',
  'SALDOI'  = 0,
  'SALDOD'  = @NETO_INTERES,
  'TOTAL'   = @NETO_INTERES +((SELECT SUM(SALDO) FROM BRECHA WHERE codigo = 'OTROS' OR codigo = 'UTILMX' ))
 --Brecha Moneda Extranjera  
 INSERT INTO #TABLA
 SELECT  'ID'      = 'BME',
  'CODIGO'  = codigo,
  'GLOSA'   = glosa,
  'SALDOI'  = Saldo,
  'SALDOD'  = 0,
  'TOTAL'   = @NETO_INTERES + ( (SELECT SUM(SALDO) FROM BRECHA WHERE codigo = 'OTROS' OR codigo = 'UTILMX' ))
 FROM BRECHA
 WHERE codigo = 'OTROS' OR codigo = 'UTILMX'
 --Saldo Pesos Reajustable Dolar
 INSERT INTO #TABLA
 SELECT  'ID'      = 'SPRD',
  'CODIGO'  = codigo,
  'GLOSA'   = glosa,
  'SALDOI'  = Saldo,
  'SALDOD'  = 0,
  'TOTAL'   = (SELECT SUM(SALDO) FROM BRECHA WHERE codigo = '400COLF' OR codigo = '400CAPF' OR codigo = '400COLO' OR codigo = '400CAPO' )
 FROM BRECHA
 WHERE codigo = '400COLF' OR codigo = '400CAPF' OR codigo = '400COLO' OR codigo = '400CAPO' 
 
 --Brecha Total
 SELECT DISTINCT @BRECHA_TOT = (SELECT SUM(TOTAL) FROM #TABLA)
  
 --Brecha Contabilidad
 SELECT  @BRECHA_CONT = SALDO FROM BRECHA WHERE codigo = 'BRECCNT'
 --Diferencia
 SELECT  @DIFERENCIA =  @BRECHA_TOT - @BRECHA_CONT
 
 SELECT  *, 
  'BRECHA_CONT' = @BRECHA_TOT,
  'BRECHA_TOT'  = @BRECHA_CONT,
  'DIFERECNCIA' = @DIFERENCIA,
  'HORA'        = CONVERT(CHAR(8),GETDATE(),108),
  'DOLAROBS'    = (SELECT ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA,VIEW_MEAC   WHERE vmfecha  = acfecpro  AND vmcodigo = 994),
  'FECHA_REPOR' = CONVERT(CHAR(10),acfecproc,103)
 FROM  #TABLA  ,
  mfac
END
/*
SP_INF_BRECHA_GRAL_RPT
SELECT * FROM BRECHA
s
*/
GO
