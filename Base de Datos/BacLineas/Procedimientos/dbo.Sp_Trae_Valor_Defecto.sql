USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Valor_Defecto]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Trae_Valor_Defecto]( @SISTEMA      CHAR(3)
                                      , @COD_PROD     CHAR(10)
                                      , @COD_AREA     CHAR(10) )
AS
BEGIN
   SELECT id_sistema    -- 1
         ,codigo_producto   -- 2
         ,codigo_area   -- 3
         ,compra_forma_pagomn   -- 4
         ,compra_forma_pagomx   -- 5
         ,compra_codigo_oma   -- 6
         ,compra_codigo_comercio  -- 7
         ,compra_codigo_concepto  -- 8
         ,venta_forma_pagomn   -- 9
         ,venta_forma_pagomx   -- 10
         ,venta_codigo_oma   -- 11
         ,venta_codigo_comercio  -- 12
         ,venta_codigo_concepto  -- 13
         ,contabiliza    -- 14
         ,monto_operacion        -- 15
         ,codigo_moneda   -- 16
   FROM VALOR_DEFECTO
  WHERE id_sistema        = @SISTEMA
    AND codigo_area       = @COD_AREA
    AND codigo_producto   = @COD_PROD
END






GO
