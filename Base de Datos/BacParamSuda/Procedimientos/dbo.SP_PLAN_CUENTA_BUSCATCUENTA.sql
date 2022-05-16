USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLAN_CUENTA_BUSCATCUENTA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PLAN_CUENTA_BUSCATCUENTA] 
      ( @cuenta CHAR(12))
AS
BEGIN
SET NOCOUNT OFF

  SELECT cuenta, 
         descripcion,
         glosa,
         tipo_moneda,
         tipo_cuenta,
         con_centro_costo,
         cta_sbif
           FROM PLAN_DE_CUENTA WHERE cuenta=@cuenta 
 
SET NOCOUNT OFF
END

GO
