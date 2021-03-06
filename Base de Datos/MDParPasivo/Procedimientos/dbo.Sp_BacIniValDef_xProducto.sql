USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacIniValDef_xProducto]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacIniValDef_xProducto] 
      (
       @codigo_producto      VARCHAR(5)
      ,@codigo_area          VARCHAR(5)
      )

AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


      SELECT    

       V.Id_sistema
      ,V.codigo_producto
      ,V.codigo_area
      ,V.compra_forma_pagomn
      ,V.compra_forma_pagomx
      ,V.compra_codigo_oma
      ,'glosa_compra_oma'             = '' --ISNULL(( SELECT glosa FROM TBCODIGOSOMA WHERE V.compra_codigo_oma = codigo_numerico),'' )
      ,V.compra_codigo_comercio
--      ,V.compra_codigo_concepto
      ,'glosa_compra_concepto'        = '' --ISNULL(( SELECT glosa FROM CODIGO_COMERCIO WHERE comercio = V.compra_codigo_comercio ),'')
      ,V.venta_forma_pagomn
      ,V.venta_forma_pagomx
      ,V.venta_codigo_oma
      ,'glosa_venta_oma'              = '' --ISNULL(( SELECT glosa FROM TBCODIGOSOMA WHERE V.venta_codigo_oma = codigo_numerico ),'')
      ,V.venta_codigo_comercio
--      ,V.venta_codigo_concepto
      ,'glosa_venta_concepto'         = '' --ISNULL(( SELECT glosa FROM CODIGO_COMERCIO WHERE comercio = V.venta_codigo_comercio ),'')
      ,V.contabiliza
      ,V.monto_operacion
      ,V.codigo_moneda

      FROM  VALOR_DEFECTO V

      WHERE 
           V.codigo_producto      = @codigo_producto      
       AND V.codigo_area          = @codigo_area          
      SET NOCOUNT OFF
      
END



GO
