USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CUENTA_CONTABLE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_CUENTA_CONTABLE]
               ( @cuenta  CHAR(12)  )
AS 
BEGIN
        SELECT descripcion,
               con_centro_costo,
               tipo_cuenta,
               con_correccion,
               cuenta_imputable
  FROM VIEW_PLAN_DE_CUENTAS 
        WHERE cuenta = @cuenta
END
--SELECT * FROM CON_PLAN_CUENTAS


GO
