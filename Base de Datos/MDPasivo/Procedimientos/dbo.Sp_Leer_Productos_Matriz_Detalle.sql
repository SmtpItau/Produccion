USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Productos_Matriz_Detalle]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Leer_Productos_Matriz_Detalle]
            (   @Usuario   CHAR(15)
            )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @tipo_usuario CHAR(15)

   SELECT @tipo_usuario = tipo_usuario FROM USUARIO  WITH (NOLOCK) WHERE usuario = @Usuario

   SELECT codigo_producto
      ,   plazo_desde
      ,   plazo_hasta
      ,   montoinicio
      ,   montofinal            
   FROM   MATRIZ_ATRIBUCION  WITH (NOLOCK)
   WHERE  tipo_usuario = @tipo_usuario

END








GO
