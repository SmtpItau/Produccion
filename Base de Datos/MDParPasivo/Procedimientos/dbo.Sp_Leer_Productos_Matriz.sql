USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Productos_Matriz]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Leer_Productos_Matriz]
            (   @Usuario CHAR(15)
            )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @tipo_usuario CHAR(15)


   SELECT @tipo_usuario = tipo_usuario FROM USUARIO WITH (NOLOCK) WHERE usuario = @Usuario


   SELECT DISTINCT P.codigo_producto
      ,   P.descripcion
      ,   @Usuario
   FROM MATRIZ_ATRIBUCION M  WITH (NOLOCK)
      , PRODUCTO          P  WITH (NOLOCK)
      WHERE M.tipo_usuario         = @tipo_usuario
        AND P.codigo_producto	= M.codigo_producto

END

GO
