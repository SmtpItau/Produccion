USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSINTERMAP20071106]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DATOSINTERMAP20071106]  -- sp_helptext Sp_interfaz_Derivados_Forward

AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Fecha    DATETIME
   DECLARE @Max      INT
   DECLARE @Fecha_FM DATETIME

   SELECT @Fecha    = '20091127' -- acfecproc 
   FROM   MFAC

   SELECT @Max      = COUNT(1) 
   FROM   MFCA

   SELECT @Fecha_FM      = DATEADD(MONTH, -1, @Fecha)
   SELECT @Fecha_FM      = MAX(vmfecha) 
   FROM   BacParamSuda..VALOR_MONEDA 
   WHERE  MONTH(VMFECHA) = MONTH(@Fecha_FM) 
   AND    YEAR(VMFECHA)  = YEAR(@Fecha_FM)

   SELECT vmcodigo = CASE WHEN vmcodigo = 994 THEN 13 ELSE vmcodigo END
   ,      vmvalor
   INTO   #ValMon
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha    = @Fecha

   INSERT INTO #ValMon SELECT 999 , 1

   SELECT vmcodigo = Codigo_Moneda
   ,      vmvalor  = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacparamSuda..VALOR_MONEDA_CONTABLE
   WHERE  Fecha    = @Fecha

   INSERT INTO #VALOR_TC_CONTABLE SELECT vmcodigo, vmvalor FROM #ValMon WHERE vmcodigo = 998
   INSERT INTO #VALOR_TC_CONTABLE SELECT 999 , 1.0
   INSERT INTO #VALOR_TC_CONTABLE SELECT 13  , Tipo_Cambio 
                                    FROM BacparamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @Fecha AND Codigo_Moneda = 994

   SELECT 'fecha_contable'   = @Fecha
   ,      'cod_producto'     = 'MD01'
   ,      'T_producto'       = 'MDIR'
   ,      'rut'              = CONVERT(CHAR(9),cacodigo)
   ,      'dig'              = ISNULL(Cldv,'')
   ,      'n_operacion'      = CONVERT(VARCHAR(5),canumoper)
   ,      'fecha_inic'       = convert(char(8),cafecha,112)
   ,      'fecha_vcto'       = cafecvcto
   ,      'mda_compra'       = CASE WHEN catipoper = 'C' THEN cacodmon1 ELSE cacodmon2 END
   ,      'mto_compra'       = CASE WHEN catipoper = 'C' THEN camtomon1 ELSE camtomon2 END
   ,      'mda_venta'        = CASE WHEN catipoper = 'C' THEN cacodmon2 ELSE cacodmon1 END
   ,      'mto_venta'        = CASE WHEN catipoper = 'C' THEN camtomon2 ELSE camtomon1 END
   ,      'tip_vcto'         = CASE WHEN catipmoda = 'E' THEN 'D'       ELSE catipmoda END
/*
   ,      'activo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN fval_obtenido
                                                      WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN catipcam
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'pasivo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN catipcam
                                                      WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN fval_obtenido
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)


*/
   ,      'activo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN fval_obtenido
                                                      WHEN catipoper = 'V' THEN catipcam
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'pasivo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN catipcam
                                                      WHEN catipoper = 'V' THEN fval_obtenido
                                    END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'Vpresen_activo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN fval_obtenido
                                                      WHEN catipoper = 'V' THEN catipcam
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'Vpresen_pasivo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN catipcam
                                                      WHEN catipoper = 'V' THEN fval_obtenido
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'Flujos'           =    ' ' 

--   FROM   MFCA
     FROM   MFCARES
          LEFT JOIN BacParamSuda..CLIENTE     ON cacodigo = clrut and cacodcli = clcodigo
          LEFT JOIN BacParamSuda..MONEDA  cnv ON mncodmon = cacodmon2
   WHERE  cafecvcto          > @Fecha
     AND  cacodpos1          NOT IN(2, 10, 11)
and CaFechaProceso = @Fecha

   UNION

   SELECT 'fecha_contable'   = @Fecha
   ,      'cod_producto'     = 'MD01'
   ,      'T_producto'       = 'MDIR'
   ,      'rut'              = CONVERT(CHAR(9),cacodigo)
   ,      'dig'              = ISNULL(Cldv,'')
   ,      'n_operacion'      = CONVERT(VARCHAR(5),canumoper)
   ,      'fecha_inic'       = convert(char(8),cafecha,112)
   ,      'fecha_vcto'       = cafecvcto
   ,      'mda_compra'       = CASE WHEN catipoper = 'C' THEN cacodmon1 ELSE cacodmon2 END
   ,      'mto_compra'       = CASE WHEN catipoper = 'C' THEN camtomon1 ELSE camtomon2 END
   ,      'mda_venta'        = CASE WHEN catipoper = 'C' THEN cacodmon2 ELSE cacodmon1 END
   ,      'mto_venta'        = CASE WHEN catipoper = 'C' THEN camtomon2 ELSE camtomon1 END
   ,      'tip_vcto'         = CASE WHEN catipmoda = 'E' THEN 'D'       ELSE catipmoda END

   ,      'activo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN fval_obtenido
                                                      WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN catipcam
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'pasivo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN catipcam
                                                      WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN fval_obtenido
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)

   ,      'Vpresen_activo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN fval_obtenido
                                                      WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN catipcam
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)
                                  END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)
   ,      'Vpresen_pasivo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN catipcam
                                                      WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN fval_obtenido
                                                      WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)
                                                 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)
   ,      'Flujos'           =    ' '

--   FROM   MFCA
     FROM MFCARES
          LEFT JOIN BacParamSuda..CLIENTE     ON cacodigo = clrut and cacodcli = clcodigo
          LEFT JOIN BacParamSuda..MONEDA  cnv ON mncodmon = cacodmon1
   WHERE  cafecvcto          > @Fecha
     AND  cacodpos1           IN(2)
     and CaFechaProceso = @Fecha


   UNION

   SELECT 'fecha_contable'   = @Fecha
   ,      'cod_producto'     = 'MD01'
   ,      'T_producto'       = 'MDIR'
   ,      'rut'              = CONVERT(CHAR(9), cacodigo )
   ,      'dig'              = ISNULL( cldv, '0')
   ,      'n_operacion'      = CONVERT(VARCHAR(5), canumoper )
   ,      'fecha_inic'       = CONVERT(CHAR(8), cafecha, 112)
   ,      'fecha_vcto'       = cafecvcto
   ,      'mda_compra'       = CASE WHEN cacodmon2 = 13  THEN 13        ELSE 999        END
   ,      'mto_compra'       = CASE WHEN catipoper = 'C' THEN caequusd2 ELSE caequmon1  END
   ,      'mda_venta'        = CASE WHEN cacodmon1 = 13  THEN 13        ELSE 999        END
   ,      'mto_venta'        = CASE WHEN catipoper = 'C' THEN caequmon1 ELSE caequusd2  END
   ,      'tip_vcto'         = CASE WHEN catipmoda = 'E' THEN 'D'       ELSE catipmoda  END

   ,      'activo_mtm'       = mtm_hoy_moneda1
   ,      'pasivo_mtm'       = mtm_hoy_moneda2
   ,      'Vpresen_activo'   = ISNULL( valorrazonableactivo ,0)
   ,      'Vpresen_pasivo'   = ISNULL( valorrazonablepasivo ,0)
   ,      'Flujos'           = 'R'

--   FROM   MFCA
     FROM MFCARES
          LEFT JOIN BacParamSuda..CLIENTE ON cacodigo = clrut and cacodcli = clcodigo
   WHERE  cafecvcto          > @Fecha
   AND    cacodpos1          = 10
   and CaFechaProceso = @Fecha

SET NOCOUNT OFF
END

GO
