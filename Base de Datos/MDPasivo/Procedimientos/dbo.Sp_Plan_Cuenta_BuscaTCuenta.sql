USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Plan_Cuenta_BuscaTCuenta]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Plan_Cuenta_BuscaTCuenta] 
      ( @cuenta CHAR(16))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
  SELECT cuenta, 
         descripcion,
	 glosa,
         tipo_moneda,
         tipo_cuenta,
         con_centro_costo
  FROM PLAN_DE_CUENTA WHERE ltrim(rtrim(cuenta)) = @cuenta 
SET NOCOUNT OFF
END




GO
