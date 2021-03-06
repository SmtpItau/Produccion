USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEERMOVIMIENTOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CNT_LEERMOVIMIENTOS] 
   (   @pareid_sistema   CHAR(03)   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT DISTINCT 
          mov.tipo_movimiento  
   ,      mov.glosa_movimiento  
   FROM   MOVIMIENTO_CNT  mov with (nolock)
   WHERE  mov.id_sistema = @pareid_sistema

END
GO
