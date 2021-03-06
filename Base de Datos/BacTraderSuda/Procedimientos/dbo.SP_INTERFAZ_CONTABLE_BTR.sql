USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CONTABLE_BTR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_CONTABLE_BTR]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @fecproc DATETIME
 SELECT @fecproc = acfecproc
 FROM MDAC
 SELECT 'cuenta' = b.cuenta  ,
  'tipo_monto' = b.tipo_monto  ,
  'monto'  = b.monto  ,
  'glosa'  = CASE
     WHEN a.tipo_operacion IN ('RV','RC','RVA','RCA')
      THEN SUBSTRING(a.glosa,1,45)+' '+a.tipo_operacion+' '+CONVERT(CHAR(5),a.fpagoentre)+' '+CONVERT(CHAR(5),a.condicion_pacto)
     WHEN a.tipo_operacion IN ('VI') 
      THEN SUBSTRING(a.glosa,1,45)+' '+a.tipo_operacion+' '+CONVERT(CHAR(10),a.operacion)
     WHEN a.tipo_operacion IN ('CI','VI','DVCI','DVVI','DVIT')
      THEN SUBSTRING(a.glosa,1,45)+' '+a.tipo_operacion+' '+CONVERT(CHAR(5),a.fpago)+' '+CONVERT(CHAR(5),a.condicion_pacto)
     WHEN a.tipo_operacion IN ('IB')
      THEN SUBSTRING(a.glosa,1,45)+' '+a.tipo_operacion+' '+CONVERT(CHAR(5),a.plazo)+' '+a.clasificacion_cliente
     WHEN a.Tipo_Operacion IN ('DICO','DICA')
      THEN SUBSTRING(a.glosa,1,45)+' '+a.tipo_operacion+' '+CONVERT(CHAR(5),a.fpago)+' '+a.clasificacion_cliente
     WHEN a.tipo_operacion IN ('CP','VP')   
      THEN SUBSTRING(a.glosa,1,45)+' '+ a.tipo_operacion+' '+a.fpago ELSE SUBSTRING(a.glosa,1,45)+' '+a.tipo_operacion+' '
      END   ,
  'moneda' = CASE
     WHEN SUBSTRING(instser,1,3)<>'DPX' THEN 999
     ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=a.documento AND nscorrela=a.correlativo)
      END   ,
  'corresponsal' = CASE
     WHEN SUBSTRING(instser,1,3)='DPX' THEN 'S'
     ELSE 'N'
      END
 INTO #VOUCHER_1
 FROM BAC_CNT_DETALLE_VOUCHER b LEFT OUTER JOIN VIEW_PLAN_DE_CUENTA ON RTRIM(LTRIM(VIEW_PLAN_DE_CUENTA.Cuenta)) = RTRIM(LTRIM(b.Cuenta)) 
, BAC_CNT_VOUCHER a
 WHERE b.Numero_Voucher=a.Numero_Voucher 
 AND a.FECHA_INGRESO=@fecproc

--REQ.7619 CASS 25-01-2011
-- FROM BAC_CNT_DETALLE_VOUCHER b, BAC_CNT_VOUCHER a, VIEW_PLAN_DE_CUENTA
-- WHERE b.Numero_Voucher=a.Numero_Voucher AND RTRIM(LTRIM(VIEW_PLAN_DE_CUENTA.Cuenta))=*RTRIM(LTRIM(b.Cuenta)) AND
--  a.FECHA_INGRESO=@fecproc
--
 SELECT cuenta   ,
  tipo_monto  ,
  glosa   ,
  'monto' = SUM(CONVERT(NUMERIC(19,2),monto)) ,
  'tipo' = 1  ,
  moneda   ,
  corresponsal
 INTO #VOUCHER
 FROM #VOUCHER_1
 GROUP BY cuenta, tipo_monto, glosa, moneda, corresponsal
 SELECT 'glosita' = SUBSTRING(glosa,1,50)     ,
  'cuenta' = cuenta      ,
  'debe'  = (CASE WHEN tipo_monto='D' THEN monto ELSE 0 END) ,
  'haber'  = (CASE WHEN tipo_monto='H' THEN monto ELSE 0 END) ,
  'glosa'  = glosa       ,
  'tipo'  = 1       ,
  moneda         ,
  corresponsal
 INTO #INTERFAZ
 FROM #VOUCHER
 ORDER BY glosa
 SELECT DISTINCT
  glosita  ,
  glosa  ,
  moneda  ,
  corresponsal
 INTO #INTERFAZ1
 FROM #INTERFAZ 
 
 INSERT INTO #INTERFAZ
 SELECT SUBSTRING(glosa,1,50) ,
  ''   ,
  0   ,
  0   ,
  GLOSA   ,
  2   ,
  moneda   ,
  corresponsal
 FROM #INTERFAZ1
 SELECT glosa      ,
  glosita      ,
  cuenta      ,
  debe  = SUM(debe)   ,
  haber  = SUM(haber)   ,
  tot_monto_debe = CONVERT(NUMERIC(19,4),0) ,
  tot_monto_haber = CONVERT(NUMERIC(19,4),0) ,
  monto_debe = SUM(debe)   ,
  monto_haber = SUM(haber)   ,
  tipo      ,
  moneda      ,
  corresponsal
 INTO #TEMP1
 FROM #INTERFAZ
 GROUP BY glosa, glosita, cuenta, tipo, moneda, corresponsal
 ORDER BY glosa,tipo 
 UPDATE #TEMP1
 SET monto_debe  = debe - haber ,
  monto_haber = 0
 WHERE debe<>0 AND haber<>0 AND debe>haber
 UPDATE #TEMP1
 SET monto_haber  = haber - debe ,
  monto_debe   = 0
 WHERE debe<>0 AND haber<>0 AND haber>debe
 SELECT glo     = glosa,
  glo1    = glosita,
  tot_deb = SUM(monto_debe),
  tot_hab = SUM(monto_haber)
 INTO #TEMP2
 FROM #TEMP1
 GROUP BY glosa, glosita
 UPDATE #TEMP1
 SET tot_monto_debe = tot_deb ,
  tot_monto_haber = tot_hab
 FROM #TEMP2
 WHERE glo=glosa AND glo1=glosita
 SELECT glosita   ,
  cuenta   ,
  monto_debe  ,
  monto_haber  ,
  tot_monto_debe  ,
  tot_monto_haber  ,
  0   ,
  tipo   ,
  mncodfox ,
  isnull((CASE
   WHEN moneda=13 THEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@fecproc)
   ELSE 0
  END),0)   ,
  corresponsal = CASE
     WHEN corresponsal='S' THEN (SELECT CONVERT(CHAR(04),mncodcorrespC) FROM VIEW_MONEDA WHERE moneda=mncodmon)
     ELSE '0000'
      END
 FROM #TEMP1, VIEW_MONEDA
 WHERE mncodmon=moneda
 ORDER BY glosa ,tipo 
END
-- SP_INTERFAZ_CONTABLE_BTR
-- select * from BAC_CNT_DETALLE_VOUCHER
-- select * from BAC_CNT_VOUCHER
-- select * from VIEW_MONEDA
-- select VMFECHA,* from VIEW_VALOR_MONEDA WHERE VMCODIGO=994 ORDER BY VMFECHA DESC
-- select * from view_noserie
-- update mdmo set mostatreg=' '


GO
