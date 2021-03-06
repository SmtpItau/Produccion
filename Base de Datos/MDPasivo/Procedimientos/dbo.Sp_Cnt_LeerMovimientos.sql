USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cnt_LeerMovimientos]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/****** Objeto:  procedimiento  almacenado dbo.Sp_Cnt_LeerMovimientos    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Cnt_LeerMovimientos    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[Sp_Cnt_LeerMovimientos] ( 
     @pareid_sistema CHAR(03)
      )
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

  SELECT 
   DISTINCT mov.tipo_movimiento  ,
   mov.glosa_movimiento  
  FROM
                        MOVIMIENTO_CNT  mov
  WHERE  
   mov.id_sistema = @pareid_sistema
SET NOCOUNT OFF
END


GO
