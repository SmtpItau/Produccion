USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacIniValDef_Graba]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacIniValDef_Graba]
      (
         @id_sistema	         char(3)
	,@codigo_producto	 varchar(5)
	,@codigo_area	         varchar(5)
	,@compra_forma_pagomn	 numeric(2)
	,@compra_forma_pagomx	 numeric(2)
	,@compra_codigo_oma	 numeric(3)
	,@compra_codigo_comercio char(6)

--	,@compra_codigo_concepto char(3)

	,@venta_forma_pagomn	 numeric(2)
	,@venta_forma_pagomx	 numeric(2)
	,@venta_codigo_oma	 numeric(3)
	,@venta_codigo_comercio	 char(6)

--	,@venta_codigo_concepto	 char(3)

	,@contabiliza	         char(1)
	,@monto_operacion	 numeric(19,4)
	,@codigo_moneda	         numeric(5)

      )

AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


      IF EXISTS ( SELECT 1 FROM VALOR_DEFECTO WHERE @id_sistema = id_sistema AND @codigo_producto = codigo_producto AND @codigo_area = codigo_area ) BEGIN

            UPDATE VALOR_DEFECTO
            SET

             id_sistema	            =	@id_sistema
            ,codigo_producto	    =	@codigo_producto
            ,codigo_area	    =	@codigo_area
            ,compra_forma_pagomn    =	@compra_forma_pagomn
            ,compra_forma_pagomx    =	@compra_forma_pagomx
            ,compra_codigo_oma	    =	@compra_codigo_oma
            ,compra_codigo_comercio =	@compra_codigo_comercio
--            ,compra_codigo_concepto =	@compra_codigo_concepto
            ,venta_forma_pagomn	    =	@venta_forma_pagomn
            ,venta_forma_pagomx	    =	@venta_forma_pagomx
            ,venta_codigo_oma	    =	@venta_codigo_oma
            ,venta_codigo_comercio  =	@venta_codigo_comercio
--            ,venta_codigo_concepto  =	@venta_codigo_concepto
            ,contabiliza	    =	@contabiliza
            ,monto_operacion	    =	@monto_operacion
            ,codigo_moneda	    =	@codigo_moneda
            
            WHERE 
                @id_sistema = id_sistema 
            AND @codigo_producto = codigo_producto 
            AND @codigo_area = codigo_area      

      END ELSE BEGIN

            INSERT INTO VALOR_DEFECTO 
            (
             id_sistema	            
            ,codigo_producto	    
            ,codigo_area	    
            ,compra_forma_pagomn    
            ,compra_forma_pagomx    
            ,compra_codigo_oma	    
            ,compra_codigo_comercio 
--            ,compra_codigo_concepto 
            ,venta_forma_pagomn	    
            ,venta_forma_pagomx	    
            ,venta_codigo_oma	    
            ,venta_codigo_comercio  
--            ,venta_codigo_concepto  
            ,contabiliza	    
            ,monto_operacion	    
            ,codigo_moneda	    
            )
            VALUES
            (
             @id_sistema
            ,@codigo_producto
            ,@codigo_area
            ,@compra_forma_pagomn
            ,@compra_forma_pagomx
            ,@compra_codigo_oma
            ,@compra_codigo_comercio
--            ,@compra_codigo_concepto
            ,@venta_forma_pagomn
            ,@venta_forma_pagomx
            ,@venta_codigo_oma
            ,@venta_codigo_comercio
--            ,@venta_codigo_concepto
            ,@contabiliza
            ,@monto_operacion
            ,@codigo_moneda
            )
            

      END

      SET NOCOUNT OFF

END


GO
