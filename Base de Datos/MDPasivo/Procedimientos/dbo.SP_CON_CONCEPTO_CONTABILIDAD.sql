USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONCEPTO_CONTABILIDAD]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CON_CONCEPTO_CONTABILIDAD]
               ( @icodigo_concepto   CHAR(05) = ' '
               )

AS
BEGIN
   
   SET NOCOUNT ON

   SET DATEFORMAT dmy

       SELECT 
          concepto_contable
	, descripcion
	, inventario
	, resultado
	, switch_producto
	, switch_garantia
	, switch_tipo_plazo
	, switch_financia
	, switch_sector
	, switch_corresponsal
	, switch_propiedad
	, switch_cuota
	, switch_colocacion
	, switch_recup
	, switch_divisa
	, switch_tipo_moneda	
        , referencia
        , switch_codigo_operacion
       FROM CONCEPTO_CONTABLE
       WHERE ( concepto_contable = @icodigo_concepto 
          OR   @icodigo_concepto = ' ' )

   SET NOCOUNT OFF

END





GO
