USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cnt_LeerOperaciones]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/****** Objeto:  procedimiento  almacenado dbo.Sp_Cnt_LeerOperaciones    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Cnt_LeerOperaciones    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[Sp_Cnt_LeerOperaciones]
                                    ( @pareid_sistema  CHAR(03),
     @paretipo_movimiento CHAR(03)  )
AS
BEGIN
	SET DATEFORMAT DMY
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
