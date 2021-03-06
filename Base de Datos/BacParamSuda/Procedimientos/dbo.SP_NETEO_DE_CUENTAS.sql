USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NETEO_DE_CUENTAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_NETEO_DE_CUENTAS]
   (   @Fecha    DATETIME
   ,   @Modulo   CHAR(3)
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #Movimiento_Contables
      (   CtaCtable   NUMERIC(18)
      ,   TipoCuenta  CHAR(1)
      ,   Monto       FLOAT
      )

   CREATE TABLE #DIFERENCIA_CONTABLE
      (   Cuenta      VARCHAR(16)
      ,   Debe        FLOAT
      ,   Haber       FLOAT
      ,   Dif         FLOAT
      )
      CREATE INDEX #ixt_DIFERENCIA_CONTABLE ON #DIFERENCIA_CONTABLE (Cuenta)

   IF @Modulo = 'PCS'
   BEGIN
      INSERT INTO #Movimiento_Contables
      SELECT CtaCtable  = de.Cuenta
           , TipoCuenta = de.Tipo_Monto
           , Monto      = SUM(de.Monto)
      FROM   BacSwapSuda.dbo.BAC_CNT_VOUCHER                    vo
             INNER JOIN BacSwapSuda.dbo.BAC_CNT_DETALLE_VOUCHER de ON de.numero_voucher = vo.numero_voucher
      WHERE  vo.fecha_ingreso = @Fecha
      GROUP BY de.Cuenta, de.Tipo_Monto
      ORDER BY de.Cuenta
   END

   IF @Modulo = 'BFW'
   BEGIN
      INSERT INTO #Movimiento_Contables
      SELECT CtaCtable  = de.Cuenta
           , TipoCuenta = de.Tipo_Monto
           , Monto      = SUM(de.Monto)
      FROM   BacFwdSuda.dbo.VOUCHER_CNT                    vo
             INNER JOIN BacFwdSuda.dbo.DETALLE_VOUCHER_CNT de ON de.numero_voucher = vo.numero_voucher
      WHERE  vo.fecha_ingreso = @Fecha
      GROUP BY de.Cuenta, de.Tipo_Monto
      ORDER BY de.Cuenta
   END

   DECLARE @nCantDebe   NUMERIC(9)
       SET @nCantDebe   = ISNULL((SELECT ISNULL(COUNT(1), 0) FROM #Movimiento_Contables WHERE TipoCuenta = 'D'), 0)

   DECLARE @nCantHaber  NUMERIC(9)
       SET @nCantHaber  = ISNULL((SELECT ISNULL(COUNT(1), 0) FROM #Movimiento_Contables WHERE TipoCuenta = 'H'), 0)

   IF @nCantDebe = 0 AND @nCantHaber = 0
      RETURN
   
      INSERT INTO #DIFERENCIA_CONTABLE
      SELECT Cuenta      = CtaCtable
      ,      Debe        = Monto
      ,      Haber       = 0.0
      ,      Dif         = 0.0
      FROM   #Movimiento_Contables
      WHERE  TipoCuenta  = CASE WHEN @nCantDebe > @nCantHaber THEN 'D' ELSE 'H' END
   
      UPDATE #DIFERENCIA_CONTABLE
         SET Haber       = Monto
        FROM #Movimiento_Contables
       WHERE TipoCuenta  = CASE WHEN @nCantDebe > @nCantHaber THEN 'H' ELSE 'D' END
         AND CtaCtable   = Cuenta
   
      UPDATE #DIFERENCIA_CONTABLE
         SET Dif         = Debe - Haber
   
   SELECT Cuenta
   ,      Debe
   ,      Haber
   ,      Dif
   FROM   #DIFERENCIA_CONTABLE
   ORDER BY Cuenta

END
GO
