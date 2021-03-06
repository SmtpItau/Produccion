USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_MONEDA_EXTRANJERA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTER_MONEDA_EXTRANJERA]
AS
BEGIN 
    DECLARE @FECHA DATETIME

    SELECT @FECHA = acfecproc 
      FROM MFAC

 SELECT  'TIPOREG'           = '1'                                 --1
 ,       'CODOFIC'           = '01'                                --2
 ,       'AREA'              = '1'                                 --3
 ,       'SECCION'           = '356'                               --4
 ,       'FECHACONT'         = @FECHA                              --5
 ,       'NUM_VOUCHER'       = V.Numero_Voucher                    --6
 ,       'CUENTA'            = CASE WHEN B.Tipo_Monto = 'D' THEN LTRIM(RTRIM(B.cuenta)) + '0000000'
                                    ELSE '0000000000000000' 
                               END                                 --7
 ,       'CODMONEDA'         = CASE WHEN B.Tipo_Monto = 'D' THEN ISNULL((SELECT mncodfox FROM VIEW_MONEDA WHERE mncodmon = B.Moneda),0)
                                   ELSE  '000' 
                               END                                --8
 ,       'CARGA'             = '5'                                --9
 ,       'MTODEBE'           = CASE
                                 WHEN B.Tipo_Monto = 'D' THEN ISNULL(ROUND(B.monto,2),0)  
                                 ELSE 0 
                               END                                --10
 ,       'CTADEBE'           = '00000000'                         --11
 ,       'REFDEBE'           = '0000000000'                       --12
 ,       'CODOHABER'         = CASE  WHEN B.Tipo_Monto = 'H' THEN LTRIM(RTRIM(B.cuenta)) + '0000000'
                                     ELSE '0000000000000000' 
                               END                                --13
 ,       'CODMDHABER'        = CASE  
                                 WHEN B.Tipo_Monto = 'H' THEN ISNULL((SELECT mncodfox FROM VIEW_MONEDA WHERE mncodmon = B.Moneda),0) /*CASE 
                                                               WHEN ISNULL((SELECT mncodsuper FROM VIEW_MONEDA WHERE mncodmon = B.moneda),0) = 13 THEN 11
                                                               ELSE ISNULL((SELECT mncodsuper FROM VIEW_MONEDA WHERE mncodmon = B.moneda),0)
                                                             END */
                                 ELSE '000' 
                               END                                --14
 ,       'ABONO'             = '6'                                --15
 ,       'MTOHABER'          = CASE  
                                  WHEN B.Tipo_Monto = 'H' THEN ISNULL(ROUND(B.monto,2),0) 
                                  ELSE 0 
                               END                                --16
 ,       'NUMCTAHABER'       = '00000000'                         --17
 ,       'N_VOUCHER'         = '0000000000'                       --18
 ,       'EMISORA'           = '00'                               --19
 ,       'RECPTORA'          = '00'                               --20
 ,       'EVE1'              = '0'                                --21
 ,       'TIPCAMDB'          = '00000000'                         --22
 ,       'MOTIVODB'          = '  '                               --23
 ,       'TASADB'            = '000000'                           --24
 ,       'FECEMIDB'          = '000000'                           --25
 ,       'FECVTODB'          = '000000'                           --26
 ,       'CONTVALDB'         = '000000000000000'                  --27
 ,       'TIPMOVDB'          = ' '                                --28
 ,       'CODEJEDB'          = SPACE(3)                           --29
 ,       'FILLERdb'          = '0000000'                      --30
 ,       'TIPCAMHB'          = '00000000'                         --31    
 ,       'MOTIVOHB'          = SPACE(2)                           --32
 ,       'TASAHB'            = '000000'                           --33
 ,       'FECEMIHB'          = '000000'                           --34
 ,       'FECVTOHB'          = '000000'                           --35
 ,       'CONTVALDHB'        = '000000000000000'                  --36
 ,       'TIPMOVHB'          = SPACE(1)                           --37
 ,       'CODEJEHB'          = SPACE(3)                           --38
 ,       'FILLERHB'          = '0000000'                          --39
 ,       'BENEFICIA'         = SPACE(30)                          --40
 ,       'BACH'              = 'PCF'                              --41
 ,       'SECRE'             = SPACE(3)                           --42
 ,       'FILLER2'           = '0000'                             --43
    FROM VOUCHER_CNT         V  
    ,    DETALLE_VOUCHER_CNT B 
    ,    VIEW_PLAN_DE_CUENTA C
   WHERE (V.Numero_Voucher  = B.Numero_Voucher ) 
     AND  V.Fecha_Ingreso   = @FECHA
     AND  C.cuenta          = b.cuenta       
     AND  B.Moneda        <> 999  
END
GO
