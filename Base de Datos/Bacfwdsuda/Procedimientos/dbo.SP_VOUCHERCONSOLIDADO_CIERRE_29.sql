USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VOUCHERCONSOLIDADO_CIERRE_29]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VOUCHERCONSOLIDADO_CIERRE_29]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iContador   NUMERIC(9)

   SELECT  @iContador       = 0.0
   SELECT  @iContador       = COUNT(1)
   FROM    VOUCHER_CNT                   v WITH (NoLock)
           LEFT JOIN DETALLE_VOUCHER_CNT d ON v.numero_voucher = d.numero_voucher
   ,       MFACH
   WHERE   acfecproc       = '20101029' 
     AND   v.fecha_ingreso = acfecproc

   SELECT /*01*/ 'NI05TR'    = '1'
   ,      /*02*/ 'NI05OF'    = '00071'
   ,      /*03*/ 'NI05AR'    = '1'
   ,      /*04*/ 'NI05SEC'   = '00645'
   ,      /*05*/ 'NI05DIA'   = CONVERT(CHAR(2),REPLICATE('0', 2 - LEN(DAY(acfecproc)))   + LTRIM(RTRIM(DAY(acfecproc))))
   ,      /*06*/ 'NI05MES'   = CONVERT(CHAR(2),REPLICATE('0', 2 - LEN(MONTH(acfecproc))) + LTRIM(RTRIM(MONTH(acfecproc))))
   ,      /*07*/ 'NI05AÑO'   = CONVERT(CHAR(2),SUBSTRING(REPLICATE('0', 4 - LEN(YEAR(acfecproc)))  + LTRIM(RTRIM(YEAR(acfecproc))),3,2))
   ,      /*08*/ 'NI05NDO'   = SUBSTRING(LTRIM(RTRIM(v.numero_voucher)),1,6)
   ,      /*09*/ 'NI05DCOP'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(16),LTRIM(RTRIM(ISNULL(d.cuenta,'0'))) + REPLICATE('0', 16 - LEN(ISNULL(d.cuenta,'0'))))
                                    ELSE                         CONVERT(CHAR(16),                                     REPLICATE('0', 16))
                               END
   ,      /*10*/ 'NI05DDIV'  = CASE WHEN d.Tipo_Monto = 'D' AND d.moneda NOT IN(994,998,997,999) THEN CONVERT(CHAR(2),REPLICATE('0',2 - LEN(ISNULL(m.mncodfox,'00'))) + LTRIM(RTRIM(ISNULL(m.mncodfox,'00'))))
                                    ELSE                                                              CONVERT(CHAR(2),REPLICATE('0',2))
                               END
   ,      /*11*/ 'NI05DDBE'  = '5'
   ,      /*12*/ 'NI05DMTO'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))),'.','') )
                                    ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
                               END
   ,      /*13*/ 'NI05DCLA'  = REPLICATE('0', 4)
   ,      /*14*/ 'NI05DNOM'  = REPLICATE('0', 8)
   ,      /*15*/ 'NI05DREF'  = CASE WHEN d.Tipo_Monto = 'D' THEN CONVERT(CHAR(10),REPLICATE('0', 10 - LEN(LTRIM(v.numero_voucher))) + LTRIM(v.numero_voucher))
                                    ELSE                         CONVERT(CHAR(10),REPLICATE('0', 10))
                               END
   ,      /*16*/ 'NI05HCOP'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(16),LTRIM(RTRIM(ISNULL(d.cuenta,'0'))) + REPLICATE('0', 16 - LEN(ISNULL(d.cuenta,'0'))))
                                    ELSE                         CONVERT(CHAR(16),                                     REPLICATE('0', 16))
                               END
   ,      /*17*/ 'NI05HDIV'  = CASE WHEN d.Tipo_Monto = 'H' AND d.moneda NOT IN(994,998,997,999) THEN CONVERT(CHAR(2),REPLICATE('0',2 - LEN(ISNULL(m.mncodfox,'00'))) + LTRIM(RTRIM(ISNULL(m.mncodfox,'00'))))
                                    ELSE                                                              CONVERT(CHAR(2),REPLICATE('0',2))
                               END
   ,      /*18*/ 'NI05HDBE'  = '6'
   ,      /*19*/ 'NI05HMTO'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(17),REPLICATE('0', 16 - LEN(LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))))) + REPLACE( LTRIM(RTRIM(CONVERT(NUMERIC(15,2),ISNULL(d.monto,0.0)))),'.','') )
                                    ELSE                         CONVERT(CHAR(17),REPLICATE('0',13) + '00')
                               END
   ,      /*20*/ 'NI05HCLA'  = REPLICATE('0', 4)
   ,      /*21*/ 'NI05HNOM'  = REPLICATE('0', 8)
   ,      /*22*/ 'NI05HREF'  = CASE WHEN d.Tipo_Monto = 'H' THEN CONVERT(CHAR(10),REPLICATE('0', 10 - LEN(LTRIM(v.numero_voucher))) + LTRIM(v.numero_voucher))
                                    ELSE                         CONVERT(CHAR(10),REPLICATE('0', 10))
                               END
   ,      /*23*/ 'NI05OEMI'  = REPLICATE('0',5)
   ,      /*24*/ 'NI05OREC'  = REPLICATE('0',5)
   ,      /*25*/ 'NI05OFILL' = REPLICATE('0',126)
   ,      /*26*/ 'NI05TICP'  = '00000000000'
   ,      /*27*/ 'CANTREG'   = @iContador
   INTO   #TMP_RETORNO_FINAL_INTERFAZ
   FROM   VOUCHER_CNT                            v WITH (NoLock)
          LEFT JOIN DETALLE_VOUCHER_CNT          d ON v.numero_voucher = d.numero_voucher
          LEFT JOIN BacParamSuda..PLAN_DE_CUENTA c ON c.cuenta         = d.cuenta
          LEFT JOIN BacParamSuda..MONEDA         m ON m.mncodmon       = convert(INT,d.moneda)
   ,      MFACH
   WHERE  acfecproc       = '20101029' 
   AND    v.fecha_ingreso = acfecproc
   ORDER BY d.numero_voucher , d.correlativo

   SELECT NI05DCOP, MONTO = SUM( CONVERT(NUMERIC(21,4), NI05DMTO ) ) FROM #TMP_RETORNO_FINAL_INTERFAZ WHERE NI05DCOP IN('2128010130000000','2128010140000000') group by NI05DCOP
   SELECT NI05HCOP, MONTO = SUM( CONVERT(NUMERIC(21,4), NI05HMTO ) ) FROM #TMP_RETORNO_FINAL_INTERFAZ WHERE NI05HCOP IN('2128010130000000','2128010140000000') group by NI05HCOP

END

GO
