USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDO_CUENTAS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SALDO_CUENTAS]
AS
BEGIN
CREATE TABLE #Saldo(Cuenta_voucher  CHAR(20),
       Debe    FLOAT   ,
       Haber   FLOAT)
set nocount on
INSERT INTO #Saldo SELECT Distinct Cuenta, 0 , 0 FROM BAC_CNT_DETALLE_VOUCHER 
UPDATE #Saldo SET Haber =  (SELECT ISNULL(sum(monto),0) FROM BAC_CNT_DETALLE_VOUCHER where tipo_monto = 'H' and cuenta = cuenta_voucher )
UPDATE #Saldo SET Debe =  (SELECT ISNULL(sum(monto),0) FROM BAC_CNT_DETALLE_VOUCHER where tipo_monto = 'D' and cuenta = cuenta_voucher )
SELECT * FROM #Saldo ORDER BY Cuenta_Voucher
set nocount off
END

GO
