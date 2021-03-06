USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEEROPERACIONES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CNT_LEEROPERACIONES]
   (   @pareid_sistema      CHAR(03)
   ,   @paretipo_movimiento CHAR(03)  
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT mov.tipo_operacion  
   ,      mov.glosa_operacion  
   ,      mov.control_instrumento  
   ,      mov.control_moneda
   FROM   MOVIMIENTO_CNT  mov
   WHERE  mov.id_sistema       = @pareid_sistema
   AND    mov.tipo_movimiento  = @paretipo_movimiento
   ORDER BY mov.glosa_operacion

END

GO
