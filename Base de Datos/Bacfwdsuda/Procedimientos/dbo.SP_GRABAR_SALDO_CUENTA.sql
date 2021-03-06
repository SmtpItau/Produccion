USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_SALDO_CUENTA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_SALDO_CUENTA](
      @cuenta  CHAR(12),
      @imprime INT ,
      @brecha  CHAR(7)
     )
AS 
BEGIN
SET NOCOUNT ON
IF EXISTS( SELECT * FROM saldo_cuentas WHERE @cuenta = cuenta )
 BEGIN
  UPDATE  saldo_cuentas
  SET imprime  = @imprime ,
   tipo_brecha = @brecha
  WHERE  cuenta = @cuenta
 END
ELSE
 BEGIN
  INSERT INTO saldo_cuentas
  VALUES( @cuenta , 0 , 0 , 999 , @imprime , @brecha )
 END
SET NOCOUNT OFF
END
-- select * from saldo_cuentas

GO
