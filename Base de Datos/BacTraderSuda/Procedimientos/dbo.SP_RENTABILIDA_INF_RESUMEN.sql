USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDA_INF_RESUMEN]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDA_INF_RESUMEN]  (@nFecha CHAR(10))
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Fecha DATETIME
 DECLARE @Hora  CHAR(10)
 DECLARE @sFecha CHAR(10)
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
 
 SELECT @Fecha = CONVERT(DATETIME,@nFecha,112)
 SELECT @Hora = CONVERT (CHAR(10),GetDate(),108)
 SELECT @sFecha =CONVERT(CHAR(10),@Fecha,103)
 CREATE TABLE #paso01(
  codigo  NUMERIC(2,0)  ,
  nmes  CHAR(20)  ,
  marca  NUMERIC (1,0)  ,
  Sinterb  NUMERIC(19,4) DEFAULT 0,
  Scartera_cpl NUMERIC(19,4) DEFAULT 0,
  Scartera_lpl NUMERIC(19,4) DEFAULT 0,
  Scipactos NUMERIC(19,4) DEFAULT 0,
  Svipactos NUMERIC(19,4) DEFAULT 0, 
  Sventas_cpl NUMERIC(19,4) DEFAULT 0,
  Sventas_lpl NUMERIC(19,4) DEFAULT 0,
  Shora  CHAR(10)        DEFAULT CONVERT (CHAR(10),GetDate(),108),
  Sfecha  CHAR(10) ,
                BANCO          CHAR(40)  DEFAULT '')
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,1,1,'ENERO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,2,1,'FEBRERO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,3,1,'MARZO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,4,1,'ABRIL') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,5,1,'MAYO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,6,1,'JUNIO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,7,1,'JULIO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,8,1,'AGOSTO') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,9,1,'SEPTIEMBRE') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,10,1,'OCTUBRE') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,11,1,'NOVIEMBRE') 
 INSERT INTO #paso01 (Sfecha,codigo,marca,nmes)VALUES(@sFecha,12,1,'DICIEMBRE') 
 SELECT 'codmes' = DATEPART(MONTH,fecproc),
  'sSinterb' = SUM(interb/1000) ,
  'sScartera_cpl' = SUM(cartera_cpl/1000),
  'sScartera_lpl' = SUM(cartera_lpl/1000),
  'sScipactos' = SUM(pactos_ci/1000) ,
  'sSvipactos' = SUM(pactos_vi/1000) ,
  'sSventas_cpl' = SUM(ventas_cpl/1000) ,
  'sSventas_lpl' = SUM(ventas_lpl/1000)       
 INTO #paso2
 FROM RENTA_RESUMEN 
 WHERE DATEPART(YEAR,fecproc) = DATEPART(YEAR,@Fecha)
 AND fecproc <= @Fecha
 GROUP BY DATEPART(MONTH,fecproc)
 UPDATE #PASO01
 SET Sinterb  = sSinterb,
  Scartera_cpl  = sScartera_cpl,
  Scartera_lpl  = sScartera_lpl,
  Scipactos = sScipactos,
  Svipactos  = sSvipactos,
  Sventas_cpl  = sSventas_cpl,
  Sventas_lpl  = sSventas_lpl
 FROM #paso2
 WHERE codigo = codmes
 INSERT into #PASO01
 SELECT  0,
  CONVERT(CHAR(10),fecproc,103),
  2,
  interb/1000,
  cartera_cpl/1000,
  cartera_lpl/1000,
  pactos_ci/1000,
  pactos_vi/1000,
  ventas_cpl/1000,
  ventas_lpl/1000,
  CONVERT (CHAR(10),GetDate(),108),
  @sFecha
 FROM RENTA_RESUMEN
 WHERE DATEPART(YEAR,fecproc) = DATEPART(YEAR,@Fecha)
 AND DATEPART(MONTH,fecproc) = DATEPART(MONTH,@Fecha)
 AND fecproc <= @Fecha
 ORDER BY fecproc
        UPDATE #PASO01 SET  BANCO  = @ACNOMPROP
 SELECT * from #PASO01
 SET NOCOUNT OFF
END
/*
sp_rentabilida_inf_resumen '20011122'
SELECT * FROM RENTA_RESUMEN
DROP TABLE #paso01
SP_AUTORIZA_EJECUTAR 'BACUSER'
*/

GO
