USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEERMOVIMIENTOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CNT_LEERMOVIMIENTOS    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_CNT_LEERMOVIMIENTOS    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_CNT_LEERMOVIMIENTOS] ( 
     @pareid_sistema CHAR(03)
      )
AS
BEGIN
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
