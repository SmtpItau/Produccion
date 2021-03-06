USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEEROPERACIONES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CNT_LEEROPERACIONES    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_CNT_LEEROPERACIONES    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_CNT_LEEROPERACIONES]
                                    ( @pareid_sistema  CHAR(03),
     @paretipo_movimiento CHAR(03)  )
AS
BEGIN
SET NOCOUNT ON
  SELECT 
   mov.tipo_operacion  ,
   mov.glosa_operacion  ,
   mov.control_instrumento  ,
   mov.control_moneda
  FROM
   MOVIMIENTO_CNT  mov
  WHERE  
   mov.id_sistema  = @pareid_sistema
  AND mov.tipo_movimiento  = @paretipo_movimiento
 
SET NOCOUNT OFF
END

GO
