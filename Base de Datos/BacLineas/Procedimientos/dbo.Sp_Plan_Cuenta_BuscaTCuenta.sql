USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Plan_Cuenta_BuscaTCuenta]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Plan_Cuenta_BuscaTCuenta] 
      ( @cuenta CHAR(12))
AS
BEGIN
SET NOCOUNT OFF
--    IF EXISTS (SELECT cuenta,descripcion,glosa,tipo_moneda,tipo_cuenta FROM PLAN_DE_CUENTA WHERE cuenta=@cuenta ) BEGIN
  SELECT cuenta, 
           descripcion,
    glosa,
      tipo_moneda,
    tipo_cuenta,
    con_centro_costo
           FROM PLAN_DE_CUENTA WHERE cuenta=@cuenta 
-- END
-- ELSE BEGIN
--  SELECT "ERROR"
-- END
  
SET NOCOUNT OFF
END






GO
