USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_PROPIO_NACIONAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTER_PROPIO_NACIONAL]  
AS
BEGIN 
 DECLARE @FECHA DATETIME
 SELECT @FECHA = '20020530'
--print @FECHA 
 SELECT  'TIPOREG'  = '1'      --1
  ,'CODOFIC' = '01'      --2
  ,'AREA'  = '1'      --3
  ,'SECCION' = '356'      --4
  ,'FECHACONT'  = @FECHA --(select acfecproc FROM MFAC)  --5
  ,'NUM_VOUCHER'  = V.Numero_Voucher    --6
  ,'CUENTA' = CASE  WHEN B.Tipo_Monto = 'D' THEN SUBSTRING(B.CUENTA,5, 5)  --7
     ELSE '00000' END
   ,'codmoneda' = CASE  WHEN B.Tipo_Monto = 'D' THEN      --8                                    
                                                  isnull((select mncodsuper from VIEW_MONEDA 
                  where mncodmon = B.Moneda),0)
                                       ELSE 
     0 
                                   END
  ,'CARGA' = '5'      --9
  ,'MTODEBE'  = CASE  WHEN B.Tipo_Monto = 'D' THEN ISNULL(ROUND(B.MONTO,2),0)  --10
       ELSE 0 END
  ,'CTADEBE'  = '00000000'     --11
      
  ,'refdebe'  = '0000000000'         --12
  ,'CODOHABER' = CASE  WHEN B.Tipo_Monto = 'H' THEN SUBSTRING(B.CUENTA,5, 5) --13
     ELSE '00000' END
  ,'CODMDHABER' =  CASE  WHEN B.Tipo_Monto = 'D' THEN isnull((select mncodsuper from VIEW_MONEDA   --14
          where mncodmon = B.MONEDA),0)
                                        ELSE '00000' END 
  ,'ABONO' = '6'       
  ,'MTOHABER' = CASE  WHEN B.Tipo_Monto = 'H' THEN ISNULL(ROUND(B.MONTO,2),0) --16
     ELSE 0 END
  ,'NUMCTAHABER' = '00000000'      --17
  ,'N_VOUCHER' = '0000000000'      --18
  ,'EMISORA' = '00'      --19
  ,'RECPTORA' = '00'      --20
  ,'EVE1'  = '0'      --21
  ,'TIPCAMDB' = '00000000'      --22
  ,'MOTIVODB' = '  '      --23
  ,'TASADB' = '000000'      --24
  ,'FECEMIDB' = '000000'      --25
  ,'FECVTODB' = '000000'      --26
  ,'CONTVALDB' = '000000000000000'      --27
  ,'TIPMOVDB' = ' '      --28
  ,'CODEJEDB' = SPACE(3)      --29
  ,'FILLERdb' = '0000000'       --30
  ,'TIPCAMHB' = '00000000'      --31    
  ,'MOTIVOHB' = SPACE(2)      --32
  ,'TASAHB' = '000000'      --33
  ,'FECEMIHB' = '000000'      --34
  ,'FECVTOHB' = '000000'      --35
  ,'CONTVALDHB' = '000000000000000'      --36
  ,'TIPMOVHB' = SPACE(1)      --37
  ,'CODEJEHB' = SPACE(3)      --38
  ,'FILLERHB' = '0000000'      --39
  ,'BENEFICIA'    = SPACE(30)      --40
  ,'BACH'  = 'PCF'       --41
  ,'SECRE' = SPACE(3)      --42
  ,'FILLER2'      = '0000'      --43
 
  FROM voucher_CNT V  ,detalle_voucher_CNT B ,view_plan_de_cuenta C
         WHERE  (V.Numero_Voucher  = B.Numero_Voucher ) 
          and v.Fecha_Ingreso    = @FECHA
                 and C.cuenta          = b.cuenta       
    AND  B.Moneda   = 999 
 ORDER BY B.Numero_Voucher,B.Correlativo
END 
 
 
GO
