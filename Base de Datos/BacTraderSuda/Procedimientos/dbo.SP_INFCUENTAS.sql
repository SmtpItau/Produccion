USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFCUENTAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFCUENTAS]
AS
BEGIN
SET NOCOUNT ON
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACFECPROC_TITULO  DATETIME
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
       @ACNOMPROP = acnomprop,
       @ACFECPROC = acfecproc,
	   @ACFECPROC_TITULO = acfecproc,
       @ACRUTPROP = acrutprop,
       @ACDIGPROP = acdigprop
    FROM MDAC               
 SELECT cta=CUENTA,
        monto=SUM(MONTO),
        tipo=TIPO_MONTO,
        'TIP_MONEDA'= CASE WHEN E.MONEDA=0 OR E.MONEDA=999 OR E.MONEDA=998 OR E.MONEDA=994 OR E.MONEDA=997  THEN 'N' ELSE 'E' END  
 INTO #temp1
 FROM BAC_CNT_DETALLE_VOUCHER E,
  BAC_CNT_VOUCHER G,
  mdac
 WHERE   g.fecha_ingreso =  acfecproc
 and g.numero_voucher = e.numero_voucher
 GROUP BY
  CUENTA,
  TIPO_MONTO,
  MONEDA

 SELECT  CTA=CTA,MONTO=SUM(MONTO),MONEDA=TIP_MONEDA,TIPO=TIPO INTO #TEMP3 from #temp1 GROUP BY CTA,TIP_MONEDA,TIPO

 SELECT DISTINCT
  B.CUENTA,
--  MONTO_DEBE = ISNULL((SELECT SUM(MONTO) FROM BAC_CNT_DETALLE_VOUCHER E,BAC_CNT_VOUCHER G WHERE E.TIPO_MONTO = 'D' AND E.CUENTA = A.CUENTA  and g.numero_voucher = e.numero_voucher and g.fecha_ingreso = d.acfecproc),0) ,
--  MONTO_HABER = ISNULL((SELECT SUM(MONTO) FROM BAC_CNT_DETALLE_VOUCHER F,BAC_CNT_VOUCHER H WHERE F.TIPO_MONTO = 'H' AND F.CUENTA = A.CUENTA  and f.numero_voucher = h.numero_voucher and h.fecha_ingreso = d.acfecproc),0) ,
  MONTO_DEBE = CONVERT(NUMERIC(19,4),0),
  MONTO_HABER = CONVERT(NUMERIC(19,4),0),
  DESCRIPCION,
  FECHA =  CONVERT(CHAR(10),ACFECPROC,103),
  HORA = RIGHT(GETDATE(),8),
  'TIPO_MONEDA' = CASE WHEN B.MONEDA=0 OR B.MONEDA=999 OR B.MONEDA=998 OR B.MONEDA=994 or B.MONEDA=997 THEN 'N' ELSE 'E' END ,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 INTO #temp2
 FROM VIEW_PLAN_DE_CUENTA A,
  BAC_CNT_DETALLE_VOUCHER B,
  BAC_CNT_VOUCHER C  ,
  MDAC D 
 WHERE  C.FECHA_INGRESO =  D.ACFECPROC 
 AND B.CUENTA = A.CUENTA 
 AND C.NUMERO_VOUCHER = B.NUMERO_VOUCHER 

 UPDATE #temp2
 SET MONTO_DEBE = monto
 FROM #temp3
 WHERE cuenta = cta
 AND tipo = 'D' 
 AND tipo_moneda = moneda
  
 UPDATE #temp2
 SET MONTO_HABER = monto
 FROM #temp3
 WHERE cuenta = cta
 AND tipo = 'H'
 AND tipo_moneda = moneda

 UPDATE #temp2
 SET TIPO_MONEDA = 'N'
 WHERE TIPO_MONEDA= ' '

 if Exists (SELECT TOP 1 * FROM #temp2)
 
	 BEGIN

		 SELECT CUENTA,
		  MONTO_DEBE,
		  MONTO_HABER,
		  DESCRIPCION,
		  FECHA,
		  HORA,
		  'banco'=  @ACNOMPROP,
		  TIPO_MONEDA,
		  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
		 FROM #temp2
		 ORDER BY CUENTA
		 SET NOCOUNT OFF
	END

	ELSE

	BEGIN

	   SELECT CUENTA  = 0,
		  MONTO_DEBE = 0,
		  MONTO_HABER = 0,
		  DESCRIPCION = '',
		  FECHA = CONVERT(char(10), @ACFECPROC_TITULO,103),
		  HORA = RIGHT(GETDATE(),8),
		  'banco'=  @ACNOMPROP,
		  TIPO_MONEDA = 0,
		  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

		 SET NOCOUNT OFF

	END

END

-- select * from BAC_CNT_VOUCHER WHERE FECHA_INGRESO='20040622' order by NUMERO_VOUCHER Fecha_Ingreso desc
-- select * from mdac
-- update mdac set acfecproc = '20011228'

--SELECT * FROM VIEW_PLAN_DE_CUENTA WHERE TIPO_MONEDA='E'

--SELECT * FROM BAC_CNT_DETALLE_VOUCHER WHERE NUMERO_VOUCHER>19782 AND CUENTA=34

GO
