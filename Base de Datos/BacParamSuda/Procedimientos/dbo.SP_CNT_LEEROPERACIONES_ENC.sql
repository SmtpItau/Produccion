USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEEROPERACIONES_ENC]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CNT_LEEROPERACIONES_ENC]
   (   @pareid_sistema      CHAR(03)
   ,   @paretipo_movimiento CHAR(03)  
   ,   @ind_encaje			INT
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @ind_encaje = 0
	BEGIN
	   SELECT mov.tipo_operacion  
	   ,      mov.glosa_operacion  
	   ,      mov.control_instrumento  
	   ,      mov.control_moneda	   
	   FROM   MOVIMIENTO_CNT  mov
	   WHERE  mov.id_sistema       = @pareid_sistema
	   AND    mov.tipo_movimiento  = @paretipo_movimiento
	   AND	  mov.tipo_operacion   <> 'ENC'	
	   ORDER BY mov.glosa_operacion
	END
	ELSE IF @ind_encaje = 1
	BEGIN
	   SELECT mov.tipo_operacion  
	   ,      mov.glosa_operacion  
	   ,      mov.control_instrumento  
	   ,      mov.control_moneda
	   , *
	   FROM   MOVIMIENTO_CNT  mov
	   WHERE  mov.id_sistema       = @pareid_sistema
	   AND    mov.tipo_movimiento  = @paretipo_movimiento
	   AND	  mov.tipo_operacion   = 'ENC'	
	   ORDER BY mov.glosa_operacion
	END

END
GO
