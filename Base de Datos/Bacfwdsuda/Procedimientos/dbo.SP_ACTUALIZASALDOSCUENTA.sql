USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZASALDOSCUENTA]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZASALDOSCUENTA]
       (
        @Cuenta  CHAR   (10),
        @Moneda  CHAR   (05),
        @Monto  NUMERIC(17,0)
       )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT CUENTA FROM SALDO_CUENTAS WHERE CUENTA = @Cuenta ) 
         BEGIN
   UPDATE  SALDO_CUENTAS
   SET     SALDO_BANCO  = @Monto,
           MONEDA       = @Moneda
   WHERE   CUENTA       = @Cuenta
  END
 ELSE
         BEGIN
   INSERT INTO SALDO_CUENTAS
           (CUENTA ,
    SALDO_BANCO,
    SALDO_BAC,
    MONEDA,
    IMPRIME,
    TIPO_BRECHA)
   VALUES (@Cuenta,
    @Monto,
    0,
    @Moneda,
    1,
    0)
  END 
 SET NOCOUNT OFF
END
-- select * from saldo_cuentas where cuenta = 2127630006

GO
