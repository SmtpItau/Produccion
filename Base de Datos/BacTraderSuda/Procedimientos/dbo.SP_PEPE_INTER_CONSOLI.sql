USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PEPE_INTER_CONSOLI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PEPE_INTER_CONSOLI]
AS 
BEGIN 
 DECLARE @FECHA char(8)
 SELECT @FECHA = '20020530'
SELECT   '1_X'  = '1'
 ,'2_X'  = '47'
 ,'3_X'  = '1'
 ,'4_X'  = '874'
 ,'Fecha_rpoceso'= @FECHA
 ,'N_voucher' = V.Numero_Voucher
 ,'cta_contable' = b.cuenta
 ,'8_X'  = '00'                             
 ,'debe_haber' = CASE WHEN B.Tipo_Monto = 'D' THEN '5' ELSE '0'END 
 ,'monto_debe' = CASE WHEN B.Tipo_Monto = 'D' THEN (RIGHT( '000000000000000' + CONVERT( VARCHAR(15),CONVERT(NUMERIC(15,2),b.monto,2) ), 15 ))
                               ELSE 0 
                          END 
 ,'11_X'  = '00'
 ,'12_X'  = '000000'
 ,'13_X'  = '0000000000'
 ,'cta_contable2'= b.cuenta
 ,'15_X'  = '00'
 ,'debe_haber2' = CASE WHEN B.Tipo_Monto = 'D' THEN '6' ELSE '0'END 
 ,'monto_haber' = CASE WHEN B.Tipo_Monto = 'H' THEN (RIGHT( '000000000000000' + CONVERT( VARCHAR(15),CONVERT(NUMERIC(15,2),b.monto,2) ), 15 ))
                               ELSE 0 
                          END 
 ,'18_X'  = '00'
 ,'19_X'  = '000000'
 ,'20_X'  = '0000000000'
 --,'21_X'  = '00000'
 ,'21_X' = CASE WHEN b.cuenta = 30023 THEN 10 ELSE 0 END
 ,'22_X' = CASE WHEN b.cuenta = 30023 THEN 47 ELSE 0 END
 ,'23_X' = '0'
 ,'24_X' = '00000000'
 ,'25_X' = '00'
 ,'26_X' = '000000'
 ,'27_X' = '000000'
 ,'28_X' = '000000'
 ,'29_X' = '000000000000000'
 ,'30_X' = '0'
 ,'31_X' = '000'
 ,'32_X' = '0000000'
 ,'33_X' = '00000000'
 ,'34_X' = '00'
 ,'35_X' = '000000'
 ,'36_X' = '000000'
 ,'37_X' = '000000'
 ,'38_X' = '000000000000000'
 ,'39_X' = '0'
 ,'40_X' = '000'
 ,'41_X' = '0000000'
 ,'42_X' = '000000000000000000000000000000'
 ,'43_X' = 'PDP'
 ,'44_X' = '0000000'
 --into #tmp_consoli
 FROM bac_cnt_voucher V  ,bac_cnt_detalle_voucher B ,view_plan_de_cuenta C
         WHERE   V.Numero_Voucher  = B.Numero_Voucher  
          and v.Fecha_Ingreso    = @FECHA
                 and C.cuenta          = b.cuenta              
 ORDER BY B.Numero_Voucher,B.Correlativo
--select * from #tmp_consoli
END
-- select * from mdrs where rsnumdocu = 39862 and rsfecha = '20020517'
-- select * from bac_cnt_voucher where Fecha_Ingreso = '20020517'
-- select * from bac_cnt_detalle_voucher 
-- select * from view_plan_de_cuenta
/*
select b.cuenta,
CASE WHEN SUBSTRING(b.cuenta,6,5) = '30023' THEN 47 ELSE 0 END
FROM bac_cnt_voucher V  ,bac_cnt_detalle_voucher B ,view_plan_de_cuenta C
 WHERE   V.Numero_Voucher  = B.Numero_Voucher  
          and v.Fecha_Ingreso    = (SELECT acfecproc FROM MDAC) --@FECHA
                 and C.cuenta          = b.cuenta              
select top 1 * from bac_cnt_voucher
select top 1 * from bac_cnt_detalle_voucher 
select top 1 * from view_plan_de_cuenta
*/
/*
select * from mdca --CASUCURSAL
sp_help  mdca
select * from bac_cnt_detalle_voucher
select * from mdmo
select * from view_plan_de_cuenta
select * from bac_cnt_voucher where Fecha_Ingreso = '20010110'
select * from view_moneda
select  'montodebe'   = sum(monto_debe)
 ,'monto_haber'   = sum(monto_haber)
 ,'total_registros'  = count(*)
 ,'fecha_proceso' = (SELECT acfecproc FROM MDAC)
 from #tmp_consoli
*/
 


GO
